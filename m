Received: from eggs.gnu.org ([2001:4830:134:3::10]:33581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDWZw-00079R-3Y
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDWZu-00056p-VX
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:43:56 -0400
References: <20170519023233.24461-1-eblake@redhat.com>
	<20170519023233.24461-2-eblake@redhat.com>
	<20170524062833.GO12279@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <712887cb-308b-44a9-e4bf-9d8948670ff5@redhat.com>
Date: Wed, 24 May 2017 08:43:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170524062833.GO12279@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hxtuHNmpKnSGDvaMOwFQmuVx7uWsp5B2j"
Subject: Re: [Qemu-devel] [PATCH 1/4] qemu-io: Don't die on second open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hxtuHNmpKnSGDvaMOwFQmuVx7uWsp5B2j
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <712887cb-308b-44a9-e4bf-9d8948670ff5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] qemu-io: Don't die on second open
References: <20170519023233.24461-1-eblake@redhat.com>
 <20170519023233.24461-2-eblake@redhat.com> <20170524062833.GO12279@lemon.lan>
In-Reply-To: <20170524062833.GO12279@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/24/2017 01:28 AM, Fam Zheng wrote:
> On Thu, 05/18 21:32, Eric Blake wrote:
>> Failure to open a file in qemu-io should normally return 1 on
>> failure to end the command loop, on the presumption that when
>> batching commands all on the command line, failure to open means
>> nothing further can be attempted. But when executing qemu-io
>> interactively, there is a special case: if open is executed a
>> second time, we print a hint that the user should try the
>> interactive 'close' first.  But the hint is useless if we don't
>> actually LET them try 'close'.
>>
>> This has been awkward since at least as far back as commit
>> 43642b3, in 2011 (probably earlier, but git blame has a harder
>> time going past the file renames at that point).
>>

>> @@ -63,7 +63,7 @@ static int openfile(char *name, int flags, bool writ=
ethrough, bool force_share,
>>      if (qemuio_blk) {
>>          error_report("file open already, try 'help close'");
>>          QDECREF(opts);
>> -        return 1;
>> +        return 0;
>>      }
>>
>>      if (force_share) {
>> --=20
>> 2.9.4
>>
>>
>=20
> Hmm, failure is failure, why is "return 0" better than "return 1"?

"return 0" is what tells the caller to keep interpreting commands.
"return 1" is what tells the caller to exit immediately.  Most qemu-io
commands return 0 always.  Only a few need to return 1 ("quit"
absolutely needs to, and we are arguing about whether "open" should do
so).  Pre-patch, "open" always failed with 1, exiting the interpreter
immediately with nonzero status.  Which is wrong if we print a help
message on the second attempt at open (since a second attempt is only
possible in interactive mode), but DOES match what you want to have
happen on a first open attempt from the command line:

$ qemu-io unreadable_file

But you are arguing that in batch mode, when you do:

$ qemu-io
qemu-io> open unreadable_file

that you want to keep things in qemu-io, rather than exiting
immediately.  If so, then we need to make openfile() return 0 always,
and instead teach the caller to check whether it is invoked in command
line mode (cause non-zero exit status if nothing was opened) or in
interactive mode (keep qemu-io running, to let the user try to open
something else).  In command line mode, the caller should then use the
status of whether a file was actually opened (rather than the return
code) when dealing with the call to openfile() for the command line
argument.

That's a bigger change; but I can try it if you think it is worth it.

>=20
> If the control flow in the caller has a problem, fix it there? Specific=
ally, I
> don't think failed interactive open need to exit program, at all.
>=20
> Fam
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hxtuHNmpKnSGDvaMOwFQmuVx7uWsp5B2j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJY4LAAoJEKeha0olJ0NqJawH/3fGKUEAMLX4SQ+8lsYBHKU9
hMB1MCchSdxY8orVt7X6HdHvGupbD+ziLp3L+AK5pZ2HjelfknfjubgjUshvYDI5
HpLINZioWkN5/BmxcFEVnavHm2clN/bMlpj6cu5VOO5ZII0dCmrBR1ZTVkGqKDYb
2OvNfK4TetLfxgXieNcVRnLCF18d2xGr+NW8GjSWcWUjPjykD3sko8M61DNn4HUv
j67iY6D1NgPcVVI46lIr6MI4ijRtm0R69Bbj/SkWFiY1DFYOYYa5rck51zeOASfN
y8N+2cX3/LY1CbK2/J3ljzMoRMXJmqrlc4OuNYHogmggLJSwB6CgLp6XParfvBU=
=HG2A
-----END PGP SIGNATURE-----

--hxtuHNmpKnSGDvaMOwFQmuVx7uWsp5B2j--
