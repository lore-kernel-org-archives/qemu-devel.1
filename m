Received: from eggs.gnu.org ([2001:4830:134:3::10]:56257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9Dk6-0003Dl-Kd
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9Dk3-0002Ax-Ci
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:20:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:53996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e9Dk3-0002AP-37
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:20:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e9Dk2-0004HS-7e
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 17:20:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 37CB92E80C7
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 17:20:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Oct 2017 17:08:02 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1728661 <1728661@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150938328262.20448.12104835174396986902.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728661] [NEW] qemu-io segfaults at
 block/qcow2.h:533
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

git is at HEAD a93ece47fd9edbd4558db24300056c9a57d3bcd4
This is on ppc64le architecture.

Re-production steps:

1. Copy the attached file named test.img to a directory
2. And customize the following command to point to the above directory and =
run the same.
# mv test.img copy.img
# qemu-io <path to>/copy.img -c "truncate 66560"

from gdb:
Program terminated with signal 11, Segmentation fault.
#0  0x0000000010054cec in get_refblock_offset (s=3D0x32ca3210, offset=3D922=
3372036854775296) at ./block/qcow2.h:533
533	    return s->refcount_table[index] & REFT_OFFSET_MASK;
Missing separate debuginfos, use: debuginfo-install cyrus-sasl-lib-2.1.26-2=
1.el7.ppc64le glib2-2.50.3-3.el7.ppc64le glibc-2.17-196.el7.ppc64le gmp-6.0=
.0-15.el7.ppc64le gnutls-3.3.26-9.el7.ppc64le keyutils-libs-1.5.8-3.el7.ppc=
64le krb5-libs-1.15.1-8.el7.ppc64le libaio-0.3.109-13.el7.ppc64le libcom_er=
r-1.42.9-10.el7.ppc64le libcurl-7.29.0-42.el7.ppc64le libffi-3.0.13-18.el7.=
ppc64le libgcc-4.8.5-16.el7_4.1.ppc64le libidn-1.28-4.el7.ppc64le libselinu=
x-2.5-11.el7.ppc64le libssh2-1.4.3-10.el7_2.1.ppc64le libstdc++-4.8.5-16.el=
7_4.1.ppc64le libtasn1-4.10-1.el7.ppc64le nettle-2.7.1-8.el7.ppc64le nspr-4=
.13.1-1.0.el7_3.ppc64le nss-3.28.4-15.el7_4.ppc64le nss-softokn-freebl-3.28=
.3-8.el7_4.ppc64le nss-util-3.28.4-3.el7.ppc64le openldap-2.4.44-5.el7.ppc6=
4le openssl-libs-1.0.2k-8.el7.ppc64le p11-kit-0.23.5-3.el7.ppc64le pcre-8.3=
2-17.el7.ppc64le zlib-1.2.7-17.el7.ppc64le
(gdb) bt
#0  0x0000000010054cec in get_refblock_offset (s=3D0x32ca3210, offset=3D922=
3372036854775296) at ./block/qcow2.h:533
#1  0x000000001005df4c in qcow2_discard_refcount_block (bs=3D0x32c96f60, di=
scard_block_offs=3D9223372036854775296) at block/qcow2-refcount.c:3070
#2  0x000000001005e5c4 in qcow2_shrink_reftable (bs=3D0x32c96f60) at block/=
qcow2-refcount.c:3169
#3  0x0000000010051184 in qcow2_truncate (bs=3D0x32c96f60, offset=3D66560, =
prealloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block/qcow2.c:3155
#4  0x0000000010016480 in bdrv_truncate (child=3D0x32ca6270, offset=3D66560=
, prealloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block.c:3585
#5  0x0000000010090800 in blk_truncate (blk=3D0x32c89410, offset=3D66560, p=
realloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block/block-backend.=
c:1845
#6  0x0000000010023028 in truncate_f (blk=3D0x32c89410, argc=3D2, argv=3D0x=
32c685a0) at qemu-io-cmds.c:1580
#7  0x000000001001e648 in command (blk=3D0x32c89410, ct=3D0x32c96e30, argc=
=3D2, argv=3D0x32c685a0) at qemu-io-cmds.c:117
#8  0x0000000010024d64 in qemuio_command (blk=3D0x32c89410, cmd=3D0x3fffc05=
2f66e "truncate 66560") at qemu-io-cmds.c:2291
#9  0x000000001000b540 in command_loop () at qemu-io.c:374
#10 0x000000001000c05c in main (argc=3D4, argv=3D0x3fffc051f618) at qemu-io=
.c:630
(gdb) bt full
#0  0x0000000010054cec in get_refblock_offset (s=3D0x32ca3210, offset=3D922=
3372036854775296) at ./block/qcow2.h:533
        index =3D 4294967295
#1  0x000000001005df4c in qcow2_discard_refcount_block (bs=3D0x32c96f60, di=
scard_block_offs=3D9223372036854775296) at block/qcow2-refcount.c:3070
        s =3D 0x32ca3210
        refblock_offs =3D 852111520
        cluster_index =3D 16384
        block_index =3D 3226593616
        refblock =3D 0x32cb9570
        ret =3D 16384
        __PRETTY_FUNCTION__ =3D "qcow2_discard_refcount_block"
#2  0x000000001005e5c4 in qcow2_shrink_reftable (bs=3D0x32c96f60) at block/=
qcow2-refcount.c:3169
        s =3D 0x32ca3210
        reftable_tmp =3D 0x32cb9570
        i =3D 0
        ret =3D 0
#3  0x0000000010051184 in qcow2_truncate (bs=3D0x32c96f60, offset=3D66560, =
prealloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block/qcow2.c:3155
        last_cluster =3D 70367675804416
        old_file_size =3D 70367675804416
        s =3D 0x32ca3210
        old_length =3D 1048576
        new_l1_size =3D 1
        ret =3D 0
        __func__ =3D "qcow2_truncate"
        __PRETTY_FUNCTION__ =3D "qcow2_truncate"
        __FUNCTION__ =3D "qcow2_truncate"
#4  0x0000000010016480 in bdrv_truncate (child=3D0x32ca6270, offset=3D66560=
, prealloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block.c:3585
        bs =3D 0x32c96f60
        drv =3D 0x102036f0 <bdrv_qcow2>
        ret =3D 16383
        __PRETTY_FUNCTION__ =3D "bdrv_truncate"
        __func__ =3D "bdrv_truncate"
#5  0x0000000010090800 in blk_truncate (blk=3D0x32c89410, offset=3D66560, p=
realloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block/block-backend.=
c:1845
        __func__ =3D "blk_truncate"
#6  0x0000000010023028 in truncate_f (blk=3D0x32c89410, argc=3D2, argv=3D0x=
32c685a0) at qemu-io-cmds.c:1580
        local_err =3D 0x0
        offset =3D 66560
        ret =3D 0
#7  0x000000001001e648 in command (blk=3D0x32c89410, ct=3D0x32c96e30, argc=
=3D2, argv=3D0x32c685a0) at qemu-io-cmds.c:117
        cmd =3D 0x32c684c0 "truncate"
#8  0x0000000010024d64 in qemuio_command (blk=3D0x32c89410, cmd=3D0x3fffc05=
2f66e "truncate 66560") at qemu-io-cmds.c:2291
        ctx =3D 0x32c924d0
        input =3D 0x32c684c0 "truncate"
        ct =3D 0x32c96e30
        v =3D 0x32c685a0
        c =3D 2
        done =3D false
#9  0x000000001000b540 in command_loop () at qemu-io.c:374
        i =3D 0
        done =3D 0
        fetchable =3D 0
---Type <return> to continue, or q <return> to quit---
        prompted =3D 0
        input =3D 0x0
#10 0x000000001000c05c in main (argc=3D4, argv=3D0x3fffc051f618) at qemu-io=
.c:630
        readonly =3D 0
        sopt =3D 0x101b2608 "hVc:d:f:rsnCmkt:T:U"
        lopt =3D {{name =3D 0x101b26d0 "driver", has_arg =3D 0, flag =3D 0x=
0, val =3D 104}, {name =3D 0x101b26d8 "help", has_arg =3D 0, flag =3D 0x0, =
val =3D 86}, {
            name =3D 0x101b26e0 "version", has_arg =3D 1, flag =3D 0x0, val=
 =3D 99}, {name =3D 0x101b26e8 "cmd", has_arg =3D 1, flag =3D 0x0, val =3D =
102}, {
            name =3D 0x101b26f0 "format", has_arg =3D 0, flag =3D 0x0, val =
=3D 114}, {name =3D 0x101b2700 "y", has_arg =3D 0, flag =3D 0x0, val =3D 11=
5}, {
            name =3D 0x101b2710 "", has_arg =3D 0, flag =3D 0x0, val =3D 11=
0}, {name =3D 0x101b2718 "nocache", has_arg =3D 0, flag =3D 0x0, val =3D 67=
}, {
            name =3D 0x101b2728 "read", has_arg =3D 0, flag =3D 0x0, val =
=3D 109}, {name =3D 0x101b2738 "", has_arg =3D 0, flag =3D 0x0, val =3D 107=
}, {
            name =3D 0x101b2748 "io", has_arg =3D 1, flag =3D 0x0, val =3D =
100}, {name =3D 0x101b2750 "discard", has_arg =3D 1, flag =3D 0x0, val =3D =
116}, {
            name =3D 0x101b2758 "cache", has_arg =3D 1, flag =3D 0x0, val =
=3D 84}, {name =3D 0x101b25e8 "object", has_arg =3D 1, flag =3D 0x0, val =
=3D 256}, {
            name =3D 0x101b2760 "trace", has_arg =3D 0, flag =3D 0x0, val =
=3D 257}, {name =3D 0x101b1c48 "force-share", has_arg =3D 0, flag =3D 0x0, =
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

image_fuzzer image will be attached.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728661

Title:
  qemu-io segfaults at block/qcow2.h:533

Status in QEMU:
  New

Bug description:
  git is at HEAD a93ece47fd9edbd4558db24300056c9a57d3bcd4
  This is on ppc64le architecture.

  Re-production steps:

  1. Copy the attached file named test.img to a directory
  2. And customize the following command to point to the above directory an=
d run the same.
  # mv test.img copy.img
  # qemu-io <path to>/copy.img -c "truncate 66560"

  from gdb:
  Program terminated with signal 11, Segmentation fault.
  #0  0x0000000010054cec in get_refblock_offset (s=3D0x32ca3210, offset=3D9=
223372036854775296) at ./block/qcow2.h:533
  533	    return s->refcount_table[index] & REFT_OFFSET_MASK;
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
  #0  0x0000000010054cec in get_refblock_offset (s=3D0x32ca3210, offset=3D9=
223372036854775296) at ./block/qcow2.h:533
  #1  0x000000001005df4c in qcow2_discard_refcount_block (bs=3D0x32c96f60, =
discard_block_offs=3D9223372036854775296) at block/qcow2-refcount.c:3070
  #2  0x000000001005e5c4 in qcow2_shrink_reftable (bs=3D0x32c96f60) at bloc=
k/qcow2-refcount.c:3169
  #3  0x0000000010051184 in qcow2_truncate (bs=3D0x32c96f60, offset=3D66560=
, prealloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block/qcow2.c:3155
  #4  0x0000000010016480 in bdrv_truncate (child=3D0x32ca6270, offset=3D665=
60, prealloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block.c:3585
  #5  0x0000000010090800 in blk_truncate (blk=3D0x32c89410, offset=3D66560,=
 prealloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block/block-backen=
d.c:1845
  #6  0x0000000010023028 in truncate_f (blk=3D0x32c89410, argc=3D2, argv=3D=
0x32c685a0) at qemu-io-cmds.c:1580
  #7  0x000000001001e648 in command (blk=3D0x32c89410, ct=3D0x32c96e30, arg=
c=3D2, argv=3D0x32c685a0) at qemu-io-cmds.c:117
  #8  0x0000000010024d64 in qemuio_command (blk=3D0x32c89410, cmd=3D0x3fffc=
052f66e "truncate 66560") at qemu-io-cmds.c:2291
  #9  0x000000001000b540 in command_loop () at qemu-io.c:374
  #10 0x000000001000c05c in main (argc=3D4, argv=3D0x3fffc051f618) at qemu-=
io.c:630
  (gdb) bt full
  #0  0x0000000010054cec in get_refblock_offset (s=3D0x32ca3210, offset=3D9=
223372036854775296) at ./block/qcow2.h:533
          index =3D 4294967295
  #1  0x000000001005df4c in qcow2_discard_refcount_block (bs=3D0x32c96f60, =
discard_block_offs=3D9223372036854775296) at block/qcow2-refcount.c:3070
          s =3D 0x32ca3210
          refblock_offs =3D 852111520
          cluster_index =3D 16384
          block_index =3D 3226593616
          refblock =3D 0x32cb9570
          ret =3D 16384
          __PRETTY_FUNCTION__ =3D "qcow2_discard_refcount_block"
  #2  0x000000001005e5c4 in qcow2_shrink_reftable (bs=3D0x32c96f60) at bloc=
k/qcow2-refcount.c:3169
          s =3D 0x32ca3210
          reftable_tmp =3D 0x32cb9570
          i =3D 0
          ret =3D 0
  #3  0x0000000010051184 in qcow2_truncate (bs=3D0x32c96f60, offset=3D66560=
, prealloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block/qcow2.c:3155
          last_cluster =3D 70367675804416
          old_file_size =3D 70367675804416
          s =3D 0x32ca3210
          old_length =3D 1048576
          new_l1_size =3D 1
          ret =3D 0
          __func__ =3D "qcow2_truncate"
          __PRETTY_FUNCTION__ =3D "qcow2_truncate"
          __FUNCTION__ =3D "qcow2_truncate"
  #4  0x0000000010016480 in bdrv_truncate (child=3D0x32ca6270, offset=3D665=
60, prealloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block.c:3585
          bs =3D 0x32c96f60
          drv =3D 0x102036f0 <bdrv_qcow2>
          ret =3D 16383
          __PRETTY_FUNCTION__ =3D "bdrv_truncate"
          __func__ =3D "bdrv_truncate"
  #5  0x0000000010090800 in blk_truncate (blk=3D0x32c89410, offset=3D66560,=
 prealloc=3DPREALLOC_MODE_OFF, errp=3D0x3fffc051ecd8) at block/block-backen=
d.c:1845
          __func__ =3D "blk_truncate"
  #6  0x0000000010023028 in truncate_f (blk=3D0x32c89410, argc=3D2, argv=3D=
0x32c685a0) at qemu-io-cmds.c:1580
          local_err =3D 0x0
          offset =3D 66560
          ret =3D 0
  #7  0x000000001001e648 in command (blk=3D0x32c89410, ct=3D0x32c96e30, arg=
c=3D2, argv=3D0x32c685a0) at qemu-io-cmds.c:117
          cmd =3D 0x32c684c0 "truncate"
  #8  0x0000000010024d64 in qemuio_command (blk=3D0x32c89410, cmd=3D0x3fffc=
052f66e "truncate 66560") at qemu-io-cmds.c:2291
          ctx =3D 0x32c924d0
          input =3D 0x32c684c0 "truncate"
          ct =3D 0x32c96e30
          v =3D 0x32c685a0
          c =3D 2
          done =3D false
  #9  0x000000001000b540 in command_loop () at qemu-io.c:374
          i =3D 0
          done =3D 0
          fetchable =3D 0
  ---Type <return> to continue, or q <return> to quit---
          prompted =3D 0
          input =3D 0x0
  #10 0x000000001000c05c in main (argc=3D4, argv=3D0x3fffc051f618) at qemu-=
io.c:630
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

  image_fuzzer image will be attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728661/+subscriptions
