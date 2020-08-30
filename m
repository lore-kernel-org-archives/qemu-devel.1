Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3024DC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 09:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD6520738
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 09:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzFMK4t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD6520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCJkk-0007DR-1A
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 05:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCJk1-0006iY-Kj
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:35:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCJjz-0001e8-JP
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598780110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65JYfLl6inKAbOFKsP0kGe4Ec6Xk8TEN5s+xEc/nylo=;
 b=DzFMK4t/chp0gq87FddE+LqI2ISCHbwLG3poD8ad0wgHRddQICIpQd3Oe9e810W++sSNuW
 0SpTNMr8B3wkuNK2JVH2B98fiLwjAIj6uF1RN3oZ1+HCmbBv4Wagc5aXVA+e8fnRstqJtN
 tTVCJSsudlhng1JGWoYFlnIKNUKYWhc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-crvjpLrANi-bIIMFOEOvfg-1; Sun, 30 Aug 2020 05:35:08 -0400
X-MC-Unique: crvjpLrANi-bIIMFOEOvfg-1
Received: by mail-wm1-f69.google.com with SMTP id q7so579453wmc.6
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 02:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=65JYfLl6inKAbOFKsP0kGe4Ec6Xk8TEN5s+xEc/nylo=;
 b=jV0n67PIKpZSEGJ3sF69fgMwLlWAiuTHKYzzIaaq6s4VZzMGGjtLDxFlazxqM/QtfK
 USMqq3GFtZdsuDMAZiouwj2vebbJyis5CNAGbYSsgRBBHLOD10hTqtwIeEWg5RyI2uoh
 IjdITTiVBT20JiTH9rdOh7FeNrTtLERAWZ+9Gf0nMpQ/h6Bal5I9suS4nI0t1U/7OcMz
 671jLa7KioVIUJL03Vw5FRNibCvgmeqOsVWGhMi0PMyHfQSpSHrOGlU1E0bWOkdxk05w
 URgYk5znYu6bvwiBzLZIXNzzFDHPczTEaaC0sSO1a941e+37r/AuFnvXhSEy1ZYc6usl
 yqiQ==
X-Gm-Message-State: AOAM532k7JFDuWWJwz8G0E8yRrmlsyb+2cikuLTCBkaXXyNZWIZvV8Fj
 g+e3WKRdpxfMaNTT5QOR/k+wUJrc+nvFWbmgG7BEQ3AAy7PnDFXnpbK5+BNHG1Q+HAanZKGletc
 3S5lQvpWFM5VMXJk=
X-Received: by 2002:a5d:4448:: with SMTP id x8mr7174961wrr.207.1598780107412; 
 Sun, 30 Aug 2020 02:35:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt78aoHWomq80+zsGQ8q5zbkSL2nnhsOsrqXCoaLJZSAn9gJ4o+GxJq0rx+ns3TrymecMaPQ==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr7174948wrr.207.1598780107230; 
 Sun, 30 Aug 2020 02:35:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d8:ed0a:2dde:9ff7?
 ([2001:b07:6468:f312:9d8:ed0a:2dde:9ff7])
 by smtp.gmail.com with ESMTPSA id c4sm6666776wrt.41.2020.08.30.02.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 02:35:06 -0700 (PDT)
Subject: Re: Meson build on macOS: undefined symbol treatment
To: Thomas Huth <thuth@redhat.com>, Emmanuel Blot <eblot.ml@gmail.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <E79B1486-1C3C-4271-9B76-62B2C4B8BCA7@gmail.com>
 <24ac4d35-ff2b-4381-ab1b-1a8f31ba36fb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b3f88da-ec74-96d0-41a4-8fd89b845a6f@redhat.com>
Date: Sun, 30 Aug 2020 11:35:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <24ac4d35-ff2b-4381-ab1b-1a8f31ba36fb@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 05:35:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/08/20 10:16, Thomas Huth wrote:
> Seems like this is added by meson itself (see
> meson/mesonbuild/linkers.py), not by our meson.build files ... Paolo,
> any idea why this happens?

This is done by "b_lundef=false".  I think it was added for modules, but
maybe it's not necessary.  Emmanuel, can you try removing it (line 3 of
meson.build) and seeing if --enable-modules still works for you?

Paolo


