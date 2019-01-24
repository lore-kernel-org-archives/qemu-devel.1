Received: from eggs.gnu.org ([209.51.188.92]:33632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmfPV-0005e7-5a
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmfPT-0005Eo-AQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:51:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmfPT-0005EK-3j
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:51:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so6526262wrs.10
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:51:11 -0800 (PST)
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-4-philmd@redhat.com>
	<20190124112336.oviomaisnaglg22e@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c047d5bf-2cfb-233d-07ca-dbd2effa850e@redhat.com>
Date: Thu, 24 Jan 2019 14:51:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190124112336.oviomaisnaglg22e@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] configure: Let SDL support be
 optional on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 1/24/19 12:23 PM, Gerd Hoffmann wrote:
>>      sdl)
>>      if test "$sdl" = "no"; then
>> -        error_exit "sdl not found or disabled, can not use sdl audio driver"
>> +        echo "WARN: sdl not found or disabled, can not use sdl audio driver"
>> +        audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/sdl *//g')
> 
> Busy tackling that in a separate patch series (audio: rework driver
> probing)

But we need the Milkymist TMU fixes to build without SDL,
I still get this error when building the series you mentioned using
--disable-sdl on OpenBSD:

    LINK    lm32-softmmu/qemu-system-lm32
  hw/lm32/milkymist.o: In function `milkymist_tmu2_create':
  hw/lm32/milkymist-hw.h:114: undefined reference to `XOpenDisplay'
  hw/lm32/milkymist-hw.h:140: undefined reference to `XFree'
  hw/lm32/milkymist-hw.h:141: undefined reference to `XCloseDisplay'
  hw/lm32/milkymist-hw.h:130: undefined reference to `XCloseDisplay'
  ../hw/display/milkymist-tmu2.o: In function `tmu2_glx_init':
  hw/display/milkymist-tmu2.c:112: undefined reference to `XOpenDisplay'
  hw/display/milkymist-tmu2.c:123: undefined reference to `XFree'
  collect2: error: ld returned 1 exit status
  gmake[1]: *** [Makefile:199: qemu-system-lm32] Error 1

> 
>>      fi
>>      ;;
>>  
>> @@ -3408,6 +3409,9 @@ for drv in $audio_drv_list; do
>>      ;;
>>      esac
>>  done
>> +if test -z "$audio_drv_list"; then
>> +    audio_drv_list="none"
>> +fi
> 
> Not needed, "none" is used as fallback even without this.

It is not needed indeed, but I find it clearer when looking at the
./configure output, rather than having an empty list:

  SDL support       no
  Audio drivers
  GEN     config-host.h

vs:

  SDL support       no
  Audio drivers     none
  GEN     config-host.h

Maybe my error was to not clarify that this change is purely cosmetic.

Your call anyway.

> 
> The other tree patches look fine to me, I'll go queue them up.

Thanks! I'll wait for Michael Walle feedbacks before respining rebased
on your work, also fixing "WARN".

> 
> cheers,
>   Gerd
> 
