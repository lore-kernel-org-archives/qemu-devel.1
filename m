Received: from eggs.gnu.org ([2001:4830:134:3::10]:39398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d3cy8-0005ep-SI
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d3cy5-0002Sw-Jp
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:32:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:12796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d3cy5-0002SL-AX
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:31:57 -0400
Message-ID: <590190C8.6030609@intel.com>
Date: Thu, 27 Apr 2017 14:33:44 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<1492076108-117229-6-git-send-email-wei.w.wang@intel.com>
	<20170413194732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170413194732-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 5/5] virtio-balloon:
 VIRTIO_BALLOON_F_MISC_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On 04/14/2017 01:08 AM, Michael S. Tsirkin wrote:
> On Thu, Apr 13, 2017 at 05:35:08PM +0800, Wei Wang wrote:
>> Add a new vq, miscq, to handle miscellaneous requests between the device
>> and the driver.
>>
>> This patch implemnts the VIRTIO_BALLOON_MISCQ_INQUIRE_UNUSED_PAGES
> implements
>
>> request sent from the device.
> Commands are sent from host and handled on guest.
> In fact how is this so different from stats?
> How about reusing the stats vq then? You can use one buffer
> for stats and one buffer for commands.
>

The meaning of the two vqs is a little different. statq is used for
reporting statistics, while miscq is intended to be used to handle
miscellaneous requests from the guest or host (I think it can
also be used the other way around in the future when other
new features are added which need the guest to send requests
and the host to provide responses).

I would prefer to have them separate, because:
If we plan to combine them, we need to put the previous statq
related implementation under miscq with a new command (I think
we can't combine them without using commands to distinguish
the two features).
In this way, an old driver won't work with a new QEMU or a new
driver won't work with an old QEMU. Would this be considered
as an issue here?



>
>> +	miscq_out_hdr->flags = 0;
>> +
>> +	for_each_populated_zone(zone) {
>> +		for (order = MAX_ORDER - 1; order > 0; order--) {
>> +			for (migratetype = 0; migratetype < MIGRATE_TYPES;
>> +			     migratetype++) {
>> +				do {
>> +					ret = inquire_unused_page_block(zone,
>> +						order, migratetype, &page);
>> +					if (!ret) {
>> +						pfn = (u64)page_to_pfn(page);
>> +						add_one_chunk(vb, vq,
>> +							PAGE_CHUNK_TYPE_UNUSED,
>> +							pfn,
>> +							(u64)(1 << order));
>> +					}
>> +				} while (!ret);
>> +			}
>> +		}
>> +	}
>> +	miscq_out_hdr->flags |= VIRTIO_BALLOON_MISCQ_F_COMPLETE;
> And where is miscq_out_hdr used? I see no add_outbuf anywhere.
>
> Things like this should be passed through function parameters
> and not stuffed into device structure, fields should be
> initialized before use and not where we happen to
> have the data handy.
>

miscq_out_hdr is linear with the payload (i.e. kmalloc(hdr+payload) ).
It is the same as the use of statq - one request in-flight each time.


>
> Also, _F_ is normally a bit number, you use it as a value here.
>
It intends to be a bit number. Bit 0 of flags to indicate the completion
of handling the request.
