Received: from eggs.gnu.org ([2001:4830:134:3::10]:44731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVrBq-0007sC-82
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVrBn-0003tX-3k
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:22:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dVrBm-0003tF-Tv
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:22:47 -0400
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499925175-21218-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <80774faf-ebc4-4ffa-feb6-211b63495339@redhat.com>
Date: Fri, 14 Jul 2017 11:22:39 +0800
MIME-Version: 1.0
In-Reply-To: <1499925175-21218-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 1/4] net/colo-compare.c: Add checkpoint
 min period to optimize performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B407=E6=9C=8813=E6=97=A5 13:52, Zhang Chen wrote:
> If colo-compare find out the first different packet that means
> the following packet almost is different. we needn't do a lot
> of checkpoint in this time, so we set the no-need-checkpoint
> peroid, default just set 3 second.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 6d500e1..0f8e198 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -40,6 +40,9 @@
>   /* TODO: Should be configurable */
>   #define REGULAR_PACKET_CHECK_MS 3000
>  =20
> +/* TODO: Should be configurable */
> +#define CHECKPOINT_MIN_TIME 3000
> +
>   /*
>     + CompareState ++
>     |               |
> @@ -455,6 +458,7 @@ static void colo_compare_connection(void *opaque, v=
oid *user_data)
>       Packet *pkt =3D NULL;
>       GList *result =3D NULL;
>       int ret;
> +    static int64_t checkpoint_time_ms;

Let's avoid static variable here since we support more than one compare=20
instance.

Thanks

>  =20
>       while (!g_queue_is_empty(&conn->primary_list) &&
>              !g_queue_is_empty(&conn->secondary_list)) {
> @@ -494,7 +498,14 @@ static void colo_compare_connection(void *opaque, =
void *user_data)
>                */
>               trace_colo_compare_main("packet different");
>               g_queue_push_tail(&conn->primary_list, pkt);
> -            /* TODO: colo_notify_checkpoint();*/
> +
> +            if (pkt->creation_ms - checkpoint_time_ms > CHECKPOINT_MIN=
_TIME) {
> +                /*
> +                 * TODO: Notify colo frame to do checkpoint.
> +                 * colo_compare_inconsistent_notify();
> +                 */
> +                checkpoint_time_ms =3D pkt->creation_ms;
> +            }
>               break;
>           }
>       }
