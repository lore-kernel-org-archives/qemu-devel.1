Received: from eggs.gnu.org ([2001:4830:134:3::10]:39827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA7Fz-0007bb-Il
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA7Fw-0003ug-EC
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:05:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dA7Fw-0003u4-56
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:05:12 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-8-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8779a4c4-17eb-c643-6a44-6f20f55cb6f7@redhat.com>
Date: Mon, 15 May 2017 12:05:05 +0800
MIME-Version: 1.0
In-Reply-To: <1494553288-30764-8-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 07/12] net/colo.c: Make vnet_hdr_len as
 packet property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B405=E6=9C=8812=E6=97=A5 09:41, Zhang Chen wrote:
> We can use this property flush and send packet with vnet_hdr_len.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Then I think it's not necessary to store vnet_hdr_len in SocketReadState?

Thanks

> ---
>   net/colo-compare.c    | 8 ++++++--
>   net/colo.c            | 3 ++-
>   net/colo.h            | 4 +++-
>   net/filter-rewriter.c | 2 +-
>   4 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 99a6912..87a9529 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -122,9 +122,13 @@ static int packet_enqueue(CompareState *s, int mod=
e)
>       Connection *conn;
>  =20
>       if (mode =3D=3D PRIMARY_IN) {
> -        pkt =3D packet_new(s->pri_rs.buf, s->pri_rs.packet_len);
> +        pkt =3D packet_new(s->pri_rs.buf,
> +                         s->pri_rs.packet_len,
> +                         s->pri_rs.vnet_hdr_len);
>       } else {
> -        pkt =3D packet_new(s->sec_rs.buf, s->sec_rs.packet_len);
> +        pkt =3D packet_new(s->sec_rs.buf,
> +                         s->sec_rs.packet_len,
> +                         s->sec_rs.vnet_hdr_len);
>       }
>  =20
>       if (parse_packet_early(pkt)) {
> diff --git a/net/colo.c b/net/colo.c
> index 8cc166b..180eaed 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -153,13 +153,14 @@ void connection_destroy(void *opaque)
>       g_slice_free(Connection, conn);
>   }
>  =20
> -Packet *packet_new(const void *data, int size)
> +Packet *packet_new(const void *data, int size, int vnet_hdr_len)
>   {
>       Packet *pkt =3D g_slice_new(Packet);
>  =20
>       pkt->data =3D g_memdup(data, size);
>       pkt->size =3D size;
>       pkt->creation_ms =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +    pkt->vnet_hdr_len =3D vnet_hdr_len;
>  =20
>       return pkt;
>   }
> diff --git a/net/colo.h b/net/colo.h
> index 7c524f3..caedb0d 100644
> --- a/net/colo.h
> +++ b/net/colo.h
> @@ -43,6 +43,8 @@ typedef struct Packet {
>       int size;
>       /* Time of packet creation, in wall clock ms */
>       int64_t creation_ms;
> +    /* Get vnet_hdr_len from filter */
> +    uint32_t vnet_hdr_len;
>   } Packet;
>  =20
>   typedef struct ConnectionKey {
> @@ -82,7 +84,7 @@ Connection *connection_get(GHashTable *connection_tra=
ck_table,
>                              ConnectionKey *key,
>                              GQueue *conn_list);
>   void connection_hashtable_reset(GHashTable *connection_track_table);
> -Packet *packet_new(const void *data, int size);
> +Packet *packet_new(const void *data, int size, int vnet_hdr_len);
>   void packet_destroy(void *opaque, void *user_data);
>  =20
>   #endif /* QEMU_COLO_PROXY_H */
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index afa06e8..63256c7 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -158,7 +158,7 @@ static ssize_t colo_rewriter_receive_iov(NetFilterS=
tate *nf,
>       char *buf =3D g_malloc0(size);
>  =20
>       iov_to_buf(iov, iovcnt, 0, buf, size);
> -    pkt =3D packet_new(buf, size);
> +    pkt =3D packet_new(buf, size, 0);
>       g_free(buf);
>  =20
>       /*
