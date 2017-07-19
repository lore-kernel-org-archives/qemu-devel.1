Received: from eggs.gnu.org ([2001:4830:134:3::10]:51693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dXi8c-0001EA-Ms
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dXi8X-0004zz-IX
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:07:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dXi8X-0004zT-8C
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:07:05 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-2-anton.ivanov@cambridgegreys.com>
	<1236f136-c211-32a1-11b1-1e86fad422c4@redhat.com>
	<89e2f26c-4e1d-05ef-9a99-85dc5c9c111a@cambridgegreys.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <050e2865-0453-64d8-f29a-7b6d2bb418d9@redhat.com>
Date: Wed, 19 Jul 2017 14:07:00 +0800
MIME-Version: 1.0
In-Reply-To: <89e2f26c-4e1d-05ef-9a99-85dc5c9c111a@cambridgegreys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] Unified Datagram Socket Transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B407=E6=9C=8819=E6=97=A5 13:48, Anton Ivanov wrote:
>
>
> On 19/07/17 06:39, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B407=E6=9C=8819=E6=97=A5 01:08, anton.ivanov@cambridgegr=
eys.com wrote:
>>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>>
>>> 1. Creates a common backend for socket transports using
>>> recvmmsg().
>>> 2. Migrates L2TPv3 to the new backend
>>
>> It would be better if you could further split out 2 from this patch.
>>
>>>
>>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>> ---
>>>   configure         |  10 +-
>>>   net/Makefile.objs |   2 +-
>>>   net/l2tpv3.c      | 531=20
>>> +++++++++---------------------------------------------
>>>   net/net.c         |   4 +-
>>>   net/unified.c     | 406 +++++++++++++++++++++++++++++++++++++++++
>>>   net/unified.h     | 118 ++++++++++++
>>>   6 files changed, 613 insertions(+), 458 deletions(-)
>>>   create mode 100644 net/unified.c
>>>   create mode 100644 net/unified.h
>>>
>>> diff --git a/configure b/configure
>>> index a3f0522e8f..99a60b723c 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -1862,7 +1862,7 @@ if ! compile_object -Werror ; then
>>>   fi
>>>     ##########################################
>>> -# L2TPV3 probe
>>> +# UNIFIED probe
>>>     cat > $TMPC <<EOF
>>>   #include <sys/socket.h>
>>> @@ -1870,9 +1870,9 @@ cat > $TMPC <<EOF
>>>   int main(void) { return sizeof(struct mmsghdr); }
>>>   EOF
>>>   if compile_prog "" "" ; then
>>> -  l2tpv3=3Dyes
>>> +  unified=3Dyes
>>>   else
>>> -  l2tpv3=3Dno
>>> +  unified=3Dno
>>>   fi
>>>     ##########################################
>>> @@ -5458,8 +5458,8 @@ fi
>>>   if test "$netmap" =3D "yes" ; then
>>>     echo "CONFIG_NETMAP=3Dy" >> $config_host_mak
>>>   fi
>>> -if test "$l2tpv3" =3D "yes" ; then
>>> -  echo "CONFIG_L2TPV3=3Dy" >> $config_host_mak
>>> +if test "$unified" =3D "yes" ; then
>>> +  echo "CONFIG_UNIFIED=3Dy" >> $config_host_mak
>>>   fi
>>
>> Could we keep l2tpv3 option?
>
> The l2tpv3 test is actually a test for recvmmsg. If you can do one=20
> recvmmsg transport you can do all of them.

Yes, but I wonder whether or not the check for recvmmsg is too simple.=20
We probably want something like what AV_VSOCK did, test the support of=20
each transport through socket().

>
>>
>>>   if test "$cap_ng" =3D "yes" ; then
>>>     echo "CONFIG_LIBCAP=3Dy" >> $config_host_mak
>>> diff --git a/net/Makefile.objs b/net/Makefile.objs
>>> index 67ba5e26fb..8026ad778a 100644
>>> --- a/net/Makefile.objs
>>> +++ b/net/Makefile.objs
>>> @@ -2,7 +2,7 @@ common-obj-y =3D net.o queue.o checksum.o util.o hub.=
o
>>>   common-obj-y +=3D socket.o
>>>   common-obj-y +=3D dump.o
>>>   common-obj-y +=3D eth.o
>>> -common-obj-$(CONFIG_L2TPV3) +=3D l2tpv3.o
>>> +common-obj-$(CONFIG_UNIFIED) +=3D l2tpv3.o unified.o
>>>   common-obj-$(CONFIG_POSIX) +=3D vhost-user.o
>>>   common-obj-$(CONFIG_SLIRP) +=3D slirp.o
>>>   common-obj-$(CONFIG_VDE) +=3D vde.o

[...]

>>>>   -    s =3D DO_UPCAST(NetL2TPV3State, nc, nc);
>>>> +    s->params =3D p;
>>>>   +    s->form_header =3D &l2tpv3_form_header;
>>>> +    s->verify_header =3D &l2tpv3_verify_header;
>>>>       s->queue_head =3D 0;
>>>>       s->queue_tail =3D 0;
>>>>       s->header_mismatch =3D false;
>>>
>>> Why not move all above into qemu_new_unified_net()?
>
> Only queue head/tail assignment can move.
>
> raw which uses same backend does not use header_mismatch. Form/verify=20
> header are different for each sub-transport. F.e. for gre you need the=20
> gre one, for raw you need the raw one, etc.

Right, I mean pass function pointer to qemu_new_unified_net().

>
>>
>>> @@ -549,9 +188,9 @@ int net_init_l2tpv3(const Netdev *netdev,
>>>       l2tpv3 =3D &netdev->u.l2tpv3;
>>>         if (l2tpv3->has_ipv6 && l2tpv3->ipv6) {
>>> -        s->ipv6 =3D l2tpv3->ipv6;
>>> +        p->ipv6 =3D l2tpv3->ipv6;
>>>       } else {
>>> -        s->ipv6 =3D false;
>>> +        p->ipv6 =3D false;

[...]

>>>   diff --git a/net/unified.c b/net/unified.c
>>
>> Not a native speaker, but I think we need a better name here e.g udst=20
>> which is short for Unified Datagram Socket Transport?
>
> I am not a native speaker either :)
>
> I am OK - let's call it udst as this is more descriptive and this=20
> clearly delineates that you cannot
> migrate tcp/socket to it.

Ok.

>
>>
>>>

[...]

>>> +
>>> +static ssize_t net_unified_receive_dgram_iov(NetClientState *nc,
>>> +                    const struct iovec *iov,
>>> +                    int iovcnt)
>>> +{
>>> +    NetUnifiedState *s =3D DO_UPCAST(NetUnifiedState, nc, nc);
>>> +
>>> +    struct msghdr message;
>>> +    int ret;
>>> +
>>> +    if (iovcnt > MAX_UNIFIED_IOVCNT - 1) {
>>> +        error_report(
>>> +            "iovec too long %d > %d, change unified.h",
>>> +            iovcnt, MAX_UNIFIED_IOVCNT
>>> +        );
>>> +        return -1;
>>> +    }
>>> +    if (s->offset > 0) {
>>
>> net_l2tpv3_receive_dgram_iov() does not have this check. I guess it=20
>> s->offset=3D0 will be used by other transport. Maybe it's better to=20
>> delay this change until is has a real user or add a comment here.
>
> The real user is in patch No 2. Raw.

Ok.

Thanks.
