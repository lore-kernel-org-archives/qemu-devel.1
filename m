Received: from eggs.gnu.org ([209.51.188.92]:39506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEOy2-0001Mx-3s
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hEOxI-0001Dg-19
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:56:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:41984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hEOxH-0001A4-MZ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 21:56:43 -0400
Date: Thu, 11 Apr 2019 09:56:19 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190411015619.GA9198@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190407092314.11066-1-thuth@redhat.com>
	<20190408134517.GA9047@richard>
	<14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
	<20190408212911.jiqdva62ddebndut@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408212911.jiqdva62ddebndut@master>
Subject: Re: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, Apr 08, 2019 at 09:29:11PM +0000, Wei Yang wrote:
>>> 
>>> Thomas,
>>> 
>>> Thanks for pointing this out, while I have some different idea on how to fix
>>> this.
>>> 
>>> The reason of the core dump is errp already been set in
>>> hotplug_handler_pre_plug(), and this function check acpi hotplug capability.
>>> The order of this check is correct, while we should  return when errp is set
>>> in hotplug_handler_pre_plug().
>>> 
>>> I got a fix like this, which I have tested and looks good to me.
>>> 
>>> 
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 6077d27361..b11f3b15c1 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -2091,6 +2091,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>      }
>>>  
>>>      hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
>>> +    if (*errp) {
>>> +        return;
>>> +    }
>>
>>Not sure, but I think you can not rely on the fact that the caller set
>>*errp = NULL already... that's why it is more common to use a local_err
>>variable and error_propagate() for such cases (which is what I did in my
>>patch).
>>
>
>Ok, that's fine for me.
>
>>Also, why don't you want the "nvdimm is not enabled: missing 'nvdimm' in
>>'-M'" check to be done first?
>>
>
>Because this function pc_memory_pre_plug() will be called not only when
>nvdimm is hot-plugged but also dimm is hot-plugged. And
>hotplug_handler_pre_plug() here is to check the acpi(if it has) hot-plug
>capability.
>
>So the check in pc_memory_pre_plug() is from generic to specific: 
>    1. Do we have capability to hot-plug?
>    2. If the device is nvdimm, do we enabled nvdimm?
>

Thomas

Do you think this is a reasonable explanation?

-- 
Wei Yang
Help you, Help me
