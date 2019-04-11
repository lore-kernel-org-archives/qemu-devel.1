Received: from eggs.gnu.org ([209.51.188.92]:43763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEW8h-0002kJ-39
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEW8f-0004EZ-V7
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:36:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEW8f-0004E9-IE
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:36:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so5812429wmf.5
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:36:57 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ffa34897-8a8b-418a-07be-f12f86822380@redhat.com>
Date: Thu, 11 Apr 2019 11:36:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/23] crypto: Use O_CLOEXEC in
 qcrypto_random_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 3/15/19 4:26 AM, Richard Henderson wrote:
> Avoids leaking the /dev/urandom fd into any child processes.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  crypto/random-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/random-platform.c b/crypto/random-platform.c
> index 260b64564d..6df40744c7 100644
> --- a/crypto/random-platform.c
> +++ b/crypto/random-platform.c
> @@ -42,9 +42,9 @@ int qcrypto_random_init(Error **errp)
>  #else
>      /* TBD perhaps also add support for BSD getentropy / Linux
>       * getrandom syscalls directly */
> -    fd = open("/dev/urandom", O_RDONLY);
> +    fd = open("/dev/urandom", O_RDONLY | O_CLOEXEC);
>      if (fd == -1 && errno == ENOENT) {
> -        fd = open("/dev/random", O_RDONLY);
> +        fd = open("/dev/random", O_RDONLY | O_CLOEXEC);
>      }
>  
>      if (fd < 0) {
> 
