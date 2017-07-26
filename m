Received: from eggs.gnu.org ([2001:4830:134:3::10]:53698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daB8W-0000VD-In
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daB8T-00029j-Fg
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:29:16 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daB8T-00029G-AR
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 21:29:13 -0400
Received: by mail-qt0-x244.google.com with SMTP id u19so3274083qtc.0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:29:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-7-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9a40c690-0b80-cd34-6129-849703b452e2@amsat.org>
Date: Tue, 25 Jul 2017 22:28:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170629010300.2848-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/8] tcg/tci: disable MTTCG if TCI is
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G . Cota" <cota@braap.org>

Hi Peter,

I think this patch belongs to 2.10, as there is no time to fix TCI + 
MTTCG. Should I RESEND it alone with "for 2.10" subject?

One other option might be disable TCI if MTTCG enabled, but there is no 
./configure option for MTTCG while there is for TCI.

Regards,

Phil.

On 06/28/2017 10:02 PM, Philippe Mathieu-Daudé wrote:
> TCI + MTTCG cause strange errors...
> 
>    $ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4 -accel tcg,thread=multi -kernel kernel7.img
>    qemu-system-arm: Guest expects a stronger memory ordering than the host provides
>    This may cause strange/hard to debug errors
>    Segmentation fault (core dumped)
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   configure | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index c571ad14e5..510f443e06 100755
> --- a/configure
> +++ b/configure
> @@ -6225,7 +6225,11 @@ fi
>   if test "$target_softmmu" = "yes" ; then
>     echo "CONFIG_SOFTMMU=y" >> $config_target_mak
>     if test "$mttcg" = "yes" ; then
> -    echo "TARGET_SUPPORTS_MTTCG=y" >> $config_target_mak
> +    if test "$tcg_interpreter" = "yes" ; then
> +        echo "TCI enabled, disabling MTTCG"
> +    else
> +        echo "TARGET_SUPPORTS_MTTCG=y" >> $config_target_mak
> +    fi
>     fi
>   fi
>   if test "$target_user_only" = "yes" ; then
> 
