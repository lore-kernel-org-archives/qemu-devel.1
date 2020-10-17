Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C127CC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 15:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009C220708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 15:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l3DQGcmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009C220708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnja-0001pe-Ud
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 11:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1kTnip-0000o7-5k
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 11:02:15 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:45145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1kTnim-0001tW-UD
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 11:02:14 -0400
Received: by mail-pg1-x52e.google.com with SMTP id y14so3210916pgf.12
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3Av728nHUNWDB99Z9R2oPXgfeSaWAqr1kGKqCSrROkg=;
 b=l3DQGcmChwuutZXYo7hRJRTj652AaI25WSApAF4SR9zbf6NzjCsieQPaXMG3STe/ZL
 yhFv6RGW+omQOGF+/cXP6FAK/ZTu6097t6tcaAeGBCmo9MW3FLArj7kILhrq1LJtAQ4D
 UzCHwyN6mqig60fNBaygRFX9M9pQToLNuNAvwMiDAvfGQO6r8N0ToNGY80VUNzFeVrgJ
 rFKuU3GeYaccI+q99RGb1cmXmHhsIG7c3uj8wRodTA4hGX9fuUosx+cBCB4yo7kMZZ+C
 YSf2RONP6BAZoYnCvuhCRhpOn88jD1AQDYGsxPPFdwBmM5Tm1LgCwvmQ+FavlbLBHZM8
 YcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3Av728nHUNWDB99Z9R2oPXgfeSaWAqr1kGKqCSrROkg=;
 b=U3MGq9og7h+fao5xY/Ww8fUrbM04Js+0150h4d1pTLAnOGjA3Y/2SqHEgRDjeVFr+9
 UuFND8v64UKsguyXtUT508m/e0zdc0mRMOhQqdaVVEgBXiRwK2f66JO1oJ/0II97dVr8
 ZVYaCCvNIAf5U53Q2D4kIsT+Bt80xd83WmbJr+7t+kQtUkkE7Ux1luCzI4zb39BZSbzv
 FqIhofRKiTadyzk8uFfm16M/anQD3U8rB6jNpxnuiC0IxLcM0eElFgzAuaK3GyMXTMjI
 YrVtvs17pK6q4usNmjV3QPEz5Z+DtzNHeThMZ86UZLd0gl6L8ru7sz4J0YaAfG0gWBeF
 QGnQ==
X-Gm-Message-State: AOAM531IpAUWFhg9JzgGL/2Cmf6dqJVFX47hsaelfI8qa35NHLw/bcH8
 1JGipqrH/Nm7xsw+K0o32JfNWz+fSS1mZh0h
X-Google-Smtp-Source: ABdhPJyB6FbdNCnvkLijCDVBbwjGC+a0NwA6qlBeytGY5+f2CyXS0uMfYrWKL12OwEg86LRKbnJLyA==
X-Received: by 2002:a63:380d:: with SMTP id f13mr7612106pga.105.1602946930766; 
 Sat, 17 Oct 2020 08:02:10 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id y80sm6298017pfb.144.2020.10.17.08.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 08:02:10 -0700 (PDT)
Subject: Re: io_uring possibly the culprit for qemu hang (linux-5.4.y)
To: Ju Hyung Park <qkrwngud825@gmail.com>
References: <CAD14+f3G2f4QEK+AQaEjAG4syUOK-9bDagXa8D=RxdFWdoi5fQ@mail.gmail.com>
 <20201001085900.ms5ix2zyoid7v3ra@steredhat>
 <CAD14+f1m8Xk-VC1nyMh-X4BfWJgObb74_nExhO0VO3ezh_G2jA@mail.gmail.com>
 <20201002073457.jzkmefo5c65zlka7@steredhat>
 <CAD14+f0h4Vp=bsgpByTmaOU-Vbz6nnShDHg=0MSg4WO5ZyO=vA@mail.gmail.com>
 <05afcc49-5076-1368-3cc7-99abcf44847a@kernel.dk>
 <CAD14+f0h-r7o=m0NvHxjCgKaQe24_MDupcDdSOu05PhXp8B1-w@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7ea53adb-14c7-8c31-2f9e-44a3847ee91c@kernel.dk>
Date: Sat, 17 Oct 2020 09:02:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAD14+f0h-r7o=m0NvHxjCgKaQe24_MDupcDdSOu05PhXp8B1-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=axboe@kernel.dk; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.247, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, io-uring@vger.kernel.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 8:29 AM, Ju Hyung Park wrote:
> Hi Jens.
> 
> On Sat, Oct 17, 2020 at 3:07 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Would be great if you could try 5.4.71 and see if that helps for your
>> issue.
>>
> 
> Oh wow, yeah it did fix the issue.
> 
> I'm able to reliably turn off and start the VM multiple times in a row.
> Double checked by confirming QEMU is dynamically linked to liburing.so.1.
> 
> Looks like those 4 io_uring fixes helped.

Awesome, thanks for testing!

-- 
Jens Axboe


