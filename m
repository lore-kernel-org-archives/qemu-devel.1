Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F00C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820202072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/VNXOm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820202072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7dH3-0003Wh-MF
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 07:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7dG1-000309-O0
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:24:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25239
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7dG0-00079p-3o
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597663491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wLfx1COto8qeeJ2uYCN9IVJPIZeIpK1r6ekgvI4TrE=;
 b=d/VNXOm66ULoo46s3j35fmu5WliHzAeYWTpV0hnU/CPYylmzN4sxrI30Z9k5zCrWW/bbgS
 91X9ijhj4HRUjmv01jCwpERPZpyLrsw2UCzJgkQgThuWXevxCoYiA/R/mqy8jSd9Hg5G+b
 vTH8Y11wEFfJOhHN30i07yaO97hbVog=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-PION-5r2Oe6V8KpGubx77w-1; Mon, 17 Aug 2020 07:24:49 -0400
X-MC-Unique: PION-5r2Oe6V8KpGubx77w-1
Received: by mail-wm1-f69.google.com with SMTP id u14so3994071wml.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 04:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+wLfx1COto8qeeJ2uYCN9IVJPIZeIpK1r6ekgvI4TrE=;
 b=gcvsXUQoSVJlQJhYygeNRZEGepTfall0HJj/IMHH0PMdu/tR8fgW9X2AsyV2iO4d4W
 tpFFmFiooNHoFW+Npg0n63ThMnA/GBAtBjU9aoyO6wxdstJKm72mm1eY39r7/ZmzUKzM
 I9Lthzp0zA3VGRSVna14EYeMKAFgCSYlBrwhUChQgRDeXdWh1CkAzfcROl829dThT5in
 8ttN1FTqztrlbKFzwidnF9HJIHZHWol4rUemlUkPJ9PC0/acVfcwc8M1gbdR58XSGbGb
 BJ8RPau3ihgn8aJhoElpTnGoSJZD9uGA9yZvI7eL3AwydbhOjcSOqLrGDRBAa7Q2Gu/p
 AZQQ==
X-Gm-Message-State: AOAM5320Lv+cNlnPhT44ZdWXY0uH6dL/Jht6hudlY51QcWRoQY3aMLlZ
 uKLE3z7QRu+t3bHyMCw2uv1MZMnN0wKxJVjmsz0LTkfvQQUP9gjYjsk4QMX5ZV0/9eVSKYSuxxw
 oRtha9N2NMlrvqdY=
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr562084wrs.302.1597663488466;
 Mon, 17 Aug 2020 04:24:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcESo7JEyO59Jv1R1BgxSQxXu4fgI6bEPacz+pW42KhkYhH6llZ4W0naCucJokn5MZxM/MyQ==
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr562065wrs.302.1597663488246;
 Mon, 17 Aug 2020 04:24:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977?
 ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id m20sm56282338wmc.1.2020.08.17.04.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 04:24:47 -0700 (PDT)
Subject: Re: [PATCH v2 000/150] Meson integration for 5.2
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
 <20200817110254.GA98227@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8a9f236-7017-01a7-0a6d-06a2e18f95f1@redhat.com>
Date: Mon, 17 Aug 2020 13:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200817110254.GA98227@SPB-NB-133.local>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/08/20 13:02, Roman Bolshakov wrote:
> 
> Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
> 
> On the next step, it might be good to drop configure in favor of meson
> configuration, so configure, build and test commands would be similar to
> libvirt:
> 
> meson build
> ninja -C build
> meson test -C build

Well, there are quite a few steps needed to get there:

1) moving feature tests from configure to Meson is a no-brainer.
However it's better to first convert the unit tests to Meson and get rid
of the rest of rules.mak.  This is because it's simpler to do this if
there are no uses left of CONFIG_* symbols in the Makefiles.

2) moving the rest of "make install" to Meson is even more of a
no-brainer.  Marc-André has patches there.  They also include a
conversion of the ROM build.

3) moving the bulk of the build from meson to ninja is possible and I
already have patches for it.  It requires adding ninja as a build
dependency however.  The main advantage here is getting rid of
Ninjatool.  I'm not sure how moving the handling of submodules to Meson
would work, and that's needed in order to be able to build with "ninja
-C build".

4) I find "meson test" to be inferior in some respects to the QEMU's TAP
test harness.  In particular, one feature of QEMU's Makefiles is that
you can cut-and-paste from "make V=1 output" into the shell.  So that
part may take some time.  I'd rather extend Meson so that it's possible
to write arbitrary test runners.

Thanks,

Paolo


