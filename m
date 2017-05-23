Received: from eggs.gnu.org ([2001:4830:134:3::10]:45291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dD282-0008Ii-JJ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 01:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dD27y-0000F5-J8
	for qemu-devel@nongnu.org; Tue, 23 May 2017 01:13:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:36660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dD27y-0000Bh-8X
	for qemu-devel@nongnu.org; Tue, 23 May 2017 01:13:02 -0400
Message-ID: <5923C557.3020301@intel.com>
Date: Tue, 23 May 2017 13:15:03 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1495161139-28757-1-git-send-email-wei.w.wang@intel.com>
	<20170519233750-mutt-send-email-mst@kernel.org>
	<5922D0EC.6060405@intel.com>
	<b415fea9-9d48-9390-0ec2-46f69b7a54b0@redhat.com>
In-Reply-To: <b415fea9-9d48-9390-0ec2-46f69b7a54b0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH RFC] virtio-net: enable
 configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, jan.scheurich@ericsson.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 05/23/2017 10:04 AM, Jason Wang wrote:
>
>
> On 2017年05月22日 19:52, Wei Wang wrote:
>> On 05/20/2017 04:42 AM, Michael S. Tsirkin wrote:
>>> On Fri, May 19, 2017 at 10:32:19AM +0800, Wei Wang wrote:
>>>> This patch enables the virtio-net tx queue size to be configurable
>>>> between 256 (the default queue size) and 1024 by the user. The queue
>>>> size specified by the user should be power of 2.
>>>>
>>>> Setting the tx queue size to be 1024 requires the guest driver to
>>>> support the VIRTIO_NET_F_MAX_CHAIN_SIZE feature.
>>> This should be a generic ring feature, not one specific to virtio net.
>> OK. How about making two more changes below:
>>
>> 1) make the default tx queue size = 1024 (instead of 256).
>
> As has been pointed out, you need compat the default value too in this 
> case.

The driver gets the size info from the device, then would it cause any
compatibility issue if we change the default ring size to 1024 in the
vhost case? In other words, is there any software (i.e. any virtio-net 
driver)
functions based on the assumption of 256 queue size?

For live migration, the queue size that is being used will also be 
transferred
to the destination.

>
>> We can reduce the size (to 256) if the MAX_CHAIN_SIZE feature
>> is not supported by the guest.
>> In this way, people who apply the QEMU patch can directly use the
>> largest queue size(1024) without adding the booting command line.
>>
>> 2) The vhost backend does not use writev, so I think when the vhost
>> backed is used, using 1024 queue size should not depend on the
>> MAX_CHAIN_SIZE feature.
>
> But do we need to consider even larger queue size now?

Need Michael's feedback on this. Meanwhile, I'll get the next version of
code ready and check if larger queue size would cause any corner case.

>
> Btw, I think it's better to draft a spec patch.
>

I think it should be easier to draft the spec patch when the code is
almost done.


Best,
Wei
