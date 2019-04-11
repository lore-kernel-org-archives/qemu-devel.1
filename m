Received: from eggs.gnu.org ([209.51.188.92]:44762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWCC-0004HZ-5c
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWCB-0005pA-43
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:40:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWC3-0005l0-VH
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:40:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so6406083wre.7
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:40:23 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <73b0d19e-aad2-b9f0-1f12-64889e77521d@redhat.com>
Date: Thu, 11 Apr 2019 11:40:21 +0200
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 08/23] ui/vnc: Use gcrypto_random_bytes
 for start_auth_vnc
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
> Use a better interface for random numbers than rand().
> Fail gracefully if for some reason we cannot use the crypto system.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v2: Use qcrypto_random_bytes, not qemu_getrandom, as there is
>     no need for deterministic results for this interface.
> v3: Fail gracefully in the event qcrypto_random_bytes fails.
> ---
>  ui/vnc.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 785edf3af1..d83f4a6ff9 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -43,6 +43,7 @@
>  #include "crypto/hash.h"
>  #include "crypto/tlscredsanon.h"
>  #include "crypto/tlscredsx509.h"
> +#include "crypto/random.h"
>  #include "qom/object_interfaces.h"
>  #include "qemu/cutils.h"
>  #include "io/dns-resolver.h"
> @@ -2547,16 +2548,6 @@ static void authentication_failed(VncState *vs)
>      vnc_client_error(vs);
>  }
>  
> -static void make_challenge(VncState *vs)
> -{
> -    int i;
> -
> -    srand(time(NULL)+getpid()+getpid()*987654+rand());
> -
> -    for (i = 0 ; i < sizeof(vs->challenge) ; i++)
> -        vs->challenge[i] = (int) (256.0*rand()/(RAND_MAX+1.0));
> -}
> -
>  static int protocol_client_auth_vnc(VncState *vs, uint8_t *data, size_t len)
>  {
>      unsigned char response[VNC_AUTH_CHALLENGE_SIZE];
> @@ -2628,7 +2619,16 @@ reject:
>  
>  void start_auth_vnc(VncState *vs)
>  {
> -    make_challenge(vs);
> +    Error *err = NULL;
> +
> +    if (qcrypto_random_bytes(vs->challenge, sizeof(vs->challenge), &err)) {
> +        trace_vnc_auth_fail(vs, vs->auth, "cannot get random bytes",
> +                            error_get_pretty(err));
> +        error_free(err);
> +        authentication_failed(vs);
> +        return;
> +    }
> +
>      /* Send client a 'random' challenge */
>      vnc_write(vs, vs->challenge, sizeof(vs->challenge));
>      vnc_flush(vs);
> 
