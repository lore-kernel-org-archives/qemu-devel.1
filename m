Received: from eggs.gnu.org ([2001:4830:134:3::10]:48210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dN5OM-0007Xs-3B
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dN5OJ-00025M-22
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:43:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dN5OI-00024y-R2
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:43:26 -0400
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170619142852.GS5016@thinpad.lan.raisama.net>
	<7d5904ae-e66c-5594-cfff-747578d91f4b@ilande.co.uk>
	<08da52ec-e4d2-d836-49bd-90baf21747fb@redhat.com>
	<1d8147a6-d55c-4951-68db-4c1cf502a4f3@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9d24bf00-cf82-717a-eccd-f51e2c80dd6f@redhat.com>
Date: Tue, 20 Jun 2017 00:43:19 +0200
MIME-Version: 1.0
In-Reply-To: <1d8147a6-d55c-4951-68db-4c1cf502a4f3@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv6 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, imammedo@redhat.com

On 06/19/17 20:49, Mark Cave-Ayland wrote:
> On 19/06/17 18:09, Laszlo Ersek wrote:
> 
>>> What seems to happen is that calling object_property_add_child() only
>>> succeeds for the first instance and so a simple comparison is enough to
>>> determine that the device already exists at FW_CFG_PATH. Or is this a
>>> fairly terrible (ab)use of the QOM APIs?
>>
>> This has jogged my memory about how we ensure "at most one" for the
>> vmgenid device. Please see:
>>
>>   vmgenid_realize()    [hw/acpi/vmgenid.c]
>>     find_vmgenid_dev() [include/hw/acpi/vmgenid.h]
>>
>> ... I was quite silly not to think of this on my own now, despite having
>> authored commit f92063028a0e ("hw/acpi/vmgenid: prevent more than one
>> vmgenid device", 2017-03-20) :/
> 
> Right that definitely helps - the following code seems to work correctly
> when trying to instantiate a mixture of fw_cfg_io and/or fw_cfg_mem types:
> 
> if (!object_resolve_path_type("", TYPE_FW_CFG, NULL)) {
>     error_setg(errp, "at most one %s device is permitted", TYPE_FW_CFG);
>     return;
> }
> 
> I've also copied the wording from the above commit to make everything
> consistent. Does that seem okay? If so, I'll fold it into a v7 patchset.

It looks good to me, but please await Eduardo's reply as well.

In particular, it should be confirmed that object_resolve_path_type()
matches instances of *subclasses* as well (as I expect it would). Your
test results confirm that; let's make sure it is intentional behavior.
Eduardo (or someone else on the CC list), can you please comment on that?

Thanks!
Laszlo
