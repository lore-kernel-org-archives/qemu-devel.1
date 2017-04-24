Received: from eggs.gnu.org ([2001:4830:134:3::10]:57780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d2dm8-0004VV-Ee
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d2dm3-0007Yk-BI
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:11:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d2dm3-0007Y8-18
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:11:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3OD8wiJ013950
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 09:11:25 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a038r2vdc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 09:11:25 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 24 Apr 2017 07:11:23 -0600
References: <70ef6f1f-27f4-133f-ab33-03a30f19867b@de.ibm.com>
	<20170424105344.GF2362@work-vm>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 24 Apr 2017 15:11:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170424105344.GF2362@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <8559a6bc-ef35-47c2-78a4-aec960169765@de.ibm.com>
Subject: Re: [Qemu-devel] postcopy migration hangs while loading virtio state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 04/24/2017 12:53 PM, Dr. David Alan Gilbert wrote:

FWIW, the sending side calltrace looks like:

> 
Thread 8 (Thread 0x3ff509aa910 (LWP 58594)):
#0  0x000003ff9d588ca4 in pthread_join () from target:/lib64/libpthread.so.0
#1  0x0000000001493d4a in qemu_thread_join (thread=0x16c7e78 <current_migration+216>) at /root/qemu/util/qemu-thread-posix.c:504
#2  0x00000000012a0d0e in await_return_path_close_on_source (ms=0x16c7da0 <current_migration>) at /root/qemu/migration/migration.c:1641
#3  0x00000000012a1312 in migration_completion (s=0x16c7da0 <current_migration>, current_active_state=5, old_vm_running=0x3ff509a7789, start_time=0x3ff509a7790)
    at /root/qemu/migration/migration.c:1860
#4  0x00000000012a17b2 in migration_thread (opaque=0x16c7da0 <current_migration>) at /root/qemu/migration/migration.c:1987
#5  0x000003ff9d587bc4 in start_thread () from target:/lib64/libpthread.so.0
#6  0x000003ff9d48a9f2 in thread_start () from target:/lib64/libc.so.6

Thread 7 (Thread 0x3ff4bfff910 (LWP 58593)):
#0  0x000003ff9d5915b6 in recvmsg () from target:/lib64/libpthread.so.0
#1  0x000000000141771a in qio_channel_socket_readv (ioc=0xc9986b0, iov=0x3ff4bffc170, niov=1, fds=0x0, nfds=0x0, errp=0x0) at /root/qemu/io/channel-socket.c:476
#2  0x0000000001411668 in qio_channel_readv_full (ioc=0xc9986b0, iov=0x3ff4bffc170, niov=1, fds=0x0, nfds=0x0, errp=0x0) at /root/qemu/io/channel.c:64
#3  0x000000000141190a in qio_channel_read (ioc=0xc9986b0, buf=0xca23888 "", buflen=32768, errp=0x0) at /root/qemu/io/channel.c:112
#4  0x00000000012ad384 in channel_get_buffer (opaque=0xc9986b0, buf=0xca23888 "", pos=49, size=32768) at /root/qemu/migration/qemu-file-channel.c:78
#5  0x00000000012abb64 in qemu_fill_buffer (f=0xca23850) at /root/qemu/migration/qemu-file.c:295
#6  0x00000000012ac7b2 in qemu_peek_byte (f=0xca23850, offset=0) at /root/qemu/migration/qemu-file.c:555
#7  0x00000000012ac82e in qemu_get_byte (f=0xca23850) at /root/qemu/migration/qemu-file.c:568
#8  0x00000000012acbfa in qemu_get_be16 (f=0xca23850) at /root/qemu/migration/qemu-file.c:640
#9  0x00000000012a0756 in source_return_path_thread (opaque=0x16c7da0 <current_migration>) at /root/qemu/migration/migration.c:1512
#10 0x000003ff9d587bc4 in start_thread () from target:/lib64/libpthread.so.0
#11 0x000003ff9d48a9f2 in thread_start () from target:/lib64/libc.so.6

Thread 6 (Thread 0x3ff511aa910 (LWP 58454)):
#0  0x000003ff9d58d450 in pthread_cond_wait@@GLIBC_2.3.2 () from target:/lib64/libpthread.so.0
#1  0x0000000001492fce in qemu_cond_wait (cond=0xc9ca238, mutex=0xc9ca210) at /root/qemu/util/qemu-thread-posix.c:133
#2  0x00000000010c6080 in do_data_decompress (opaque=0xc9ca208) at /root/qemu/migration/ram.c:2277
#3  0x000003ff9d587bc4 in start_thread () from target:/lib64/libpthread.so.0
#4  0x000003ff9d48a9f2 in thread_start () from target:/lib64/libc.so.6

Thread 5 (Thread 0x3ff519aa910 (LWP 58453)):
#0  0x000003ff9d58d450 in pthread_cond_wait@@GLIBC_2.3.2 () from target:/lib64/libpthread.so.0
#1  0x0000000001492fce in qemu_cond_wait (cond=0xc9ca1c0, mutex=0xc9ca198) at /root/qemu/util/qemu-thread-posix.c:133
#2  0x00000000010c6080 in do_data_decompress (opaque=0xc9ca190) at /root/qemu/migration/ram.c:2277
#3  0x000003ff9d587bc4 in start_thread () from target:/lib64/libpthread.so.0
#4  0x000003ff9d48a9f2 in thread_start () from target:/lib64/libc.so.6

Thread 4 (Thread 0x3ff98807910 (LWP 58440)):
#0  0x000003ff9d58d450 in pthread_cond_wait@@GLIBC_2.3.2 () from target:/lib64/libpthread.so.0
#1  0x0000000001492fce in qemu_cond_wait (cond=0xc9e6930, mutex=0x17116b0 <qemu_global_mutex>) at /root/qemu/util/qemu-thread-posix.c:133
#2  0x000000000107720e in qemu_kvm_wait_io_event (cpu=0xc9a87d0) at /root/qemu/cpus.c:1085
#3  0x00000000010773aa in qemu_kvm_cpu_thread_fn (arg=0xc9a87d0) at /root/qemu/cpus.c:1123
#4  0x000003ff9d587bc4 in start_thread () from target:/lib64/libpthread.so.0
#5  0x000003ff9d48a9f2 in thread_start () from target:/lib64/libc.so.6

Thread 3 (Thread 0x3ff99d7f910 (LWP 58437)):
#0  0x000003ff9d47d832 in ppoll () from target:/lib64/libc.so.6
#1  0x000000000148b2fa in qemu_poll_ns (fds=0x3ff940008c0, nfds=1, timeout=-1) at /root/qemu/util/qemu-timer.c:322
#2  0x000000000148f6d2 in aio_poll (ctx=0xc9473c0, blocking=true) at /root/qemu/util/aio-posix.c:622
#3  0x00000000011a7b5e in iothread_run (opaque=0xc947230) at /root/qemu/iothread.c:59
#4  0x000003ff9d587bc4 in start_thread () from target:/lib64/libpthread.so.0
#5  0x000003ff9d48a9f2 in thread_start () from target:/lib64/libc.so.6

Thread 2 (Thread 0x3ff9a57f910 (LWP 58434)):
#0  0x000003ff9d484336 in syscall () from target:/lib64/libc.so.6
---Type <return> to continue, or q <return> to quit---
#1  0x0000000001493636 in qemu_futex_wait (f=0x1b2b9dc <rcu_call_ready_event>, val=4294967295) at /root/qemu/include/qemu/futex.h:26
#2  0x0000000001493838 in qemu_event_wait (ev=0x1b2b9dc <rcu_call_ready_event>) at /root/qemu/util/qemu-thread-posix.c:399
#3  0x00000000014b40a8 in call_rcu_thread (opaque=0x0) at /root/qemu/util/rcu.c:249
#4  0x000003ff9d587bc4 in start_thread () from target:/lib64/libpthread.so.0
#5  0x000003ff9d48a9f2 in thread_start () from target:/lib64/libc.so.6

Thread 1 (Thread 0x3ffb24c5f00 (LWP 58412)):
#0  0x000003ff9d47d832 in ppoll () from target:/lib64/libc.so.6
#1  0x000000000148b414 in qemu_poll_ns (fds=0xc98f6e0, nfds=6, timeout=999000000) at /root/qemu/util/qemu-timer.c:334
#2  0x000000000148ccca in os_host_main_loop_wait (timeout=999000000) at /root/qemu/util/main-loop.c:255
#3  0x000000000148ce0a in main_loop_wait (nonblocking=0) at /root/qemu/util/main-loop.c:517
#4  0x00000000011b3cfa in main_loop () at /root/qemu/vl.c:1898
#5  0x00000000011bc3fc in main (argc=91, argv=0x3ffdc87eed8, envp=0x3ffdc87f1b8) at /root/qemu/vl.c:4709
