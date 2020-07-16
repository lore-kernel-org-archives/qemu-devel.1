Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC30FC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8C6206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGD7lJTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8C6206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvyNu-0003G9-UP
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 03:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvyNK-0002id-RQ; Thu, 16 Jul 2020 03:32:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvyNJ-0008Aw-C0; Thu, 16 Jul 2020 03:32:14 -0400
Received: by mail-wm1-x343.google.com with SMTP id o2so10287912wmh.2;
 Thu, 16 Jul 2020 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zrl55Vs1w7yuOJkV/JCwUC6s7VmY9n9j6fSAy6veEug=;
 b=oGD7lJTiKfn1nl09TN3B3Iktq18iyzG6vnINEloikRbEFvKYE4zqTcqEiSB5pZoIy1
 HyL40IYTWuJTNd4/VmZqaCKkIJQ+NXJaI3iaZF6afe0QU+stIlJuYQa80Ih6uTGDkv4G
 8lvkYQAJc/TQUHgs8tQXqe4n/h03gHVDAAg2VoBbubc5aaXCdLDq1guk1E7AfsoGFIoO
 XzJX/T1xp8aatZg1kSBAGDE/cJmsTYnpzZClcde9pSyQW5igZoew7BBDGzDWB6EVSYTn
 FOfthbtX4XiPm03OxvHdNqiIqwYtTdw8cbjcSL38qMk5QW6tX2D54OiDeeIo2u+wF5fV
 c/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zrl55Vs1w7yuOJkV/JCwUC6s7VmY9n9j6fSAy6veEug=;
 b=S7mNbw4sS3xcrRAzCXkuF2LNXlbhObNdeB9qYav/9ygdbk/D6+ZnE5ed0o2qr+6XCx
 UXkykaDMbeJAq6mfFSWPghyGTCxyutbyyqcBhcMpffiRLtRXUcjpDX53wNhZGN6ykd7f
 cfMS640Foob4zgqsa+Z8Vu19EafmhODKX+Zi7y0224qX0CB8CtTiHD+j1ZWsIxBbVh0L
 d98YCsJtVrzqYYdRTYTMbsUzLsCgUwc/k5vlv8ZsNDv78/6gzb9VMU3OFWpzu7pPJmSc
 Iq5bK0zcyyVqCTiVRNcL4RP6KH38tJHj7pxs8rr84G9uQF0ggal+4u2ZfZ79EYpwOZrg
 TrVA==
X-Gm-Message-State: AOAM530xpF1NGq4I/bkR0DxIyLyB8Y2ci7xlDZwddKxNVab5iH9MdozE
 fMGG+7vu0A4jJlkNVDuECNM=
X-Google-Smtp-Source: ABdhPJwPZxgcisuLoiWgLwSomqQgRrkRt0etIsN85OB+05jzDQGbrzGx8AGWYDsE+hxX8SDEHZbOBw==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr3057113wma.9.1594884731273; 
 Thu, 16 Jul 2020 00:32:11 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g14sm7460798wrm.93.2020.07.16.00.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 00:32:10 -0700 (PDT)
Subject: Re: [PATCH] configure: Fix for running with --enable-werror on macOS
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200716055655.24507-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ec2ae831-d666-3d0c-a8f3-0e16e2ffd3d1@amsat.org>
Date: Thu, 16 Jul 2020 09:32:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200716055655.24507-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 7:56 AM, Thomas Huth wrote:
> The configure script currently refuses to succeed when run on macOS
> with --enable-werror:
> 
>  ERROR: configure test passed without -Werror but failed with -Werror.
> 
> The information in config.log indicates:
> 
>  config-temp/qemu-conf.c:3:55: error: control reaches end of non-void
>  function [-Werror,-Wreturn-type]
>  static void *f(void *p) { pthread_setname_np("QEMU"); }
>                                                       ^
> And indeed, the return statement is missing here.

I have a similar commit dated "2019-07-13 17:13:51" that fixes that too,
because I had problem with a CI (cirrus?). I remember there was a
discussion about it, as I can't find on the list, I suppose it was
discussed on IRC.
I don't remember the outcome, it was negative or the patch was
incomplete. I'm happy if it get fixed, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Fixes: 479a57475e ("util: Implement debug-threads for macOS")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: There is another issue with --enable-werror on macOS, with the
>        atomic64, which I haven't quite figured out yet, so compiling
>        with --enable-werror is still not working there.
> 
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index b751c853f5..e93836aaae 100755
> --- a/configure
> +++ b/configure
> @@ -4198,7 +4198,7 @@ pthread_setname_np_wo_tid=no
>  cat > $TMPC << EOF
>  #include <pthread.h>
>  
> -static void *f(void *p) { pthread_setname_np("QEMU"); }
> +static void *f(void *p) { pthread_setname_np("QEMU"); return NULL; }
>  int main(void)
>  {
>      pthread_t thread;
> 


