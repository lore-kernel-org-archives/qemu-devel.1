Received: from eggs.gnu.org ([2001:4830:134:3::10]:39789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHU5-0007VS-A8
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNHU1-0002GW-JV
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:15:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gNHU1-0002Fw-Di
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:14:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so4287851wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 05:14:57 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-7-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4ea0f6b-4080-75f7-2369-2795fbe264ed@redhat.com>
Date: Thu, 15 Nov 2018 14:12:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 06/41] slirp: add a callback for
 qemu_chr_fe_write_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On 14/11/2018 13:36, Marc-André Lureau wrote:
> Replace strong dependency on QEMU.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  slirp/libslirp.h | 1 +
>  net/slirp.c      | 6 ++++++
>  slirp/slirp.c    | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
> index 36d5fb9163..16ced2aa0f 100644
> --- a/slirp/libslirp.h
> +++ b/slirp/libslirp.h
> @@ -7,6 +7,7 @@ typedef struct Slirp Slirp;
>  
>  typedef struct SlirpCb {
>      void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
> +    int (*chr_write_all)(void *chr, const void *buf, size_t len);
>  } SlirpCb;
>  
>  
> diff --git a/net/slirp.c b/net/slirp.c
> index 233f66b1ef..5c1f676487 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -140,8 +140,14 @@ static NetClientInfo net_slirp_info = {
>      .cleanup = net_slirp_cleanup,
>  };
>  
> +static int net_slirp_chr_write_all(void *chr, const void *buf, size_t len)
> +{
> +    return qemu_chr_fe_write_all(chr, buf, len);
> +}
> +
>  static SlirpCb slirp_cb = {
>      .output = net_slirp_output,
> +    .chr_write_all = net_slirp_chr_write_all,


>  };
>  
>  static int net_slirp_init(NetClientState *peer, const char *model,
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 7213915bf3..4e809e5d7f 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -1099,7 +1099,7 @@ ssize_t slirp_send(struct socket *so, const void *buf, size_t len, int flags)
>      if (so->s == -1 && so->chardev) {
>          /* XXX this blocks entire thread. Rewrite to use
>           * qemu_chr_fe_write and background I/O callbacks */
> -        qemu_chr_fe_write_all(so->chardev, buf, len);
> +        so->slirp->cb->chr_write_all(so->chardev, buf, len);
>          return len;
>      }
>  
> 

Rather than this, I would split out add_exec's do_pty==3 case to a new
function add_guestfwd, and pass the function pointer to add_guestfwd.  Then:

1) add_guestfwd can store the function pointer in struct ex_list,

2) tcp_ctl can store the ex_ptr in struct socket directly, instead of
storing ex_ptr->ex_exec (that is the chardev field becomes "struct
ex_list *guestfwd" or something)

3) slirp_send can use so->chardev to retrieve both the function pointer
and the void* (renaming it to so->exec maybe)

Paolo
