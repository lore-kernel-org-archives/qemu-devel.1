Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA38C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6152C208A9
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeCi4am0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6152C208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8n4p-0008Aa-JS
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8n1Z-0002Uw-Nm
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8n1U-0005Lf-Nh
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597939358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MwLquO3Y0FqoUCweoZsMXG5f2NwnrsqcRerpRZf5dM=;
 b=BeCi4am0FljLwOUjyIcHdIq7ZavBdV9OxWDWUUanwsX6GVAO7GM72qcXxutZrIQb1GE2oh
 6Ew16cN7u6414dEuNKsE5TX5lBqenaUSSyYY3vqfiB/jpktQ5EB79Xt7K71LswHDF4PRG1
 VeuW194eNx6R7cY6v4OIZjH8Q/xR7AM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-T63Te7DnNd2zlteNpJcKlg-1; Thu, 20 Aug 2020 12:02:29 -0400
X-MC-Unique: T63Te7DnNd2zlteNpJcKlg-1
Received: by mail-wm1-f71.google.com with SMTP id d22so947147wmd.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6MwLquO3Y0FqoUCweoZsMXG5f2NwnrsqcRerpRZf5dM=;
 b=j3j4uAmGjOhHAcAuLTWFHKO04G2Ny/toacLn7WLrTZTX6IbVZfWHPUW04cuWxYnfut
 7n9klBD6TdIm7diyaZHT0YcHfxtdookkd10F3z28dxp8fhI6o7MWxkU4C9DirLI0DrqM
 Bs0Mxy0l8qQbx7ShuOVBw4y5OZtYAIx+pDqxfWOqv+dCudVYaC+bkskzhD0YaPIT/X5p
 dPRQrMQ/eR9YEZ6COh71r3l1PT8inrJtWnd0jwSI02kKAUyDMmtBgiAysLC10jOnS2DN
 8AbThL93yW3dSVaKjHGCV3O5czWVfr2Hk1FejIXWGN+39v9D0WpBQqVdGSLz4i4Sn07t
 5H2Q==
X-Gm-Message-State: AOAM533F18cPHID5Eb269FM/Jy0e9OGl2DZEkBa8ACl0LBD8l83EzbLu
 9YG6DCK7hQ/1ykEqUjrZvALN+kHGHynQwmdgjvYJQJjXVYYfcgcxPT1YstYhU3MXr4n9wlpDLdv
 PpQXJHRWCN+dzq9Y=
X-Received: by 2002:adf:90d1:: with SMTP id i75mr3704660wri.278.1597939347900; 
 Thu, 20 Aug 2020 09:02:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGS+f8eVFtTHsksQLX6k9mnxzvneEMeK9djE8xdOlgtBItLNMsPzehmB3mEtWUel9y03zmew==
X-Received: by 2002:adf:90d1:: with SMTP id i75mr3704639wri.278.1597939347678; 
 Thu, 20 Aug 2020 09:02:27 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id q6sm5257792wma.22.2020.08.20.09.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 09:02:27 -0700 (PDT)
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200819213203.17876-1-pbonzini@redhat.com>
 <CAFEAcA86m9N5ceYB+Nu965Se=qyZ_3W-Cn76Qc+Dd75hEApz=w@mail.gmail.com>
 <446a210a-7e88-ab9b-05f4-6b0ffabf97c6@redhat.com>
 <CAFEAcA8chPqS0keyGv0vBgNgacnMo95gA3LZDU2QfmteQ=4UZg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <223cfebd-605c-20d0-f649-b462effaf04e@redhat.com>
Date: Thu, 20 Aug 2020 18:02:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8chPqS0keyGv0vBgNgacnMo95gA3LZDU2QfmteQ=4UZg@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:28:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/20 16:54, Peter Maydell wrote:
> Configuring ninjatool using configuration
> Library m found: YES
> Library util found: YES
> Library aio found: YES
> Library rt found: YES
> Found pkg-config: /usr/bin/pkg-config (0.29.1)
> WARNING: Static library 'asound' not found for dependency 'sdl2', may
> not be statically linked
> WARNING: Static library 'pulse-simple' not found for dependency
> 'sdl2', may not be statically linked
> WARNING: Static library 'pulse' not found for dependency 'sdl2', may
> not be statically linked
> WARNING: Static library 'sndio' not found for dependency 'sdl2', may
> not be statically linked
> WARNING: Static library 'wayland-egl' not found for dependency 'sdl2',
> may not be statically linked
> WARNING: Static library 'wayland-client' not found for dependency
> 'sdl2', may not be statically linked
> WARNING: Static library 'wayland-cursor' not found for dependency
> 'sdl2', may not be statically linked
> Run-time dependency sdl2 found: YES 2.0.8
> Found CMake: /usr/bin/cmake (3.10.2)
> Run-time dependency sdl-image found: NO (tried pkgconfig and cmake)
> Run-time dependency libpng found: YES 1.6.34
> 
> What are they for, and can they be suppressed ?

Meson (just like configure before it) is looking for SDL and other
dependencies even if you're not building system emulators.

Because you don't have those dependencies installed as static libraries,
Meson warns that library is marked as "not found" even though the
library itself is there.  To suppress the warnings, it's enough to put
an "if have_system" around the dependency check.  Let me know if you
want me to do it now.

Paolo


