Received: from eggs.gnu.org ([2001:4830:134:3::10]:43336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmvMe-0000fu-UU
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 02:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmvMb-0002Ao-Ix
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 02:21:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:47764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fmvMb-0002AS-5G
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 02:21:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fmvMa-0005lX-5p
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 06:21:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 17D862E80CC
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 06:21:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Aug 2018 06:10:04 -0000
From: Li Qiang <liq3ea@163.com>
Reply-To: Bug 1785670 <1785670@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153357530568.2634.11935730297153408386.malonedeb@wampee.canonical.com>
Message-Id: <153362220495.32238.3631301715964585270.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785670] Re: Guest(ubuntu 18.04) crashes when
 trying uploading file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, =

 =

I have find the overflow point using ASAN.
 =

void
m_cat(struct mbuf *m, struct mbuf *n)
{
 /*
  * If there's no room, realloc
  */
 if (M_FREEROOM(m) < n->m_len)
  m_inc(m, m->m_len + n->m_len);
 =

 memcpy(m->m_data+m->m_len, n->m_data, n->m_len);
 m->m_len +=3D n->m_len;
 =

 m_free(n);
}
 =


/* make m 'size' bytes large from m_data */
void
m_inc(struct mbuf *m, int size)
{
    int datasize;
 =

    /* some compilers throw up on gotos.  This one we can fake. */
    if (m->m_size > size) {
        return;
    }
 =

    if (m->m_flags & M_EXT) {
        datasize =3D m->m_data - m->m_ext;
        m->m_ext =3D g_realloc(m->m_ext, size + datasize);
    } else {
        datasize =3D m->m_data - m->m_dat;
        m->m_ext =3D g_malloc(size + datasize);
        memcpy(m->m_ext, m->m_dat, m->m_size);
        m->m_flags |=3D M_EXT;
    }
 =

    m->m_data =3D m->m_ext + datasize;
    m->m_size =3D size + datasize;
}
 =

Here m_cat catenates two mbuf, when the first has no buffer, it allocates a=
n M_EXT.
In m_inc, g_malloc called, then return m_cat, the next call to m_cat will t=
rigger oob write.
 =

Seems the m_len is too big.
In my debug, I see the m->m_len is 0x5b0, but datasize in m_inc is 0x40. Is=
 this right?
 =

Thanks,
Li Qiang
 =

=3D=3D17835=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0=
x61f000041dd0 at pc 0x7ffff6e9ad7b bp 0x7fffc6b215d0 sp 0x7fffc6b20d80
WRITE of size 28 at 0x61f000041dd0 thread T4
    #0 0x7ffff6e9ad7a  (/usr/lib/x86_64-linux-gnu/libasan.so.3+0x5cd7a)
    #1 0x55555663fa71 in m_cat slirp/mbuf.c:143
    #2 0x555556632cdd in ip_reass slirp/ip_input.c:341
    #3 0x555556631609 in ip_input slirp/ip_input.c:190
    #4 0x55555663bd91 in slirp_input slirp/slirp.c:874
    #5 0x555556600d6f in net_slirp_receive net/slirp.c:121
    #6 0x5555565e8192 in nc_sendv_compat net/net.c:701
    #7 0x5555565e8322 in qemu_deliver_packet_iov net/net.c:728
    #8 0x5555565edda2 in qemu_net_queue_deliver_iov net/queue.c:179
    #9 0x5555565edfaa in qemu_net_queue_send_iov net/queue.c:224
    #10 0x5555565e8547 in qemu_sendv_packet_async net/net.c:764
    #11 0x5555565e8574 in qemu_sendv_packet net/net.c:772
    #12 0x55555636657c in net_tx_pkt_sendv hw/net/net_tx_pkt.c:546
    #13 0x5555563668f3 in net_tx_pkt_do_sw_fragmentation hw/net/net_tx_pkt.=
c:588
    #14 0x555556366c93 in net_tx_pkt_send hw/net/net_tx_pkt.c:625
    #15 0x55555638586c in e1000e_tx_pkt_send hw/net/e1000e_core.c:665
    #16 0x555556385fca in e1000e_process_tx_desc hw/net/e1000e_core.c:742
    #17 0x555556387680 in e1000e_start_xmit hw/net/e1000e_core.c:933
    #18 0x55555638f390 in e1000e_set_tdt hw/net/e1000e_core.c:2450
    #19 0x5555563911cb in e1000e_core_write hw/net/e1000e_core.c:3255
    #20 0x555556370524 in e1000e_mmio_write hw/net/e1000e.c:105
    #21 0x555555d4ec07 in memory_region_write_accessor /home/liqiang02/qemu=
-devel/qemu/memory.c:527
    #22 0x555555d4eee3 in access_with_adjusted_size /home/liqiang02/qemu-de=
vel/qemu/memory.c:594
    #23 0x555555d54d16 in memory_region_dispatch_write /home/liqiang02/qemu=
-devel/qemu/memory.c:1473
    #24 0x555555c94b76 in flatview_write_continue /home/liqiang02/qemu-deve=
l/qemu/exec.c:3255
    #25 0x555555c94da1 in flatview_write /home/liqiang02/qemu-devel/qemu/ex=
ec.c:3294
    #26 0x555555c95354 in address_space_write /home/liqiang02/qemu-devel/qe=
mu/exec.c:3384
    #27 0x555555c953a5 in address_space_rw /home/liqiang02/qemu-devel/qemu/=
exec.c:3395
    #28 0x555555d92c4d in kvm_cpu_exec /home/liqiang02/qemu-devel/qemu/acce=
l/kvm/kvm-all.c:1979
    #29 0x555555d18936 in qemu_kvm_cpu_thread_fn /home/liqiang02/qemu-devel=
/qemu/cpus.c:1215
    #30 0x5555569afef1 in qemu_thread_start util/qemu-thread-posix.c:504
    #31 0x7fffdadbd493 in start_thread (/lib/x86_64-linux-gnu/libpthread.so=
.0+0x7493)
    #32 0x7fffdaafface in __clone (/lib/x86_64-linux-gnu/libc.so.6+0xe8ace)
 =

AddressSanitizer can not describe address in more detail (wild memory acces=
s suspected).
SUMMARY: AddressSanitizer: heap-buffer-overflow (/usr/lib/x86_64-linux-gnu/=
libasan.so.3+0x5cd7a) =

Shadow bytes around the buggy address:
  0x0c3e80000360: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c3e80000370: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c3e80000380: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c3e80000390: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c3e800003a0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
=3D>0x0c3e800003b0: fa fa fa fa fa fa fa fa fa fa[fa]fa fa fa fa fa
  0x0c3e800003c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c3e800003d0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c3e800003e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c3e800003f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c3e80000400: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 =

  Heap left redzone:       fa
  Heap right redzone:      fb
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack partial redzone:   f4
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
Thread T4 created by T0 here:
    #0 0x7ffff6e6ef59 in __interceptor_pthread_create (/usr/lib/x86_64-linu=
x-gnu/libasan.so.3+0x30f59)
    #1 0x5555569b012f in qemu_thread_create util/qemu-thread-posix.c:534
    #2 0x555555d1b7b9 in qemu_kvm_start_vcpu /home/liqiang02/qemu-devel/qem=
u/cpus.c:1935
    #3 0x555555d1bf6c in qemu_init_vcpu /home/liqiang02/qemu-devel/qemu/cpu=
s.c:2001
    #4 0x555555f682de in x86_cpu_realizefn /home/liqiang02/qemu-devel/qemu/=
target/i386/cpu.c:4996
    #5 0x55555621c00c in device_set_realized hw/core/qdev.c:826
    #6 0x5555566f962f in property_set_bool qom/object.c:1984
    #7 0x5555566f5bfc in object_property_set qom/object.c:1176
    #8 0x5555566fbdce in object_property_set_qobject qom/qom-qobject.c:27
    #9 0x5555566f5f19 in object_property_set_bool qom/object.c:1242
    #10 0x555555edf7d7 in pc_new_cpu /home/liqiang02/qemu-devel/qemu/hw/i38=
6/pc.c:1107
    #11 0x555555edfc98 in pc_cpus_init /home/liqiang02/qemu-devel/qemu/hw/i=
386/pc.c:1155
    #12 0x555555ef2451 in pc_q35_init /home/liqiang02/qemu-devel/qemu/hw/i3=
86/pc_q35.c:130
    #13 0x555555ef37f4 in pc_init_v3_0 /home/liqiang02/qemu-devel/qemu/hw/i=
386/pc_q35.c:320
    #14 0x55555622ca6d in machine_run_board_init hw/core/machine.c:830
    #15 0x555556099045 in main /home/liqiang02/qemu-devel/qemu/vl.c:4516
    #16 0x7fffdaa372e0 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x202e0)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785670

Title:
  Guest(ubuntu 18.04) crashes when trying uploading file

Status in QEMU:
  Confirmed

Bug description:
  I speficy slirp network, and I can open websites, git clone repos. But
  when I try to upload a file to slack, or try to do a git push, it
  crashes.

  My host is ubuntu 16.04 with kernel 4.15.0-29-generic, and qemu is
  latest source in git(commit 1fb57da72ae0886e). The command I use is

  ./x86_64-softmmu/qemu-system-x86_64 -machine q35,accel=3Dkvm -m 2048
  -drive file=3D../qcow2/guest.qcow2  -netdev user,id=3Drealnet0 -device
  e1000e,netdev=3Drealnet0

  The trace is as follows

  *** Error in `./x86_64-softmmu/qemu-system-x86_64': free(): invalid next =
size (normal): 0x00007f66d80b7300 ***
  =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
  /lib/x86_64-linux-gnu/libc.so.6(+0x777e5)[0x7f66fb7967e5]
  /lib/x86_64-linux-gnu/libc.so.6(+0x8037a)[0x7f66fb79f37a]
  /lib/x86_64-linux-gnu/libc.so.6(cfree+0x4c)[0x7f66fb7a353c]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6a8549)[0x55dc10c7d549]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6a99d4)[0x55dc10c7e9d4]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6ad09a)[0x55dc10c8209a]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6a3feb)[0x55dc10c78feb]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6a746e)[0x55dc10c7c46e]
  ./x86_64-softmmu/qemu-system-x86_64(+0x68fe2c)[0x55dc10c64e2c]
  ./x86_64-softmmu/qemu-system-x86_64(+0x685b3b)[0x55dc10c5ab3b]
  ./x86_64-softmmu/qemu-system-x86_64(+0x685bfd)[0x55dc10c5abfd]
  ./x86_64-softmmu/qemu-system-x86_64(+0x6885a8)[0x55dc10c5d5a8]
  ./x86_64-softmmu/qemu-system-x86_64(+0x688717)[0x55dc10c5d717]
  ./x86_64-softmmu/qemu-system-x86_64(+0x685d27)[0x55dc10c5ad27]
  ./x86_64-softmmu/qemu-system-x86_64(+0x685d54)[0x55dc10c5ad54]
  ./x86_64-softmmu/qemu-system-x86_64(+0x586bb8)[0x55dc10b5bbb8]
  ./x86_64-softmmu/qemu-system-x86_64(+0x586d92)[0x55dc10b5bd92]
  ./x86_64-softmmu/qemu-system-x86_64(+0x586ecd)[0x55dc10b5becd]
  ./x86_64-softmmu/qemu-system-x86_64(+0x593ea8)[0x55dc10b68ea8]
  ./x86_64-softmmu/qemu-system-x86_64(+0x59419d)[0x55dc10b6919d]
  ./x86_64-softmmu/qemu-system-x86_64(+0x5947df)[0x55dc10b697df]
  ./x86_64-softmmu/qemu-system-x86_64(+0x597ddf)[0x55dc10b6cddf]
  ./x86_64-softmmu/qemu-system-x86_64(+0x5989e7)[0x55dc10b6d9e7]
  ./x86_64-softmmu/qemu-system-x86_64(+0x58ae11)[0x55dc10b5fe11]
  ./x86_64-softmmu/qemu-system-x86_64(+0x30d4f6)[0x55dc108e24f6]
  ./x86_64-softmmu/qemu-system-x86_64(+0x30d70e)[0x55dc108e270e]
  ./x86_64-softmmu/qemu-system-x86_64(+0x310336)[0x55dc108e5336]
  ./x86_64-softmmu/qemu-system-x86_64(+0x2ac368)[0x55dc10881368]
  ./x86_64-softmmu/qemu-system-x86_64(+0x2ac4b2)[0x55dc108814b2]
  ./x86_64-softmmu/qemu-system-x86_64(+0x2ac7b8)[0x55dc108817b8]
  ./x86_64-softmmu/qemu-system-x86_64(+0x2ac809)[0x55dc10881809]
  ./x86_64-softmmu/qemu-system-x86_64(+0x32b673)[0x55dc10900673]
  ./x86_64-softmmu/qemu-system-x86_64(+0x2f2875)[0x55dc108c7875]
  ./x86_64-softmmu/qemu-system-x86_64(+0x81b91c)[0x55dc10df091c]
  /lib/x86_64-linux-gnu/libpthread.so.0(+0x76ba)[0x7f66fbaf06ba]
  /lib/x86_64-linux-gnu/libc.so.6(clone+0x6d)[0x7f66fb82641d]
  =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
  55dc105d5000-55dc112a9000 r-xp 00000000 103:02 5767220                   =
/home/biggerfish/src/qemu/x86_64-softmmu/qemu-system-x86_64
  55dc114a9000-55dc115bd000 r--p 00cd4000 103:02 5767220                   =
/home/biggerfish/src/qemu/x86_64-softmmu/qemu-system-x86_64
  55dc115bd000-55dc11773000 rw-p 00de8000 103:02 5767220                   =
/home/biggerfish/src/qemu/x86_64-softmmu/qemu-system-x86_64
  55dc11773000-55dc117b5000 rw-p 00000000 00:00 0 =

  55dc134d6000-55dc14e20000 rw-p 00000000 00:00 0                          =
[heap]
  7f6634000000-7f6634021000 rw-p 00000000 00:00 0 =

  7f6634021000-7f6638000000 ---p 00000000 00:00 0 =

  7f663c000000-7f663c021000 rw-p 00000000 00:00 0 =

  7f663c021000-7f6640000000 ---p 00000000 00:00 0 =

  7f6642000000-7f6644000000 rw-s 00000000 00:05 4882443                    =
/SYSV00000000 (deleted)
  7f6644000000-7f6644021000 rw-p 00000000 00:00 0 =

  7f6644021000-7f6648000000 ---p 00000000 00:00 0 =

  7f66491cc000-7f66491cd000 ---p 00000000 00:00 0 =

  7f66491cd000-7f66499cd000 rw-p 00000000 00:00 0 =

  7f66499cd000-7f66499ce000 ---p 00000000 00:00 0 =

  7f66499ce000-7f664a1ce000 rw-p 00000000 00:00 0 =

  7f664a1ce000-7f664a1cf000 ---p 00000000 00:00 0 =

  7f664a1cf000-7f664a9cf000 rw-p 00000000 00:00 0 =

  7f664a9cf000-7f664a9d0000 ---p 00000000 00:00 0 =

  7f664a9d0000-7f664b1d0000 rw-p 00000000 00:00 0 =

  7f664b1d0000-7f664b1d1000 ---p 00000000 00:00 0 =

  7f664b1d1000-7f664b9d1000 rw-p 00000000 00:00 0 =

  7f664b9d1000-7f664b9d2000 ---p 00000000 00:00 0 =

  7f664b9d2000-7f664bad2000 rw-p 00000000 00:00 0 =

  7f664bad2000-7f664bad3000 ---p 00000000 00:00 0 =

  7f664bad3000-7f664bbd3000 rw-p 00000000 00:00 0 =

  7f664bbd3000-7f664bbd4000 ---p 00000000 00:00 0 =

  7f664bbd4000-7f664bcd4000 rw-p 00000000 00:00 0 =

  7f664bcd4000-7f664bcd5000 ---p 00000000 00:00 0 =

  7f664bcd5000-7f664c4d5000 rw-p 00000000 00:00 0 =

  7f664c4d5000-7f664c4d6000 ---p 00000000 00:00 0 =

  7f664c4d6000-7f664c5d6000 rw-p 00000000 00:00 0 =

  7f664c5d6000-7f664c5d7000 ---p 00000000 00:00 0 =

  7f664c5d7000-7f664c6d7000 rw-p 00000000 00:00 0 =

  7f664c6d7000-7f664c6d8000 ---p 00000000 00:00 0 =

  7f664c6d8000-7f664c7d8000 rw-p 00000000 00:00 0 =

  7f664c7d8000-7f664c7d9000 ---p 00000000 00:00 0 =

  7f664c7d9000-7f664c8d9000 rw-p 00000000 00:00 0 =

  7f664c8d9000-7f664c8da000 ---p 00000000 00:00 0 =

  7f664c8da000-7f664c9da000 rw-p 00000000 00:00 0 =

  7f664c9da000-7f664c9db000 ---p 00000000 00:00 0 =

  7f664c9db000-7f664cadb000 rw-p 00000000 00:00 0 =

  7f664cadb000-7f664cadc000 ---p 00000000 00:00 0 =

  7f664cadc000-7f664cbdc000 rw-p 00000000 00:00 0 =

  7f664cbdc000-7f664cbdd000 ---p 00000000 00:00 0 =

  7f664cbdd000-7f664ccdd000 rw-p 00000000 00:00 0 =

  7f664ccdd000-7f664ccde000 ---p 00000000 00:00 0 =

  7f664ccde000-7f664cdde000 rw-p 00000000 00:00 0 =

  7f664cdde000-7f664cddf000 ---p 00000000 00:00 0 =

  7f664cddf000-7f664cedf000 rw-p 00000000 00:00 0 =

  7f664cedf000-7f664cee0000 ---p 00000000 00:00 0 =

  7f664cee0000-7f664cfe0000 rw-p 00000000 00:00 0 =

  7f664cfe0000-7f664cfe1000 ---p 00000000 00:00 0 =

  7f664cfe1000-7f664d0e1000 rw-p 00000000 00:00 0 =

  7f664d0e1000-7f664d0e2000 ---p 00000000 00:00 0 =

  7f664d0e2000-7f664d1e2000 rw-p 00000000 00:00 0 =

  7f664d1e2000-7f664d1e3000 ---p 00000000 00:00 0 =

  7f664d1e3000-7f664d2e3000 rw-p 00000000 00:00 0 =

  7f664d2e3000-7f664d2e4000 ---p 00000000 00:00 0 =

  7f664d2e4000-7f664d3e4000 rw-p 00000000 00:00 0 =

  7f664d3e4000-7f664d3e5000 ---p 00000000 00:00 0 =

  7f664d3e5000-7f664d4e5000 rw-p 00000000 00:00 0 =

  7f664d4e5000-7f664d4e6000 ---p 00000000 00:00 0 =

  7f664d4e6000-7f664d5e6000 rw-p 00000000 00:00 0 =

  7f664d5e6000-7f664d5e7000 ---p 00000000 00:00 0 =

  7f664d5e7000-7f664d6e7000 rw-p 00000000 00:00 0 =

  7f664d6e7000-7f664d6e8000 ---p 00000000 00:00 0 =

  7f664d6e8000-7f664d7e8000 rw-p 00000000 00:00 0 =

  7f664d7e8000-7f664d7e9000 ---p 00000000 00:00 0 =

  7f664d7e9000-7f664d8e9000 rw-p 00000000 00:00 0 =

  7f664d8e9000-7f664d8ea000 ---p 00000000 00:00 0 =

  7f664d8ea000-7f664d9ea000 rw-p 00000000 00:00 0 =

  7f664d9ea000-7f664d9eb000 ---p 00000000 00:00 0 =

  7f664d9eb000-7f664daeb000 rw-p 00000000 00:00 0 =

  7f664daeb000-7f664daec000 ---p 00000000 00:00 0 =

  7f664daec000-7f664dbec000 rw-p 00000000 00:00 0 =

  7f664dbec000-7f664dbed000 ---p 00000000 00:00 0 =

  7f664dbed000-7f664dced000 rw-p 00000000 00:00 0 =

  7f664dced000-7f664dcee000 ---p 00000000 00:00 0 =

  7f664dcee000-7f664ddee000 rw-p 00000000 00:00 0 =

  7f664ddee000-7f664ddef000 ---p 00000000 00:00 0 =

  7f664ddef000-7f664deef000 rw-p 00000000 00:00 0 =

  7f664deef000-7f664def0000 ---p 00000000 00:00 0 =

  7f664def0000-7f664dff0000 rw-p 00000000 00:00 0 =

  7f664dff0000-7f664dff1000 ---p 00000000 00:00 0 =

  7f664dff1000-7f664e0f1000 rw-p 00000000 00:00 0 =

  7f664e0f1000-7f664e0f2000 ---p 00000000 00:00 0 =

  7f664e0f2000-7f664e1f2000 rw-p 00000000 00:00 0 =

  7f664e1f2000-7f664e1f3000 ---p 00000000 00:00 0 =

  7f664e1f3000-7f664e2f3000 rw-p 00000000 00:00 0 =

  7f664e2f3000-7f664e2f4000 ---p 00000000 00:00 0 =

  7f664e2f4000-7f664e3f4000 rw-p 00000000 00:00 0 =

  7f664e3f4000-7f664e3f5000 ---p 00000000 00:00 0 =

  7f664e3f5000-7f664e4f5000 rw-p 00000000 00:00 0 =

  7f664e4f5000-7f664e4f6000 ---p 00000000 00:00 0 =

  7f664e4f6000-7f664e5f6000 rw-p 00000000 00:00 0 =

  7f664e5f6000-7f664e5f7000 ---p 00000000 00:00 0 =

  7f664e5f7000-7f664e6f7000 rw-p 00000000 00:00 0 =

  7f664e6f7000-7f664e6f8000 ---p 00000000 00:00 0 =

  7f664e6f8000-7f664e7f8000 rw-p 00000000 00:00 0 =

  7f664e7f8000-7f664e7f9000 ---p 00000000 00:00 0 =

  7f664e7f9000-7f664e8f9000 rw-p 00000000 00:00 0 =

  7f664e8f9000-7f664e8fa000 ---p 00000000 00:00 0 =

  7f664e8fa000-7f664e9fa000 rw-p 00000000 00:00 0 =

  7f664e9fa000-7f664e9fb000 ---p 00000000 00:00 0 =

  7f664e9fb000-7f664eafb000 rw-p 00000000 00:00 0 =

  7f664eafb000-7f664eafc000 ---p 00000000 00:00 0 =

  7f664eafc000-7f664ebfc000 rw-p 00000000 00:00 0 =

  7f664ebfc000-7f664ebfd000 ---p 00000000 00:00 0 =

  7f664ebfd000-7f664ecfd000 rw-p 00000000 00:00 0 =

  7f664ecfd000-7f664ecfe000 ---p 00000000 00:00 0 =

  7f664ecfe000-7f664edfe000 rw-p 00000000 00:00 0 =

  7f664edfe000-7f664edff000 ---p 00000000 00:00 0 =

  7f664edff000-7f664eeff000 rw-p 00000000 00:00 0 =

  7f664eeff000-7f664ef00000 ---p 00000000 00:00 0 =

  7f664ef00000-7f664f000000 rw-p 00000000 00:00 0 =

  7f664f6fe000-7f664f6ff000 ---p 00000000 00:00 0 =

  7f664f6ff000-7f664f7ff000 rw-p 00000000 00:00 0 =

  7f664f7ff000-7f664f800000 ---p 00000000 00:00 0 =

  7f664f800000-7f6650000000 rw-p 00000000 00:00 0 =

  7f6650000000-7f6650022000 rw-p 00000000 00:00 0 =

  7f6650022000-7f6654000000 ---p 00000000 00:00 0 =

  7f66540f5000-7f66540f6000 ---p 00000000 00:00 0 =

  7f66540f6000-7f66541f6000 rw-p 00000000 00:00 0 =

  7f66541f6000-7f66541f7000 ---p 00000000 00:00 0 =

  7f66541f7000-7f66542f7000 rw-p 00000000 00:00 0 =

  7f66542f7000-7f66542f8000 ---p 00000000 00:00 0 =

  7f66542f8000-7f66543f8000 rw-p 00000000 00:00 0 =

  7f66543f8000-7f66543f9000 ---p 00000000 00:00 0 =

  7f66543f9000-7f66544f9000 rw-p 00000000 00:00 0 =

  7f66544f9000-7f66544fa000 ---p 00000000 00:00 0 =

  7f66544fa000-7f66545fa000 rw-p 00000000 00:00 0 =

  7f66545fa000-7f66545fb000 ---p 00000000 00:00 0 =

  7f66545fb000-7f66546fb000 rw-p 00000000 00:00 0 =

  7f66546fb000-7f66546fc000 ---p 00000000 00:00 0 =

  7f66546fc000-7f66547fc000 rw-p 00000000 00:00 0 =

  7f66547fc000-7f66547fd000 ---p 00000000 00:00 0 =

  7f66547fd000-7f66548fd000 rw-p 00000000 00:00 0 =

  7f66548fd000-7f66548fe000 ---p 00000000 00:00 0 =

  7f66548fe000-7f66549fe000 rw-p 00000000 00:00 0 =

  7f66549fe000-7f66549ff000 ---p 00000000 00:00 0 =

  7f66549ff000-7f6654aff000 rw-p 00000000 00:00 0 =

  7f6654aff000-7f6654b00000 ---p 00000000 00:00 0 =

  7f6654b00000-7f6654c00000 rw-p 00000000 00:00 0 =

  7f6654c00000-7f6654c01000 rw-p 00000000 00:00 0 =

  7f6654c01000-7f6654c02000 ---p 00000000 00:00 0 =

  7f6654cff000-7f6654d00000 ---p 00000000 00:00 0 =

  7f6654d00000-7f6654e00000 rw-p 00000000 00:00 0 =

  7f6654e00000-7f6654e01000 rw-p 00000000 00:00 0 =

  7f6654e01000-7f6654e02000 ---p 00000000 00:00 0 =

  7f6654eff000-7f6654f00000 ---p 00000000 00:00 0 =

  7f6654f00000-7f6655000000 rw-p 00000000 00:00 0 =

  7f6655000000-7f6655200000 rw-p 00000000 00:00 0 =

  7f6655200000-7f6655201000 ---p 00000000 00:00 0 =

  7f665523b000-7f6656af1000 r-xp 00000000 103:02 2233416                   =
/usr/lib/x86_64-linux-gnu/libicudata.so.55.1
  7f6656af1000-7f6656cf0000 ---p 018b6000 103:02 2233416                   =
/usr/lib/x86_64-linux-gnu/libicudata.so.55.1
  7f6656cf0000-7f6656cf1000 r--p 018b5000 103:02 2233416                   =
/usr/lib/x86_64-linux-gnu/libicudata.so.55.1
  7f6656cf1000-7f6656cf2000 rw-p 018b6000 103:02 2233416                   =
/usr/lib/x86_64-linux-gnu/libicudata.so.55.1
  7f6656cf2000-7f6656e71000 r-xp 00000000 103:02 2233420                   =
/usr/lib/x86_64-linux-gnu/libicuuc.so.55.1
  7f6656e71000-7f6657071000 ---p 0017f000 103:02 2233420                   =
/usr/lib/x86_64-linux-gnu/libicuuc.so.55.1
  7f6657071000-7f6657081000 r--p 0017f000 103:02 2233420                   =
/usr/lib/x86_64-linux-gnu/libicuuc.so.55.1
  7f6657081000-7f6657082000 rw-p 0018f000 103:02 2233420                   =
/usr/lib/x86_64-linux-gnu/libicuuc.so.55.1
  7f6657082000-7f6657086000 rw-p 00000000 00:00 0 =

  7f6657086000-7f6657237000 r-xp 00000000 103:02 2237922                   =
/usr/lib/x86_64-linux-gnu/libxml2.so.2.9.3
  7f6657237000-7f6657436000 ---p 001b1000 103:02 2237922                   =
/usr/lib/x86_64-linux-gnu/libxml2.so.2.9.3
  7f6657436000-7f665743e000 r--p 001b0000 103:02 2237922                   =
/usr/lib/x86_64-linux-gnu/libxml2.so.2.9.3
  7f665743e000-7f6657440000 rw-p 001b8000 103:02 2237922                   =
/usr/lib/x86_64-linux-gnu/libxml2.so.2.9.3
  7f6657440000-7f6657441000 rw-p 00000000 00:00 0 =

  7f6657441000-7f6657e00000 r--p 00000000 103:02 2235565                   =
/usr/lib/locale/locale-archive
  7f6657e00000-7f66d7e00000 rw-p 00000000 00:00 0 =

  7f66d7e00000-7f66d7e01000 ---p 00000000 00:00 0 =

  7f66d7eff000-7f66d7f00000 ---p 00000000 00:00 0 =

  7f66d7f00000-7f66d8000000 rw-p 00000000 00:00 0 =

  7f66d8000000-7f66d8b29000 rw-p 00000000 00:00 0 =

  7f66d8b29000-7f66dc000000 ---p 00000000 00:00 0 =

  7f66dc000000-7f66dc022000 rw-p 00000000 00:00 0 =

  7f66dc022000-7f66e0000000 ---p 00000000 00:00 0 =

  7f66e008a000-7f66e008b000 ---p 00000000 00:00 0 =

  7f66e008b000-7f66e018b000 rw-p 00000000 00:00 0 =

  7f66e018b000-7f66e01c2000 r-xp 00000000 103:02 2236734                   =
/usr/lib/x86_64-linux-gnu/libcroco-0.6.so.3.0.1
  7f66e01c2000-7f66e03c2000 ---p 00037000 103:02 2236734                   =
/usr/lib/x86_64-linux-gnu/libcroco-0.6.so.3.0.1
  7f66e03c2000-7f66e03c5000 r--p 00037000 103:02 2236734                   =
/usr/lib/x86_64-linux-gnu/libcroco-0.6.so.3.0.1
  7f66e03c5000-7f66e03c6000 rw-p 0003a000 103:02 2236734                   =
/usr/lib/x86_64-linux-gnu/libcroco-0.6.so.3.0.1
  7f66e03c6000-7f66e03fb000 r-xp 00000000 103:02 2237572                   =
/usr/lib/x86_64-linux-gnu/librsvg-2.so.2.40.13
  7f66e03fb000-7f66e05fb000 ---p 00035000 103:02 2237572                   =
/usr/lib/x86_64-linux-gnu/librsvg-2.so.2.40.13
  7f66e05fb000-7f66e05fc000 r--p 00035000 103:02 2237572                   =
/usr/lib/x86_64-linux-gnu/librsvg-2.so.2.40.13
  7f66e05fc000-7f66e05fd000 rw-p 00036000 103:02 2237572                   =
/usr/lib/x86_64-linux-gnu/librsvg-2.so.2.40.13
  7f66e05fd000-7f66e05ff000 r-xp 00000000 103:02 2493292                   =
/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg=
.so
  7f66e05ff000-7f66e07fe000 ---p 00002000 103:02 2493292                   =
/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg=
.so
  7f66e07fe000-7f66e07ff000 r--p 00001000 103:02 2493292                   =
/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg=
.so
  7f66e07ff000-7f66e0800000 rw-p 00002000 103:02 2493292                   =
/usr/lib/x86_64-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader-svg=
.so
  7f66e0800000-7f66e0840000 rw-p 00000000 00:00 0 =

  7f66e0840000-7f66e0841000 ---p 00000000 00:00 0 =

  7f66e08ff000-7f66e0900000 ---p 00000000 00:00 0 =

  7f66e0900000-7f66e0a00000 rw-p 00000000 00:00 0 =

  7f66e0a00000-7f66e0a10000 rw-p 00000000 00:00 0 =

  7f66e0a10000-7f66e0a11000 ---p 00000000 00:00 0 =

  7f66e0aff000-7f66e0b00000 ---p 00000000 00:00 0 =

  7f66e0b00000-7f66e0c00000 rw-p 00000000 00:00 0 =

  7f66e0c00000-7f66e1c00000 rw-p 00000000 00:00 0 =

  7f66e1c00000-7f66e1c01000 ---p 00000000 00:00 0 =

  7f66e1cff000-7f66e1d00000 ---p 00000000 00:00 0 =

  7f66e1d00000-7f66e1e00000 rw-p 00000000 00:00 0 =

  7f66e1e00000-7f66e1e20000 rw-p 00000000 00:00 0 =

  7f66e1e20000-7f66e1e21000 ---p 00000000 00:00 0 =

  7f66e1e5c000-7f66e1eb3000 r--p 00000000 103:02 3277771                   =
/usr/share/fonts/truetype/ubuntu-font-family/Ubuntu-R.ttf
  7f66e1eb3000-7f66e1ebe000 r--s 00000000 103:02 3019418                   =
/var/cache/fontconfig/945677eb7aeaf62f1d50efc3fb3ec7d8-le64.cache-6
  7f66e1ebe000-7f66e1ed3000 r--s 00000000 103:02 3019394                   =
/var/cache/fontconfig/04aabc0a78ac019cf9454389977116d2-le64.cache-6
  7f66e1eff000-7f66e1f00000 ---p 00000000 00:00 0 =

  7f66e1f00000-7f66e2000000 rw-p 00000000 00:00 0 =

  7f66e2000000-7f66e2040000 rw-p 00000000 00:00 0 =

  7f66e2040000-7f66e2041000 ---p 00000000 00:00 0 =

  7f66e204a000-7f66e204b000 rw-p 00000000 00:00 0 =

  7f66e204b000-7f66e2051000 r--s 00000000 103:02 3019400                   =
/var/cache/fontconfig/2cd17615ca594fa2959ae173292e504c-le64.cache-6
  7f66e2051000-7f66e2052000 r--s 00000000 103:02 3019397                   =
/var/cache/fontconfig/0d8c3b2ac0904cb8a57a757ad11a4a08-le64.cache-6
  7f66e2052000-7f66e2053000 r--s 00000000 103:02 3019399                   =
/var/cache/fontconfig/1ac9eb803944fde146138c791f5cc56a-le64.cache-6
  7f66e2053000-7f66e2057000 r--s 00000000 103:02 3019404                   =
/var/cache/fontconfig/385c0604a188198f04d133e54aba7fe7-le64.cache-6
  7f66e2057000-7f66e2058000 r--s 00000000 103:02 3019431                   =
/var/cache/fontconfig/dc05db6664285cc2f12bf69c139ae4c3-le64.cache-6
  7f66e2058000-7f66e205b000 r--s 00000000 103:02 3019414                   =
/var/cache/fontconfig/767a8244fc0220cfb567a839d0392e0b-le64.cache-6
  7f66e205b000-7f66e2060000 r--s 00000000 103:02 3019417                   =
/var/cache/fontconfig/8801497958630a81b71ace7c5f9b32a8-le64.cache-6
  7f66e2060000-7f66e2067000 r--s 00000000 103:02 3019401                   =
/var/cache/fontconfig/3047814df9a2f067bd2d96a2b9c36e5a-le64.cache-6
  7f66e2067000-7f66e206d000 r--s 00000000 103:02 3019422                   =
/var/cache/fontconfig/b47c4e1ecd0709278f4910c18777a504-le64.cache-6
  7f66e206d000-7f66e2080000 r--s 00000000 103:02 3019428                   =
/var/cache/fontconfig/d52a8644073d54c13679302ca1180695-le64.cache-6
  7f66e2080000-7f66e208b000 r--s 00000000 103:02 3019416                   =
/var/cache/fontconfig/83bf95040141907cd45bb53cf7c1c148-le64.cache-6
  7f66e208b000-7f66e209d000 r--s 00000000 103:02 3019420                   =
/var/cache/fontconfig/9b89f8e3dae116d678bbf48e5f21f69b-le64.cache-6
  7f66e209d000-7f66e20bc000 r--s 00000000 103:02 2752558                   =
/usr/share/mime/mime.cache
  7f66e20bc000-7f66e20bd000 ---p 00000000 00:00 0 =

  7f66e20bd000-7f66e21bd000 rw-p 00000000 00:00 0 =

  7f66e21bd000-7f66e21be000 ---p 00000000 00:00 0 =

  7f66e21be000-7f66e2ca2000 rw-p 00000000 00:00 0 =

  7f66e2ca2000-7f66e2ca3000 ---p 00000000 00:00 0 =

  7f66e2ca3000-7f66e2da3000 rw-p 00000000 00:00 0 =

  7f66e2da3000-7f66e2da4000 ---p 00000000 00:00 0 =

  7f66e2da4000-7f66e35a4000 rw-p 00000000 00:00 0 =

  7f66e35a4000-7f66e35ab000 r-xp 00000000 103:02 2237425                   =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.2
  7f66e35ab000-7f66e37ab000 ---p 00007000 103:02 2237425                   =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.2
  7f66e37ab000-7f66e37ac000 r--p 00007000 103:02 2237425                   =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.2
  7f66e37ac000-7f66e37ad000 rw-p 00008000 103:02 2237425                   =
/usr/lib/x86_64-linux-gnu/libogg.so.0.8.2
  7f66e37ad000-7f66e37d7000 r-xp 00000000 103:02 2233113                   =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.8
  7f66e37d7000-7f66e39d6000 ---p 0002a000 103:02 2233113                   =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.8
  7f66e39d6000-7f66e39d7000 r--p 00029000 103:02 2233113                   =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.8
  7f66e39d7000-7f66e39d8000 rw-p 0002a000 103:02 2233113                   =
/usr/lib/x86_64-linux-gnu/libvorbis.so.0.4.8
  7f66e39d8000-7f66e39e1000 r-xp 00000000 103:02 2237286                   =
/usr/lib/x86_64-linux-gnu/libltdl.so.7.3.1
  7f66e39e1000-7f66e3be0000 ---p 00009000 103:02 2237286                   =
/usr/lib/x86_64-linux-gnu/libltdl.so.7.3.1
  7f66e3be0000-7f66e3be1000 r--p 00008000 103:02 2237286                   =
/usr/lib/x86_64-linux-gnu/libltdl.so.7.3.1
  7f66e3be1000-7f66e3be2000 rw-p 00009000 103:02 2237286                   =
/usr/lib/x86_64-linux-gnu/libltdl.so.7.3.1
  7f66e3be2000-7f66e3bf6000 r-xp 00000000 103:02 2237676                   =
/usr/lib/x86_64-linux-gnu/libtdb.so.1.3.8Aborted (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785670/+subscriptions
