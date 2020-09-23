Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022E6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37AD820663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1XcCdhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AD820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL3Uv-0005oD-0i
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL3UD-0005J4-4C
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL3U7-0001YI-VN
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600862575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=msS/G5bxiNgrv8OcnHCj3SXyDBzh/tqTF3WPL6ELImg=;
 b=f1XcCdhrLIbfrA6hWYCWqqTvRfCJIRPPUwhVldrjBm8D4iZekcplbaVjTNocz7NVDO507d
 Zreg23zG48CklFbYLtFbeKM9Vt7a02LNp6QP7YhjEokT24iWAgAADlKHnN8obp77xQDUQj
 ZtBtvl2+r5X1qwAWeE/o25bn1OVIp7U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-yP6fJlyLPLm3PrysBqTbfw-1; Wed, 23 Sep 2020 08:02:53 -0400
X-MC-Unique: yP6fJlyLPLm3PrysBqTbfw-1
Received: by mail-wm1-f69.google.com with SMTP id l15so2128667wmh.9
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 05:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=msS/G5bxiNgrv8OcnHCj3SXyDBzh/tqTF3WPL6ELImg=;
 b=iLOQy1ebzipnH6lVbTdutlGx6SDAOFR751jCa0WhNYeeUiJSRjC65PdNv2VFQTJDgP
 Nyb5skOq90fnNcLLodP6bqWhajI8lPI2HOt6fG3J8BMIdskq+vQIXICGwl7H6Pgi26fr
 AqyKYqjAF8jYJFG6ZenFajiRCLPl4VhiQW/xg/NDrr9+fk0T5OjJw0xIfs213YDI44G9
 xaNmF0scqdFs0yDe0mG1kKQINpeWL78SIps1UecN/XDaGfwcvowB5iKyf8kzSh8KWCff
 yS8D/frPrZ5d0v3C/sqEJ/JMZtN01KQa/Y46Ru/6d73LWNwkkAebjpiLHiFrddU6PLpr
 4DqQ==
X-Gm-Message-State: AOAM531XRAmcopw+JIHac9bqBp6S/Ke8VhtNzzmSjf6VBzY4u3RoS/yj
 VVDABEva/MrCMR+Wkw+fLAmjwn3QV7XD4kamLFVDHMJoKZUZSr1RLgYHDyf98wgkODH/K9YhbvO
 DVdSk089NrUZ69Xg=
X-Received: by 2002:adf:f24f:: with SMTP id b15mr460564wrp.301.1600862572232; 
 Wed, 23 Sep 2020 05:02:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6SansG3zPuqnv37AzSAGPXHMPTINuSo8Ro4AyHQUSutyIVtkM1WfnrTEmWVdwh+L8FT5lXw==
X-Received: by 2002:adf:f24f:: with SMTP id b15mr460548wrp.301.1600862572037; 
 Wed, 23 Sep 2020 05:02:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9?
 ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
 by smtp.gmail.com with ESMTPSA id l10sm28480975wru.59.2020.09.23.05.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 05:02:51 -0700 (PDT)
Subject: Re: [PATCH] Add execute bit back to scripts/tracetool.py
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
References: <20200923103620.1980151-1-anthony.perard@citrix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <94748953-43e7-fce4-3ec4-eb18678fbb76@redhat.com>
Date: Wed, 23 Sep 2020 14:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923103620.1980151-1-anthony.perard@citrix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/20 12:36, Anthony PERARD wrote:
> Commit a81df1b68b65 ("libqemuutil, qapi, trace: convert to meson")
> removed it without explanation and it is useful to be able to run a
> script without having to figure out which interpreter to use.
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  scripts/tracetool.py | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 scripts/tracetool.py
> 
> diff --git a/scripts/tracetool.py b/scripts/tracetool.py
> old mode 100644
> new mode 100755
> 

Cc: qemu-trivial@nongnu.org


