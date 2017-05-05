Received: from eggs.gnu.org ([2001:4830:134:3::10]:36566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6ZUm-0001i8-0c
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d6ZUi-0006HZ-1o
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:25:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d6ZUh-0006H6-Nt
	for qemu-devel@nongnu.org; Fri, 05 May 2017 05:25:47 -0400
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1493372840-24551-5-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<d0bb0735-7b25-5236-bbfa-45b751395e7e@redhat.com>
	<c05b73cc-fb91-abc4-2dee-27576df0add7@cn.fujitsu.com>
	<c8cf702f-8fdb-76d1-33bb-037ce495106b@redhat.com>
	<13c41d79-09fe-26a9-d874-4ac5a942c15b@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cb6a8f58-f047-c11c-582c-82e0152ac0b3@redhat.com>
Date: Fri, 5 May 2017 17:25:37 +0800
MIME-Version: 1.0
In-Reply-To: <13c41d79-09fe-26a9-d874-4ac5a942c15b@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 04/10] net/filter-mirror.c: Add
 filter-mirror and filter-redirector vnet support.
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



On 2017=E5=B9=B405=E6=9C=8805=E6=97=A5 16:44, Zhang Chen wrote:
>
>
> On 05/03/2017 06:19 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B405=E6=9C=8803=E6=97=A5 11:18, Zhang Chen wrote:
>>>
>>>
>>> On 05/02/2017 12:47 PM, Jason Wang wrote:
>>>>
>>>>
>>>> On 2017=E5=B9=B404=E6=9C=8828=E6=97=A5 17:47, Zhang Chen wrote:
>>>>> In this patch, we change the send packet format from
>>>>> struct {int size; const uint8_t buf[];} to {int size; int=20
>>>>> vnet_hdr_len; const uint8_t buf[];}.
>>>>> make other module(like colo-compare) know how to parse net packet=20
>>>>> correctly.
>>>>>
>>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>>> ---
>>>>>   net/filter-mirror.c | 28 +++++++++++++++++++++++-----
>>>>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
>>>>> index 72fa7c2..bb9ecf3 100644
>>>>> --- a/net/filter-mirror.c
>>>>> +++ b/net/filter-mirror.c
>>>>> @@ -43,12 +43,14 @@ typedef struct MirrorState {
>>>>>       SocketReadState rs;
>>>>>   } MirrorState;
>>>>>   -static int filter_mirror_send(CharBackend *chr_out,
>>>>> +static int filter_mirror_send(MirrorState *s,
>>>>>                                 const struct iovec *iov,
>>>>>                                 int iovcnt)
>>>>>   {
>>>>> +    NetFilterState *nf =3D NETFILTER(s);
>>>>>       int ret =3D 0;
>>>>>       ssize_t size =3D 0;
>>>>> +    ssize_t vnet_hdr_len;
>>>>>       uint32_t len =3D 0;
>>>>>       char *buf;
>>>>>   @@ -58,14 +60,30 @@ static int filter_mirror_send(CharBackend=20
>>>>> *chr_out,
>>>>>       }
>>>>>         len =3D htonl(size);
>>>>> -    ret =3D qemu_chr_fe_write_all(chr_out, (uint8_t *)&len,=20
>>>>> sizeof(len));
>>>>> +    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len,=20
>>>>> sizeof(len));
>>>>> +    if (ret !=3D sizeof(len)) {
>>>>> +        goto err;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * We send vnet header len make other module(like colo-compare=
)
>>>>> +     * know how to parse net packet correctly.
>>>>> +     */
>>>>> +    if (qemu_get_using_vnet_hdr(nf->netdev)) {
>>>>> +        vnet_hdr_len =3D qemu_get_vnet_hdr_len(nf->netdev);
>>>>> +    } else {
>>>>> +        vnet_hdr_len =3D qemu_get_vnet_hdr_len(nf->netdev->peer);
>>>>> +    }
>>>>
>>>> Any reason to query peer here?
>>>
>>> That's depend on using NetClientState, If we using nf->netdev that=20
>>> need to query,
>>> Otherwise we query nf->netdev->peer, then we can get the real=20
>>> vnet_hdr_len in my test.
>>>
>>> Thanks
>>> Zhang Chen=20
>>
>> Confused, I think nf->netdev won't be a nic?
>
> I don't know whether I fully understand.
> I think it's depend on the sender, we must query sender to get real=20
> vnet_hdr_len ,
> like that in filter.c:
>
>         if (sender =3D=3D nf->netdev) {
>             /* This packet is sent by netdev itself */
>             direction =3D NET_FILTER_DIRECTION_TX;
>         } else {
>             direction =3D NET_FILTER_DIRECTION_RX;
>         }
>
> Thanks
> Zhang Chen

The problem is nf->netdev->peer should be a nic. But we don't care about=20
its vnet_hdr_len. Take virtio-net as an example, we only care about=20
host_hdr_len, since guest will strip the part that host does not care.

Thanks

>
>
>>
>> Thanks
>>
>>
>> .
>>
>
