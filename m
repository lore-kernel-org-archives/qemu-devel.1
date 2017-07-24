Received: from eggs.gnu.org ([2001:4830:134:3::10]:51519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dZUOs-0006i0-C6
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dZUOp-0003RI-9G
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:51:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dZUOp-0003Qt-01
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:51:15 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-2-anton.ivanov@cambridgegreys.com>
	<1236f136-c211-32a1-11b1-1e86fad422c4@redhat.com>
	<c6bd0b81-0b9c-89fd-31e0-00662115cad8@cambridgegreys.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <20f8a99b-e05b-8371-461d-a6481d2fa68f@redhat.com>
Date: Mon, 24 Jul 2017 11:51:07 +0800
MIME-Version: 1.0
In-Reply-To: <c6bd0b81-0b9c-89fd-31e0-00662115cad8@cambridgegreys.com>
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



On 2017=E5=B9=B407=E6=9C=8822=E6=97=A5 01:50, Anton Ivanov wrote:
> [snip]
>
>>> +    NetUnifiedState *s =3D (NetUnifiedState *) us;
>>> +    L2TPV3TunnelParams *p =3D (L2TPV3TunnelParams *) s->params;
>>
>> How about embedding NetUnifiedState into this structure and keep=20
>> using NetL2TPV3State? Then:
>>
>> -  's' could be kept and lots of lines of changes could be saved here=20
>> and l2tpv3_verify_header()
>> -  each transport could have their own type instead of using=20
>> NET_CLIENT_DRIVER_L2TPV3
>
> That means each of them having their own read/write functions in each=20
> transport, destroy functions, etc.

Looks not? Just something like

typedef struct L2TPV3State {
     NetUDSTState udst;
     /* L2TPV3 specific data */
     ....
};

static NetClientInfo l2tpv3_info =3D {
     /* we share this one for all types for now, wrong I know :) */
     .type =3D NET_CLIENT_DRIVER_L2TPV3,
     .size =3D sizeof(L2TPV3State),
     .receive =3D net_udst_receive_dgram,
     .receive_iov =3D net_udst_receive_dgram_iov,
     .poll =3D udst_poll,
     .cleanup =3D net_udst_cleanup,
};

Thanks

>
> I am trying to achieve exactly the opposite which across all=20
> transports should save more code. There should be nothing in a=20
> transport which leverages the common datagram processing backend except=
:
>
> 1. Init and parse arguments
> 2. Form Header
> 3. Verify Header
>
> All the rest can be common for a large family of datagram based=20
> transports - L2TPv3, GRE, RAW (both full interface and just pulling a=20
> specific vlan out of it), etc.
>
> It is trivial to do that for fixed size headers (as in the current=20
> patchset family). It is a bit more difficult to that for variable=20
> headers, but still datagram (GUE, Geneve, etc).
>
> These may also add 4 - I/O to control plane, but it remains to be seen=20
> if that is needed.
>
> This also makes any improvements to the backend - f.e. switching from=20
> send() to sendmmsg() automatically available for all transports.
>
> What cannot be done is to shoehorn into this stream based. I believe=20
> we have only one of those - the original socket.c in tcp mode and we=20
> can leave it to stay that way and switch only the datagram mode to a=20
> better backend.
>
> I am going through the other comments in the meantime to see if I=20
> missed something else and fixing the omissions.
>
> A.
>
> [snip]
>
