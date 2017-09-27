Received: from eggs.gnu.org ([2001:4830:134:3::10]:60061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dx8u7-00039z-5V
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dx8u0-0001eI-Pz
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:45:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dx8u0-0001dW-Cn
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:45:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8R78g8L078633
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:11:13 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d86hmtj77-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:11:13 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 27 Sep 2017 03:11:12 -0400
Date: Wed, 27 Sep 2017 15:11:06 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-6-pasic@linux.vnet.ibm.com>
	<20170906151821.1a77afe5.cohuck@redhat.com>
	<20170907073108.GD31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907100817.08ddae29.cohuck@redhat.com>
	<20170921084547.GN11080@bjsdjshi@linux.vnet.ibm.com>
	<20170921105402.617d905b.cohuck@redhat.com>
	<20170926074856.GC28541@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926074856.GC28541@bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170927071106.GA5870@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-09-26 15:48:56 +0800]:

[...]

> > > 
> > > Tried to test with the following method:
> > > 1. Start g1 (first level guest on kvm a host) with a virtio blk device
> > >    defined:
> > > -drive file=/dev/disk/by-path/ccw-0.0.3f3e,if=none,id=drive-virtio-disk1,format=raw \
> > > -device virtio-blk-ccw,devno=fe.0.2222,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1 \
> > > 2. Login g1, and bind the subchannel of ccw device 0.0.2222 with
> > >    vfio-ccw drvier.
> > > 3. Create a mdev on the above subchannel.
> > > 4. Passthrough the mdev to g2, and try to start g2.
> > > 
> > > The 4th step failed with the following message and hang:
> > > qemu-system-s390x: vfio-ccw: wirte I/O region: errno=4
> > > (BTW, 4 is EINTR.)
> > > 
> > > I roughly guess this might be caused by:
> > > On the kvm host, virtio callback injects the I/O interrupt in a
> > > synchronzing manner. And this causes g1's I/O interrupt handler getting
> > > the interrupt and then signaling the Qemu instance on g1 with the I/O
> > > result, even before return of the pwrite().
> > > 
> > > But, using gdb on the kvm host, I do see several ssch successfully
> > > executed. I will dig the root reason, and see if there is some way to
> > > fix the issue.
> > 
> > Hm... would that be the ccws used for setting up a virtio device, and
> > the problems start once adapter interrupts become active?
> After a debugging, when starting g2, I got the following ccw sequence:
> 1. CCW_CMD_SENSE_ID		0xe4 [OK]
> 2. CCW_CMD_NOOP			0x03 [OK]
> 3. CCW_CMD_SET_VIRTIO_REV	0x83 [OK]
> 4. CCW_CMD_VDEV_RESET		0x33 [FAILED]
> 
> So this is still in the phase of setting up the device.
> 
> > Does it work if you modify the nested guest to use the old
> > per-subchannel indicators mechanism?
> It turns out the root reason for the pwrite failure is caused by a bug
> in the vfio-ccw driver:
> drivers/s390/cio/vfio_ccw_cp.c: ccwchain_fetch_direct()
>     calls pfn_array_alloc_pin() with a zero @len parameter.
> So it results in a -EINVAL return.
> 
> The current code assumes that a valid direct ccw always has its count
> value not equal to zero. However this is not true at least for the
> CCW_CMD_VDEV_RESET (0x33) command:
> (gdb) p/x ccw
>  $5 = {cmd_code = 0x33, flags = 0x4, count = 0x0, cda = 0x0}
> 
> With a temp fix on this problem, more ccws (e.g. 0x11, 0x12, 0x31, 0x72
> ...) could be translated and executed well. But finnaly the qemu process
> on g1 got a segmentation fault:
> User process fault: interruption code 0238 ilc:3 in libpthread-2.24.so[3ff84f80000+1b000]
> Failing address: 000ce330b0b00000 TEID: 000ce330b0b00800
> Fault in primary space mode while using user ASCE.
> AS:000000003b6cc1c7 R3:0000000000000024 
> Segmentation fault
> 
> dmesg on g1:
> [   18.160413] User process fault: interruption code 0238 ilc:3 in libpthread-2.24.so[3ff84f80000+1b000]
> [   18.160462] Failing address: 000ce330b0b00000 TEID: 000ce330b0b00800
> [   18.160463] Fault in primary space mode while using user ASCE.
> [   18.160470] AS:000000003b6cc1c7 R3:0000000000000024 
> [   18.160476] CPU: 1 PID: 2095 Comm: qemu-system-s39 Not tainted 4.13.0-01250-g6baa298-dirty #58
> [   18.160477] Hardware name: IBM 2964 NC9 704 (KVM/Linux)
> [   18.160479] task: 0000000038ac8000 task.stack: 0000000038e4c000
> [   18.160480] User PSW : 0705200180000000 000003ff84f93b8a
> [   18.160483]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:2 PM:0 RI:0 EA:3
> [   18.160486] User GPRS: 0000000000000001 000003ff00000003 0000000104be86b0 0000000104be86c6
> [   18.160487]            0000000000000000 0000000100000001 00000001049efb22 000003ffc5dfe13f
> [   18.160489]            000003ff643fee60 0000000000000000 000003ffc5dfe258 000003ff643fe8c8
> [   18.160490]            000003ff855a5000 00000001049cc320 000003ff643fe888 000003ff643fe7e8
> [   18.160503] User Code: 000003ff84f93b7a: c0e5ffffe7cb        brasl %r14,3ff84f90b10
>                           000003ff84f93b80: a7f4ffc4            brc 15,3ff84f93b08
>                          #000003ff84f93b84: e5600000ff0c        tbegin 0,65292
>                          >000003ff84f93b8a: b2220050            ipm >%r5
>                           000003ff84f93b8e: 8850001c            srl %r5,28
>                           000003ff84f93b92: a774001c            brc 7,3ff84f93bca
>                           000003ff84f93b96: e30020000012        lt %r0,0(%r2)
>                           000003ff84f93b9c: a784ffb6            brc 8,3ff84f93b08
> [   18.160520] Last Breaking-Event-Address:
> [   18.160524]  [<00000001046404e6>] 0x1046404e6
> 
> The above fault is not caused by vfio-ccw directly I think. So now I
> need to install gdb stuff on g1, and continuing debugging. But ideas on
> this are welcomed. ;)

Using gdb with Qemu on g1, I got the following information:

Thread 3 "qemu-system-s39" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x3ffdcdff910 (LWP 2095)]
__lll_lock_elision (futex=0x1007686b0 <qemu_global_mutex>, 
    adapt_count=0x1007686c6 <qemu_global_mutex+22>, private=0)
    at ../sysdeps/unix/sysv/linux/s390/elision-lock.c:66
66      ../sysdeps/unix/sysv/linux/s390/elision-lock.c: No such file or directory.

(gdb) bt
#0  __lll_lock_elision (futex=0x1007686b0 <qemu_global_mutex>, 
    adapt_count=0x1007686c6 <qemu_global_mutex+22>, private=0)
    at ../sysdeps/unix/sysv/linux/s390/elision-lock.c:66
#1  0x000003fffd98a1f4 in __GI___pthread_mutex_lock (mutex=<optimized out>)
    at ../nptl/pthread_mutex_lock.c:92
#2  0x0000000100515326 in qemu_mutex_lock (
    mutex=0x1007686b0 <qemu_global_mutex>) at util/qemu-thread-posix.c:65
#3  0x00000001000f2dec in qemu_mutex_lock_iothread () at /root/qemu/cpus.c:1581
#4  0x000000010022827e in kvm_arch_handle_exit (cs=0x100c30ce0, 
    run=0x3fffce80000) at /root/qemu/target/s390x/kvm.c:2193
#5  0x0000000100131c40 in kvm_cpu_exec (cpu=0x100c30ce0)
    at /root/qemu/accel/kvm/kvm-all.c:2094
#6  0x00000001000f1d2a in qemu_kvm_cpu_thread_fn (arg=0x100c30ce0)
    at /root/qemu/cpus.c:1128
#7  0x000003fffd9879d4 in start_thread (arg=0x3ffdcdff910)
    at pthread_create.c:335
#8  0x000003fffd8736ae in thread_start ()
    at ../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:71
PC not saved

Googled lock elision for a while, and I still have no idea on this
problem. Any suggestions on this?

-- 
Dong Jia Shi
