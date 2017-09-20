Received: from eggs.gnu.org ([2001:4830:134:3::10]:51376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dufXB-0005Yd-TZ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dufXA-000790-RR
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:59:25 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:51917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dufXA-00078g-KE
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:59:24 -0400
Received: by mail-wr0-x231.google.com with SMTP id z39so2241233wrb.8
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:59:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <84d1e5a0-141f-cd91-f62c-14fe58e73b4b@redhat.com>
References: <1505811353-29151-1-git-send-email-thuth@redhat.com>
	<84d1e5a0-141f-cd91-f62c-14fe58e73b4b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Sep 2017 11:07:25 +0100
Message-ID: <CAFEAcA_morPirUBzbpX1tHKfSCX+vAEcWX+KmUZKdnNm3O3vhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

On 20 September 2017 at 08:50, Marcel Apfelbaum <marcel@redhat.com> wrote:
> Hi Thomas,
>
>
> On 19/09/2017 11:55, Thomas Huth wrote:
>>
>> Historically we've marked all devices as hotpluggable by default. However,
>> most devices are not hotpluggable, and you also need a HotplugHandler to
>> support these devices. So if the user tries to "device_add" or
>> "device_del"
>> such a non-hotpluggable device during runtime, either nothing really
>> usable
>> happens, or QEMU even crashes/aborts unexpectedly (see for example commit
>> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
>> So let's change this dangerous default behaviour and mark the devices as
>> non-hotpluggable by default. Certain parent devices classes which are
>> known
>> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable =
>> true",
>> so that devices that are derived from these classes continue to work as
>> expected.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Note: I've marked the patch as RFC since I'm not 100% sure whether I've
>>   correctly identified all devices that should still be marked as hot-
>>   pluggable. Feedback is welcome!
>>
>>   hw/core/qdev.c        | 10 ++++------
>>   hw/cpu/core.c         |  1 +
>>   hw/mem/nvdimm.c       |  3 +++
>>   hw/mem/pc-dimm.c      |  1 +
>>   hw/pci/pci.c          |  1 +
>>   hw/s390x/ccw-device.c |  1 +
>>   hw/scsi/scsi-bus.c    |  1 +
>>   hw/usb/bus.c          |  1 +
>>   8 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 606ab53..c4f1902 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -1120,13 +1120,11 @@ static void device_class_init(ObjectClass *class,
>> void *data)
>>       dc->realize = device_realize;
>>       dc->unrealize = device_unrealize;
>>   -    /* by default all devices were considered as hotpluggable,
>> -     * so with intent to check it in generic qdev_unplug() /
>> -     * device_set_realized() functions make every device
>> -     * hotpluggable. Devices that shouldn't be hotpluggable,
>> -     * should override it in their class_init()
>> +    /*
>> +     * All devices are considered as cold-pluggable by default. The
>> devices
>> +     * that are hotpluggable should override it in their class_init().
>>        */
>> -    dc->hotpluggable = true;
>> +    dc->hotpluggable = false;
>
>
> I agree with the defensive mode as long as we don't
> introduce any regression...

Is it possible to hack together some kind of test code that
can give us a list of the devices compiled in that have
hotpluggable enabled? Then we could compare before and
after to see which devices we've changed.

thanks
-- PMM
