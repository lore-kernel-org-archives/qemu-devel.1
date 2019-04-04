Received: from eggs.gnu.org ([209.51.188.92]:44897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hBwy1-0006vr-RB
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hBwy0-0000xf-TF
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:39:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hBwy0-0000s6-Ja
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:39:20 -0400
References: <f3a469aa-4a18-a8be-3a37-8989401e2db7@huawei.com>
	<20190403144550-mutt-send-email-mst@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4c3d0235-f5b6-a3d7-89b9-2054f24f84f7@redhat.com>
Date: Thu, 4 Apr 2019 09:39:13 +0200
MIME-Version: 1.0
In-Reply-To: <20190403144550-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Question: can we hot plug a PCIe switch on machine
 "virt"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Heyi Guo <guoheyi@huawei.com>
Cc: wanghaibin 00208455 <wanghaibin.wang@huawei.com>, qemu-devel@nongnu.org

Hi Heyi,

On 4/3/19 8:50 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 03, 2019 at 03:32:09PM +0800, Heyi Guo wrote:
>> Hi folks,
>>
>> In physical world, a PCIe switch including one upstream port and several downstream ports is a single physical device, however we treat each port as a device in qemu world. In qemu docs/pcie.txt, we have below statements:
>>
>> Line 230: Be aware that PCI Express Downstream Ports can't be hot-plugged into
>> Line 231: an existing PCI Express Upstream Port.
>>
>> To my understanding, it implies PCIe downstream ports *can* be hot-plugged into something which is not an existing upstream port. If it is true, how can we do that? AFAIK monitor command device_add can only add one device at a time.
>>
>> Please help to show the truth.
>>
>> Thanks,
>>
>> Heyi
>>
> 
> afaik they can only be plugged into upstearm ports with or without hotplug.

Hotplug on upstream port does not look supported, as mentionned in the doc:
(QEMU) device_add driver=xio3130-downstream id=down0 bus=upstream_port1
{"error": {"class": "GenericError", "desc": "Bus 'upstream_port1' does
not support hotplugging"}}

Looks the std way to use the downstream port is the one documented in 2.2.3:

2.2.3 Plugging a PCI Express device into a Switch:
-device ioh3420,id=root_port1,chassis=x,slot=y[,bus=pcie.0][,addr=z]
-device x3130-upstream,id=upstream_port1,bus=root_port1[,addr=x]
-device
xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=x1,slot=y1[,addr=z1]]
-device <dev>,bus=downstream_port1

For my curiosity why do you want to hotplug a downstream port in another
place than an upstream port?

Thanks

Eric


> 
