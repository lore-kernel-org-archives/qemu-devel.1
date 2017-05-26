Received: from eggs.gnu.org ([2001:4830:134:3::10]:57328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE7kk-0001F6-41
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE7kg-0008E4-3N
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dE7kf-0008Dc-QW
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:25:30 -0400
References: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1495549241-23380-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<838b8626-c5e4-86d5-a318-ab957bc9bcbe@redhat.com>
	<f9344c1f-fa0a-4745-bf51-658c37d1d53e@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1550e79d-c657-6e9b-d7b0-39ee94c8f7af@redhat.com>
Date: Fri, 26 May 2017 13:25:19 +0800
MIME-Version: 1.0
In-Reply-To: <f9344c1f-fa0a-4745-bf51-658c37d1d53e@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V5 2/9] net/filter-mirror.c: Make filter
 mirror support vnet support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>



On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 20:55, Zhang Chen wrote:
>
>
> On 05/25/2017 02:04 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B405=E6=9C=8823=E6=97=A5 22:20, Zhang Chen wrote:
>>> We add the vnet_hdr option for filter-mirror, default is disable.
>>> If you use virtio-net-pci net driver, please enable it.
>>> You can use it for example:
>>> -object=20
>>> filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0,vnet_h=
dr=3Don
>>>
>>> If vnet_hdr=3Don we change the send packet format from
>>> struct {int size; const uint8_t buf[];} to {int size; int=20
>>> vnet_hdr_len; const uint8_t buf[];}.
>>> make other module(like colo-compare) know how to parse net packet=20
>>> correctly.
>>>
>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>> ---
>>>   net/filter-mirror.c | 73=20
>>> +++++++++++++++++++++++++++++++++++++++++++++++++----
>>>   qemu-options.hx     |  5 ++--
>>>   2 files changed, 70 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
>>> index 72fa7c2..8df0be6 100644
>>> --- a/net/filter-mirror.c
>>> +++ b/net/filter-mirror.c
>>> @@ -38,15 +38,17 @@ typedef struct MirrorState {
>>>       NetFilterState parent_obj;
>>>       char *indev;
>>>       char *outdev;
>>> +    bool vnet_hdr;
>>>       CharBackend chr_in;
>>>       CharBackend chr_out;
>>>       SocketReadState rs;
>>>   } MirrorState;
>>>   -static int filter_mirror_send(CharBackend *chr_out,
>>> +static int filter_mirror_send(MirrorState *s,
>>>                                 const struct iovec *iov,
>>>                                 int iovcnt)
>>>   {
>>> +    NetFilterState *nf =3D NETFILTER(s);
>>>       int ret =3D 0;
>>>       ssize_t size =3D 0;
>>>       uint32_t len =3D 0;
>>> @@ -58,14 +60,42 @@ static int filter_mirror_send(CharBackend *chr_ou=
t,
>>>       }
>>>         len =3D htonl(size);
>>> -    ret =3D qemu_chr_fe_write_all(chr_out, (uint8_t *)&len,=20
>>> sizeof(len));
>>> +    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len,=20
>>> sizeof(len));
>>>       if (ret !=3D sizeof(len)) {
>>>           goto err;
>>>       }
>>>   +    if (s->vnet_hdr) {
>>> +        /*
>>> +         * If vnet_hdr =3D on, we send vnet header len to make other
>>> +         * module(like colo-compare) know how to parse net
>>> +         * packet correctly.
>>> +         */
>>> +        ssize_t vnet_hdr_len;
>>> +
>>> +        /*
>>> +         * In anytime, nf->netdev and nf->netdev->peer both have a=20
>>> vnet_hdr_len,
>>> +         * Here we just find out which is we need. When filter set=20
>>> RX or TX
>>> +         * that the real vnet_hdr_len are different.
>>> +         */
>>> +        if (nf->netdev->using_vnet_hdr) {
>>> +            vnet_hdr_len =3D nf->netdev->vnet_hdr_len;
>>> +        } else if (nf->netdev->peer->using_vnet_hdr) {
>>> +            vnet_hdr_len =3D nf->netdev->peer->vnet_hdr_len;
>>
>> Rethink about this, looks like what we really want is:
>>
>> - For tx direction, only check nf->netdev->vnet_hdr_len,
>> - For rx direction, only check nf->netdev->peer->vnet_hdr_len
>
> Agree, So do you means we should remove the using_vnet_hdr related=20
> codes then just
> use the nf->direction to choice which we need check?
>
> Thanks
> Zhang Chen=20

Maybe.

Thanks
