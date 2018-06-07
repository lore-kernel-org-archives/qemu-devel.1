Received: from eggs.gnu.org ([2001:4830:134:3::10]:36409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQvEN-00027m-Gy
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQvEM-0000U1-AY
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:45:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fQvEM-0000Td-0h
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:45:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73A8FA5003
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 13:45:33 +0000 (UTC)
Date: Thu, 7 Jun 2018 14:45:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180607134529.GL2522@work-vm>
References: <20180605122636.33654-1-dgilbert@redhat.com>
	<20180605122636.33654-5-dgilbert@redhat.com>
	<20180607084933.GH750@xz-mi> <87muw6wzud.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muw6wzud.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 4/6] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Jun 05, 2018 at 01:26:34PM +0100, Dr. David Alan Gilbert (git) wrote:
> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> 
> >> Allow a bunch of the info commands to be used in preconfig.
> >> Could probably add most of them.
> >
> > I guess some of them may not work yet during preconfig.  E.g.:
> >
> > $ ./x86_64-softmmu/qemu-system-x86_64 -preconfig -monitor stdio
> > QEMU 2.12.50 monitor - type 'help' for more information
> > (qemu) info mtree
> > address-space: memory
> >   0000000000000000-ffffffffffffffff (prio 0, i/o): system
> >
> > address-space: I/O
> >   0000000000000000-000000000000ffff (prio 0, i/o): io
> >
> > But it's fine to enable that I guess.
> >
> > (Which "info" command would you want to use during preconfig?)
> >
> >> 
> >> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> The reason for having -preconfig is us despairing of making -S do the
> right thing.  We'd have to *understand* the tangled mess that is our
> startup, and rearrange it so QMP becomes available early enough for
> configuring NUMA (and other things), yet late enough for everything to
> work.
> 
> -preconfig is a cheap hack to avoid this headache, by bypassing almost
> all of "everything".
> 
> Now you bring back some of "everything".  Dangerous.  You better show it
> actually works.  Until you do:
> 
> NAK

Well I did test each command in here to make sure it didn't
crash/produce complete junk; but here's the output with the v2 of this
patch that Igor R-b:

[dgilbert@dgilbert-t530 try]$ ./x86_64-softmmu/qemu-system-x86_64 -nographic -preconfig

(qemu) 
(qemu) 
(qemu) help info
info chardev  -- show the character devices
info history  -- show the command line history
info hotpluggable-cpus  -- Show information about hotpluggable CPUs
info iothreads  -- show iothreads
info memdev  -- show memory backends
info name  -- show the current VM name
info numa  -- show NUMA information
info qom-tree [path] -- show QOM composition tree
info status  -- show the current VM status (running|paused)
info usbhost  -- show host USB devices
info uuid  -- show the current VM UUID
info version  -- show the version of QEMU
(qemu) info chardev
serial0: filename=mux
serial0-base: filename=stdio
parallel0: filename=null
(qemu) info history
0: 'help info'
1: 'info chardev'
2: 'info history'
(qemu) info hotpluggable-cpus 
Hotpluggable CPUs:
  type: "qemu64-x86_64-cpu"
  vcpus_count: "1"
  CPUInstance Properties:
    socket-id: "0"
    core-id: "0"
    thread-id: "0"
(qemu) info iothreads
(qemu) info memdev

(qemu) info name
(qemu) info numa
0 nodes
(qemu) info qom-tree 
/machine (pc-i440fx-3.0-machine)
  /peripheral (container)
  /peripheral-anon (container)
  /unattached (container)
    /system[0] (qemu:memory-region)
    /io[0] (qemu:memory-region)
(qemu) info status
VM status: paused (preconfig)
(qemu) info usbhost 
  Bus 2, Addr 3, Port 1.5, Speed 1.5 Mb/s
    Class 00: USB device 093a:2510
  Bus 1, Addr 3, Port 1.6, Speed 480 Mb/s
    Class ef: USB device 5986:02d2
  Bus 3, Addr 2, Port 1, Speed 1.5 Mb/s
    Class 00: USB device 0d3d:0001
(qemu) info uuid
00000000-0000-0000-0000-000000000000
(qemu) info version
2.12.50v2.12.0-1074-gfbb4dcae3a
(qemu) 

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
