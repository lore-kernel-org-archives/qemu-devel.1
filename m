Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D486C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1CA2064C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gW+Mbt/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1CA2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPM7n-0006dq-Bb
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPM6a-0005Db-Ox
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPM6Y-0001kA-F0
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601887460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s67EkkDFWu7se6DueBPlDE8HGIJXstU2ZAIwbZ/kYHA=;
 b=gW+Mbt/TwEi3/jgGMS44l8rDAPAXlmIetHn+3rGWiR9pejF+qJRFQARRRt0/DcRNGyoVF6
 q2gzPrSWNB7wyv83dfUXIY+y7ZH5RQPrgKXSKQN7CgMHq5TKO0mzYgEbqEEYWxDN8cxUOY
 1M1LqbeValifYlrtXjHvQ94L7sQFZCE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-s7l_AD-kO5ec_s6g5nUu_Q-1; Mon, 05 Oct 2020 04:44:17 -0400
X-MC-Unique: s7l_AD-kO5ec_s6g5nUu_Q-1
Received: by mail-wm1-f71.google.com with SMTP id f2so1497180wml.6
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s67EkkDFWu7se6DueBPlDE8HGIJXstU2ZAIwbZ/kYHA=;
 b=qauiORVNAkY7ZPllrOseDF5An6HBEfMOqiGrmcCFBiyzXriNYDCg9yvopDkbNpDmdt
 FXFGs0h+Et3LMvXNSvqbpj7ThB2sCdaxahbOWlet2uKEiyqGncA2fZUrRDDrUG2FWbft
 sJVOwlMmzOaOb+k55gZrdqQyVFvcVnSIeRvSnYsER7w06TvYKOgEB7rA7KgMtCu9Mt6V
 EGUuTeAUZFfm76+L2BzBGZPvVq38EexFLASzqpI2UMVvjVrAIJYWMRZ83kShgjtSKoHg
 ErUsqGF463DWr0GaB4EBBYxBCkwOBo2egLeVqkSOKHPUdGsXaFt+cdcEg6h4WdqwNzls
 tn/g==
X-Gm-Message-State: AOAM530sh5KsQVmQLMRv/waYRKKbHLgx8PAvj5MrostHstnGtGqKYVKe
 o+YNeORkXiY91P0XB7+qCwEFe6Vk6NtkryZ9bMQAxcKAjwq6w83n+kxaRrHJGOn+7HMr/Cl30HA
 K1EY5NG6p0iHWZnk=
X-Received: by 2002:a1c:4909:: with SMTP id w9mr16711784wma.133.1601887456121; 
 Mon, 05 Oct 2020 01:44:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxceM9cZLh3NfwX8uJzDyzbx1Zg65L/SQ2gheyuT5lrUq/IlFhVWAsRokG+Q/bqc/8m8kYPxQ==
X-Received: by 2002:a1c:4909:: with SMTP id w9mr16711760wma.133.1601887455890; 
 Mon, 05 Oct 2020 01:44:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2e86:3d8b:8b70:920c?
 ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id w15sm12312185wro.46.2020.10.05.01.44.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 01:44:15 -0700 (PDT)
Subject: Re: [PULL v2 00/92] Misc patches for 2020-09-24
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200925102257.1848666-1-pbonzini@redhat.com>
 <CAFEAcA-okvLfrjtvVVUWJWunzOSC8kgAEUuMM1JXciebfSJ0pg@mail.gmail.com>
 <CAFEAcA_6j7n5CvahUkxuQmWLfpq6L5ya+XTCMqnxaTqoB05QpA@mail.gmail.com>
 <62f95614-b9b1-8a9f-a4e0-c825799b6958@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6277f12-b24e-20c2-687f-c1cff8ebad3f@redhat.com>
Date: Mon, 5 Oct 2020 10:44:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <62f95614-b9b1-8a9f-a4e0-c825799b6958@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 09:51, Philippe Mathieu-Daudé wrote:
> Is that why your "configure: fix performance regression due to PIC
> objects" patch has been dropped from your pull request?

Partly.

Regarding this particular failure, since Richard's capstone patches are 
being merged, I think it's easier to do the same with slirp and libfdt 
and drop the submodule rules from the makefile altogether.  Then we can
merge safely "configure: fix performance regression due to PIC objects"
and also simplify the CFLAGS/LDFLAGS patches.

Second, I am hoping that https://github.com/mesonbuild/meson/pull/7760 
gets in 0.56.0; then the fix can be simply

diff --git a/meson.build b/meson.build
index 1dd3f49011..d29b9d41db 100644
--- a/meson.build
+++ b/meson.build
@@ -1,6 +1,6 @@
 project('qemu', ['c'], meson_version: '>=0.55.0',
-        default_options: ['warning_level=1', 'c_std=gnu99', 'cpp_std=gnu++11',
-                          'b_colorout=auto'],
+        default_options: ['warning_level=1', 'c_std=gnu99', 'cpp_std=gnu++11', 'b_colorout=auto'] +
+                         (meson.version().version_compare('>=0.56.0') ? ['b_staticpic=false'] : []),
         version: run_command('head', meson.source_root() / 'VERSION').stdout().strip())
 
 not_found = dependency('', required: false)
 
Paolo


