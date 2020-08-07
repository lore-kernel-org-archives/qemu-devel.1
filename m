Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B407EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824C720866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtKWkt+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824C720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k43Dg-00066R-M3
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k43DA-0005hN-1s
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:19:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k43D7-000443-8Q
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596809943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAjMBiooYBOl8zBPJsj8kkNGvyasQwYf02rciro3jXU=;
 b=YtKWkt+72yIcQOyd5eQRjK6YnkSdTQpo6bbYuTdIyxeIHiPWIXmpojr5kyJdL8kTBMT07n
 3JKr6af4ddSj/ibcbVA+pp5QyDcO8Z/QvAgOWix09hPsfLBLg/C4WlxuRV/OH5bYN55AUF
 av3FvVlrdgGfHZUVRYk0piCWFGQVUpU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-hdqguDy8OXixmk0ALNz3hQ-1; Fri, 07 Aug 2020 10:19:01 -0400
X-MC-Unique: hdqguDy8OXixmk0ALNz3hQ-1
Received: by mail-wr1-f72.google.com with SMTP id e12so807459wra.13
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 07:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wAjMBiooYBOl8zBPJsj8kkNGvyasQwYf02rciro3jXU=;
 b=LQoIdogkHa9j0wXP0s+vqp3sZ58/6QPzFgGMcfsCX17BrrrsB+0fIGYgvR2IYQeyGa
 9QnISXj/4XP+3zh5TKkwoB07V2YPo1sPnEsFs3bFsOo/DD2W8Ni89NgdVCGT4ENlATC6
 DEcqhYDNepOna4eoP2DOAnPEB2wV4AQ4pVqohr6wnfnzAFUKveXgqad9UKFXk11mgWVs
 x0PVcTKvNBcYxKj7SjPGP3KQM47S2aUJP8ixPhlyf5Vu0ixxD1uVa/4RnF8GHqQjHXfQ
 HpAiDRgXzWauPhkDOTRqAmtfbEdxkh33RxkyGE14Tr9zTW1Yjm0yhIN0vny6y0ozkv4H
 4sFQ==
X-Gm-Message-State: AOAM530mdBWNvICPc8eej+5SvDvnPr6Sz+daPu1/tqD5f2GuIF2ywMyb
 hkUFeb2nhlxmh0FtIxOG7PFIGNvycBUfquKrVfRwBsJWL7HKvj7vhD5GX36sYphw8fqQyra40Zs
 n/iallo6C+v5IEDs=
X-Received: by 2002:adf:f64a:: with SMTP id x10mr11490249wrp.99.1596809940469; 
 Fri, 07 Aug 2020 07:19:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiqspbnsK3YbIgXkacbAyCHJQcGylMAdQpu4cdw319fK4uQXDr0zGl6wDbXOxDR+L/PInj8Q==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr11490236wrp.99.1596809940265; 
 Fri, 07 Aug 2020 07:19:00 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id g3sm11882237wrb.59.2020.08.07.07.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 07:18:59 -0700 (PDT)
Subject: Re: [PATCH 068/143] meson: convert most of softmmu/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-69-git-send-email-pbonzini@redhat.com>
 <bac67efd-d736-b7ae-b9b3-0373393d2849@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a54f3ef9-5905-628c-c277-f7d6190c3be6@redhat.com>
Date: Fri, 7 Aug 2020 16:18:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bac67efd-d736-b7ae-b9b3-0373393d2849@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On 07/08/20 15:36, Philippe Mathieu-Daudé wrote:
> There is still "obj-y += vl.o" in softmmu/Makefile.objs.
> 
> Did you meant to squash this into the previous patch?

This is what I meant:

diff --git a/meson.build b/meson.build
index a7ad3248cc..ef6f811c51 100644
--- a/meson.build
+++ b/meson.build
@@ -618,6 +618,8 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 
 common_ss.add(files('cpus-common.c'))
 
+subdir('softmmu')
+
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
 
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index a414a74c50..ebcfd15695 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -1,14 +1,2 @@
 softmmu-main-y = softmmu/main.o
-
-obj-y += arch_init.o
-obj-y += cpus.o
-obj-y += cpu-throttle.o
-obj-y += balloon.o
-obj-y += ioport.o
-obj-y += memory.o
-obj-y += memory_mapping.o
-
-obj-y += qtest.o
-
-obj-y += vl.o
-vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
+main.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
diff --git a/softmmu/meson.build b/softmmu/meson.build
new file mode 100644
index 0000000000..95d38df259
--- /dev/null
+++ b/softmmu/meson.build
@@ -0,0 +1,10 @@
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
+  'arch_init.c',
+  'balloon.c',
+  'cpus.c',
+  'cpu-throttle.c',
+  'ioport.c',
+  'memory.c',
+  'memory_mapping.c',
+  'qtest.c',
+  'vl.c'))


