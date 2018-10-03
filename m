Received: from eggs.gnu.org ([2001:4830:134:3::10]:52810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7fca-00064u-Kk
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7fcZ-0000VE-Pn
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:47:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7fcZ-0000Uh-E4
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:47:15 -0400
References: <20180921082041.29380-1-rkagan@virtuozzo.com>
	<20180921082041.29380-4-rkagan@virtuozzo.com>
	<eac406e9-13d0-31e3-9b80-15d1fa46e165@redhat.com>
	<20181003113428.GA24354@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c12b5ef-b209-0ce2-080c-682326c52265@redhat.com>
Date: Wed, 3 Oct 2018 13:47:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181003113428.GA24354@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] hyperv: factor out arch-independent
 API into hw/hyperv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On 03/10/2018 13:34, Roman Kagan wrote:
> On Wed, Oct 03, 2018 at 12:56:00PM +0200, Paolo Bonzini wrote:
>> On 21/09/2018 10:20, Roman Kagan wrote:
>>> A significant part of hyperv.c is not actually tied to x86, and can
>>> be moved to hw/.
>>>
>>> This will allow to maintain most of Hyper-V and VMBus
>>> target-independent, and to avoid conflicts with inclusion of
>>> arch-specific headers down the road in VMBus implementation.
>>>
>>> Also this stuff can now be opt-out with CONFIG_HYPERV.
>>>
>>> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
>>
>> We can squash this in too:
>>
>> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
>> index b8f4675219..30722ccf98 100644
>> --- a/hw/Makefile.objs
>> +++ b/hw/Makefile.objs
> ...
>> -devices-dirs-$(CONFIG_SOFTMMU) += hyperv/
>> +devices-dirs-$(CONFIG_HYPERV) += hyperv/
> ...
>> --- a/hw/hyperv/Makefile.objs
>> +++ b/hw/hyperv/Makefile.objs
> ...
>> -obj-$(CONFIG_HYPERV) += hyperv.o
>> +obj-y += hyperv.o
> 
> Actually I did it this way at first, but then decided to follow the
> pattern of virtio/, xen/, and most other subdirectories there just for
> consistency.  Is there any preference for this?

It's half-and-half.  For example, CONFIG_IPMI, CONFIG_SCSI,
CONFIG_VIRTFS work this way.

acpi/ and virtio/ use CONFIG_SOFTMMU just because they need to compile
acpi-stub.o/ipmi-stub.o/vhost-stub.o unconditionally.  xen/ could be
changed if one was inclined to do it.

Paolo
