Received: from eggs.gnu.org ([2001:4830:134:3::10]:46355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAMvI-0006ks-NC
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAMvE-0000IY-Ef
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:21:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:56536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAMvE-0000Hu-5T
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:21:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAMvD-0006Ak-77
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 21:21:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 34AF02E8069
	for <qemu-devel@nongnu.org>; Thu,  2 Nov 2017 21:21:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Nov 2017 21:14:43 -0000
From: Max Reitz <1728639@bugs.launchpad.net>
Reply-To: Bug 1728639 <1728639@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150937882540.4122.2407662790431063606.malonedeb@gac.canonical.com>
Message-Id: <150965728318.5178.3990282102837730873.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728639] Re: qemu-io crashes with SIGSEGV when
 did -c truncate 320000 on a image_fuzzer image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

Thanks a lot for reporting this bug!  I've found a fix and I'll send a
patch once I've written a test case.

Max

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728639

Title:
  qemu-io crashes with SIGSEGV when did  -c truncate 320000 on a
  image_fuzzer image

Status in QEMU:
  New

Bug description:
  git is at HEAD a93ece47fd9edbd4558db24300056c9a57d3bcd4
  This is on ppc64le architecture.

  Re-production steps:

  1. Copy the attached files named test.img to a directory
  2. And customize the following command to point to the above directory an=
d run the same.
  # mv test.img copy.img
  # qemu-io <path to>/copy.img -c "truncate 320000"

  from gdb:
  Program terminated with signal 11, Segmentation fault.
  #0  0x000000001000e444 in refresh_total_sectors (bs=3D0x1fe86f60, hint=3D=
11648) at block.c:723
  723	    if (drv->bdrv_getlength) {
  Missing separate debuginfos, use: debuginfo-install cyrus-sasl-lib-2.1.26=
-21.el7.ppc64le glib2-2.50.3-3.el7.ppc64le glibc-2.17-196.el7.ppc64le gmp-6=
.0.0-15.el7.ppc64le gnutls-3.3.26-9.el7.ppc64le keyutils-libs-1.5.8-3.el7.p=
pc64le krb5-libs-1.15.1-8.el7.ppc64le libaio-0.3.109-13.el7.ppc64le libcom_=
err-1.42.9-10.el7.ppc64le libcurl-7.29.0-42.el7.ppc64le libffi-3.0.13-18.el=
7.ppc64le libgcc-4.8.5-16.el7_4.1.ppc64le libidn-1.28-4.el7.ppc64le libseli=
nux-2.5-11.el7.ppc64le libssh2-1.4.3-10.el7_2.1.ppc64le libstdc++-4.8.5-16.=
el7_4.1.ppc64le libtasn1-4.10-1.el7.ppc64le nettle-2.7.1-8.el7.ppc64le nspr=
-4.13.1-1.0.el7_3.ppc64le nss-3.28.4-15.el7_4.ppc64le nss-softokn-freebl-3.=
28.3-8.el7_4.ppc64le nss-util-3.28.4-3.el7.ppc64le openldap-2.4.44-5.el7.pp=
c64le openssl-libs-1.0.2k-8.el7.ppc64le p11-kit-0.23.5-3.el7.ppc64le pcre-8=
.32-17.el7.ppc64le zlib-1.2.7-17.el7.ppc64le
  (gdb) bt
  #0  0x000000001000e444 in refresh_total_sectors (bs=3D0x1fe86f60, hint=3D=
11648) at block.c:723
  #1  0x000000001000fa10 in bdrv_open_driver (bs=3D0x1fe86f60, drv=3D0x1020=
36f0 <bdrv_qcow2>, node_name=3D0x0, options=3D0x1fe8c240, open_flags=3D2457=
8,
      errp=3D0x3fffea0fc920) at block.c:1153
  #2  0x0000000010010480 in bdrv_open_common (bs=3D0x1fe86f60, file=3D0x1fe=
92540, options=3D0x1fe8c240, errp=3D0x3fffea0fc920) at block.c:1395
  #3  0x0000000010013ac8 in bdrv_open_inherit (filename=3D0x3fffea0ff661 "c=
opy.img", reference=3D0x0, options=3D0x1fe8c240, flags=3D24578, parent=3D0x=
0, child_role=3D0x0,
      errp=3D0x3fffea0fcae0) at block.c:2616
  #4  0x0000000010013e8c in bdrv_open (filename=3D0x3fffea0ff661 "copy.img"=
, reference=3D0x0, options=3D0x0, flags=3D16386, errp=3D0x3fffea0fcae0) at =
block.c:2698
  #5  0x000000001008b6d4 in blk_new_open (filename=3D0x3fffea0ff661 "copy.i=
mg", reference=3D0x0, options=3D0x0, flags=3D16386, errp=3D0x3fffea0fcae0)
      at block/block-backend.c:321
  #6  0x000000001000a6ec in openfile (name=3D0x3fffea0ff661 "copy.img", fla=
gs=3D16386, writethrough=3Dtrue, force_share=3Dfalse, opts=3D0x0) at qemu-i=
o.c:81
  #7  0x000000001000c040 in main (argc=3D4, argv=3D0x3fffea0fd208) at qemu-=
io.c:624
  (gdb) bt full
  #0  0x000000001000e444 in refresh_total_sectors (bs=3D0x1fe86f60, hint=3D=
11648) at block.c:723
          drv =3D 0x0
  #1  0x000000001000fa10 in bdrv_open_driver (bs=3D0x1fe86f60, drv=3D0x1020=
36f0 <bdrv_qcow2>, node_name=3D0x0, options=3D0x1fe8c240, open_flags=3D2457=
8,
      errp=3D0x3fffea0fc920) at block.c:1153
          local_err =3D 0x0
          ret =3D 0
          __PRETTY_FUNCTION__ =3D "bdrv_open_driver"
          __func__ =3D "bdrv_open_driver"
  #2  0x0000000010010480 in bdrv_open_common (bs=3D0x1fe86f60, file=3D0x1fe=
92540, options=3D0x1fe8c240, errp=3D0x3fffea0fc920) at block.c:1395
          ret =3D 16383
          open_flags =3D 24578
          filename =3D 0x1fe8e2b1 "copy.img"
          driver_name =3D 0x1fe54810 "qcow2"
          node_name =3D 0x0
          discard =3D 0x0
          detect_zeroes =3D 0x0
          opts =3D 0x1fe93100
          drv =3D 0x102036f0 <bdrv_qcow2>
          local_err =3D 0x0
          __PRETTY_FUNCTION__ =3D "bdrv_open_common"
          __func__ =3D "bdrv_open_common"
  #3  0x0000000010013ac8 in bdrv_open_inherit (filename=3D0x3fffea0ff661 "c=
opy.img", reference=3D0x0, options=3D0x1fe8c240, flags=3D24578, parent=3D0x=
0, child_role=3D0x0,
      errp=3D0x3fffea0fcae0) at block.c:2616
          ret =3D 512
          file =3D 0x1fe92540
          bs =3D 0x1fe86f60
          drv =3D 0x102036f0 <bdrv_qcow2>
          drvname =3D 0x0
          backing =3D 0x0
          local_err =3D 0x0
          snapshot_options =3D 0x0
          snapshot_flags =3D 0
          __PRETTY_FUNCTION__ =3D "bdrv_open_inherit"
          __func__ =3D "bdrv_open_inherit"
  #4  0x0000000010013e8c in bdrv_open (filename=3D0x3fffea0ff661 "copy.img"=
, reference=3D0x0, options=3D0x0, flags=3D16386, errp=3D0x3fffea0fcae0) at =
block.c:2698
  No locals.
  #5  0x000000001008b6d4 in blk_new_open (filename=3D0x3fffea0ff661 "copy.i=
mg", reference=3D0x0, options=3D0x0, flags=3D16386, errp=3D0x3fffea0fcae0)
      at block/block-backend.c:321
          blk =3D 0x1fe79410
          bs =3D 0x0
          perm =3D 3
  #6  0x000000001000a6ec in openfile (name=3D0x3fffea0ff661 "copy.img", fla=
gs=3D16386, writethrough=3Dtrue, force_share=3Dfalse, opts=3D0x0) at qemu-i=
o.c:81
          local_err =3D 0x0
  #7  0x000000001000c040 in main (argc=3D4, argv=3D0x3fffea0fd208) at qemu-=
io.c:624
          readonly =3D 0
          sopt =3D 0x101b2608 "hVc:d:f:rsnCmkt:T:U"
          lopt =3D {{name =3D 0x101b26d0 "driver", has_arg =3D 0, flag =3D =
0x0, val =3D 104}, {name =3D 0x101b26d8 "help", has_arg =3D 0, flag =3D 0x0=
, val =3D 86}, {
              name =3D 0x101b26e0 "version", has_arg =3D 1, flag =3D 0x0, v=
al =3D 99}, {name =3D 0x101b26e8 "cmd", has_arg =3D 1, flag =3D 0x0, val =
=3D 102}, {
              name =3D 0x101b26f0 "format", has_arg =3D 0, flag =3D 0x0, va=
l =3D 114}, {name =3D 0x101b2700 "y", has_arg =3D 0, flag =3D 0x0, val =3D =
115}, {
              name =3D 0x101b2710 "", has_arg =3D 0, flag =3D 0x0, val =3D =
110}, {name =3D 0x101b2718 "nocache", has_arg =3D 0, flag =3D 0x0, val =3D =
67}, {
  ---Type <return> to continue, or q <return> to quit---
              name =3D 0x101b2728 "read", has_arg =3D 0, flag =3D 0x0, val =
=3D 109}, {name =3D 0x101b2738 "", has_arg =3D 0, flag =3D 0x0, val =3D 107=
}, {
              name =3D 0x101b2748 "io", has_arg =3D 1, flag =3D 0x0, val =
=3D 100}, {name =3D 0x101b2750 "discard", has_arg =3D 1, flag =3D 0x0, val =
=3D 116}, {
              name =3D 0x101b2758 "cache", has_arg =3D 1, flag =3D 0x0, val=
 =3D 84}, {name =3D 0x101b25e8 "object", has_arg =3D 1, flag =3D 0x0, val =
=3D 256}, {
              name =3D 0x101b2760 "trace", has_arg =3D 0, flag =3D 0x0, val=
 =3D 257}, {name =3D 0x101b1c48 "force-share", has_arg =3D 0, flag =3D 0x0,=
 val =3D 85}, {name =3D 0x0,
              has_arg =3D 0, flag =3D 0x0, val =3D 0}}
          c =3D -1
          opt_index =3D 0
          flags =3D 16386
          writethrough =3D true
          local_error =3D 0x0
          opts =3D 0x0
          format =3D 0x0
          trace_file =3D 0x0
          force_share =3D false
  (gdb)
  (gdb) quit

  Will attach image_fuzzer image.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728639/+subscriptions
