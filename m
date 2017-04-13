Received: from eggs.gnu.org ([2001:4830:134:3::10]:39269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cyZC3-0007lB-IT
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cyZC0-0004tK-Em
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:29:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cyZC0-0004sc-8u
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:29:24 -0400
References: <1491999127-21103-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fa3401b0-df41-7fbd-f59f-ed5c3baa953d@redhat.com>
Date: Thu, 13 Apr 2017 15:29:18 +0800
MIME-Version: 1.0
In-Reply-To: <1491999127-21103-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] colo-compare: Fix old packet check bug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B404=E6=9C=8812=E6=97=A5 20:12, Zhang Chen wrote:
> If colo-compare find one old packet,we can notify colo-frame
> do checkpoint, no need continue find more old packet here.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 54e6d40..9b09cfc 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -372,10 +372,9 @@ static int colo_old_packet_check_one(Packet *pkt, =
int64_t *check_time)
>       }
>   }
>  =20
> -static void colo_old_packet_check_one_conn(void *opaque,
> -                                           void *user_data)
> +static int colo_old_packet_check_one_conn(Connection *conn,
> +                                          void *user_data)
>   {
> -    Connection *conn =3D opaque;
>       GList *result =3D NULL;
>       int64_t check_time =3D REGULAR_PACKET_CHECK_MS;
>  =20
> @@ -386,7 +385,10 @@ static void colo_old_packet_check_one_conn(void *o=
paque,
>       if (result) {
>           /* do checkpoint will flush old packet */
>           /* TODO: colo_notify_checkpoint();*/
> +        return 0;
>       }
> +
> +    return 1;
>   }
>  =20
>   /*
> @@ -398,7 +400,12 @@ static void colo_old_packet_check(void *opaque)
>   {
>       CompareState *s =3D opaque;
>  =20
> -    g_queue_foreach(&s->conn_list, colo_old_packet_check_one_conn, NUL=
L);
> +    /*
> +     * If we find one old packet, stop finding job and notify
> +     * COLO frame do checkpoint.
> +     */
> +    g_queue_find_custom(&s->conn_list, NULL,
> +                        (GCompareFunc)colo_old_packet_check_one_conn);
>   }
>  =20
>   /*

Queued in net-next.

Thanks
