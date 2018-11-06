Received: from eggs.gnu.org ([2001:4830:134:3::10]:37992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK9gs-0000do-58
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 17:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK9gn-0005i6-DG
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 17:19:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gK9gm-0005Zo-K9
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 17:19:12 -0500
References: <20181106153330.5139-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5786633e-6edf-50c3-59e8-967db6c10dd7@redhat.com>
Date: Tue, 6 Nov 2018 23:19:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181106153330.5139-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 06/11/2018 16:33, Peter Maydell wrote:
> Currently replay_get_byte() does not check for an error
> from getc(). Coverity points out (CID 1390622) that this
> could result in unexpected behaviour (such as looping
> forever, if we use the replay_get_dword() return value
> for a loop count). We don't expect reads from the replay
> log to fail, and if they do there is no way we can
> continue. So make them fatal errors.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
> 

Makes sense, can you apply it directly to qemu.git as soon as Pavel
reviews it (or in some time if he doesn't)?

Thanks,

Paolo
