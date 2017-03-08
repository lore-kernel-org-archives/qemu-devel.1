Received: from eggs.gnu.org ([2001:4830:134:3::10]:33200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1clYsp-0008VW-2Z
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1clYsk-0006C5-6L
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:31:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1clYsk-0006Bm-0J
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:31:46 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9817E76ED
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 10:31:45 +0000 (UTC)
Date: Wed, 8 Mar 2017 11:31:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170308113141.17724171@nial.brq.redhat.com>
In-Reply-To: <20170307194617.GJ2869@work-vm>
References: <20170307194617.GJ2869@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] RAMBlock's named ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, marcel@redhat.com, pbonzini@redhat.com, lvivier@redhat.com

On Tue, 7 Mar 2017 19:46:56 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> We seem to have a couple of weird cases where we end up with
> RAMBlocks with no name;  I think they'll badly confuse
> the migration code, but I don't quite understand how they're
> happening.
> 
> 1) device_del e1000e
> 2) -object memory-backend-file  without wiring it up
> 
> I added some debug into migration/ram.c ram_save_setup to
> dump the names it was seeing in it's FOREACH.
> 
> 1)
>   (from https://bugzilla.redhat.com/show_bug.cgi?id=1425273)
>   The simplest reproducer of this is:
> 
> ./qemu-system-x86_64 -nographic  -device e1000e,id=foo -m 1G -M pc,accel=kvm my.img
> 
>   with a Linux image and after it's booted do a device_del foo
> 
>   migration at that point sees an empty RAMBlock that was the ROM
>   associated with the device.  This doesn't happen on an e1000 device,
>   so I've not figured out what the difference is.
> 
>   This gives a : Unknown ramblock "", cannot accept migration
>   on the destination (correctly).
> 
>   (This happens on 2.7.0 as well, so it's nothing new)
> 
> 2)
>   ./qemu-system-x86_64 -nographic -object memory-backend-file,id=mem,size=512M,mem-path=/tmp
> 
>   Note I've not wired that memory to a NUMA node or a DIMM or anything, so
>   it's just hanging around.
>   Again that RAMBlock does exist and shows up in the migration code,
>   I think it'll try and migrate it.
it has to be registered with vmstate_register_ram() which
doesn't happen for non used hostmem object.
See:
  pc_dimm_memory_plug()
and
  memory_region_allocate_system_memory()

> The real fun is that there doesn't seem to be anything that stops
> two blocks having the same name!
code doesn't permit duplicate ids for -object created objects
but memory region api doesn't care about it as long as
memory_region name is unique child name within its parent object
children namespace.

you can do a check for empty / duplicate names at ram_block_add()
time and fail gracefully, but that probably will break things as
it hasn't been expected behavior before.


> 
> Dave
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
