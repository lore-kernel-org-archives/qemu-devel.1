Received: from eggs.gnu.org ([2001:4830:134:3::10]:52398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqlbC-0004qs-6C
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqlb9-0001wA-24
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:07:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqlb8-0001w3-Pr
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:07:07 -0400
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c46ff864-fc8b-aeba-30f4-4c773f879786@redhat.com>
Date: Wed, 22 Mar 2017 14:07:04 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k26KOG4IPg934CHVt3JXKi8JGUskHhrgl"
Subject: [Qemu-devel] rawhide gcc failures [was: Proposal for deprecating
 unsupported host OSes & architecutures]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k26KOG4IPg934CHVt3JXKi8JGUskHhrgl
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <c46ff864-fc8b-aeba-30f4-4c773f879786@redhat.com>
Subject: rawhide gcc failures [was: Proposal for deprecating unsupported host
 OSes & architecutures]
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
In-Reply-To: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 10:23 AM, Peter Maydell wrote:
> OK, here's a concrete proposal for deprecating/dropping out of
> date host OS and architecture support.
>=20
> We'll put this in the ChangeLog 'Future incompatible changes'
> section:
> -----
> * Removal of support for untested host OS and architectures:

Tangentially-related: do we officially support bleeding-edge OS builds?
For example, current rawhide has a new-enough gcc that gives some
(possibly-useful) new warnings (-Werror=3Dformat-truncation) that fire
when formatting what can be easily proven to be larger than a
fixed-width buffer will hold.  If rawhide is not a current target, then
I don't need to spend any time on this (yet); but if rawhide builds ARE
supported, then we want this patched before 2.9:


  CC      block/blkdebug.o
block/blkdebug.c: In function =E2=80=98blkdebug_refresh_filename=E2=80=99=
:
block/blkdebug.c:693:31: error: =E2=80=98%s=E2=80=99 directive output may=
 be truncated
writing up to 4095 bytes into a region of size 4086
[-Werror=3Dformat-truncation=3D]
                  "blkdebug:%s:%s", s->config_file ?: "",
                               ^~
block/blkdebug.c:692:9: note: =E2=80=98snprintf=E2=80=99 output 11 or mor=
e bytes
(assuming 4106) into a destination of size 4096
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  "blkdebug:%s:%s", s->config_file ?: "",
                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  bs->file->bs->exact_filename);
                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/home/dummy/qemu/rules.mak:69: block/blkdebug.o] Error 1
  CC      block/blkverify.o
block/blkverify.c: In function =E2=80=98blkverify_refresh_filename=E2=80=99=
:
block/blkverify.c:309:29: error: =E2=80=98%s=E2=80=99 directive output ma=
y be truncated
writing up to 4095 bytes into a region of size 4086
[-Werror=3Dformat-truncation=3D]
                  "blkverify:%s:%s",
                             ^~
block/blkverify.c:308:9: note: =E2=80=98snprintf=E2=80=99 output between =
12 and 8202
bytes into a destination of size 4096
         snprintf(bs->exact_filename, sizeof(bs->exact_filename),
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  "blkverify:%s:%s",
                  ~~~~~~~~~~~~~~~~~~
                  bs->file->bs->exact_filename,
                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  s->test_file->bs->exact_filename);
                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/home/dummy/qemu/rules.mak:69: block/blkverify.o] Error 1
  CC      hw/usb/bus.o
hw/usb/bus.c: In function =E2=80=98usb_port_location=E2=80=99:
hw/usb/bus.c:410:66: error: =E2=80=98%d=E2=80=99 directive output may be =
truncated
writing between 1 and 11 bytes into a region of size between 0 and 15
[-Werror=3Dformat-truncation=3D]
         snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
                                                                  ^~
hw/usb/bus.c:410:9: note: =E2=80=98snprintf=E2=80=99 output between 3 and=
 28 bytes into
a destination of size 16
         snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  upstream->path, portnr);
                  ~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/home/dummy/qemu/rules.mak:69: hw/usb/bus.o] Error 1
  CC      net/slirp.o
net/slirp.c: In function =E2=80=98slirp_smb_cleanup=E2=80=99:
net/slirp.c:565:44: error: =E2=80=98%s=E2=80=99 directive output may be t=
runcated
writing up to 127 bytes into a region of size 121
[-Werror=3Dformat-truncation=3D]
         snprintf(cmd, sizeof(cmd), "rm -rf %s", s->smb_dir);
                                            ^~
net/slirp.c:565:9: note: =E2=80=98snprintf=E2=80=99 output between 8 and =
135 bytes into
a destination of size 128
         snprintf(cmd, sizeof(cmd), "rm -rf %s", s->smb_dir);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/slirp.c: In function =E2=80=98slirp_smb=E2=80=99:
net/slirp.c:609:46: error: =E2=80=98%s=E2=80=99 directive output may be t=
runcated
writing 8 bytes into a region of size between 0 and 127
[-Werror=3Dformat-truncation=3D]
     snprintf(smb_conf, sizeof(smb_conf), "%s/%s", s->smb_dir, "smb.conf"=
);
                                              ^~               ~~~~~~~~~~=

net/slirp.c:609:5: note: =E2=80=98snprintf=E2=80=99 output between 10 and=
 137 bytes into
a destination of size 128
     snprintf(smb_conf, sizeof(smb_conf), "%s/%s", s->smb_dir, "smb.conf"=
);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
net/slirp.c:654:55: error: =E2=80=98%s=E2=80=99 directive output may be t=
runcated
writing up to 127 bytes into a region of size 110
[-Werror=3Dformat-truncation=3D]
     snprintf(smb_cmdline, sizeof(smb_cmdline), "%s -l %s -s %s",
                                                       ^~
net/slirp.c:654:5: note: =E2=80=98snprintf=E2=80=99 output 23 or more byt=
es (assuming
150) into a destination of size 128
     snprintf(smb_cmdline, sizeof(smb_cmdline), "%s -l %s -s %s",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/home/dummy/qemu/rules.mak:69: net/slirp.o] Error 1
make: Target 'all' not remade because of errors.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--k26KOG4IPg934CHVt3JXKi8JGUskHhrgl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0stYAAoJEKeha0olJ0NqKpkH/jSurObrIv3MMEAKPbppdH1m
D6xkHNQKj9HIqUImKhRqF4WrS37Jfxul96ixSv3aPrbRg0SwZKqAZSJAJ84U5qf8
aq+xybzA4oVIN13HPW4ZYwUKrTpa5cIg2Lgv4N3Fts4A4WmrsovuhiFTtBJ7silx
W6FDeeml0gFnOWKwtw/t/+0TsK/yLdsGHUsXjdZlpCKIw/kQUeTDAOHaI0e3Wl5r
JHC1ZYJt6M3xaYFWxuGgQRoDuOdTTRSaWzjdc9e/npo6NIx8++MwlBA1uGfgJGkX
vNyz+n0tXCpy5vBHGZNtP/fbCHdLRbjUO3kuI1fbn+HdR15UZ4xjSk0X+VVcZLk=
=1oYK
-----END PGP SIGNATURE-----

--k26KOG4IPg934CHVt3JXKi8JGUskHhrgl--
