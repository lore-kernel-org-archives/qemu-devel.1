Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6087BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 07:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75262073A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 07:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/TKSN25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75262073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR9RO-0008Bl-Pe
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 03:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kR9Qb-0007nA-PY
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kR9QY-0004eV-K5
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602315384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Id932dWeG7GxCZ9VYNc0qX03nTZ3xubpIc0yGMX8nXU=;
 b=A/TKSN25OffbZViDAxItjZQgI7h2ZwOwWr2hvmMBZAR8tHJvC1+I4pXDxrREF9a7rBfRax
 6SLQq5gCCsyKgN77jtgdZMt8i4sY707GWaHGCAL0nUS5j+U8yJNgh3UXLjyt0yU6qd1fm+
 HhhJ+TrrXyvtbEsAULR1OIvDSJbKZDA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-K8H1MK15MWW0B8kTLda-Kg-1; Sat, 10 Oct 2020 03:36:21 -0400
X-MC-Unique: K8H1MK15MWW0B8kTLda-Kg-1
Received: by mail-wr1-f69.google.com with SMTP id j6so216201wrg.20
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 00:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Id932dWeG7GxCZ9VYNc0qX03nTZ3xubpIc0yGMX8nXU=;
 b=XIVSMAHC1jmft1xZaeJ1SoKAe5hqxvexnRp6vNoFdvvjAS0g4SynkEzhpPpQGPM4lA
 hWg7xhyslk/3Bg3El9PU97V2KVUMDGQK25VoigeOL7kuD6aVJxwbEXZ2/NaGH77tVHAh
 JZGNd0R36mJ64y6f+gxd/pa/Kjkj39MD677BICuKZu5KFhZDpTNYy5aZddRZzEscjJKV
 AMaXTt24qiaAg1MwgN1QyQZ3X4GAEJuhaRHKgLnHScfbI5oicGbVyjoCBl+U6uOXfi/r
 oQpMmSVtHWUlAPnBlE9An/C2QxvWxstX/tHLb1GKbH121jZn2p+GW/irm94nLpO1mZQX
 Y6hA==
X-Gm-Message-State: AOAM531eBdGFX65+YovXRedFtwGBZnKiZQTB5dnfZ/qTF625+tFL0BOs
 54SPdtGrkPPrHw0Dbfz9gZgawNmaJzi38jDGKmmZjunJi6bKEBNU/agiiwlBUUMizWv0CdczF4L
 TCJWp+6evNaVF9RI=
X-Received: by 2002:a1c:9dcf:: with SMTP id g198mr1605545wme.42.1602315379713; 
 Sat, 10 Oct 2020 00:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWqLDXiJ5bJ47FisLazxrHJMlKwmGCYCc55/wC5wyRMfT5Txm0rzVS/NM5K2g0JoU0MDDBaQ==
X-Received: by 2002:a1c:9dcf:: with SMTP id g198mr1605531wme.42.1602315379488; 
 Sat, 10 Oct 2020 00:36:19 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id m11sm14762357wmf.10.2020.10.10.00.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 00:36:18 -0700 (PDT)
Subject: Re: [PATCH 1/3] Acceptance tests: bump pycdlib version for easier
 installation
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20201009205513.751968-1-crosa@redhat.com>
 <20201009205513.751968-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <90377288-f072-daee-c638-373382ff5efb@redhat.com>
Date: Sat, 10 Oct 2020 09:36:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201009205513.751968-2-crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 03:36:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Bug 1897783 <1897783@bugs.launchpad.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 10:55 PM, Cleber Rosa wrote:
> On with certain versions of "pip", package installations will attempt
> to create wheels.  And, on environments without a "complete" Python
> installation (as described in the acceptance tests requirements docs),
> that will fail.
> 
> pycdlib, starting with version 1.11.0, is now being made available
> as wheels, so its instalation on those constrained environments is
> now possible.
> 
> Cc: Bug 1897783 <1897783@bugs.launchpad.net>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880189

This BZ is different. The correct URL is:
https://bugs.launchpad.net/qemu/+bug/1897783

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/requirements.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index 036691c922..a1c631fa59 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -2,4 +2,4 @@
>   # in the tests/venv Python virtual environment. For more info,
>   # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>   avocado-framework==81.0
> -pycdlib==1.9.0
> +pycdlib==1.11.0
> 


