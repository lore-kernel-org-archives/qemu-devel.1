Received: from eggs.gnu.org ([2001:4830:134:3::10]:40511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dkqAJ-0005hF-8E
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dkqAC-0000En-LR
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:19:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1dkqAC-0000D1-Bu
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:19:04 -0400
Date: Thu, 24 Aug 2017 16:48:53 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20170823202728.dsmitbqt7bsezfgq@var.youpi.perso.aquilenet.fr>
Message-ID: <alpine.LFD.2.20.1708241020570.29123@wniryva>
References: <alpine.LFD.2.20.1708031718030.16909@wniryva>
	<20170823202728.dsmitbqt7bsezfgq@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] A use-after-free in slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, wjjzhang <wjjzhang@tencent.com>, qemu-devel@nongnu.org

  Hello Samuel,

+-- On Wed, 23 Aug 2017, Samuel Thibault wrote --+
| The paste is not available any more. Is it really very large? It's usually 
| really better to just send it by mail, so it's archived in the mailing list 
| etc.

Yes, stack-trace was quite long.

===
==2704==ERROR: AddressSanitizer: heap-use-after-free on address 0x61400001018c 
at pc 0x003921ea145d bp 0x7fd49c4fc940 sp 0x7fd49c4fc930
READ of size 4 at 0x61400001018c thread T2
    #0 0x3921ea145c in if_start slirp/if.c:230
    #1 0x3921ea1015 in if_output slirp/if.c:141
    #2 0x3921eadf1f in ip_output slirp/ip_output.c:85
    #3 0x3921ed229e in tcp_respond slirp/tcp_subr.c:218
    #4 0x3921ecc959 in tcp_input slirp/tcp_input.c:1392
    #5 0x3921eab799 in ip_input slirp/ip_input.c:206
    #6 0x3921eb6529 in slirp_input slirp/slirp.c:872
    #7 0x3921e7c56f in net_slirp_receive net/slirp.c:119
    #8 0x3921e60fe0 in nc_sendv_compat net/net.c:707
    #9 0x3921e61170 in qemu_deliver_packet_iov net/net.c:734
    #10 0x3921e67c53 in qemu_net_queue_deliver_iov net/queue.c:179
    #11 0x3921e67e5b in qemu_net_queue_send_iov net/queue.c:224
    #12 0x3921e61395 in qemu_sendv_packet_async net/net.c:770
    #13 0x3921e613c2 in qemu_sendv_packet net/net.c:778
    #14 0x3921e6961e in net_hub_receive_iov net/hub.c:72
    #15 0x3921e69c12 in net_hub_port_receive_iov net/hub.c:123
    #16 0x3921e61155 in qemu_deliver_packet_iov net/net.c:732
    #17 0x3921e67ae7 in qemu_net_queue_deliver net/queue.c:164
    #18 0x3921e67d59 in qemu_net_queue_send net/queue.c:199
    #19 0x3921e60d58 in qemu_send_packet_async_with_flags net/net.c:661
    #20 0x3921e60d90 in qemu_send_packet_async net/net.c:668
    #21 0x3921e60dbd in qemu_send_packet net/net.c:674
    #22 0x3921bef076 in ne2000_ioport_write hw/net/ne2000.c:302
    #23 0x3921bf07c4 in ne2000_write hw/net/ne2000.c:688
    #24 0x3921668a95 in memory_region_write_accessor /home/test/qemu/memory.c:529
    #25 0x3921668d6e in access_with_adjusted_size /home/test/qemu/memory.c:595
    #26 0x392166f4ca in memory_region_dispatch_write /home/test/qemu/memory.c:1337
    #27 0x39215c633c in address_space_write_continue /home/test/qemu/exec.c:2942
    #28 0x39215c65df in address_space_write /home/test/qemu/exec.c:2987
    #29 0x39215c6df3 in address_space_rw /home/test/qemu/exec.c:3089
    #30 0x39216a3159 in kvm_handle_io /home/test/qemu/accel/kvm/kvm-all.c:1795
    #31 0x39216a4425 in kvm_cpu_exec /home/test/qemu/accel/kvm/kvm-all.c:2035
    #32 0x3921636a6c in qemu_kvm_cpu_thread_fn /home/test/qemu/cpus.c:1128
    #33 0x7fd4a5f4336c in start_thread (/lib64/libpthread.so.0+0x736c)
    #34 0x7fd4a5c7bbbe in __GI___clone (/lib64/libc.so.6+0x110bbe)

0x61400001018c is located 332 bytes inside of 416-byte region 
[0x614000010040,0x6140000101e0)
freed by thread T2 here:
    #0 0x7fd4a967c4b8 in __interceptor_free (/lib64/libasan.so.4+0xde4b8)
    #1 0x3921ebf027 in sofree slirp/socket.c:106
    #2 0x3921ed2cd5 in tcp_close slirp/tcp_subr.c:334
    #3 0x3921eca600 in tcp_input slirp/tcp_input.c:948
    #4 0x3921eab799 in ip_input slirp/ip_input.c:206
    #5 0x3921eb6529 in slirp_input slirp/slirp.c:872
    #6 0x3921e7c56f in net_slirp_receive net/slirp.c:119
    #7 0x3921e60fe0 in nc_sendv_compat net/net.c:707
    #8 0x3921e61170 in qemu_deliver_packet_iov net/net.c:734
    #9 0x3921e67c53 in qemu_net_queue_deliver_iov net/queue.c:179
    #10 0x3921e67e5b in qemu_net_queue_send_iov net/queue.c:224
    #11 0x3921e61395 in qemu_sendv_packet_async net/net.c:770
    #12 0x3921e613c2 in qemu_sendv_packet net/net.c:778
    #13 0x3921e6961e in net_hub_receive_iov net/hub.c:72
    #14 0x3921e69c12 in net_hub_port_receive_iov net/hub.c:123
    #15 0x3921e61155 in qemu_deliver_packet_iov net/net.c:732
    #16 0x3921e67ae7 in qemu_net_queue_deliver net/queue.c:164
    #17 0x3921e67d59 in qemu_net_queue_send net/queue.c:199
    #18 0x3921e60d58 in qemu_send_packet_async_with_flags net/net.c:661
    #19 0x3921e60d90 in qemu_send_packet_async net/net.c:668
    #20 0x3921e60dbd in qemu_send_packet net/net.c:674
    #21 0x3921bef076 in ne2000_ioport_write hw/net/ne2000.c:302
    #22 0x3921bf07c4 in ne2000_write hw/net/ne2000.c:688
    #23 0x3921668a95 in memory_region_write_accessor /home/test/qemu/memory.c:529
    #24 0x3921668d6e in access_with_adjusted_size /home/test/qemu/memory.c:595
    #25 0x392166f4ca in memory_region_dispatch_write /home/test/qemu/memory.c:1337
    #26 0x39215c633c in address_space_write_continue /home/test/qemu/exec.c:2942
    #27 0x39215c65df in address_space_write /home/test/qemu/exec.c:2987
    #28 0x39215c6df3 in address_space_rw /home/test/qemu/exec.c:3089
    #29 0x39216a3159 in kvm_handle_io /home/test/qemu/accel/kvm/kvm-all.c:1795

previously allocated by thread T2 here:
    #0 0x7fd4a967c850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x3921ebeaa5 in socreate slirp/socket.c:51
    #2 0x3921ec7184 in tcp_input slirp/tcp_input.c:432
    #3 0x3921eab799 in ip_input slirp/ip_input.c:206
    #4 0x3921eb6529 in slirp_input slirp/slirp.c:872
    #5 0x3921e7c56f in net_slirp_receive net/slirp.c:119
    #6 0x3921e60fe0 in nc_sendv_compat net/net.c:707
    #7 0x3921e61170 in qemu_deliver_packet_iov net/net.c:734
    #8 0x3921e67c53 in qemu_net_queue_deliver_iov net/queue.c:179
    #9 0x3921e67e5b in qemu_net_queue_send_iov net/queue.c:224
    #10 0x3921e61395 in qemu_sendv_packet_async net/net.c:770
    #11 0x3921e613c2 in qemu_sendv_packet net/net.c:778
    #12 0x3921e6961e in net_hub_receive_iov net/hub.c:72
    #13 0x3921e69c12 in net_hub_port_receive_iov net/hub.c:123
    #14 0x3921e61155 in qemu_deliver_packet_iov net/net.c:732
    #15 0x3921e67ae7 in qemu_net_queue_deliver net/queue.c:164
    #16 0x3921e67d59 in qemu_net_queue_send net/queue.c:199
    #17 0x3921e60d58 in qemu_send_packet_async_with_flags net/net.c:661
    #18 0x3921e60d90 in qemu_send_packet_async net/net.c:668
    #19 0x3921e60dbd in qemu_send_packet net/net.c:674
    #20 0x3921bef076 in ne2000_ioport_write hw/net/ne2000.c:302
    #21 0x3921bf07c4 in ne2000_write hw/net/ne2000.c:688
    #22 0x3921668a95 in memory_region_write_accessor /home/test/qemu/memory.c:529
    #23 0x3921668d6e in access_with_adjusted_size /home/test/qemu/memory.c:595
    #24 0x392166f4ca in memory_region_dispatch_write /home/test/qemu/memory.c:1337
    #25 0x39215c633c in address_space_write_continue /home/test/qemu/exec.c:2942
    #26 0x39215c65df in address_space_write /home/test/qemu/exec.c:2987
    #27 0x39215c6df3 in address_space_rw /home/test/qemu/exec.c:3089
    #28 0x39216a3159 in kvm_handle_io /home/test/qemu/accel/kvm/kvm-all.c:1795
    #29 0x39216a4425 in kvm_cpu_exec /home/test/qemu/accel/kvm/kvm-all.c:2035

Thread T2 created by T0 here:
    #0 0x7fd4a95d5a2f in pthread_create (/lib64/libasan.so.4+0x37a2f)
    #1 0x39221e317e in qemu_thread_create util/qemu-thread-posix.c:508
    #2 0x39216392a7 in qemu_kvm_start_vcpu /home/test/qemu/cpus.c:1734
    #3 0x3921639868 in qemu_init_vcpu /home/test/qemu/cpus.c:1774
    #4 0x392182ae7a in x86_cpu_realizefn /home/test/qemu/target/i386/cpu.c:3735
    #5 0x3921ae4b71 in device_set_realized hw/core/qdev.c:914
    #6 0x3921f66be3 in property_set_bool qom/object.c:1886
    #7 0x3921f629f5 in object_property_set qom/object.c:1093
    #8 0x3921f6987c in object_property_set_qobject qom/qom-qobject.c:27
    #9 0x3921f62cc2 in object_property_set_bool qom/object.c:1162
    #10 0x39217abf1f in pc_new_cpu /home/test/qemu/hw/i386/pc.c:1102
    #11 0x39217ac727 in pc_cpus_init /home/test/qemu/hw/i386/pc.c:1182
    #12 0x39217b5c34 in pc_init1 /home/test/qemu/hw/i386/pc_piix.c:151
    #13 0x39217b79c5 in pc_init_v2_10 /home/test/qemu/hw/i386/pc_piix.c:446
    #14 0x3921af5157 in machine_run_board_init hw/core/machine.c:760
    #15 0x392196b37c in main /home/test/qemu/vl.c:4633
    #16 0x7fd4a5b8b509 in __libc_start_main (/lib64/libc.so.6+0x20509)

SUMMARY: AddressSanitizer: heap-use-after-free slirp/if.c:230 in if_start
Shadow bytes around the buggy address:
  0x0c287fff9fe0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fff9ff0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fffa000: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x0c287fffa010: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c287fffa020: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
=>0x0c287fffa030: fd[fd]fd fd fd fd fd fd fd fd fd fd fa fa fa fa
  0x0c287fffa040: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fffa050: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fffa060: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fffa070: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fffa080: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
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
==2704==ABORTING
===

--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
