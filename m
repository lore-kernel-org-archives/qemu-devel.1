Received: from eggs.gnu.org ([2001:4830:134:3::10]:51901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfB7Q-0004Pu-T0
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfB7N-0001f0-MQ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:28:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfB7N-0001cx-CU
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:28:45 -0400
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
	<9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
	<9f3c0af6-1ff8-adca-9f69-2be8dd7d250f@redhat.com>
	<db1e220e-f3bf-352d-57ac-6ad3b427e944@amsat.org>
	<c26818de-c402-2db2-25f7-0e568ab41ddf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13af5639-c245-f186-6684-479665c700eb@redhat.com>
Date: Tue, 8 Aug 2017 15:28:35 -0500
MIME-Version: 1.0
In-Reply-To: <c26818de-c402-2db2-25f7-0e568ab41ddf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8a6UOq2V68KgmJQ3qLktvmwr5kfrouhqH"
Subject: Re: [Qemu-devel] [for-2.10 PATCH] 9pfs: local: fix
 fchmodat_nofollow() limitations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>, zhiyong.wu@ucloud.cn, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8a6UOq2V68KgmJQ3qLktvmwr5kfrouhqH
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 zhiyong.wu@ucloud.cn, qemu-devel@nongnu.org
Message-ID: <13af5639-c245-f186-6684-479665c700eb@redhat.com>
Subject: Re: [Qemu-devel] [for-2.10 PATCH] 9pfs: local: fix
 fchmodat_nofollow() limitations
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
 <9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
 <9f3c0af6-1ff8-adca-9f69-2be8dd7d250f@redhat.com>
 <db1e220e-f3bf-352d-57ac-6ad3b427e944@amsat.org>
 <c26818de-c402-2db2-25f7-0e568ab41ddf@redhat.com>
In-Reply-To: <c26818de-c402-2db2-25f7-0e568ab41ddf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 03:24 PM, Eric Blake wrote:
> On 08/08/2017 03:10 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Technically, POSIX says (and 'man 2 open' agrees, modulo the fact tha=
t
>>> Linux still lacks O_SEARCH) that you MUST provide one of the 5 access=

>>> modes (they are O_RDONLY, O_RDWR, O_WRONLY, O_EXEC, and O_SEARCH;
>>> although POSIX allows O_EXEC and O_SEARCH to be the same bit pattern)=
,
>>> and then bitwise-or any additional flags.  So the usage here is corre=
ct.
>>>
>=20
>> Oh ok. I didn't think of that, just checked Linux manpage:
>>
>>    O_PATH (since Linux 2.6.39)
>>
>>           When O_PATH is specified in flags, flag bits other than
>>           O_CLOEXEC, O_DIRECTORY, and O_NOFOLLOW are ignored.
>=20
> There are access modes (5 in POSIX), and then flag bits (O_NONBLOCK
> being one of the flag bits, and therefore ignored when O_PATH is true).=

> Presumably, the author was being careful by mentioning "flag bits" (and=

> thereby implicitly meaning that O_RDONLY is NOT ignored when using
> O_PATH).  But I'm not _quite_ sure whether O_PATH should be considered =
a
> sixth access mode, or a flag bit, and the Linux man page doesn't help o=
n
> that front ;)  Hmm - if you treat O_PATH as an access mode rather than =
a
> flag bit, then O_RDONLY | O_PATH no longer makes sense at all (you can'=
t
> mix two modes at once).  Maybe we should file a bug report against the
> man page to get clarification.

Quoting my version of 'man 2 open'

       The  argument  flags  must  include  one of the following access
modes:
       O_RDONLY, O_WRONLY, or O_RDWR.  These request opening  the  file
read-
       only, write-only, or read/write, respectively.

       In addition, zero or more file creation flags and file status
flags can
       be bitwise-or'd in flags.   The  file  creation  flags  are
O_CLOEXEC,
       O_CREAT,  O_DIRECTORY,  O_EXCL,  O_NOCTTY,  O_NOFOLLOW,
O_TMPFILE, and
       O_TRUNC.  The file status flags are all of the remaining  flags
listed
       below.   The  distinction between these two groups of flags is
that the
       file status flags can be retrieved and (in some  cases)
modified;  see
       fcntl(2) for details.

and fcntl() lets you see whether an fd was opened with O_PATH, which
makes it a file status flag.  Well, except that fcntl() also lets you
see which mode an fd was opened with (such as O_WRONLY).  Hmm - still fuz=
zy.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8a6UOq2V68KgmJQ3qLktvmwr5kfrouhqH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKHvMACgkQp6FrSiUn
Q2owQwf/dTCAtkZ8dt/MvRW08h/sXJIDrU6TL835U3cb7SRjHEeKUjYTKFZ4vTAF
hdXlOpwtjHIDXW6rTG14bVx2yuGtMBo2WzI3+uLHc81ymflfnhwYTjCH8Rdpyzb+
zfh2fUWjDARW+N3ZzopkbU2878amG0gLner1IvNTSWJkiNl36k5UbIpYZLBVN5Te
2L+aBJcbfbZip/0uPkcbzrPQsCrqMM/ZbEWq+Lzgxr5dPdsfTBHu421fILPAOLY+
WeN88eAw6rziRqJPlcPXi4gNSNHhw9TwrXBMdv/g7tlnmFTC+sDxT4dX4Rv0FvI4
bBnmUzOLrpiTP44a/xpZndPq/MBLpg==
=+4Qt
-----END PGP SIGNATURE-----

--8a6UOq2V68KgmJQ3qLktvmwr5kfrouhqH--
