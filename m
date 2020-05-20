Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA7DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E5B2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYCBdB5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E5B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbHoh-00039O-GI
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 02:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbHnh-0002X0-Vf
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:02:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbHng-0001Zw-LY
 for qemu-devel@nongnu.org; Wed, 20 May 2020 02:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589954515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2erczWdPet2g/DXKF5G6tIZ+qV3qGTsEoAIPBJfiGSY=;
 b=QYCBdB5a88APGAo1VmXZhFKfjPh4+nNRLs24+O0FuC28UtabFaNh8aB38Tzzwu3N++6lgI
 wKG5TLuMczu/qS0moW+WrWKxBCJVu/V8H6T7h56KCGj9uxdDNZhaWEyClZ7O65MY4hkt4m
 Ncgvv7XNaddaN71qZ9cTp50LKwar8U4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-cFHWHvmWPHCYfjIxyTDOuA-1; Wed, 20 May 2020 02:01:51 -0400
X-MC-Unique: cFHWHvmWPHCYfjIxyTDOuA-1
Received: by mail-wm1-f72.google.com with SMTP id n66so764752wme.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 23:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2erczWdPet2g/DXKF5G6tIZ+qV3qGTsEoAIPBJfiGSY=;
 b=kqzyy+rSL7R1spswk6Mc2BdiWNvio6YIveazZEjJPB7h6KrTye3Pc/Pd06z/wuWmai
 kg4r7ZB/OPvv1ihqLdC99ZyfAatOHzJ9Td46mO67TlVjUkxSy7R0WZH+wITfl1US2OoX
 X60waJQPyIZu31Ds1j3pW1h8cOWLml2rFlKVR8+NSQ0sy5Rbw8MBM4m/EnRBBMntpLI2
 HhSElfev+tSLh0diotfx30vBWwlzdu/x3Jd98qKQMa2sMRXQv1k+QmIqsyMT6bmUSOUF
 Qgf96IqY4nKOEcw1B8hAhYuAV980iOplM9ZgYhFAF5n0o44hc1Vq4NOaPQvEkleRhVaa
 wq9A==
X-Gm-Message-State: AOAM531eUg8DAqeayE4pQ41PNlyWcg5bq6oes+6iKQScBdESpBRmW1VQ
 1+zDMlVa/MD38Ntxj3tquEx77r5QD7SzMTBO2BqCgY+8A7TGGd8jX5obkjwJEBaRzfnDNG3N8Zq
 JXLm4RUhzMAVpNlo=
X-Received: by 2002:a1c:9d12:: with SMTP id g18mr2895925wme.109.1589954510251; 
 Tue, 19 May 2020 23:01:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKMKiV13ObV+xf/WWDyj2RvWjgJOx/l2/ZG3DeG8GuxqBKulQ0zPbAuuS99VhAtic17Uc7pQ==
X-Received: by 2002:a1c:9d12:: with SMTP id g18mr2895897wme.109.1589954509924; 
 Tue, 19 May 2020 23:01:49 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v205sm1978384wmg.11.2020.05.19.23.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 23:01:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/9] riscv/boot: Add a missing header include
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1589923785.git.alistair.francis@wdc.com>
 <05ea15f2ec07e1c85273d4897d47c05225b116f6.1589923785.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0fcaef83-ec31-d5f5-4677-d42a77d90e3e@redhat.com>
Date: Wed, 20 May 2020 08:01:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <05ea15f2ec07e1c85273d4897d47c05225b116f6.1589923785.git.alistair.francis@wdc.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 11:31 PM, Alistair Francis wrote:
> Currently every c file that includes boot.h also includes loader.h
> before it. Which is why the build works fine. We should be able to
> include just boot.h though so this is a small fixup to allow that.

What about:

'As the functions declared in this header use the symbol_fn_t
  typedef itself declared in "hw/loader.h", we need to include
  it here to make the header file self-contained.'

> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Bin Meng <bin.meng@windriver.com>
> ---
>   include/hw/riscv/boot.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 474a940ad5..9daa98da08 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -21,6 +21,7 @@
>   #define RISCV_BOOT_H
>   
>   #include "exec/cpu-defs.h"
> +#include "hw/loader.h"
>   
>   void riscv_find_and_load_firmware(MachineState *machine,
>                                     const char *default_machine_firmware,
> 


