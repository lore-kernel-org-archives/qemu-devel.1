Received: from eggs.gnu.org ([2001:4830:134:3::10]:39967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gWulD-0004Ty-Ql
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 22:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gWul8-0002oS-5C
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 22:00:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gWul2-0002kq-W0
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 22:00:21 -0500
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<561e0d7a-af2f-caad-aec3-c15952665687@redhat.com>
	<20181206085849-mutt-send-email-mst@kernel.org>
	<cf555a3d-0312-0b61-d18a-12ca295520a0@redhat.com>
	<CAONzpcaXTBgPTH0WSfq-=RwHLkuqi1mhKcv4C=0_O67_hV8A2Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5794e090-9a9b-ca30-1066-ef697c9b67be@redhat.com>
Date: Wed, 12 Dec 2018 11:00:02 +0800
MIME-Version: 1.0
In-Reply-To: <CAONzpcaXTBgPTH0WSfq-=RwHLkuqi1mhKcv4C=0_O67_hV8A2Q@mail.gmail.com>
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
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, zhangyu31@baidu.com, Xie Yongji <xieyongji@baidu.com>, lilin24@baidu.com, qemu-devel@nongnu.org, chaiwen@baidu.com, marcandre.lureau@redhat.com, nixun@baidu.com


On 2018/12/12 =E4=B8=8A=E5=8D=8810:48, Yongji Xie wrote:
> On Mon, 10 Dec 2018 at 17:32, Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2018/12/6 =E4=B8=8B=E5=8D=889:59, Michael S. Tsirkin wrote:
>>> On Thu, Dec 06, 2018 at 09:57:22PM +0800, Jason Wang wrote:
>>>> On 2018/12/6 =E4=B8=8B=E5=8D=882:35,elohimes@gmail.com  wrote:
>>>>> From: Xie Yongji<xieyongji@baidu.com>
>>>>>
>>>>> This patchset is aimed at supporting qemu to reconnect
>>>>> vhost-user-blk backend after vhost-user-blk backend crash or
>>>>> restart.
>>>>>
>>>>> The patch 1 tries to implenment the sync connection for
>>>>> "reconnect socket".
>>>>>
>>>>> The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
>>>>> to support offering shared memory to backend to record
>>>>> its inflight I/O.
>>>>>
>>>>> The patch 3,4 are the corresponding libvhost-user patches of
>>>>> patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.
>>>>>
>>>>> The patch 5 supports vhost-user-blk to reconnect backend when
>>>>> connection closed.
>>>>>
>>>>> The patch 6 tells qemu that we support reconnecting now.
>>>>>
>>>>> To use it, we could start qemu with:
>>>>>
>>>>> qemu-system-x86_64 \
>>>>>            -chardev socket,id=3Dchar0,path=3D/path/vhost.socket,rec=
onnect=3D1,wait \
>>>>>            -device vhost-user-blk-pci,chardev=3Dchar0 \
>>>>>
>>>>> and start vhost-user-blk backend with:
>>>>>
>>>>> vhost-user-blk -b /path/file -s /path/vhost.socket
>>>>>
>>>>> Then we can restart vhost-user-blk at any time during VM running.
>>>> I wonder whether or not it's better to handle this at the level of v=
irtio
>>>> protocol itself instead of vhost-user level. E.g expose last_avail_i=
dx to
>>>> driver might be sufficient?
>>>>
>>>> Another possible issue is, looks like you need to deal with differen=
t kinds
>>>> of ring layouts e.g packed virtqueues.
>>>>
>>>> Thanks
>>> I'm not sure I understand your comments here.
>>> All these would be guest-visible extensions.
>>
>> Looks not, it only introduces a shared memory between qemu and
>> vhost-user backend?
>>
>>
>>> Possible for sure but how is this related to
>>> a patch supporting transparent reconnects?
>>
>> I might miss something. My understanding is that we support transparen=
t
>> reconnects, but we can't deduce an accurate last_avail_idx and this is
>> what capability this series try to add. To me, this series is function=
al
>> equivalent to expose last_avail_idx (or avail_idx_cons) in available
>> ring. So the information is inside guest memory, vhost-user backend ca=
n
>> access it and update it directly. I believe this is some modern NIC di=
d
>> as well (but index is in MMIO area of course).
>>
> Hi Jason,
>
> If my understand is correct, it might be not enough to only expose
> last_avail_idx.
> Because we would not process descriptors in the same order in which the=
y have
> been made available sometimes. If so, we can't get correct inflight
> I/O information
> from available ring.


You can get this with the help of the both used ring and last_avail_idx=20
I believe. Or maybe you can give us an example?

Thanks


>
> Thanks,
> Yongji
