Received: from eggs.gnu.org ([2001:4830:134:3::10]:58049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezLc3-0007Bb-8K
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezLbv-0003O8-1k
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:16:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ezLbu-0003Nc-Ql
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:15:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2NCFVcb067519
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 08:15:54 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gw04jbedx-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 08:15:53 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Mar 2018 12:15:50 -0000
References: <d29ae6aa-5758-277b-b754-4e6fe7666e6b@redhat.com>
	<CAFEAcA9dHPLj6aF=JsS8dXaDWf_ONQ_A+SD1xXQO7DdsWK3yAw@mail.gmail.com>
	<6b4fbb94-2c28-27c2-17e4-b3ce593eb04d@redhat.com>
	<CAFEAcA_rJ_=-dKauAmrJPGRJ6C09_9CQzRdXK53va4NB_xXKpg@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Mar 2018 13:15:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rJ_=-dKauAmrJPGRJ6C09_9CQzRdXK53va4NB_xXKpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2964f298-2a9c-cb47-2280-52e54d634631@de.ibm.com>
Subject: Re: [Qemu-devel] Regression on KVM qemu-system-aarch64 since
 "monitor: enable IO thread for (qmp & !mux) typed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Auger Eric <eric.auger@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu list <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>



On 03/23/2018 01:11 PM, Peter Maydell wrote:
> On 23 March 2018 at 12:01, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi,
>>
>> On 23/03/18 11:26, Peter Maydell wrote:
>>> On 23 March 2018 at 10:24, Auger Eric <eric.auger@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> I observe a regression on KVM accelerated qemu-system-aarch64:
>>>>
>>>> Unexpected error in kvm_device_access() at
>>>> /home/augere/UPSTREAM/qemu/accel/kvm/kvm-all.c:2164:
>>>> 2018-03-23T09:59:59.629439Z qemu-system-aarch64: KVM_GET_DEVICE_ATTR
>>>> failed: Group 6 attr 0x000000000000c664: Device or resource busy
>>>> 2018-03-23 10:00:00.085+0000: shutting down, reason=crashed
>>>
>>> Can you get a backtrace for this? (I guess you'd need to fiddle
>>> with the kvm_device_access() code to make it assert rather
>>> than passing back the error).
>>
>> OK. I will try to do so. As I could have expected, I cannot reproduce on
>> a standalone qemu command line. The problem observed above is seen with
>> libvirt launch which may be doing some other QMP stuff concurrently?
> 
> Hmm, that could be a bit painful to debug. I dunno if libvirt
> has a "launch QEMU under gdb" option. If not, you could try
> something like:
>    if (condition we want to get a backtrace on) {
>        printf("hit condition, attach gdb to process %d\n", (int)getpid());
>        for (;;) { }
>    }
> 
> and then QEMU will sit in a loop waiting for you to do a
>   gdb path/to/qemu <pid>
> 
> thanks
> -- PMM
> 

This patch also breaks the qemu iotest. (qemu hangs).

backtrace for that is


Thread 4 (Thread 0x3ffa9c3c910 (LWP 171339)):
#0  0x000003ffb9d11a70 in __lll_lock_wait () at /lib64/libpthread.so.0
#1  0x000003ffb9d0a630 in pthread_mutex_lock () at /lib64/libpthread.so.0
#2  0x0000000001557e90 in qemu_mutex_lock_impl (mutex=0x1a63f90 <qemu_global_mutex>, file=0x160bc36 "/home/cborntra/REPOS/qemu/cpus.c", line=1757)
    at /home/cborntra/REPOS/qemu/util/qemu-thread-posix.c:67
#3  0x000000000108ad5e in qemu_mutex_lock_iothread () at /home/cborntra/REPOS/qemu/cpus.c:1757
#4  0x0000000001089c70 in qemu_dummy_cpu_thread_fn (arg=0x3d4f9eb0) at /home/cborntra/REPOS/qemu/cpus.c:1258
#5  0x000003ffb9d07a88 in start_thread () at /lib64/libpthread.so.0
#6  0x000003ffb731940e in thread_start () at /lib64/libc.so.6

Thread 3 (Thread 0x3ffaa43d910 (LWP 171338)):
#0  0x000003ffb730c050 in poll () at /lib64/libc.so.6
#1  0x000003ffb8bd13b4 in g_main_context_iterate.isra () at /lib64/libglib-2.0.so.0
#2  0x000003ffb8bd1840 in g_main_loop_run () at /lib64/libglib-2.0.so.0
#3  0x00000000011f499e in iothread_run (opaque=0x3d2a4110) at /home/cborntra/REPOS/qemu/iothread.c:70
#4  0x000003ffb9d07a88 in start_thread () at /lib64/libpthread.so.0
#5  0x000003ffb731940e in thread_start () at /lib64/libc.so.6

Thread 2 (Thread 0x3ffab743910 (LWP 171336)):
#0  0x000003ffb7313ada in syscall () at /lib64/libc.so.6
#1  0x0000000001558b5e in qemu_futex_wait (f=0x1e9b41c <rcu_call_ready_event>, val=4294967295) at /home/cborntra/REPOS/qemu/include/qemu/futex.h:29
#2  0x0000000001558e16 in qemu_event_wait (ev=0x1e9b41c <rcu_call_ready_event>) at /home/cborntra/REPOS/qemu/util/qemu-thread-posix.c:445
#3  0x000000000157af82 in call_rcu_thread (opaque=0x0) at /home/cborntra/REPOS/qemu/util/rcu.c:261
#4  0x000003ffb9d07a88 in start_thread () at /lib64/libpthread.so.0
#5  0x000003ffb731940e in thread_start () at /lib64/libc.so.6

Thread 1 (Thread 0x3ffba146290 (LWP 171335)):
#0  0x000003ffb730c1a2 in ppoll () at /lib64/libc.so.6
#1  0x00000000015502da in qemu_poll_ns (fds=0x3d3b2720, nfds=1, timeout=-1) at /home/cborntra/REPOS/qemu/util/qemu-timer.c:322
#2  0x0000000001554882 in aio_poll (ctx=0x3d3924e0, blocking=true) at /home/cborntra/REPOS/qemu/util/aio-posix.c:629
#3  0x000000000145533e in bdrv_drain_recurse (bs=0x3d3a6a70) at /home/cborntra/REPOS/qemu/block/io.c:197
#4  0x0000000001455f1a in bdrv_drain_all_begin () at /home/cborntra/REPOS/qemu/block/io.c:447
#5  0x00000000014560d6 in bdrv_drain_all () at /home/cborntra/REPOS/qemu/block/io.c:476
#6  0x0000000001089216 in do_vm_stop (state=RUN_STATE_SHUTDOWN, send_stop=false) at /home/cborntra/REPOS/qemu/cpus.c:1010
#7  0x0000000001089266 in vm_shutdown () at /home/cborntra/REPOS/qemu/cpus.c:1022
#8  0x0000000001208c08 in main (argc=18, argv=0x3fffbcfdbd8, envp=0x3fffbcfdc70) at /home/cborntra/REPOS/qemu/vl.c:4732
