Received: from eggs.gnu.org ([2001:4830:134:3::10]:41353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1clZSz-00076m-Nb
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1clZSu-0007bT-KE
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:09:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1clZSu-0007bF-Bf
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:09:08 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B448C05B1F2
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 11:09:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170308104506.GB10232@work-vm> (David Alan Gilbert's message of
	"Wed, 8 Mar 2017 10:45:07 +0000")
References: <20170307194617.GJ2869@work-vm>
	<20170308113141.17724171@nial.brq.redhat.com>
	<20170308104506.GB10232@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 08 Mar 2017 12:09:03 +0100
Message-ID: <874lz46n5c.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, marcel@redhat.com, pbonzini@redhat.com, lvivier@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Igor Mammedov (imammedo@redhat.com) wrote:
>> On Tue, 7 Mar 2017 19:46:56 +0000
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> 
>> > We seem to have a couple of weird cases where we end up with
>> > RAMBlocks with no name;  I think they'll badly confuse
>> > the migration code, but I don't quite understand how they're
>> > happening.
>> > 
>> > 1) device_del e1000e
>> > 2) -object memory-backend-file  without wiring it up
>> > 
>> > I added some debug into migration/ram.c ram_save_setup to
>> > dump the names it was seeing in it's FOREACH.
>> > 
>> > 1)
>> >   (from https://bugzilla.redhat.com/show_bug.cgi?id=1425273)
>> >   The simplest reproducer of this is:
>> > 
>> > ./qemu-system-x86_64 -nographic -device e1000e,id=foo -m 1G -M
>> > pc,accel=kvm my.img
>> > 
>> >   with a Linux image and after it's booted do a device_del foo
>> > 
>> >   migration at that point sees an empty RAMBlock that was the ROM
>> >   associated with the device.  This doesn't happen on an e1000 device,
>> >   so I've not figured out what the difference is.
>> > 
>> >   This gives a : Unknown ramblock "", cannot accept migration
>> >   on the destination (correctly).
>> > 
>> >   (This happens on 2.7.0 as well, so it's nothing new)
>> > 
>> > 2)
>> >   ./qemu-system-x86_64 -nographic -object
>> > memory-backend-file,id=mem,size=512M,mem-path=/tmp
>> > 
>> >   Note I've not wired that memory to a NUMA node or a DIMM or anything, so
>> >   it's just hanging around.
>> >   Again that RAMBlock does exist and shows up in the migration code,
>> >   I think it'll try and migrate it.
>> it has to be registered with vmstate_register_ram() which
>> doesn't happen for non used hostmem object.
>> See:
>>   pc_dimm_memory_plug()
>> and
>>   memory_region_allocate_system_memory()
>> 
>> > The real fun is that there doesn't seem to be anything that stops
>> > two blocks having the same name!
>> code doesn't permit duplicate ids for -object created objects
>> but memory region api doesn't care about it as long as
>> memory_region name is unique child name within its parent object
>> children namespace.
>> 
>> you can do a check for empty / duplicate names at ram_block_add()
>> time and fail gracefully, but that probably will break things as
>> it hasn't been expected behavior before.
>
> There's actually code to check for setting duplicate RAMBlock names;
> what isn't caught is where two RAMBlocks have never had their names
> set or where they've been unset.
>
> I'm tempted to add a check at the start of migration; if one of these
> blocks exists during a migration it'll probably succeed; two of them
> however will cause chaos.

This is the best approach for the short term as far as I can see.

Later, Juan.
