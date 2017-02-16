Received: from eggs.gnu.org ([2001:4830:134:3::10]:44181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceBtc-0001AU-NV
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceBtZ-0007Nq-Ju
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:34:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ceBtZ-0007Ni-Da
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:34:09 -0500
References: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487147657-166092-4-git-send-email-zhang.zhanghailiang@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <09a2bc10-d8dd-a2c0-f545-6b08a871d91a@redhat.com>
Date: Thu, 16 Feb 2017 10:34:03 +0800
MIME-Version: 1.0
In-Reply-To: <1487147657-166092-4-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] colo-compare: release all unhandled
 packets in finalize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com



On 2017=E5=B9=B402=E6=9C=8815=E6=97=A5 16:34, zhanghailiang wrote:
> We should release all unhandled packets before finalize colo compare.
> Besides, we need to free connection_track_table, or there will be
> a memory leak bug.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>   net/colo-compare.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index a16e2d5..809bad3 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -676,6 +676,23 @@ static void colo_compare_complete(UserCreatable *u=
c, Error **errp)
>       return;
>   }
>  =20
> +static void colo_release_packets(void *opaque, void *user_data)
> +{
> +    CompareState *s =3D user_data;
> +    Connection *conn =3D opaque;
> +    Packet *pkt =3D NULL;
> +
> +    while (!g_queue_is_empty(&conn->primary_list)) {
> +        pkt =3D g_queue_pop_head(&conn->primary_list);
> +        compare_chr_send(&s->chr_out, pkt->data, pkt->size);

Any reason to send packets here?

Thanks

> +        packet_destroy(pkt, NULL);
> +    }
> +    while (!g_queue_is_empty(&conn->secondary_list)) {
> +        pkt =3D g_queue_pop_head(&conn->secondary_list);
> +        packet_destroy(pkt, NULL);
> +    }
> +}
> +
>   static void colo_compare_class_init(ObjectClass *oc, void *data)
>   {
>       UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> @@ -707,9 +724,12 @@ static void colo_compare_finalize(Object *obj)
>       g_main_loop_quit(s->compare_loop);
>       qemu_thread_join(&s->thread);
>  =20
> +    /* Release all unhandled packets after compare thead exited */
> +    g_queue_foreach(&s->conn_list, colo_release_packets, s);
>  =20
>       g_queue_free(&s->conn_list);
>  =20
> +    g_hash_table_destroy(s->connection_track_table);
>       g_free(s->pri_indev);
>       g_free(s->sec_indev);
>       g_free(s->outdev);
