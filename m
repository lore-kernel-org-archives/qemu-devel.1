Received: from eggs.gnu.org ([2001:4830:134:3::10]:38827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d8OGP-0000lu-Ly
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d8OGK-0000Nk-Uv
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:50:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:57151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d8OGK-0000NQ-Mn
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:50:28 -0400
Message-ID: <5912E2D7.1030705@intel.com>
Date: Wed, 10 May 2017 17:52:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <286AC319A985734F985F78AFA26841F7391FDD30@shsmsx102.ccr.corp.intel.com>
	<056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
	<20170505233541-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F7391FFC13@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <286AC319A985734F985F78AFA26841F7391FFC13@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] RE: virtio-net: configurable TX queue
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZQ==?= =?UTF-8?B?YXU=?= <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jan Scheurich <jan.scheurich@ericsson.com>

On 05/07/2017 12:39 PM, Wang, Wei W wrote:
> On 05/06/2017 04:37 AM, Michael S. Tsirkin wrote:
>> On Fri, May 05, 2017 at 10:27:13AM +0800, Jason Wang wrote:
>>>
>>> On 2017年05月04日 18:58, Wang, Wei W wrote:
>>>> Hi,
>>>>
>>>> I want to re-open the discussion left long time ago:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg06194.html
>>>> , and discuss the possibility of changing the hardcoded (256) TX
>>>> queue size to be configurable between 256 and 1024.
>>> Yes, I think we probably need this.
>>>
>>>> The reason to propose this request is that a severe issue of packet
>>>> drops in TX direction was observed with the existing hardcoded 256
>>>> queue size, which causes performance issues for packet drop
>>>> sensitive guest applications that cannot use indirect descriptor
>>>> tables. The issue goes away with 1K queue size.
>>> Do we need even more, what if we find 1K is even not sufficient in the
>>> future? Modern nics has size up to ~8192.
>>>
>>>> The concern mentioned in the previous discussion (please check the
>>>> link
>>>> above) is that the number of chained descriptors would exceed
>>>> UIO_MAXIOV (1024) supported by the Linux.
>>> We could try to address this limitation but probably need a new
>>> feature bit to allow more than UIO_MAXIOV sgs.
>> I'd say we should split the queue size and the sg size.
>>

I'm still doing some investigation about this, one question (or issue) I
found from the implementation is that the virtio-net device changes
the message layout when the vnet_hdr needs an endianness swap
(i.e. virtio_needs_swap()). This change adds one more iov to the
iov[]-s passed from the driver.

To be more precise, the message from the driver could be in one
of the two following layout:
Layout1:
iov[0]: vnet_hdr + data

Layout2:
iov[0]: vnet_hdr
iov[1]: data

If the driver passes the message in Layout1, and the following code
from the device changes the message from Layout1 to Layout2:

if (n->needs_vnet_hdr_swap) {
                 virtio_net_hdr_swap(vdev, (void *) &mhdr);
                 sg2[0].iov_base = &mhdr;
                 sg2[0].iov_len = n->guest_hdr_len;
                 out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
                                    out_sg, out_num,
                                    n->guest_hdr_len, -1);
                 if (out_num == VIRTQUEUE_MAX_SIZE) {
                     goto drop;
                 }
                 out_num += 1;
                 out_sg = sg2;
             }

sg2[0] is the extra one, which potentially causes the off-by-one
issue. I didn't find other possibilities that can cause the issue.

Could we keep the original layout by just copying the swapped
"mhdr" back to original out_sg[0].iov_base?

Best,
Wei
