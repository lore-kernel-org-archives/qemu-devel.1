Received: from eggs.gnu.org ([209.51.188.92]:33170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gyFfJ-0006s3-Sz
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gyFfC-0002a5-Cl
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:47:19 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:32840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1gyFfB-0002YS-Vr
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:47:18 -0500
Received: by mail-ed1-x543.google.com with SMTP id c55so7466480edb.0
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 04:47:17 -0800 (PST)
Date: Mon, 25 Feb 2019 12:47:14 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190225124714.2567npif32iqt5bx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
	<20190221155004.010f7b7a@redhat.com>
	<20190223000249.e56gmq6su7vqor6k@master>
	<20190225090537.60f7aedf@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225090537.60f7aedf@Igors-MacBook-Pro.local>
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

On Mon, Feb 25, 2019 at 09:05:37AM +0100, Igor Mammedov wrote:
>On Sat, 23 Feb 2019 00:02:49 +0000
>Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> On Thu, Feb 21, 2019 at 03:50:04PM +0100, Igor Mammedov wrote:
>> >On Wed, 20 Feb 2019 08:51:21 +0800
>> >Wei Yang <richardw.yang@linux.intel.com> wrote:
>> >
>> >> Three trivial cleanup for pc-dimm.
>> >> 
>> >> Patch [1] remove the check on class->hotpluggable since pc-dimm is always
>> >> hotpluggable.
>> >> Patch [2] remove nvdimm_realize
>> >> Patch [2] remove pcdimm realize-callback
>> >even though this series doesn't break anything, I disagree with it
>> >conceptually as it makes device less abstracted and make it more
>> >dependent on how existing machine code uses it.
>> >I'd drop whole series.
>> >
>> 
>> Is Patch [1] also make device more dependent on existing implementation?
>yes, it's implementation detail that PCDIMM&Co are hotpluggable now.
>
>> For example, when we look at the counterpart of acpi_memory_plug_cb():
>> 
>>     acpi_pcihp_device_plug_cb
>> 
>> which handle the pci device hotplug. We don't check the hotpluggable
>> property for pci devices.
>> 
>> To me, this is a general rule for PCDIMM, they are hotpluggable.
>yes, PCDIMMs are hotpluggable but apci device (piix4pm/ich9/...) handling hotplug
>should ignore any non-hotpluggable one. If you remove check and then later
>someone else would add non-hotpluggable memory device or make PC-DIMMs or its
>variant of non-hotpluggable one, acpi device handling will break.
>Hence I'd prefer to keep the check.  
> 

Ok, if we'd support un-hotpluggable mem device, we could retain this
check. But this maybe not a proper place.

Based on my understanding, at this point, every thing has been done
properly. If this check pass, we will send an acpi interrupt to notify
the guest. In case this is an un-hotpluggable device, every thing looks
good but no effect in guest. Because we skip the notification.

Maybe we need to move the check in pre-plug?

>> For Patch[2][3], I agree with you.
>> 

-- 
Wei Yang
Help you, Help me
