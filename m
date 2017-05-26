Received: from eggs.gnu.org ([2001:4830:134:3::10]:47695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6hM-0005zf-6Z
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6hL-0007Ym-61
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:18:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dE6hL-0007XT-0H
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:17:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19CFB8A003
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 04:17:58 +0000 (UTC)
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-5-git-send-email-vyasevic@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <063c033a-53fe-483c-9692-90311ff3465c@redhat.com>
Date: Fri, 26 May 2017 12:17:46 +0800
MIME-Version: 1.0
In-Reply-To: <1495649128-10529-5-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/12] net: Add a network device specific
 self-announcement ability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com



On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 02:05, Vladislav Yasevich wrote:
> Some network devices have a capability to do self annoucements
> (ex: virtio-new).

I thought you mean "virtio-net" here.

> Add infrustrcture that would allow devices
> to expose this ability.
>
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> ---
>   include/net/net.h  | 2 ++
>   migration/savevm.c | 6 ++++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 99b28d5..598f523 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -64,6 +64,7 @@ typedef int (SetVnetLE)(NetClientState *, bool);
>   typedef int (SetVnetBE)(NetClientState *, bool);
>   typedef struct SocketReadState SocketReadState;
>   typedef void (SocketReadStateFinalize)(SocketReadState *rs);
> +typedef void (NetAnnounce)(NetClientState *);
>  =20
>   typedef struct NetClientInfo {
>       NetClientDriver type;
> @@ -84,6 +85,7 @@ typedef struct NetClientInfo {
>       SetVnetHdrLen *set_vnet_hdr_len;
>       SetVnetLE *set_vnet_le;
>       SetVnetBE *set_vnet_be;
> +    NetAnnounce *announce;
>   } NetClientInfo;
>  =20
>   struct NetClientState {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 555157a..a4097c9 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -207,9 +207,15 @@ static void qemu_announce_self_iter(NICState *nic,=
 void *opaque)
>       int len;
>  =20
>       trace_qemu_announce_self_iter(qemu_ether_ntoa(&nic->conf->macaddr=
));
> +
>       len =3D announce_self_create(buf, nic->conf->macaddr.a);
>  =20
>       qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
> +
> +    /* if the NIC provides it's own announcement support, use it as we=
ll */
> +    if (nic->ncs->info->announce) {
> +        nic->ncs->info->announce(nic->ncs);
> +    }
>   }
>  =20
>   static void qemu_announce_self_once(void *opaque)

Reviewed-by: Jason Wang <jasowang@redhat.com>
