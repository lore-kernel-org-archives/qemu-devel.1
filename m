Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E574C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0167B20656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDC2FJL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0167B20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0XX-0007jq-Qd
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jT0WX-0006v4-NY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jT0WR-0001Fm-Mv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:58:01 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jT0WR-00019t-7J
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:57:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id g13so19764235wrb.8
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8bBW4AyCNeDgX4H2V/mgeb7iehhCotmCOZc8OBjBmTU=;
 b=SDC2FJL3jcA8uORXssL+F/UikY99TfmHeNaFrNkY8jwKkNXR2yMGLQ59HiBYizfOlR
 yJIyFCFEQ3JKSWQlbd2yEivCvTugwyZ3KL7ALOiVxr99tAzuCcCRzNh2WCP0giZ29fUb
 RcpufvI64YV+j+GyBmH5EKUFXP0uVDqt0Nqw1MQIWSmzGGooBVjSPUZPftR0Umxbx+XO
 i/1wJ4144NkEK69NpkfEViilQnHwexfWiqGVm2cFlD39ZZO4ymS8sU93GTS/A5M5VQFj
 sEGqJMApFRIFw76i9u5GzilG3vTvZihsRIM+ERJPGwunhNzUUPmb8BiY604SVvDa4Vuq
 t8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8bBW4AyCNeDgX4H2V/mgeb7iehhCotmCOZc8OBjBmTU=;
 b=ltB6uV03fRzZxC+bj4oUaq8Ei//vsf+es37v6W7ZPbCiZKgpjMrNClwJZK9H3vlYvV
 utu8PN7SLATrsK9XKfJtCWfDtXvEYKh37IjgbcVwY6MeM/kQ9sINvyZoWlAT9Z9m6oKa
 Zwv1VmANL+8im60zvUTpe9S9gptvTzuKXpMthJ32yFyKVtDeXa3ydPLuk8hqDftTZiov
 UD2tooaE0eyPtiKf3dUqgBI7fecME1rxLse1necKj5IS4HxKml3g5zSw95rUB6eN1HE6
 rvdezUXFAEpEG4FgItBO6aqs8Ln1wVUQgpS3CH019b0CaQ6fL8EH+Y7JPc+IwbuE6u2J
 kyzg==
X-Gm-Message-State: AGi0PubwsEtpSSingjfEbG9Iy4Dnipz+f+WxTM5EqeE8tXS0Eoq5gpT/
 1cFBpjI/p1KcuRt356KhJT4=
X-Google-Smtp-Source: APiQypIZKWSYb/K8erB1TiYv0RlJpI+T3uH3nFRIltYk/HtZ/HOSPXzfvAlTpRpuJerjFqNDP01KcQ==
X-Received: by 2002:adf:ea48:: with SMTP id j8mr26425055wrn.108.1587981473451; 
 Mon, 27 Apr 2020 02:57:53 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id w10sm21209242wrg.52.2020.04.27.02.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 02:57:52 -0700 (PDT)
Subject: Re: [PATCH for-5.1 3/7] hw/mips: Add CPU IRQ3 delivery for KVM
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-3-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <5a4cc457-971c-de9b-7380-c5e81d1b378b@amsat.org>
Date: Mon, 27 Apr 2020 11:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1587979995-17717-3-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 11:33 AM, Huacai Chen wrote:
> Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch add
> IP2 delivery as well, because Loongson-3 based machine use both IRQ2
> (CPU's IP2) and IRQ3 (CPU's IP3).
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  hw/mips/mips_int.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> index 796730b..5526219 100644
> --- a/hw/mips/mips_int.c
> +++ b/hw/mips/mips_int.c
> @@ -48,16 +48,14 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
>      if (level) {
>          env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
>  
> -        if (kvm_enabled() && irq == 2) {
> +        if (kvm_enabled() && (irq == 2 || irq == 3))

Shouldn't we check env->CP0_Config6 (or Config7) has the required
feature first?

>              kvm_mips_set_interrupt(cpu, irq, level);
> -        }
>  
>      } else {
>          env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
>  
> -        if (kvm_enabled() && irq == 2) {
> +        if (kvm_enabled() && (irq == 2 || irq == 3))
>              kvm_mips_set_interrupt(cpu, irq, level);
> -        }
>      }
>  
>      if (env->CP0_Cause & CP0Ca_IP_mask) {
> 

