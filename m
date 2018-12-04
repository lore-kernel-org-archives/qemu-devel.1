Received: from eggs.gnu.org ([2001:4830:134:3::10]:37704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gU0p9-0003ep-AY
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 21:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gU0p0-0001kZ-57
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 21:52:31 -0500
References: <20181203100608.28538-1-jasowang@redhat.com>
	<20181203100608.28538-2-jasowang@redhat.com>
	<7a639e00-105f-cf6d-5198-9c6e022bf29d@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c4a04cef-a740-66ec-d206-548eb4802861@redhat.com>
Date: Tue, 4 Dec 2018 10:52:09 +0800
MIME-Version: 1.0
In-Reply-To: <7a639e00-105f-cf6d-5198-9c6e022bf29d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 for 3.1 1/4] net: drop too large packet
 early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: thuth@redhat.com, mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com, qemu-stable@nongnu.org, ppandit@redhat.com, pbonzini@redhat.com


On 2018/12/4 =E4=B8=8A=E5=8D=8812:18, Eric Blake wrote:
> On 12/3/18 4:06 AM, Jason Wang wrote:
>> We try to detect and drop too large packet (>INT_MAX) in 1592a9947036
>> ("net: ignore packet size greater than INT_MAX") during packet
>> delivering. Unfortunately, this is not sufficient as we may hit
>> another integer overflow when trying to queue such large packet in
>> qemu_net_queue_append_iov():
>>
>> - size of the allocation may overflow on 32bit
>> - packet->size is integer which may overflow even on 64bit
>>
>> Fixing this by move the check to qemu_sendv_packet_async() which is
>
> s/move/moving/


Ok.


>
>> the entrance of all networking codes and reduce the limit to
>> NET_BUFSIZE to be more conservative.
>
> Please mention commit 1592a994 in the commit message (since you are=20
> effectively reverting that with this as its replacement),


I think I did it?


> and if this is (as I suspect) an additional patch required for the=20
> complete fix to CVE-2018-10839, also mention that.


Ok.


>
>>
>> Cc: qemu-stable@nongnu.org
>> Cc: Li Qiang <liq3ea@163.com>
>> Reported-by: Li Qiang <liq3ea@gmail.com>
>> Reviewed-by: Li Qiang <liq3ea@gmail.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>> =C2=A0 net/net.c | 13 +++++++------
>> =C2=A0 1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/net.c b/net/net.c
>> index 07c194a8f6..affe1877cf 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -712,15 +712,11 @@ ssize_t qemu_deliver_packet_iov(NetClientState=20
>> *sender,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *opaque)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NetClientState *nc =3D opaque;
>> -=C2=A0=C2=A0=C2=A0 size_t size =3D iov_size(iov, iovcnt);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (size > INT_MAX) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
>> -=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nc->link_down) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return iov_size(iov, iovcn=
t);
>
> Reverts 1592a994, and...
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nc->receive_disabled) {
>> @@ -745,10 +741,15 @@ ssize_t qemu_sendv_packet_async(NetClientState=20
>> *sender,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NetPacketSent *sent_c=
b)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NetQueue *queue;
>> +=C2=A0=C2=A0=C2=A0 size_t size =3D iov_size(iov, iovcnt);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (size > NET_BUFSIZE) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
>> +=C2=A0=C2=A0=C2=A0 }
>
> ...returns early for packets larger than 68k (a much smaller limit=20
> than INT_MAX, which makes analysis for int overflow a lot easier) at a=20
> saner point in the code.=C2=A0 Returning a large value is weird,=20


Might be, but we did this for years, see the following return value when=20
link is down.


> but auditing all callers:
>
> hw/net/virtio-net.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D=20
> qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
> =C2=A0- only checks if ret is 0 (returns -EBUSY) or not (assumes packet=
 was=20
> sent)
> net/netmap.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iovsize =3D qem=
u_sendv_packet_async(&s->nc, s->iov,=20
> iovcnt,
> =C2=A0- only checks if ret is 0 (starts polling) or not (assumes packet=
 was=20
> sent)
> net/net.c:=C2=A0=C2=A0=C2=A0 return qemu_sendv_packet_async(nc, iov, io=
vcnt, NULL);
> =C2=A0- implementation of qemu_sendv_packet() - so we have to audit tho=
se=20
> callers as well:
>
> hw/net/net_tx_pkt.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_sen=
dv_packet(nc, iov, iov_cnt);
> hw/net/rocker/rocker_fp.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_sendv_packet(nc, iov, iovcnt);
> hw/net/rtl8139.c: qemu_sendv_packet(qemu_get_queue(s->nic), iov, 3);
> net/hub.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_sendv_packet(=
&port->nc, iov, iovcnt);
> - all four of these do not check the return status
>
> So, it looks like none of the callers cares if the return value is=20
> overlarge (no further math on the values), just that it is non-zero=20
> (where the callers then presumably assume the packet was sent).=20


Yes, the caller may only care if it returns zero.


> However, I am not familiar enough with the code to know if skipping=20
> the packet by returning a non-zero value is going to have knock-on=20
> effects - that is, my audit shows what the callers do, but not whether=20
> it was sane.
>

The difference between qemu_sendv_packet() and qemu_sendv_packet_async()=20
is that the latter can trigger a callback (sent_cb) when peer can accept=20
more packets. This could be used by some high speed networking=20
implementation to prevent the source from producing more packets and=20
wasting cpu cycles in dropping packets. After peer can accept more,=20
sent_cb usually enable the source to produce packets. Those who use=20
qemu_sendv_packet() will just waste some cpu in dropping the packets.

Consider we are emulating ethernet and packet will be copied if queued,=20
it's safe to assume that the packet was sent.


>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sender->link_down || !sender->peer)=
 {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return iov_size(iov, iovcn=
t);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> If this is indeed CVE fixing, then we want it in -rc4, but I don't=20
> know if the patch is correctly secure yet without answers to my=20
> questions. Especially on a CVE fix for -rc4, you want to make the=20
> reviewer's life as easy as possible by providing a commit message that=20
> includes enough details to make analysis easy.


Hope my answer help. If it is, I will add them to the commit log.

Thanks for the reviewing.
