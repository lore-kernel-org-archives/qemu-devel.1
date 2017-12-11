Received: from eggs.gnu.org ([2001:4830:134:3::10]:35821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eOQDj-0004SN-65
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eOQDg-0008MW-1U
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:42:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eOQDf-0008LQ-OZ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:42:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBBFg3IA049274
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 10:42:12 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2est05hpdv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 10:42:11 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 11 Dec 2017 15:42:07 -0000
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
	<0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
	<5A2E8067.4050000@huawei.com>
	<2b7048c1-e2f8-ab40-c4df-afe5efd8f95d@linux.vnet.ibm.com>
	<20171211160903-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 11 Dec 2017 16:41:59 +0100
MIME-Version: 1.0
In-Reply-To: <20171211160903-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a4cec719-1fb5-37da-66d4-bf57b2c045e4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, Jani.Kokkonen@huawei.com, xin.zeng@intel.com, jasowang@redhat.com, luonengjun@huawei.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, "Longpeng (Mike)" <longpeng2@huawei.com>, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com



On 12/11/2017 03:09 PM, Michael S. Tsirkin wrote:
> On Mon, Dec 11, 2017 at 02:54:25PM +0100, Halil Pasic wrote:
>> * I assume one request is supposed to correspond to one descriptor chain.
>> Right? If yes, could you tell me, where is this expressed in the spec.
>>
>> Halil
> 
> That's always the default for all virtio devices, exceptions have to
> be noted in spec.
> 

Grew to think this myself. But I could not derive it form the virtio spec.
Could you give me a pointer or a quote that _specifies_ that that's always
the default, and that exceptions have to be noted in the spec (I guess
in the corresponding device specific normative section)?

What I've found (maybe) showing in this direction is:

"""
2.4.4 Message Framing

The framing of messages with descriptors is independent of the contents of the buffers. For example, a network transmit buffer consists of a 12 byte header followed by the network packet. This could be most simply placed in the descriptor table as a 12 byte output descriptor followed by a 1514 byte output descriptor, but it could also consist of a single 1526 byte output descriptor in the case where the header and packet are adjacent, or even three or more descriptors (possibly with loss of efficiency in that case).

Note that, some device implementations have large-but-reasonable restrictions on total descriptor size (such as based on IOV_MAX in the host OS). This has not been a problem in practice: little sympathy will be given to drivers which create unreasonably-sized descriptors such as by dividing a network packet into 1500 single-byte descriptors!
"""

This however talks about buffers and messages which (seem to be used as
synonyms here BTW), and about how no assumptions should be made about
how many descriptors are used in the descriptor chain (to transfer
the same in guest memory maximal buffer elements -- maximal in a sense
that no guest physically contiguous piece of memory is represented by
two adjacent elements).

Most of the devices don't talk about messages (but rather specify
requests). So it's hard to relate the requests/packets to messages
which are framed as buffers.

I find the whole terminology a bit hard to understand (and sometimes
ambiguous).

Please help me understand this aspect of the specification.

Regards,
Halil
