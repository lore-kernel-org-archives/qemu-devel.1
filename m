Received: from eggs.gnu.org ([2001:4830:134:3::10]:56699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gKIbo-0003Q6-Is
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gKIbX-0006jp-3j
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:50:31 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41546)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gKIbT-0006eG-Nk
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 02:50:20 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181106153330.5139-1-peter.maydell@linaro.org>
In-Reply-To: <20181106153330.5139-1-peter.maydell@linaro.org>
Date: Wed, 7 Nov 2018 10:50:17 +0300
Message-ID: <000901d4766e$86a6b760$93f42620$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH for-3.1] replay: Exit on errors reading
 from replay log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Peter Maydell' <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> Currently replay_get_byte() does not check for an error
> from getc(). Coverity points out (CID 1390622) that this
> could result in unexpected behaviour (such as looping
> forever, if we use the replay_get_dword() return value
> for a loop count). We don't expect reads from the replay
> log to fail, and if they do there is no way we can
> continue. So make them fatal errors.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

> ---
> Disclaimer: checked only with "make check".
> 
>  replay/replay-internal.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/replay/replay-internal.c b/replay/replay-internal.c
> index 1cea1d4dc91..8f87e9b957e 100644
> --- a/replay/replay-internal.c
> +++ b/replay/replay-internal.c
> @@ -35,6 +35,12 @@ static void replay_write_error(void)
>      }
>  }
> 
> +static void replay_read_error(void)
> +{
> +    error_report("error reading the replay data");
> +    exit(1);
> +}
> +
>  void replay_put_byte(uint8_t byte)
>  {
>      if (replay_file) {
> @@ -83,7 +89,11 @@ uint8_t replay_get_byte(void)
>  {
>      uint8_t byte = 0;
>      if (replay_file) {
> -        byte = getc(replay_file);
> +        int r = getc(replay_file);
> +        if (r == EOF) {
> +            replay_read_error();
> +        }
> +        byte = r;
>      }
>      return byte;
>  }
> @@ -126,7 +136,7 @@ void replay_get_array(uint8_t *buf, size_t *size)
>      if (replay_file) {
>          *size = replay_get_dword();
>          if (fread(buf, 1, *size, replay_file) != *size) {
> -            error_report("replay read error");
> +            replay_read_error();
>          }
>      }
>  }
> @@ -137,7 +147,7 @@ void replay_get_array_alloc(uint8_t **buf, size_t *size)
>          *size = replay_get_dword();
>          *buf = g_malloc(*size);
>          if (fread(*buf, 1, *size, replay_file) != *size) {
> -            error_report("replay read error");
> +            replay_read_error();
>          }
>      }
>  }
> --
> 2.19.1

Pavel Dovgalyuk
