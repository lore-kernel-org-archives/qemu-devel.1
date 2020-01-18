Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37172C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 20:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71F024680
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 20:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6mX4WiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71F024680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isv4J-0003YV-4m
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 15:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isv3f-0002vn-8w
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isv3d-0005kW-72
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:51:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28545
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isv3d-0005k3-2K
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 15:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579380660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnjvUh5XsEEZonXd2SSU6jg2g/h8JR6Od0tmEBaGyQU=;
 b=N6mX4WiNvr2pxWpqlv4dzg7xvhMp73/31cJcggZV/zhORvef0FqbW6VmpSKMHu7LTCuh3V
 oy7b09VtOVHAacmtxGCm1uSDJVNsqZGoTCcoeH7sBO9GLUb7Rd9pr74JqQcTST77ePyiET
 Tb1Yqq0aNYkYLPMQzbm0p5pp6qRR43c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-dPG6BoeANgmrigFY7iax3g-1; Sat, 18 Jan 2020 15:50:57 -0500
Received: by mail-wr1-f70.google.com with SMTP id u18so12045959wrn.11
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 12:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DnjvUh5XsEEZonXd2SSU6jg2g/h8JR6Od0tmEBaGyQU=;
 b=h/QgqpoWiNPBfwlNjaZWeGogH45u4qsP5Yzq0vReuidhla/GuMKVsAIQ11IP6RQcAv
 LrwQiW6h9rZ5XRpWGKO1b7fuMNuFs3ZRxt5ZlxayneYIch9T24OG/1+xmr4ms8gX4r6s
 4xduDOba1rGY/nEMYWYpG5zW9WhpT5pfAJwKIe6cC1SpGUPGQ5Tpzx1Vx42HzZDWJmUP
 RL+mOMTv1cNBV9Sg5RzyGPmPWZcQP5h34qzDgtmJDdEsyo4vNtdbVtlr98NuJeyGs+0Q
 uMN1HzY4zyX+dJVkSiYYoTSHRCXQvDb+crNyG8RLh24UubsP4mNLnKLEcBU5/+0CHMIa
 /w6g==
X-Gm-Message-State: APjAAAUFvSTclLgKy2T+8lgqqoZeiMk9l3m8L6a4RYloNAMldrntQNdI
 RU14+TnoN6Tbuo7JpxpcZXcd1QbA/MRJ+xRsFNllpxbOfimqIPgCXCYUf1SgLRAmVfX+KpoVyof
 jAIofa8o6cmeXGmA=
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr11135526wml.50.1579380656018; 
 Sat, 18 Jan 2020 12:50:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUPRhSOg+rs7URiDlCYyPHsxo3B5uvqEixKNuJIXlKCmXBeAtC77oPZT8gt5Zu6lYhtQ8a4w==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr11135508wml.50.1579380655771; 
 Sat, 18 Jan 2020 12:50:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9?
 ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
 by smtp.gmail.com with ESMTPSA id n3sm37934544wrs.8.2020.01.18.12.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 12:50:55 -0800 (PST)
Subject: Re: [PATCH 1/2] pvpanic: introduce crashloaded for pvpanic
To: zhenwei pi <pizhenwei@bytedance.com>
References: <20200114023102.612548-1-pizhenwei@bytedance.com>
 <20200114023102.612548-2-pizhenwei@bytedance.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <698c7eb3-4597-3ded-bd0f-3391c5f9696f@redhat.com>
Date: Sat, 18 Jan 2020 21:50:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200114023102.612548-2-pizhenwei@bytedance.com>
Content-Language: en-US
X-MC-Unique: dPG6BoeANgmrigFY7iax3g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: gregkh@linuxfoundation.org, yelu@bytedance.com, qemu-devel@nongnu.org,
 mprivozn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/01/20 03:31, zhenwei pi wrote:
> Add bit 1 for pvpanic. This bit means that guest hits a panic, but
> guest wants to handle error by itself. Typical case: Linux guest runs
> kdump in panic. It will help us to separate the abnormal reboot from
> normal operation.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  docs/specs/pvpanic.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
> index c7bbacc778..bdea68a430 100644
> --- a/docs/specs/pvpanic.txt
> +++ b/docs/specs/pvpanic.txt
> @@ -16,8 +16,12 @@ pvpanic exposes a single I/O port, by default 0x505. On read, the bits
>  recognized by the device are set. Software should ignore bits it doesn't
>  recognize. On write, the bits not recognized by the device are ignored.
>  Software should set only bits both itself and the device recognize.
> -Currently, only bit 0 is recognized, setting it indicates a guest panic
> -has happened.
> +
> +Bit Definition
> +--------------
> +bit 0: setting it indicates a guest panic has happened.
> +bit 1: named crashloaded. setting it indicates a guest panic and run
> +       kexec to handle error by guest itself.
>  
>  ACPI Interface
>  --------------
> 

I added this:

@@ -30,13 +31,12 @@ pvpanic device is defined with ACPI ID "QEMU0001". Custom methods:
 
 RDPT:       To determine whether guest panic notification is supported.
 Arguments:  None
-Return:     Returns a byte, bit 0 set to indicate guest panic
-            notification is supported. Other bits are reserved and
-            should be ignored.
+Return:     Returns a byte, with the same semantics as the I/O port
+            interface.
 
 WRPT:       To send a guest panic event
-Arguments:  Arg0 is a byte, with bit 0 set to indicate guest panic has
-            happened. Other bits are reserved and should be cleared.
+Arguments:  Arg0 is a byte to be written, with the same semantics as
+            the I/O interface.
 Return:     None
 
 The ACPI device will automatically refer to the right port in case it


Paolo


