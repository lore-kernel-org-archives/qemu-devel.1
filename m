Received: from eggs.gnu.org ([2001:4830:134:3::10]:35035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cte63-00044u-CF
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cte60-0002QG-K0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:42:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cte60-0002HL-BU
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:42:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28FBF437F4D
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 17:42:48 +0000 (UTC)
Date: Thu, 30 Mar 2017 18:42:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170330174242.GM2800@work-vm>
References: <20170330122354.GF2800@work-vm>
	<1490883039.28523.25.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490883039.28523.25.camel@redhat.com>
Subject: Re: [Qemu-devel] xhci migration breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

* Gerd Hoffmann (kraxel@redhat.com) wrote:
>   Hi,
> 
> > I guess maybe there's a kick needed pre/post migrate?
> 
> Sure, but it is there already (post_load arms kick_timer for active
> endpoints), so it isn't *that* simple.
> 
> Looking at this I have no idea offhand, guess I have to schedule some
> debugging for tomorrow.  Keep me posted in case you continue digging.

OK, I don't know any of this code, but my poking about so far is:

source
....
xhci: setup packet pid 0x69 addr 1 ep 1
20095@1490894271.183259:usb_xhci_ep_kick slotid 1, epid 4, streamid 0
xhci: set epctx: 35497080 state=1 dequeue=0000000230cf2f61
20095@1490894271.183284:usb_xhci_xfer_start 0x7f302931fef0: slotid 1, epid 4, streamid 0
xhci_submit(slotid=1,epid=4)
xhci: setup packet pid 0xe1 addr 1 ep 2
20095@1490894271.183404:usb_xhci_ep_kick slotid 1, epid 3, streamid 0
xhci: set epctx: 35497060 state=1 dequeue=0000000230cf3331
20095@1490894271.183420:usb_xhci_xfer_start 0x7f302931fef0: slotid 1, epid 3, streamid 0
xhci_submit(slotid=1,epid=3)
xhci: setup packet pid 0x69 addr 1 ep 1
inputs_connect: inputs channel client create
red_dispatcher_set_cursor_peer: 

(qemu) migra
migrate                 migrate_cancel          migrate_incoming        
migrate_set_cache_size  migrate_set_capability  migrate_set_downtime    
migrate_set_parameter   migrate_set_speed       migrate_start_postcopy  
(qemu) migrate_set_speed 1G
(qemu) migrate tcp:0:4444
usb-storage msd pre_save 0x7f3044627960 sig=0 tag=0
(qemu) q

dest:
(qemu) red_dispatcher_loadvm_commands: 
usb-storage msd post_load 0x7f45f510ee50 sig=0 tag=0

I added these as debug on the 'usb-storage' vmsd element; but
the signature/tag being 0 I assume they're not the culprit.

(qemu) c
(qemu) 20107@1490894287.479732:usb_xhci_ep_kick slotid 1, epid 1, streamid 0
xhci: set epctx: 35497020 state=1 dequeue=0000000035499231
20107@1490894287.479763:usb_xhci_xfer_start 0x7f45f556a800: slotid 1, epid 1, streamid 0
xhci: setup packet pid 0x69 addr 1 ep 0
20107@1490894287.479799:usb_xhci_ep_kick slotid 1, epid 3, streamid 0
xhci: set epctx: 35497060 state=1 dequeue=0000000230cf3331
20107@1490894287.479812:usb_xhci_xfer_start 0x7f45f556a800: slotid 1, epid 3, streamid 0
xhci_submit(slotid=1,epid=3)
xhci: setup packet pid 0x69 addr 1 ep 1
xhci: set epctx: 35497060 state=2 dequeue=0000000230cf3331
20107@1490894287.479837:usb_xhci_ep_kick slotid 1, epid 4, streamid 0
xhci: set epctx: 35497080 state=1 dequeue=0000000230cf2f61
20107@1490894287.479848:usb_xhci_xfer_start 0x7f45f556a800: slotid 1, epid 4, streamid 0
xhci_submit(slotid=1,epid=4)
xhci: setup packet pid 0xe1 addr 1 ep 2
qemu-system-x86_64: usb-msd: Bad signature 53425300

given the bottom byte is 0 - is anything supposed to poison these things when
they're finished with them?


The backtrace (where I added an assert) shows it is coming off the timer
(Note I think this is a different run from that above):
#3  0x00007feba72c91f2 in __GI___assert_fail (assertion=assertion@entry=0x7febabcc1f3a "0", file=file@entry=0x7febabcb1f90 "/root/1436616/qemu/hw/usb/dev-storage.c", line=line@entry=429, function=function@entry=0x7febabcb20f0 <__PRETTY_FUNCTION__.30660> "usb_msd_handle_data") at assert.c:101
#4  0x00007febabad00e1 in usb_msd_handle_data (dev=0x7febae693e50, p=0x7febaeaef808)
    at /root/1436616/qemu/hw/usb/dev-storage.c:429
#5  0x00007febabab2b58 in usb_handle_packet (dev=<optimized out>, p=p@entry=0x7febaeaef808)
    at /root/1436616/qemu/hw/usb/core.c:412
#6  0x00007febabacae27 in xhci_kick_epctx (epctx=<optimized out>, xfer=<optimized out>, xhci=<optimized out>)
    at /root/1436616/qemu/hw/usb/hcd-xhci.c:2103 <- right at the end of xhci_submit
#7  0x00007febabacae27 in xhci_kick_epctx (epctx=<optimized out>, xfer=<optimized out>, xhci=<optimized out>)
    at /root/1436616/qemu/hw/usb/hcd-xhci.c:2112 right at end of xhci_fire_transfer
#8  0x00007febabacae27 in xhci_kick_epctx (epctx=0x7febaec395a0, streamid=0)
    at /root/1436616/qemu/hw/usb/hcd-xhci.c:2240
#9  0x00007febabb4c8b9 in timerlist_run_timers (timer_list=0x7febad2ad790) at /root/1436616/qemu/qemu-timer.c:540
#10 0x00007febabb4cb20 in qemu_clock_run_all_timers (type=<optimized out>) at /root/1436616/qemu/qemu-timer.c:551
#11 0x00007febabb4cb20 in qemu_clock_run_all_timers () at /root/1436616/qemu/qemu-timer.c:665
#12 0x00007febabb4bae7 in main_loop_wait (nonblocking=<optimized out>) at /root/1436616/qemu/main-loop.c:516
#13 0x00007febab8855e2 in main () at /root/1436616/qemu/vl.c:1888
#14 0x00007febab8855e2 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
    at /root/1436616/qemu/vl.c:4630

Dave

> cheers,
>   Gerd
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
