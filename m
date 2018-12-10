Received: from eggs.gnu.org ([2001:4830:134:3::10]:51097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gWHvM-0007Mu-NF
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gWHvH-0004hP-Ti
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:32:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gWHvG-0004g3-Gq
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:32:19 -0500
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<561e0d7a-af2f-caad-aec3-c15952665687@redhat.com>
	<20181206085849-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cf555a3d-0312-0b61-d18a-12ca295520a0@redhat.com>
Date: Mon, 10 Dec 2018 17:32:00 +0800
MIME-Version: 1.0
In-Reply-To: <20181206085849-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/6] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: zhangyu31@baidu.com, Xie Yongji <xieyongji@baidu.com>, lilin24@baidu.com, qemu-devel@nongnu.org, elohimes@gmail.com, chaiwen@baidu.com, marcandre.lureau@redhat.com, nixun@baidu.com


On 2018/12/6 =E4=B8=8B=E5=8D=889:59, Michael S. Tsirkin wrote:
> On Thu, Dec 06, 2018 at 09:57:22PM +0800, Jason Wang wrote:
>> On 2018/12/6 =E4=B8=8B=E5=8D=882:35,elohimes@gmail.com  wrote:
>>> From: Xie Yongji<xieyongji@baidu.com>
>>>
>>> This patchset is aimed at supporting qemu to reconnect
>>> vhost-user-blk backend after vhost-user-blk backend crash or
>>> restart.
>>>
>>> The patch 1 tries to implenment the sync connection for
>>> "reconnect socket".
>>>
>>> The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
>>> to support offering shared memory to backend to record
>>> its inflight I/O.
>>>
>>> The patch 3,4 are the corresponding libvhost-user patches of
>>> patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.
>>>
>>> The patch 5 supports vhost-user-blk to reconnect backend when
>>> connection closed.
>>>
>>> The patch 6 tells qemu that we support reconnecting now.
>>>
>>> To use it, we could start qemu with:
>>>
>>> qemu-system-x86_64 \
>>>           -chardev socket,id=3Dchar0,path=3D/path/vhost.socket,reconn=
ect=3D1,wait \
>>>           -device vhost-user-blk-pci,chardev=3Dchar0 \
>>>
>>> and start vhost-user-blk backend with:
>>>
>>> vhost-user-blk -b /path/file -s /path/vhost.socket
>>>
>>> Then we can restart vhost-user-blk at any time during VM running.
>> I wonder whether or not it's better to handle this at the level of vir=
tio
>> protocol itself instead of vhost-user level. E.g expose last_avail_idx=
 to
>> driver might be sufficient?
>>
>> Another possible issue is, looks like you need to deal with different =
kinds
>> of ring layouts e.g packed virtqueues.
>>
>> Thanks
> I'm not sure I understand your comments here.
> All these would be guest-visible extensions.


Looks not, it only introduces a shared memory between qemu and=20
vhost-user backend?


> Possible for sure but how is this related to
> a patch supporting transparent reconnects?


I might miss something. My understanding is that we support transparent=20
reconnects, but we can't deduce an accurate last_avail_idx and this is=20
what capability this series try to add. To me, this series is functional=20
equivalent to expose last_avail_idx (or avail_idx_cons) in available=20
ring. So the information is inside guest memory, vhost-user backend can=20
access it and update it directly. I believe this is some modern NIC did=20
as well (but index is in MMIO area of course).

Thanks
