Received: from eggs.gnu.org ([2001:4830:134:3::10]:46312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG5Im-0001mR-CL
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG5Il-0006ir-7J
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:12:48 -0400
References: <20170524202842.26724-1-eblake@redhat.com>
	<20170524202842.26724-2-eblake@redhat.com>
	<d74bac5d-4fa9-d7cc-9534-0a3fe22af6fc@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8680a378-d19e-55f9-f14b-158907bb9919@redhat.com>
Date: Wed, 31 May 2017 10:12:39 -0500
MIME-Version: 1.0
In-Reply-To: <d74bac5d-4fa9-d7cc-9534-0a3fe22af6fc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V4ubtG2IaTw1uVoHv4L5hfapmQOBNApdQ"
Subject: Re: [Qemu-devel] [PATCH v2 1/5] qemu-io: Don't die on second open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V4ubtG2IaTw1uVoHv4L5hfapmQOBNApdQ
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>
Message-ID: <8680a378-d19e-55f9-f14b-158907bb9919@redhat.com>
Subject: Re: [PATCH v2 1/5] qemu-io: Don't die on second open
References: <20170524202842.26724-1-eblake@redhat.com>
 <20170524202842.26724-2-eblake@redhat.com>
 <d74bac5d-4fa9-d7cc-9534-0a3fe22af6fc@redhat.com>
In-Reply-To: <d74bac5d-4fa9-d7cc-9534-0a3fe22af6fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 09:18 AM, Max Reitz wrote:
> On 2017-05-24 22:28, Eric Blake wrote:
>> Most callback commands in qemu-io return 0 to keep the interpreter
>> loop running, or 1 to quit immediately.  However, open_f() just
>> passed through the return value of openfile(), which has different
>> semantics of returning 0 if a file was opened, or 1 on any failure.
>>
>> As a result of mixing the return semantics, we are forcing the
>> qemu-io interpreter to exit early on any failures, which is rather
>> annoying when some of the failures are obviously trying to give
>> the user a hint of how to proceed (if we didn't then kill qemu-io
>> out from under the user's feet):
>>
>> $ qemu-io
>> qemu-io> open foo
>> qemu-io> open foo
>> file open already, try 'help close'
>> $ echo $?
>> 0
>>
>> Meanwhile, we WANT openfile() to report failures, as it is the
>> way that 'qemu-io -c "$something" no_such_file' knows to exit
>> early rather than attempting $something.  So the solution is to
>> fix open_f() to always return 0 (when we are in interactive mode,
>> even failure to open should not end the session), and save the
>> return value of openfile() for command line use in main().
>>
>> This has been awkward since at least as far back as commit
>> e3aff4f, in 2009.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> This still makes qemu-io -c "$something" no_such_file fail, right. But
> now qemu-io -c "open no_such_file" -c "$something" will execute
> $something; and I'm not sure we can convert all -c open users to not us=
e
> that command (maybe we can, now that we have --image-opts).

Oh, so we do have some uses of -c "open..." -c "$something" (iotest 103
for example).

What happens during "$something" if there was no file currently open? It
may be a command-by-command behavior.  But as long as we get graceful
secondary failures rather than crashes for those subsequent $somethings,
we may be okay.

>=20
> I don't think it's absolutely necessary for -c open to exit on error,
> but you seem to do, if I understand your penultimate paragraph
> correctly. :-)

I don't think it's absolutely necessary either.  You're right that this
patch is just worried about 'qemu-img name', not 'qemu-img -c "open
name"'.  So maybe all I need to do is update the commit message to
document that the change in semantics to -c "open..." is a side-effect,
that may or may not be changed in a followup patch?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--V4ubtG2IaTw1uVoHv4L5hfapmQOBNApdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLt1oAAoJEKeha0olJ0NqE+gH/2uhoLU2QuH+ZYe338S2KRO5
/3hH2qaUEi1gRqAvgFkSTgg6sk7154YOyDxSPDyi5iWCG5JElAsYnO/Etiqd/VNU
21SrdV9npvOY9Buf7ZmFAWuKk1AMrRlQMrDxDb76egkU7UZRyfeyWSFyJjwTvTo3
Vk4V4/SvTUovb4wAiwWgM2c2w71fkQV6Toin2hmwDLJ2b2RxheGXBhUpv7gM3cwU
yaeMXjk1QmPjTF/FsB3zXaZ5rr7xNyPnFzJnemhWdFdJeUztqGgdl/72snBnq6gO
beohPO8AFnLL53Yr/TI4ydo26mErz3w0A5Omi7jtHSDb8TyfQEW48UpJoea4Gn0=
=PoRv
-----END PGP SIGNATURE-----

--V4ubtG2IaTw1uVoHv4L5hfapmQOBNApdQ--
