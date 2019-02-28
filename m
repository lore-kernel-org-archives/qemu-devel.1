Received: from eggs.gnu.org ([209.51.188.92]:50904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gz9r0-0004hr-Nz
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gz9qx-0005xq-1M
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:47:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:57325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gz9qw-0004QE-KD
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:47:10 -0500
Date: Thu, 28 Feb 2019 08:46:10 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190228004610.GA5009@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
	<20190221155004.010f7b7a@redhat.com>
	<20190223000249.e56gmq6su7vqor6k@master>
	<20190225090537.60f7aedf@Igors-MacBook-Pro.local>
	<20190225124714.2567npif32iqt5bx@master>
	<20190227141242.71081f37@redhat.com>
	<20190227135920.ly6pzlbx5a4vubak@master>
	<20190227182749.2fbbca15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227182749.2fbbca15@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] PCDIMM cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, xiaoguangrong.eric@gmail.com, philmd@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On Wed, Feb 27, 2019 at 06:27:49PM +0100, Igor Mammedov wrote:
>On Wed, 27 Feb 2019 13:59:20 +0000
>Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> On Wed, Feb 27, 2019 at 02:12:42PM +0100, Igor Mammedov wrote:
>> >On Mon, 25 Feb 2019 12:47:14 +0000
>> >Wei Yang <richard.weiyang@gmail.com> wrote:
>> >  
>> >> >> To me, this is a general rule for PCDIMM, they are hotpluggable.    
>> >> >yes, PCDIMMs are hotpluggable but apci device (piix4pm/ich9/...) handling hotplug
>> >> >should ignore any non-hotpluggable one. If you remove check and then later
>> >> >someone else would add non-hotpluggable memory device or make PC-DIMMs or its
>> >> >variant of non-hotpluggable one, acpi device handling will break.
>> >> >Hence I'd prefer to keep the check.  
>> >> >     
>> >> 
>> >> Ok, if we'd support un-hotpluggable mem device, we could retain this
>> >> check. But this maybe not a proper place.
>> >> 
>> >> Based on my understanding, at this point, every thing has been done
>> >> properly. If this check pass, we will send an acpi interrupt to notify
>> >> the guest. In case this is an un-hotpluggable device, every thing looks
>> >> good but no effect in guest. Because we skip the notification.
>> >> 
>> >> Maybe we need to move the check in pre-plug?  
>> >And what would happen then and afterwards?
>> >
>> >Point is to make one of the handlers in chain to ignore plug event
>> >(i.e. do not generate SCI event) while the rest of handlers complete
>> >successfully mapping device in address space and whatever else.
>> >  
>> 
>> This will have a well prepared device in system but guest is not
>> notified, right?
>yes, it's theoretically possible to move check up the call stack
>to machine level and not call secondary hotplug handler on non hotplugged
>device but that again depends on what secondary hotplug handler does.
>I'd rather keep logic independent here unless there is good reason not
>to do so.
>
>
>> My idea to move the check in pre-plug will result the qemu return when
>> it see no SCI event will be generated, so there is no device created.
>> 
>> I guess current behavior is a designed decision?
>I'd say so.
>PS:
>QEMU's hotplug_hadler API is misnamed at this point as it handles both
>cold (basic device wiring) and hotplug (processing hotplug).
>Maybe we should rename it but I'm not irritated enough by it to do so.
>

After re-read the code, I found something more.

First let me describe my understanding a bit.

To hotplug a device, several part are related:

    * device itself
    * machine's hotplug_handler
    * bus's hotplug_handler
    * acpi configuration

Currently, some checks are mixed, which makes the logic not that clear.

Let's come back to the problem in this thread.

The check in concern is the device's hotpluggable property. And when we look
into device_set_realized, this property is already checked at the very
beginning. This means when we go all the way down to acpi_memory_plug_cb(), if
this device is un-hotpluggable, it is must not a hotplugged device. And the
acpi_send_event() will not be triggered.

Based on my understanding, mdev->dimm and mdev->is_enabld looks still
necessary to be set for a un-hotplugged device. For both hotpluggable and
un-hotpluggable device. Skip these two steps if the device is not hotpluggable
looks not consistent with others?

-- 
Wei Yang
Help you, Help me
