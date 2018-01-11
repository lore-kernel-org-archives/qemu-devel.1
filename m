Received: from eggs.gnu.org ([2001:4830:134:3::10]:47457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eZaVH-0008VQ-Ti
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eZaVC-0007YQ-Sj
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 05:54:36 -0500
Date: Thu, 11 Jan 2018 11:54:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180111115422.201987ee.cohuck@redhat.com>
In-Reply-To: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] vfio: ccw: basic channel path
 event handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

On Thu, 11 Jan 2018 04:04:18 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Hi Folks,
> 
> Background
> ==========
> 
> Some days ago, we had a discussion on the topic of channel path virtualization.
> Ref:
> Subject: [PATCH 0/3] Channel Path realted CRW generation
> Message-Id: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
> URL: https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg08414.html
> 
> Indeed that thread is not short and discussed many aspects in a
> non-concentrated manner. The parts those are most valuable to me are:
> 1. a re-modelling for channel path is surely the best offer, but is not
>    possible to have in the near future.
> 2. to enhance the path related functionalities, using PNO and PNOM might
>    be something we can do for now. This may be something that I could improve
>    without model related arguments.
> 
> So here I have this series targeting to add basic channel path event handling
> for vfio-ccw -- no touch of the channel path modelling in both the kernel and
> the QEMU side, but find a way to sync path status change to guest lazily using
> SCSW_FLAGS_MASK_PNO and pmcw->pnom.  In short, I want to enhance path related
> stuff (to be more specific: sync up path status to the guest) on a best effort
> basis, which means in a way that won't get us invloed to do channel path
> re-modelling.

The guest should also get the updated PIM/PAM/POM, shouldn't it?

> 
> What benifit can we get from this? The administrator of a virtual machine can
> get uptodate (in some extent) status of the current using channel paths, so
> he/she can monitor paths status and get path problem noticed timely (see the
> example below).
> 
> I think we can start a new round discussion based on this series. So reviewers
> can give their comments based on some code, and then we can decide if this is
> we want or not.
> 
> As flagged with RFC, the intention of this series is to show what I have for
> now, and what could the code look like in general. Thus I can get some early
> feedbacks. I would expect to see opinions on:
> - is the target (mentioned above) of this series welcomed or not.

It certainly makes sense to have a way to get an updated schib.

> - is the approach of this series good or bad.

Still need to read :)

> So I can either move on with this (or with other suggested approach) or leave
> it alone.
> 
> Basic Introduction of The Patches
> =================================
> 
> This is the kernel counterpart, which mainly does:
> 1. add a schib vfio region for userland to _store_ subchannel information.
> 2. add a channel path vfio irq to notify userland with chp status change event.
> 3. add .chp_event handler for vfio-ccw driver, so the driver handles chp event,
>    and signals userland about the event.

Do you plan to trigger schib updates for things other than path events?

> 
> With the above work, userland can be signaled with chp related event, and then
> it can read out uptodate SCHIB from the new region, and sync up path related
> information to the corresponding virtual subchannel. So a guest can sense the
> path update in some extent.

That's basically what Linux could do before implementing chpid related
machine checks, so it should be at least helpful.

> 
> For the QEMU counterpart, please ref:
> [RFC PATCH 0/5] vfio/ccw: basic channel path event handling
> 
> The QEMU counterpart mainly does:
> 1. add handling of the schib region, so that it can read out the newest schib
>    information.
> 2. add handling of the chp irq, so that it can get notification of channel path
>    status change.
> 3. once there is a chp status event, synchronize related information from the
>    newest schib information to guest lazily.
> 
> What are still missing, thus need to be offered in the next version are:
> - I/O termination and FSM state handling if currently we have I/O on the status
>   switched path.

I'm wondering up to which extent we should involve ourselves here. The
normal I/O subchannel driver handles all the path related things; but
for vfio, we basically want to hand the subchannel to the guest and not
involve ourselves in management. A configure off does an SCLP command;
does that already have an impact on running commands? (I can't check
myself due to lack of public documentation, sadly.)

> - Vary on/off event is not sensible to a guest.

As vary on/off basically means manipulating some internal masks and
updating path groups if applicable, I'm not sure how much we
could/should do here anyway.

> 
> Example
> =======
> 
> With both the kernel and Qemu parts applied, we can notice some new behaviors
> of a channel path when we have a guest with a passed through vfio-ccw device
> using it. The guest can reflect the chp status change of the host side lazily,
> and synchronize the updated information.
> 
> For example:
> 0. Prepare a vfio subchannel on the host:
> [root@host ~]# lscss --vfio 013f

Oh, is this a new option? In which version had it been added? (My
Fedora 26 LPAR does not yet have it.)

> MDEV                                  Subchan.  PIM PAM POM  CHPIDs
> ------------------------------------------------------------------------------
> 6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920  0.0.013f  f0  f0  ff   42434445 00000000
> 
> 1. Pass-through subchannel 0.0.013f to a guest:
> -device vfio-ccw,sysfsdev="$MDEV_FILE_PATH",devno=0.0.3f3f
> 
> 2. Start the guest and check the device and path information:
> [root@guest ~]# lscss 0002
> Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs
> ----------------------------------------------------------------------
> 0.0.3f3f 0.0.0002  3390/0c 3990/e9      f0  f0  ff   42434445 00000000 
> [root@guest ~]# lschp 
> CHPID  Vary  Cfg.  Type  Cmg  Shared  PCHID
> ============================================
> 0.00   1     -     32    -    -       -    
> 0.42   1     3     1b    -    -       -    
> 0.43   1     3     1b    -    -       -    
> 0.44   1     3     1b    -    -       -    
> 0.45   1     3     1b    -    -       -
> 
> 3. On the host, configure off one path.
> [root@host ~]# chchp -c 0 42
> 
> 4. On the guest, check the status:
> [root@guest ~]# lscss 0002
> Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs
> ----------------------------------------------------------------------
> 0.0.3f3f 0.0.0002  3390/0c 3990/e9      f0  f0  ff   42434445 00000000 
> #Notice: No change!
> 
> [root@localhost ~]# chccwdev -e 3f3f
> Setting device 0.0.3f3f online
> dasd-eckd 0.0.3f3f: A channel path to the device has become operational
> dasd-eckd 0.0.3f3f: New DASD 3390/0C (CU 3990/01) with 30051 cylinders, 15 heads, 224 sectors
> dasd-eckd 0.0.3f3f: DASD with 4 KB/block, 21636720 KB total size, 48 KB/track, compatible disk layout
>  dasda:VOL1/  0X3F3F: dasda1
> Done
> 
> [root@guest ~]# lscss 0002
> Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs
> ----------------------------------------------------------------------
> 0.0.3f3f 0.0.0002  3390/0c 3990/e9      f0  70  ff   42434445 00000000 
> #Notice: PAM value of path 0.42 changed.
> 
> 5. On the host, configure on one path.
> [root@host ~]# chchp -c 1 42
> 
> 6. On the guest, check the status again:
> [root@guest ~]# lscss 0002
> Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs
> ----------------------------------------------------------------------
> 0.0.3f3f 0.0.0002  3390/0c 3990/e9      f0  70  ff   42434445 00000000 
> #Notice: No change!
> 
> [root@localhost ~]# chccwdev -d 3f3f
> Setting device 0.0.3f3f offline
> Done
> 
> [root@guest ~]# lscss 0002
> Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs
> ----------------------------------------------------------------------
> 0.0.3f3f 0.0.0002  3390/0c 3990/e9      f0  f0  ff   42434445 00000000 
> #Notice: PAM changed again.

Yes, that looks reasonable. The guest being aware of changed masks only
if it actually did something that triggered path verification is
probably the best we can do without implementing channel path machine
checks.
