Received: from eggs.gnu.org ([2001:4830:134:3::10]:33223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1e27oB-0002nl-0b
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1e27o6-0001OQ-U9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:35:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1e27o6-0001N7-NC
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:35:42 -0400
References: <20170927152118.13328-1-jfreimann@redhat.com>
	<20171004074839.5be4pq347yray2b3@localhost.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c00a0fed-bfe6-3421-8cef-a82b80cef2a1@redhat.com>
Date: Wed, 11 Oct 2017 11:35:34 +0800
MIME-Version: 1.0
In-Reply-To: <20171004074839.5be4pq347yray2b3@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] net: fix check for number of parameters
 to -netdev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Cc: maozy.fnst@cn.fujitsu.com



On 2017=E5=B9=B410=E6=9C=8804=E6=97=A5 15:48, Jens Freimann wrote:
> ping
>
> On Wed, Sep 27, 2017 at 03:21:18PM +0000, Jens Freimann wrote:
>> Since commit 0f8c289ad "net: fix -netdev socket,fd=3D for UDP sockets"
>> we allow more than one parameter for -netdev socket. But now
>> we run into an assert when no parameter at all is specified
>>
>>> qemu-system-x86_64 -netdev socket
>> socket.c:729: net_init_socket: Assertion `sock->has_udp' failed.
>>
>> Fix this by reverting the change of the if condition done in 0f8c289ad=
.
>>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Fixes: 0f8c289ad539feb5135c545bea947b310a893f4b
>> Reported-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>>
>> ---
>> v2->v3:
>> - go back to the original check !=3D 1. No need for more than one
>> =C2=A0argument, putting sock->has_fd back into the calculation is enou=
gh
>>
>> v1->v2:
>> - add check to prevent listen=3D and connect=3D being used at the same=
 time
>>
>> net/socket.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/socket.c b/net/socket.c
>> index e6b471c63d..83a2a31025 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -695,8 +695,8 @@ int net_init_socket(const Netdev *netdev, const=20
>> char *name,
>> =C2=A0=C2=A0=C2=A0 assert(netdev->type =3D=3D NET_CLIENT_DRIVER_SOCKET=
);
>> =C2=A0=C2=A0=C2=A0 sock =3D &netdev->u.socket;
>>
>> -=C2=A0=C2=A0=C2=A0 if (sock->has_listen + sock->has_connect + sock->h=
as_mcast +
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock->has_udp > 1) {
>> +=C2=A0=C2=A0=C2=A0 if (sock->has_fd + sock->has_listen + sock->has_co=
nnect +=20
>> sock->has_mcast +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock->has_udp !=3D 1) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "exactly o=
ne of listen=3D, connect=3D, mcast=3D or=20
>> udp=3D"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " is required");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> --=20
>> 2.13.5
>>
>>
>

Applied, thanks.
