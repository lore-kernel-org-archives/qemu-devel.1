Received: from eggs.gnu.org ([2001:4830:134:3::10]:46441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fwfqk-00023y-DF
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 23:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fwfqh-0008AF-6J
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 23:48:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fwfqh-00089x-0G
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 23:48:23 -0400
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-6-sameeh@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1e0d0354-072f-73b1-ed7e-f88f4ff17659@redhat.com>
Date: Mon, 3 Sep 2018 11:48:17 +0800
MIME-Version: 1.0
In-Reply-To: <20180830142708.14311-6-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 5/6] virtio-net: steering mode: Implement rss
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>



On 2018=E5=B9=B408=E6=9C=8830=E6=97=A5 22:27, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
>
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>   hw/net/virtio-net.c | 122 +++++++++++++++++++++++++++++++++++++++++++=
+--------
>   1 file changed, 105 insertions(+), 17 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index e7c4ce6f66..4a52a6a1d0 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -972,41 +972,129 @@ static int virtio_net_handle_mq(VirtIONet *n, ui=
nt8_t cmd,
>       return VIRTIO_NET_OK;
>   }
>  =20
> -static int virtio_net_ctrl_steering_mode(VirtIONet *n, uint8_t cmd,
> +
> +static int virtio_net_ctrl_sm_rss(VirtIONet *n, uint32_t cmd,
>                                   struct iovec *iov, unsigned int iov_c=
nt,
>                                   struct iovec *iov_in, unsigned int io=
v_cnt_in,
> -        size_t *size_in)
> +                                size_t *size_in)
> +{
> +    size_t s;
> +    uint32_t supported_hash_function =3D 0;
> +
> +    switch (cmd) {
> +    case VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS:
> +        supported_hash_function |=3D RSS_HASH_FUNCTION_TOEPLITZ;
> +        if (!size_in) {
> +            return VIRTIO_NET_ERR;
> +        }
> +        s =3D iov_from_buf(iov_in, iov_cnt_in, 0,
> +        &supported_hash_function,
> +        supported_hash_function);

Indentation looks wrong.

> +        if (s !=3D sizeof(n->supported_modes) ||
> +        !size_in) {
> +            return VIRTIO_NET_ERR;
> +        }
> +        *size_in =3D s;
> +        break;
> +    case VIRTIO_NET_SM_CTRL_RSS_SET:
> +        if (!n->rss_conf) {
> +            n->rss_conf =3D g_malloc0(
> +                    sizeof(struct virtio_net_rss_conf));
> +        } else if (iov =3D=3D NULL || iov_cnt =3D=3D 0) {
> +            g_free(n->rss_conf->ptrs.hash_key);
> +            g_free(n->rss_conf->ptrs.indirection_table);
> +            g_free(n->rss_conf);
> +            return VIRTIO_NET_OK;
> +        }
> +        s =3D iov_to_buf(iov, iov_cnt, 0, n->rss_conf,
> +                sizeof(struct virtio_net_rss_conf) -
> +                sizeof(struct virtio_net_rss_conf_ptrs));
> +
> +        if (s !=3D sizeof(struct virtio_net_rss_conf) -
> +                sizeof(struct virtio_net_rss_conf_ptrs)) {
> +            return VIRTIO_NET_ERR;
> +        }
> +        n->rss_conf->ptrs.hash_key =3D g_malloc0(sizeof(uint8_t) *
> +                n->rss_conf->hash_key_length);

What happens if n->rss_conf !=3D 0 && iov !=3D NULL? Looks like a guest=20
trigger-able OOM?

Btw e.g "conf_ptrs" sounds misleading, why not just embed hash key and=20
indirection table pointers directly in rss_conf structure itself?

> +        s =3D iov_to_buf(iov, iov_cnt, 0, n->rss_conf->ptrs.hash_key,
> +                sizeof(uint8_t) * n->rss_conf->hash_key_length);
> +        if (s !=3D sizeof(uint8_t) * n->rss_conf->hash_key_length) {
> +            g_free(n->rss_conf->ptrs.hash_key);
> +            return VIRTIO_NET_ERR;
> +        }
> +        n->rss_conf->ptrs.indirection_table
> +            =3D g_malloc0(sizeof(uint32_t) *
> +                    n->rss_conf->indirection_table_length);
> +        s =3D iov_to_buf(iov, iov_cnt, 0,
> +                n->rss_conf->ptrs.indirection_table, sizeof(uint32_t) =
*
> +                n->rss_conf->indirection_table_length);
> +        if (s !=3D sizeof(uint32_t) *
> +                n->rss_conf->indirection_table_length) {
> +            g_free(n->rss_conf->ptrs.hash_key);
> +            g_free(n->rss_conf->ptrs.indirection_table);
> +            return VIRTIO_NET_ERR;
> +        }
> +        /* do bpf magic */
> +        break;
> +    default:
> +        return VIRTIO_NET_ERR;
> +    }
> +
> +    return VIRTIO_NET_OK;
> +}
> +
> +static int virtio_net_ctrl_steering_mode(VirtIONet *n, uint8_t cmd,
> +                                struct iovec *iov, unsigned int iov_cn=
t,
> +                                struct iovec *iov_in, unsigned int iov=
_in_cnt,
> +                                size_t *size_in)
>   {
>       size_t s;
>       struct virtio_net_steering_mode sm;
> +    int status =3D 0;
> +    size_t size_in_cmd =3D 0;
>  =20
>       switch (cmd) {
>       case VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES:
>           if (!size_in) {
>               return VIRTIO_NET_ERR;
>           }
> -                  s =3D iov_from_buf(iov_in, iov_cnt_in, 0,
> -          &n->supported_modes, sizeof(n->supported_modes));
> +        n->supported_modes.steering_modes |=3D STEERING_MODE_RSS |
> +            STEERING_MODE_AUTO;

We should have a property for RSS instead of hard coding it here.

Thanks

> +        s =3D iov_from_buf(iov_in, iov_in_cnt, 0,
> +        &n->supported_modes,
> +        sizeof(n->supported_modes));
>           if (s !=3D sizeof(n->supported_modes) ||
> -          !size_in) {
> +        !size_in) {
>               return VIRTIO_NET_ERR;
>           }
> -                  *size_in =3D s;
> -      break;
> +        *size_in =3D s;
> +         break;
>       case VIRTIO_NET_CTRL_SM_CONTROL:
> -        s =3D iov_to_buf(iov, iov_cnt, 0, &sm, sizeof(sm) -
> -                sizeof(union command_data));
> -        if (s !=3D sizeof(sm) - sizeof(union command_data)) {
> +        s =3D iov_to_buf(iov, iov_cnt, 0, &sm, sizeof(sm));
> +        if (s !=3D sizeof(sm)) {
> +            return VIRTIO_NET_ERR;
> +        }
> +        iov_discard_front(&iov, &iov_cnt, sizeof(sm));
> +        /* TODO handle the case where we change mode, call the old */
> +        /* mode function with null ptrs  should do the trick of */
> +        /* freeing any resources */
> +        switch (sm.steering_mode) {
> +        case STEERING_MODE_AUTO:
> +                    break;
> +        case STEERING_MODE_RSS:
> +            status =3D virtio_net_ctrl_sm_rss(n, sm.command,
> +                   iov, iov_cnt, iov_in, iov_in_cnt,
> +                   &size_in_cmd);
> +            if (status =3D=3D VIRTIO_NET_OK && size_in_cmd > 0) {
> +                *size_in +=3D size_in_cmd;
> +            }
> +            break;
> +        default:
>               return VIRTIO_NET_ERR;
>           }
> -        /* switch (cmd)
> -             {
> -                dafault:
> -                return VIRTIO_NET_ERR;
> -         } */
> -      break;
> +        break;
>       default:
> -                return VIRTIO_NET_ERR;
> +        return VIRTIO_NET_ERR;
>       }
>  =20
>       return VIRTIO_NET_OK;
