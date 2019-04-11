Received: from eggs.gnu.org ([209.51.188.92]:44554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWBA-0003fi-4D
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWB9-0005OK-52
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:39:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWB8-0005Nf-RL
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:39:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so5769109wmk.4
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:39:30 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <73de8c44-6616-d876-33a5-05524b9e05ae@redhat.com>
Date: Thu, 11 Apr 2019 11:39:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 07/23] ui/vnc: Split out
 authentication_failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> There were 3 copies of this code, one of which used the wrong
> data size for the failure indicator.

Which, as the comment said, has never been called.

Good cleanup.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  ui/vnc.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 1871422e1d..785edf3af1 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2535,6 +2535,18 @@ void start_client_init(VncState *vs)
>      vnc_read_when(vs, protocol_client_init, 1);
>  }
>  
> +static void authentication_failed(VncState *vs)
> +{
> +    vnc_write_u32(vs, 1); /* Reject auth */
> +    if (vs->minor >= 8) {
> +        static const char err[] = "Authentication failed";
> +        vnc_write_u32(vs, sizeof(err));
> +        vnc_write(vs, err, sizeof(err));
> +    }
> +    vnc_flush(vs);
> +    vnc_client_error(vs);
> +}
> +
>  static void make_challenge(VncState *vs)
>  {
>      int i;
> @@ -2609,14 +2621,7 @@ static int protocol_client_auth_vnc(VncState *vs, uint8_t *data, size_t len)
>      return 0;
>  
>  reject:
> -    vnc_write_u32(vs, 1); /* Reject auth */
> -    if (vs->minor >= 8) {
> -        static const char err[] = "Authentication failed";
> -        vnc_write_u32(vs, sizeof(err));
> -        vnc_write(vs, err, sizeof(err));
> -    }
> -    vnc_flush(vs);
> -    vnc_client_error(vs);
> +    authentication_failed(vs);
>      qcrypto_cipher_free(cipher);
>      return 0;
>  }
> @@ -2638,13 +2643,7 @@ static int protocol_client_auth(VncState *vs, uint8_t *data, size_t len)
>       * must pick the one we sent. Verify this */
>      if (data[0] != vs->auth) { /* Reject auth */
>         trace_vnc_auth_reject(vs, vs->auth, (int)data[0]);
> -       vnc_write_u32(vs, 1);
> -       if (vs->minor >= 8) {
> -           static const char err[] = "Authentication failed";
> -           vnc_write_u32(vs, sizeof(err));
> -           vnc_write(vs, err, sizeof(err));
> -       }
> -       vnc_client_error(vs);
> +       authentication_failed(vs);
>      } else { /* Accept requested auth */
>         trace_vnc_auth_start(vs, vs->auth);
>         switch (vs->auth) {
> @@ -2673,13 +2672,7 @@ static int protocol_client_auth(VncState *vs, uint8_t *data, size_t len)
>  
>         default: /* Should not be possible, but just in case */
>             trace_vnc_auth_fail(vs, vs->auth, "Unhandled auth method", "");
> -           vnc_write_u8(vs, 1);
> -           if (vs->minor >= 8) {
> -               static const char err[] = "Authentication failed";
> -               vnc_write_u32(vs, sizeof(err));
> -               vnc_write(vs, err, sizeof(err));
> -           }
> -           vnc_client_error(vs);
> +           authentication_failed(vs);
>         }
>      }
>      return 0;
> 
