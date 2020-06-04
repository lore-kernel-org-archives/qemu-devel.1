Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E5DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED99C206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQxxrW1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED99C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgv3l-0007Ui-9H
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgv3B-0006rI-M8
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:57:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgv3A-00048Y-UI
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591297032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vUBwtgqtS3fbGSHGtj76gaU04adG9cf7zkUg6v/29Lc=;
 b=QQxxrW1vnCxTSGIJiyCx9nYvzOPehKQf4oESj2Zs4KcwCREToFe86IOYOFqwSOi3GlZBbh
 rETjcNK8Kj+F7XUvRKNRuRP2alDVyvaofsj/IWXuusM30FmJHFImgmdy7suPO9sn1NDm8V
 shNy+sYvF6MHZqkr24Zazjat1KTsI0I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-81EeA4stPWSrVS0YWOfyGw-1; Thu, 04 Jun 2020 14:57:06 -0400
X-MC-Unique: 81EeA4stPWSrVS0YWOfyGw-1
Received: by mail-wm1-f72.google.com with SMTP id b65so2252577wmb.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 11:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vUBwtgqtS3fbGSHGtj76gaU04adG9cf7zkUg6v/29Lc=;
 b=S3w/IVxHCihlgOq5vV5p/co4Is0SkPkBNxY84pcBIoKD7d1rEFXMRHukLGhRTnLOIg
 ec+dDKcMh/7AHNcxKagrCNNzrRu8ancufc6Gf+ctLpk1wn9TsEFGzbKzmRCrzfz1v4Qd
 txv5+MC92IiFSEHsfjAFNYF/ZXHCouHLLBYSg7GSrFW/d99b6UIpiUXPmgkZSwjIkBQE
 8v3UCea8aIFsWH/mJoOp2Q8sY0LVcDYr6X/ZzhdSkjTtDO9IAglrShCgvjBeySZll5ig
 VWT+TWDweIQxjD/u+XINDZSDr8owYUxCDUkXMJTJljmHE3f5TycB4aiGoJdiOW/aGtMJ
 9sYA==
X-Gm-Message-State: AOAM531HzZjXLhXMxFg93+6mUpdTxF0Af1m8D63qG0GIxCHW1Wc9uJ5Z
 HZPP//ljZRT+g+r7EWbw0gem2N90coMIqeu9UMUY1tszDIqUQDCnEV5O9Sk38lQ61b6jqlO0rI7
 Ww1zeMPw0bobEWPM=
X-Received: by 2002:a1c:4143:: with SMTP id o64mr5159421wma.157.1591297025770; 
 Thu, 04 Jun 2020 11:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoKfoQba/VQvR4huvN5rVgbFJj5e20KDK0NPjqekWvwEBWEYyK/nbkp5uCfIyCna6UpiJxhw==
X-Received: by 2002:a1c:4143:: with SMTP id o64mr5159401wma.157.1591297025548; 
 Thu, 04 Jun 2020 11:57:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id p9sm8307588wma.48.2020.06.04.11.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 11:57:04 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] exec: Kill CPUReadMemoryFunc/CPUWriteMemoryFunc
 typedefs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200601141536.15192-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e07baa2-59d0-1960-8037-8054396920a5@redhat.com>
Date: Thu, 4 Jun 2020 20:57:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200601141536.15192-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/06/20 16:15, Philippe Mathieu-Daudé wrote:
> Followed Peter's suggestions [1]:
> 
>  * delete the unused MmeoryRegionMmio
>  * move these typedefs into include/hw/usb.h and rename them
>    to MUSBReadFunc and MUSBWriteFunc, since that's all they're
>    used for now
> 
> Since v1 [2], addressed Peter review:
> - Renamed include/hw/usb/musb.h -> include/hw/usb/hcd-musb.h
> - Added Peter's R-b tags
> 
> Series fully reviewed.
> 
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708165.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708194.html
> 
> Philippe Mathieu-Daudé (3):
>   exec/memory: Remove unused MemoryRegionMmio type
>   hw/usb: Move device-specific declarations to new 'hcd-musb.h' header
>   exec/cpu-common: Move MUSB specific typedefs to 'hw/usb/hcd-musb.h'
> 
>  include/exec/cpu-common.h |  3 ---
>  include/exec/memory.h     |  6 -----
>  include/hw/usb.h          | 30 -------------------------
>  include/hw/usb/hcd-musb.h | 47 +++++++++++++++++++++++++++++++++++++++
>  hw/usb/hcd-musb.c         |  5 +++--
>  hw/usb/tusb6010.c         |  1 +
>  6 files changed, 51 insertions(+), 41 deletions(-)
>  create mode 100644 include/hw/usb/hcd-musb.h
> 

Queued, thanks.

Paolo


