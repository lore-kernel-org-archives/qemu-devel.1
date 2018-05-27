Received: from eggs.gnu.org ([2001:4830:134:3::10]:43070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fMuZa-0005X7-Fg
	for qemu-devel@nongnu.org; Sun, 27 May 2018 08:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fMuZV-0001Mi-GV
	for qemu-devel@nongnu.org; Sun, 27 May 2018 08:14:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:47438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fMuZV-0001Lf-6e
	for qemu-devel@nongnu.org; Sun, 27 May 2018 08:14:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fMuZU-0003Zl-1u
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 12:14:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0750F2E8031
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 12:14:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 May 2018 12:02:50 -0000
From: Thomas Huth <1396052@bugs.launchpad.net>
Reply-To: Bug 1396052 <1396052@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141125093258.29019.8645.malonedeb@wampee.canonical.com>
Message-Id: <152742257155.24753.8827402754632258465.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1396052] Re: migration failed when running
 BurnInTest in guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Incomplete =3D> Triaged

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1396052

Title:
  migration failed when running BurnInTest in guest

Status in QEMU:
  Triaged

Bug description:
  Hi,  =

  I found a live migration problem and have found out the reason, but I can=
't fix it up myself. I really need help.
  When live migration vm and it's block device in save time, it will occur =
probabilistic .

  Step:
  1.  start a windows vm,and run burnInTest(it will write dirty data to blo=
ck device in migration)
  2.  migrate vm with it's block device.
  3.  a few minutes later,  dest vm was killed and migration will be failed=
 (probabilistic )

  Reason:
      when migraion start, in source host libvirt will send command to qemu=
,and qemu will call mirror_run coroutine to copy blcok device data to dest =
vm block device.    mirror_run running in qemu main thread.   When this fin=
ished(actually it still running because in following steps,there may genera=
te dirty data by vm), qemu will  start migration_thread to migration ram an=
d other device.
      In dest vm, qemu will call "bdrv_invalidate_cache --> qcow2_invalidat=
e_cache" function after vm read "QEMU_VM_EOF" byte. qcow2_invalidate_cache =
fuction call qcow2_close ,  in qcow2_close fuction set "s->l1_table =3D NUL=
L" and then call qcow2_cache_flush fuction.   In qcow2_cache_flush fuction =
will call "bdrv_flush-->bdrv_flush_co_entry-->bdrv_co_flush-->qemu_coroutin=
e_yield".   This will let itself back to mian loop.   If source vm send blo=
ck device dirty data to dest vm at this time, in dest vm will occur the fol=
lowing segmentation fault.
      The primary reason is mirror_run and migration run in two thread.  al=
though qemu stopping vm before write "QEMU_VM_EOF" byte, it still can't ens=
ure mirror_run coroutine do not write dirty data  after migration thread  s=
ending "QEMU_VM_EOF" byte.

  =

  Program received signal SIGSEGV, Segmentation fault.
  0x00007f90d250db24 in get_cluster_table (bs=3D0x7f90d493f500, offset=3D18=
32189952, new_l2_table=3D0x7f8fbd6faa88, =

      new_l2_index=3D0x7f8fbd6faaa0) at block/qcow2-cluster.c:573
  573         l2_offset =3D s->l1_table[l1_index] & L1E_OFFSET_MASK;
  (gdb) bt
  #0  0x00007f90d250db24 in get_cluster_table (bs=3D0x7f90d493f500, offset=
=3D1832189952, new_l2_table=3D0x7f8fbd6faa88, =

      new_l2_index=3D0x7f8fbd6faaa0) at block/qcow2-cluster.c:573
  #1  0x00007f90d250e577 in handle_copied (bs=3D0x7f90d493f500, guest_offse=
t=3D1832189952, host_offset=3D0x7f8fbd6fab18, =

      bytes=3D0x7f8fbd6fab20, m=3D0x7f8fbd6fabc8) at block/qcow2-cluster.c:=
927
  #2  0x00007f90d250ef45 in qcow2_alloc_cluster_offset (bs=3D0x7f90d493f500=
, offset=3D1832189952, num=3D0x7f8fbd6fabfc, =

      host_offset=3D0x7f8fbd6fabc0, m=3D0x7f8fbd6fabc8) at block/qcow2-clus=
ter.c:1269
  #3  0x00007f90d250445f in qcow2_co_writev (bs=3D0x7f90d493f500, sector_nu=
m=3D3578496, remaining_sectors=3D2040, =

      qiov=3D0x7f8fbd6fae90) at block/qcow2.c:1171
  #4  0x00007f90d24d4764 in bdrv_aligned_pwritev (bs=3D0x7f90d493f500, req=
=3D0x7f8fbd6facd0, offset=3D1832189952, bytes=3D1044480, =

      qiov=3D0x7f8fbd6fae90, flags=3D0) at block.c:3321
  #5  0x00007f90d24d4d21 in bdrv_co_do_pwritev (bs=3D0x7f90d493f500, offset=
=3D1832189952, bytes=3D1044480, qiov=3D0x7f8fbd6fae90, =

      flags=3D0) at block.c:3447
  #6  0x00007f90d24d3115 in bdrv_rw_co_entry (opaque=3D0x7f8fbd6fae10) at b=
lock.c:2710
  #7  0x00007f90d24d31e7 in bdrv_prwv_co (bs=3D0x7f90d493f500, offset=3D183=
2189952, qiov=3D0x7f8fbd6fae90, is_write=3Dtrue, flags=3D0)
      at block.c:2746
  #8  0x00007f90d24d32eb in bdrv_rw_co (bs=3D0x7f90d493f500, sector_num=3D3=
578496, =

      buf=3D0x7f90d4e3d400 "\004\005\006\a\b\t\n\v\f\r\016\017\020\021\022\=
023\024\025\026\027\030\031\032\033\034\035\036\037 !\"#$%&'()*+,-./0123456=
789:;<=3D>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~=
\177\200\201\202\203\204\205\206\207\210\211\212\213\214\215\216\217\220\22=
1\222\223\224\225\226\227\230\231\232\233\234\235\236\237\240\241\242\243\2=
44\245\246\247\250\251\252\253\254\255\256\257\260\261\262\263\264\265\266\=
267\270\271\272\273\274\275\276\277\300\301\302\303\304\305\306\307\310\311=
\312", <incomplete sequence \313>..., nb_sectors=3D2040, is_write=3Dtrue, f=
lags=3D0) at block.c:2776
  #9  0x00007f90d24d3429 in bdrv_write (bs=3D0x7f90d493f500, sector_num=3D3=
578496, =

      buf=3D0x7f90d4e3d400 "\004\005\006\a\b\t\n\v\f\r\016\017\020\021\022\=
023\024\025\026\027\030\031\032\033\034\035\036\037 !\"#$%&'()*+,-./0123456=
789:;<=3D>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~=
\177\200\201\202\203\204\205\206\207\210\211\212\213\214\215\216\217\220\22=
1\222\223\224\225\226\227\230\231\232\233\234\235\236\237\240\241\242\243\2=
44\245\246\247\250\251\252\253\254\255\256\257\260\261\262\263\264\265\266\=
267\270\271\272\273\274\275\276\277\300\301\302\303\304\305\306\307\310\311=
\312", <incomplete sequence \313>..., nb_sectors=3D2040) at block.c:2810
  #10 0x00007f90d24cc2b5 in nbd_trip (opaque=3D0x7f90d4ba9aa0) at nbd.c:1191
  #11 0x00007f90d24e86fb in coroutine_trampoline (i0=3D-725586416, i1=3D326=
56) at coroutine-ucontext.c:118
  #12 0x00007f90d0449310 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
  #13 0x00007fff3fcfda10 in ?? ()
  #14 0x0000000000000000 in ?? ()
  (gdb) p bs
  $1 =3D (BlockDriverState *) 0x7f90d493f500
  (gdb) p *s
  $3 =3D {cluster_bits =3D 16, cluster_size =3D 65536, cluster_sectors =3D =
128, l2_bits =3D 13, l2_size =3D 8192, l1_size =3D 40, =

    l1_vm_state_index =3D 40, csize_shift =3D 54, csize_mask =3D 255, clust=
er_offset_mask =3D 18014398509481983, =

    l1_table_offset =3D 196608, l1_table =3D 0x0, l2_table_cache =3D 0x7f90=
d493eee0, refcount_block_cache =3D 0x7f90d493ef30, =

    cluster_cache =3D 0x7f90d4a84350 "", cluster_data =3D 0x7f90ce4de010 ""=
, cluster_cache_offset =3D 18446744073709551615, =

    cluster_allocs =3D {lh_first =3D 0x0}, refcount_table =3D 0x7f90d4a9436=
0, refcount_table_offset =3D 65536, =

    refcount_table_size =3D 8192, free_cluster_index =3D 209420, free_byte_=
offset =3D 0, lock =3D {locked =3D true, queue =3D {entries =3D {
          tqh_first =3D 0x0, tqh_last =3D 0x7f90d4942c60}}}, crypt_method =
=3D 0, crypt_method_header =3D 0, aes_encrypt_key =3D {
      rd_key =3D {0 <repeats 60 times>}, rounds =3D 0}, aes_decrypt_key =3D=
 {rd_key =3D {0 <repeats 60 times>}, rounds =3D 0}, =

    snapshots_offset =3D 0, snapshots_size =3D 0, nb_snapshots =3D 0, snaps=
hots =3D 0x0, flags =3D 10338, qcow_version =3D 3, =

    use_lazy_refcounts =3D false, refcount_order =3D 4, discard_passthrough=
 =3D {false, true, false, true, false}, =

    overlap_check =3D 127, incompatible_features =3D 0, compatible_features=
 =3D 0, autoclear_features =3D 0, =

    unknown_header_fields_size =3D 0, unknown_header_fields =3D 0x0, unknow=
n_header_ext =3D {lh_first =3D 0x0}, discards =3D {
      tqh_first =3D 0x0, tqh_last =3D 0x7f90d4942ec8}, cache_discards =3D f=
alse}
  (gdb) p s->l1_table
  $4 =3D (uint64_t *) 0x0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1396052/+subscriptions
