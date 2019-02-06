Received: from eggs.gnu.org ([209.51.188.92]:49772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grOdl-0006Zb-44
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grOdk-0007n6-69
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:57:29 -0500
References: <20190204204517.23698-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3448f4d1-da76-ef9c-bc87-dfab59a5415b@vivier.eu>
Date: Wed, 6 Feb 2019 15:57:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190204204517.23698-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw/input/tsc210x: Fix
 building with no verbosity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>

On 04/02/2019 21:45, Philippe Mathieu-Daudé wrote:
> When building with TSC_VERBOSE not defined, we get:
>       CC      arm-softmmu/hw/input/tsc210x.o
>     hw/input/tsc210x.c: In function ‘tsc2102_data_register_write’:
>     hw/input/tsc210x.c:554:5: error: label at end of compound statement
>          default:
>          ^~~~~~~
>     hw/input/tsc210x.c: In function ‘tsc2102_control_register_write’:
>     hw/input/tsc210x.c:638:5: error: label at end of compound statement
>          bad_reg:
>          ^~~~~~~
>     hw/input/tsc210x.c: In function ‘tsc2102_audio_register_write’:
>     hw/input/tsc210x.c:766:5: error: label at end of compound statement
>          default:
>          ^~~~~~~
>     make[1]: *** [rules.mak:69: hw/input/tsc210x.o] Error 1
> 
> Fix this by replacing the culprit fprintf(stderr) calls by a more
> recent API: qemu_log_mask(LOG_GUEST_ERROR). Other fprintf() calls
> are left untouched.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/input/tsc210x.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
> index ded0db9351..2eb3cb9518 100644
> --- a/hw/input/tsc210x.c
> +++ b/hw/input/tsc210x.c
> @@ -552,10 +552,8 @@ static void tsc2102_data_register_write(
>          return;
>  
>      default:
> -#ifdef TSC_VERBOSE
> -        fprintf(stderr, "tsc2102_data_register_write: "
> -                        "no such register: 0x%02x\n", reg);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR, "tsc2102_data_register_write: "
> +                                       "no such register: 0x%02x\n", reg);
>      }
>  }
>  
> @@ -636,10 +634,8 @@ static void tsc2102_control_register_write(
>  
>      default:
>      bad_reg:
> -#ifdef TSC_VERBOSE
> -        fprintf(stderr, "tsc2102_control_register_write: "
> -                        "no such register: 0x%02x\n", reg);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR, "tsc2102_control_register_write: "
> +                                       "no such register: 0x%02x\n", reg);
>      }
>  }
>  
> @@ -764,10 +760,8 @@ static void tsc2102_audio_register_write(
>          return;
>  
>      default:
> -#ifdef TSC_VERBOSE
> -        fprintf(stderr, "tsc2102_audio_register_write: "
> -                        "no such register: 0x%02x\n", reg);
> -#endif
> +        qemu_log_mask(LOG_GUEST_ERROR, "tsc2102_audio_register_write: "
> +                                       "no such register: 0x%02x\n", reg);
>      }
>  }
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
