Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D741C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 05:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08BB2186A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 05:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08BB2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvasM-0004SH-0e
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 01:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57616)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvarm-0003vq-H1
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvarl-0006ro-Fz
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:21:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvarl-0006qX-Al
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:21:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so93623138wrs.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 22:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sTDFPUDFP7hahK5sGbqaKrywZqQt9tr3raO6bZ+pFmI=;
 b=t4OxEPPF/qamIWHgymQPxNkko3n/K0xiQDSxeDa3T8ltN7JbqCK+32/sRqNjA0Q2al
 yTW6x2/qCuv1EqQ2IjQTcwrtHpWBo8vkCEtrE10x5j7Pb5jy9KyOyTIEsMtYVgkFvvie
 mHfB1HabX+1kGoflD1f4PKWXqJcJVih32j5wo+NDEjtQrHTplMBMOSRTwu0wZZBUA9Bl
 um/CB0Bere+NqdCTqIu7M4lR3rtA73J8GyRaYrsxzBCGJmc8xN6AFQg70TIYoiUge0HW
 oYUlZfrOH3RL0RTKL+AGPTQ5QN4NPIZRuYURpBtqH82C36cjLEpugXe+JXuDuUEaOHM0
 UPPQ==
X-Gm-Message-State: APjAAAVISFqbllxR84CuR+A8GJlHv7+4eimYFkoGJCK7iFOJzTHpiqG+
 h3k1UbDaqeJyXMNopdsALpiY7w==
X-Google-Smtp-Source: APXvYqwbaruhccrsUsfjZgRNwigBcXiiL4wlJotBQyaX6Zg7K0EzDhjjEWSYyI/KJpxGWcIU/yJm7g==
X-Received: by 2002:adf:fe10:: with SMTP id n16mr14035141wrr.92.1565241691805; 
 Wed, 07 Aug 2019 22:21:31 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id j33sm215874921wre.42.2019.08.07.22.21.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 22:21:31 -0700 (PDT)
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
 <1565239479-2130-1-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d0ca78ec-c5d4-bc80-6f2e-3e933013b5f4@redhat.com>
Date: Thu, 8 Aug 2019 07:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1565239479-2130-1-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2] hw: net: cadence_gem: Fix build errors
 in DB_PRINT()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 8/8/19 6:44 AM, Bin Meng wrote:
> When CADENCE_GEM_ERR_DEBUG is turned on, there are several
> compilation errors in DB_PRINT(). Fix them.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> 
> ---
> 
> Changes in v2:

Please don't reply to previous version, post as a new thread (it is
harder to notice your new versions in a emails threaded view).

> - use HWADDR_PRIx instead of TARGET_FMT_plx for consistency
> - use 'z' modifier to print sizeof(..)
> 
>  hw/net/cadence_gem.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index d412085..b6ff2c1 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -983,8 +983,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>              return -1;
>          }
>  
> -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
> -                rx_desc_get_buffer(s->rx_desc[q]));
> +        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n",

rx_desc_get_buffer() returns a uint64_t, shouldn't you use a PRIx64
format here?

> +                 MIN(bytes_to_copy, rxbufsize),

Nitpick #1: since you are cleaning this file up, bytes_to_copy and
rxbufsize are both unsigned, so the first format should be %u instead of %d.

> +                 rx_desc_get_buffer(s, s->rx_desc[q]));
>  
>          /* Copy packet data to emulated DMA buffer */
>          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
> @@ -1157,7 +1158,7 @@ static void gem_transmit(CadenceGEMState *s)
>              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
>                                                 (p - tx_packet)) {
>                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
> -                         "0x%x\n", (unsigned)packet_desc_addr,
> +                         "0x%zx\n", (unsigned)packet_desc_addr,

Nitpick #2: packet_desc_addr is of type hwaddr, so removing the cast the
1st format is HWADDR_PRIx, also removing the 2nd cast the 2nd format is
PRIx64.

Then the 3rd format is now correct.

>                           (unsigned)tx_desc_get_length(desc),
>                           sizeof(tx_packet) - (p - tx_packet));
>                  break;
> 

