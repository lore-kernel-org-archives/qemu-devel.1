Received: from eggs.gnu.org ([2001:4830:134:3::10]:35426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddGXZ-0001ZT-Ug
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddGXW-0003Yi-WB
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:51:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddGXW-0003X7-LN
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:51:50 -0400
References: <150176232235.21421.11970305069558342885.malonedeb@wampee.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <10dfbd79-e5bd-e88c-27d8-246f89315387@redhat.com>
Date: Thu, 3 Aug 2017 08:51:44 -0500
MIME-Version: 1.0
In-Reply-To: <150176232235.21421.11970305069558342885.malonedeb@wampee.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="naTrWosQ2PSam0upfxSnnnEHbrQ2LNGBI"
Subject: Re: [Qemu-devel] [Bug 1708442] [NEW] Crash(assert) during reading
 image from http url through qemu-nbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1708442 <1708442@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--naTrWosQ2PSam0upfxSnnnEHbrQ2LNGBI
From: Eric Blake <eblake@redhat.com>
To: Bug 1708442 <1708442@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <10dfbd79-e5bd-e88c-27d8-246f89315387@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1708442] [NEW] Crash(assert) during reading
 image from http url through qemu-nbd
References: <150176232235.21421.11970305069558342885.malonedeb@wampee.canonical.com>
In-Reply-To: <150176232235.21421.11970305069558342885.malonedeb@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 07:12 AM, Andrey Smetanin wrote:
> Public bug reported:
>=20
> Description:
> During reading image from nbd device mounted by qemu-nbd server with ur=
l backend I/O error happens
> "blk_update_request: I/O error, dev nbd0, sector 42117" dmesg. After so=
me investigation I found that qemu-nbd server aborts in aio_co_enter() as=
sert in util/async.c:468.
>=20

Based on the backtrace, this looks to be a bug in the block/curl.c
driver, rather than the nbd/ or block/nbd.c code.  If I'm right, it
should be possible to reproduce the crash using qemu-io directly on the
curl path, rather than adding the extra layer of an nbd client reading
through qemu-nbd (then again, having the qemu-nbd layer may be what is
allowing multiple parallel requests to hit the curl driver at once,
while qemu-io is not quite as easy to provoke into performing
complicated access patterns).

>=20
> Steps to reproduce:
>=20
> 1) sudo go run qemu-nbd-bug-report/qemu-nbd-bug.go (see qemu-nbd-bug-
> report.tar.gz)
>=20
> or try directly
>=20
> 1) qemu-nbd -c /dev/nbd0 -r -v --aio=3Dnative -f qcow2 json:{"file.driv=
er":"http","file.url":"http://localhost:9666/image","file.readahead":3276=
800

Presumably, you've got something serving the file at port 9666?

> 2) try read whole nbd device while error in dmesg appears x
>=20
> Versions:
>=20
> 1) qemu built from sources(/configure --target-list=3Dx86_64-softmmu --=
disable-user --enable-curl --enable-linux-aio --enable-virtfs --enable-de=
bug --disable-pie
> , top commit 5619c179057e24195ff19c8fe6d6a6cbcb16ed28):
>=20
> qemu-nbd -v
> qemu-nbd 2.9.90 (v2.10.0-rc0-67-g5619c17)
>=20
> 2) libcurl(built from sources, top commit
> 1767adf4399bb3be29121435e1bb1cc2bc05f7bf):
>=20
> curl -V
> curl 7.55.0-DEV (Linux) libcurl/7.55.0-DEV OpenSSL/1.0.2g zlib/1.2.8
>=20
>=20
> Backtrace:
> (gdb) bt
> #0  0x00007f7131426428 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdep=
s/unix/sysv/linux/raise.c:54
> #1  0x00007f713142802a in __GI_abort () at abort.c:89
> #2  0x00007f713141ebd7 in __assert_fail_base (fmt=3D<optimized out>, as=
sertion=3Dassertion@entry=3D0x54c924 "self !=3D co",=20
>     file=3Dfile@entry=3D0x54c871 "util/async.c", line=3Dline@entry=3D46=
8,=20
>     function=3Dfunction@entry=3D0x54c980 <__PRETTY_FUNCTION__.24766> "a=
io_co_enter") at assert.c:92
> #3  0x00007f713141ec82 in __GI___assert_fail (assertion=3D0x54c924 "sel=
f !=3D co", file=3D0x54c871 "util/async.c", line=3D468,=20
>     function=3D0x54c980 <__PRETTY_FUNCTION__.24766> "aio_co_enter") at =
assert.c:101
> #4  0x00000000004fe6a2 in aio_co_enter (ctx=3D0xf0ddb0, co=3D0xf14650) =
at util/async.c:468
> #5  0x00000000004fe637 in aio_co_wake (co=3D0xf14650) at util/async.c:4=
56
> #6  0x0000000000495c8a in curl_read_cb (ptr=3D0xf566d9, size=3D1, nmemb=
=3D16135, opaque=3D0xf1cb90) at block/curl.c:275
> #7  0x00007f713242ac24 in Curl_client_chop_write () from /usr/lib/x86_6=
4-linux-gnu/libcurl.so
> #8  0x00007f713242ae03 in Curl_client_write () from /usr/lib/x86_64-lin=
ux-gnu/libcurl.so
> #9  0x00007f713244e1cf in readwrite_data () from /usr/lib/x86_64-linux-=
gnu/libcurl.so
> #10 0x00007f713244eb6f in Curl_readwrite () from /usr/lib/x86_64-linux-=
gnu/libcurl.so
> #11 0x00007f713245c1bb in multi_runsingle () from /usr/lib/x86_64-linux=
-gnu/libcurl.so
> #12 0x00007f713245d819 in multi_socket () from /usr/lib/x86_64-linux-gn=
u/libcurl.so
> #13 0x00007f713245e067 in curl_multi_socket_action () from /usr/lib/x86=
_64-linux-gnu/libcurl.so
> #14 0x0000000000497555 in curl_setup_preadv (bs=3D0xf16820, acb=3D0x7f7=
12d379860) at block/curl.c:918
> #15 0x00000000004975fb in curl_co_preadv (bs=3D0xf16820, offset=3D65561=
60, bytes=3D512, qiov=3D0x7f712d379b40, flags=3D0) at block/curl.c:935

The backtrace is definitely pointing at curl as being the problem.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--naTrWosQ2PSam0upfxSnnnEHbrQ2LNGBI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDKnAACgkQp6FrSiUn
Q2ry4Qf/RxLUMzjbbpOEXajFY7sOJfuLK6zkWWD05qynQHsKn9N+MAlJFEuLwiPw
gb/Tj5zrHoxq+uUu5Q3Ytw7OUovdnbnNbJxpfEYNgtXz05WIKGUJYHalsRAdDb2w
+r0F6POfQ6SZnjn0qMGgwKP/ZAsoFY6Pi28rD2kDx0fIhOnl/1FtUldFUC/gXYzX
DbGiL6FvF7ZXv9LUPFBr5hoFqA8pFd9Lm7LBwieowLAe9MglYp+paHiic5bwKJmv
JL6uUxyhAlpvbFVYjQfVAdjMqTMPFVPuNKG7j89nKGbSzA7NU6TTzDpntH/K8dak
ieffQzDCOH86d8k5owgIGBVW3UpswA==
=em7h
-----END PGP SIGNATURE-----

--naTrWosQ2PSam0upfxSnnnEHbrQ2LNGBI--
