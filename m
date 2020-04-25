Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8535C55185
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CC72071E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 10:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+bf8nkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CC72071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSIV3-0001qp-RS
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 06:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSITq-0008Nk-Kq
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jSITq-0006aR-4S
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:56:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25217
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jSITp-0006Zq-MM
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 06:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587812176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOhz0Yf86VukqMobWmtdGotxz56+LnfMFPhYWQLypYQ=;
 b=V+bf8nkkxUELc+XnKDxbtj6CB4ukAG/ymBuwVKlTkoP7y5UmjCDdVY+b/qdIbHgkUE0SSP
 iXxfBaO6GJBl7+1mfP55LV40FO8lF5rPk1z7n2bOCNH88s09fXZarGUcf2dVNowET2yDmP
 D/GPQYbSeY4SYmuJf5eBpX84B7QeTqo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-86ZcTRfRMiG-Io4Pdd5zPg-1; Sat, 25 Apr 2020 06:56:14 -0400
X-MC-Unique: 86ZcTRfRMiG-Io4Pdd5zPg-1
Received: by mail-wm1-f69.google.com with SMTP id 14so5707035wmo.9
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2020 03:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pOhz0Yf86VukqMobWmtdGotxz56+LnfMFPhYWQLypYQ=;
 b=m2Bfk+JQmClrAcj1KWGraleFsvScjv9e/4+WeN6n3vteL5+ariCkvDPwuqs2D3bsuP
 qX1CKCe5OGTIVshUkl1hYXTRHhuEmpb3V7WlorzD6x6TquLQ2gVMJCGMOMWrLN+kLLfT
 sQCYRwu9k9uwl0t/g/MuZdzPjVhcHi7yUBCZrR93kIt9iwYmxL5J2zMZVyTGIxrvBEgM
 3Gpk946Gq4z+6m9HdWmnxt1sBDvAoH/8BvNHjf2tTQOMoWXdwYvhJZ5gAXtfrla69MMC
 kALq6z4bv2X+zZxVe+IzptcBq1uL3lBdDkJvPmjNW97D+FV8erO9t4C+0ts1XTIv5uTn
 E+1g==
X-Gm-Message-State: AGi0PuYgFNmwRb1HW3dA1cV8+/hTQ2LIT8CLBvBAJwobEMJcHuGo5fIU
 +t3ONVbTpZmK0mkfF8Fa7DjKF6DvkGzZRpYbbpDNfskhCFgEexKqz8TnDwn7sB1evKbaPbd5LZP
 Rap48itzUpFAAh04=
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr15605334wma.89.1587812173580; 
 Sat, 25 Apr 2020 03:56:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypIKhFnDSQ4AGiVA42o+zLfNQPeka2SzzGUUvpp1LDorvjw/LKctkJ53fPyc8rJBJqEwT97a8w==
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr15605320wma.89.1587812173371; 
 Sat, 25 Apr 2020 03:56:13 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id p16sm12017042wro.21.2020.04.25.03.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2020 03:56:12 -0700 (PDT)
Subject: Re: [PATCH v1 PATCH v1 1/1] tests: machine-none-test: Enable
 MicroBlaze testing
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200416193303.23674-1-edgar.iglesias@gmail.com>
 <20200416193303.23674-2-edgar.iglesias@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f64206b-c40a-1b6a-7289-c06221018406@redhat.com>
Date: Sat, 25 Apr 2020 12:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416193303.23674-2-edgar.iglesias@gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 05:12:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: lvivier@redhat.com, edgar.iglesias@xilinx.com, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/04/20 21:33, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Enable MicroBlaze testing.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  tests/qtest/machine-none-test.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
> index 8bb54a6360..209d86eb57 100644
> --- a/tests/qtest/machine-none-test.c
> +++ b/tests/qtest/machine-none-test.c
> @@ -33,8 +33,8 @@ static struct arch2cpu cpus_map[] = {
>      { "cris", "crisv32" },
>      { "lm32", "lm32-full" },
>      { "m68k", "m5206" },
> -    /* FIXME: { "microblaze", "any" }, doesn't work with -M none -cpu any */
> -    /* FIXME: { "microblazeel", "any" }, doesn't work with -M none -cpu any */
> +    { "microblaze", "any" },
> +    { "microblazeel", "any" },
>      { "mips", "4Kc" },
>      { "mipsel", "I7200" },
>      { "mips64", "20Kc" },
> @@ -79,10 +79,8 @@ static void test_machine_cpu_cli(void)
>      QTestState *qts;
>  
>      if (!cpu_model) {
> -        if (!(!strcmp(arch, "microblaze") || !strcmp(arch, "microblazeel"))) {
> -            fprintf(stderr, "WARNING: cpu name for target '%s' isn't defined,"
> -                    " add it to cpus_map\n", arch);
> -        }
> +        fprintf(stderr, "WARNING: cpu name for target '%s' isn't defined,"
> +                " add it to cpus_map\n", arch);
>          return; /* TODO: die here to force all targets have a test */
>      }
>      qts = qtest_initf("-machine none -cpu '%s'", cpu_model);
> 

Queued, thanks.

Paolo


