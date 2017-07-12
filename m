Received: from eggs.gnu.org ([2001:4830:134:3::10]:43824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVIFf-000771-5r
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVIFb-0005np-4Z
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:04:27 -0400
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-4-famz@redhat.com>
	<20170710150707.GK14195@stefanha-x1.localdomain>
	<61a85481-9194-d68e-2544-d80365fca83e@redhat.com>
	<20170711100535.GM17792@stefanha-x1.localdomain>
	<3b602080-ef8f-6642-04cb-be5c098dd9f5@redhat.com>
	<20170712010757.GB7449@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <404be6bd-6596-bca9-2836-da0c6a93c322@redhat.com>
Date: Wed, 12 Jul 2017 16:03:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170712010757.GB7449@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 3/6] block: Introduce
 bdrv_dma_map and bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Karl Rister <krister@redhat.com>

On 12/07/2017 03:07, Fam Zheng wrote:
> On Tue, 07/11 12:28, Paolo Bonzini wrote:
>> On 11/07/2017 12:05, Stefan Hajnoczi wrote:
>>> On Mon, Jul 10, 2017 at 05:08:56PM +0200, Paolo Bonzini wrote:
>>>> On 10/07/2017 17:07, Stefan Hajnoczi wrote:
>>>>> On Wed, Jul 05, 2017 at 09:36:32PM +0800, Fam Zheng wrote:
>>>>>> Allow block driver to map and unmap a buffer for later I/O, as a p=
erformance
>>>>>> hint.
>>>>> The name blk_dma_map() is confusing since other "dma" APIs like
>>>>> dma_addr_t and dma_blk_io() deal with guest physical addresses inst=
ead
>>>>> of host addresses.  They are about DMA to/from guest RAM.
>>>>>
>>>>> Have you considered hiding this cached mapping in block/nvme.c so t=
hat
>>>>> it isn't exposed?  block/nvme.c could keep the last buffer mapped a=
nd
>>>>> callers would get the performance benefit without a new blk_dma_map=
()
>>>>> API.
>>>>
>>>> One buffer is enough for qemu-img bench, but not for more complex ca=
ses
>>>> (e.g. fio).
>>>
>>> I don't see any other blk_dma_map() callers.
>>
>> Indeed, the fio plugin is not part of this series, but it also used
>> blk_dma_map.  Without it, performance is awful.
>=20
> How many buffers does fio use, typically? If it's not too many, block/n=
vme.c can
> cache the last N buffers. I'm with Stefan that hiding the mapping logic=
 from
> block layer callers makes a nicer API, especially such that qemu-img is=
 much
> easier to maintain good performance across subcommmands.

It depends on the queue depth.

I think the API addition is necessary, otherwise we wouldn't have added
the RAMBlockNotifier which is a layering violation that does the same
thing (create permanent HVA->IOVA mappings).  In fact, the
RAMBlockNotifier could be moved out of nvme.c and made to use
blk_dma_map/unmap, though I'm not proposing to do it now.

I don't think qemu-img convert and dd are impacted by IOMMU map/unmap as
heavily as bench, because they operate with queue depth 1.  But adding
map/unmap there would not be hard.

Paolo
