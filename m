Received: from eggs.gnu.org ([2001:4830:134:3::10]:52217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d6W9P-0005bJ-Py
	for qemu-devel@nongnu.org; Fri, 05 May 2017 01:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d6W9L-0005XB-4y
	for qemu-devel@nongnu.org; Fri, 05 May 2017 01:51:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:33946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d6W9K-0005X0-RO
	for qemu-devel@nongnu.org; Fri, 05 May 2017 01:51:31 -0400
Message-ID: <590C1353.7070501@intel.com>
Date: Fri, 05 May 2017 13:53:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <286AC319A985734F985F78AFA26841F7391FDD30@shsmsx102.ccr.corp.intel.com>
	<056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
In-Reply-To: <056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: virtio-net: configurable TX queue
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Jan Scheurich <jan.scheurich@ericsson.com>

On 05/05/2017 10:27 AM, Jason Wang wrote:
>
>
> On 2017年05月04日 18:58, Wang, Wei W wrote:
>> Hi,
>>
>> I want to re-open the discussion left long time ago:
>> https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg06194.html
>> , and discuss the possibility of changing the hardcoded (256) TX  queue
>> size to be configurable between 256 and 1024.
>
> Yes, I think we probably need this.

That's great, thanks.

>
>>
>> The reason to propose this request is that a severe issue of packet 
>> drops in
>> TX direction was observed with the existing hardcoded 256 queue size,
>> which causes performance issues for packet drop sensitive guest
>> applications that cannot use indirect descriptor tables. The issue 
>> goes away
>> with 1K queue size.
>
> Do we need even more, what if we find 1K is even not sufficient in the 
> future? Modern nics has size up to ~8192.

Yes. Probably, we can also set the RX queue size to 8192 (currently it's 
1K) as well.

>
>>
>> The concern mentioned in the previous discussion (please check the link
>> above) is that the number of chained descriptors would exceed
>> UIO_MAXIOV (1024) supported by the Linux.
>
> We could try to address this limitation but probably need a new 
> feature bit to allow more than UIO_MAXIOV sgs.

I think we should first discuss whether it would be an issue below.

>
>>
>>  From the code,  I think the number of the chained descriptors is 
>> limited to
>> MAX_SKB_FRAGS + 2 (~18), which is much less than UIO_MAXIOV.
>
> This is the limitation of #page frags for skb, not the iov limitation.

I think the number of page frags are filled into the same number of 
descriptors
in the virtio-net driver (e.g. use 10 descriptors for 10 page frags). On 
the other
side, the virtio-net backend uses the same number of iov for the 
descriptors.

Since the number of page frags is limited to 18, I think there wouldn't 
be more
than 18 iovs to be passed to writev, right?

Best,
Wei
