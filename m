Received: from eggs.gnu.org ([2001:4830:134:3::10]:34014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG5zI-0005do-Bu
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG5zH-0008IR-8L
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:56:44 -0400
References: <20170524202842.26724-1-eblake@redhat.com>
	<20170524202842.26724-2-eblake@redhat.com>
	<d74bac5d-4fa9-d7cc-9534-0a3fe22af6fc@redhat.com>
	<8680a378-d19e-55f9-f14b-158907bb9919@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e20ef1ea-57d1-3592-d1d3-c3f2adfa013b@redhat.com>
Date: Wed, 31 May 2017 17:56:31 +0200
MIME-Version: 1.0
In-Reply-To: <8680a378-d19e-55f9-f14b-158907bb9919@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g1pHd3BiE6G3E7ruJNDjRP9hDqCcTMvTb"
Subject: Re: [Qemu-devel] [PATCH v2 1/5] qemu-io: Don't die on second open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g1pHd3BiE6G3E7ruJNDjRP9hDqCcTMvTb
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>
Message-ID: <e20ef1ea-57d1-3592-d1d3-c3f2adfa013b@redhat.com>
Subject: Re: [PATCH v2 1/5] qemu-io: Don't die on second open
References: <20170524202842.26724-1-eblake@redhat.com>
 <20170524202842.26724-2-eblake@redhat.com>
 <d74bac5d-4fa9-d7cc-9534-0a3fe22af6fc@redhat.com>
 <8680a378-d19e-55f9-f14b-158907bb9919@redhat.com>
In-Reply-To: <8680a378-d19e-55f9-f14b-158907bb9919@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-31 17:12, Eric Blake wrote:
> On 05/31/2017 09:18 AM, Max Reitz wrote:
>> On 2017-05-24 22:28, Eric Blake wrote:
>>> Most callback commands in qemu-io return 0 to keep the interpreter
>>> loop running, or 1 to quit immediately.  However, open_f() just
>>> passed through the return value of openfile(), which has different
>>> semantics of returning 0 if a file was opened, or 1 on any failure.
>>>
>>> As a result of mixing the return semantics, we are forcing the
>>> qemu-io interpreter to exit early on any failures, which is rather
>>> annoying when some of the failures are obviously trying to give
>>> the user a hint of how to proceed (if we didn't then kill qemu-io
>>> out from under the user's feet):
>>>
>>> $ qemu-io
>>> qemu-io> open foo
>>> qemu-io> open foo
>>> file open already, try 'help close'
>>> $ echo $?
>>> 0
>>>
>>> Meanwhile, we WANT openfile() to report failures, as it is the
>>> way that 'qemu-io -c "$something" no_such_file' knows to exit
>>> early rather than attempting $something.  So the solution is to
>>> fix open_f() to always return 0 (when we are in interactive mode,
>>> even failure to open should not end the session), and save the
>>> return value of openfile() for command line use in main().
>>>
>>> This has been awkward since at least as far back as commit
>>> e3aff4f, in 2009.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> This still makes qemu-io -c "$something" no_such_file fail, right. But=

>> now qemu-io -c "open no_such_file" -c "$something" will execute
>> $something; and I'm not sure we can convert all -c open users to not u=
se
>> that command (maybe we can, now that we have --image-opts).
>=20
> Oh, so we do have some uses of -c "open..." -c "$something" (iotest 103=

> for example).
>=20
> What happens during "$something" if there was no file currently open? I=
t
> may be a command-by-command behavior.  But as long as we get graceful
> secondary failures rather than crashes for those subsequent $somethings=
,
> we may be okay.

Sure, but this is arguing against "we want [qemu-io no_such_file] to
exit early". :-)

>> I don't think it's absolutely necessary for -c open to exit on error,
>> but you seem to do, if I understand your penultimate paragraph
>> correctly. :-)
>=20
> I don't think it's absolutely necessary either.  You're right that this=

> patch is just worried about 'qemu-img name', not 'qemu-img -c "open
> name"'.  So maybe all I need to do is update the commit message to
> document that the change in semantics to -c "open..." is a side-effect,=

> that may or may not be changed in a followup patch?

If you're OK with that, I am, too.

Max


--g1pHd3BiE6G3E7ruJNDjRP9hDqCcTMvTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLuevEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQD1a
CACEvcluc1oZL0xeBw1wSNCe7fboGN0Fc+hxI/M0/TxBAlGOq0KC+a5b90vcmIMR
f8Bbezz/st4IJzgNStVqw6scboiN7DMiSxtPNKaZ6ZbYO5kwBUP9JmtKtRmNJApb
2CyifRRWHwThVSJgqmTOJvQAhW+S4lPmkE2myrF9KBB7EdA/FtMpzCd8+8Fy5so8
ExVjJY89Cq7HOur6+10mGtVtrPSBOfMsr0HtXLEkCLdMykNyFBZiQYoxkkU0pvBP
c4LQgLoej6xhSELWXJ5F5Er9SUzaY1XDw7w2HawVuYjP1yJv+7KNEp8+AA8M2qZg
k7i465DjsWlA6Fc+nv1I5lYJ
=7rEr
-----END PGP SIGNATURE-----

--g1pHd3BiE6G3E7ruJNDjRP9hDqCcTMvTb--
