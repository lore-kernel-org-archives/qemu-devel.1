Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD24DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C02920748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZY6NWPjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C02920748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zEa-0006b0-Qn
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zDh-0005IX-8K
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:03:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zDf-0006Wq-A8
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596794602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYtUajKOhbUILX9o7u2kpIyTWubbIj9jOSX8jtsIprM=;
 b=ZY6NWPjFc7HQ4RfpUnY1J4KLgAEFBWO0nZeuR+J3+hy9oXhchMcmwV2KJgBD81vqpe3+lj
 xddXQE+o+HxF5mgLyOo7v6YdwFMQKE4zBfbifQSXhnBBRkN6G6AoyXZvk25gl/Z4DpgicR
 L5SjeZHtRhM7p/Q9cDKl7NuWPPme3Ac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-Uvn9Z3QjOVK7H7D-pZgz4w-1; Fri, 07 Aug 2020 06:03:20 -0400
X-MC-Unique: Uvn9Z3QjOVK7H7D-pZgz4w-1
Received: by mail-wr1-f70.google.com with SMTP id z1so547592wrn.18
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zYtUajKOhbUILX9o7u2kpIyTWubbIj9jOSX8jtsIprM=;
 b=cjZqPeGno/ePYTLaglMvOSj51Sa4M/FGADogXjAqSyxBX4voMR1L5h8pPX6ImEIOub
 PJskme1WJAeEOXYZRCcUKagO8pcV0WOfpuXFqfRnQADAKiy4jsr1/Pi8wtmpwx4QCOZI
 3R9jJexwLQUZSudAkSStEukndDyvvd6RYVign07xCCazSV8lfYhMp3JdQRuX8sUyL4hz
 S0gSWR1ZCV1GN7gA6+RBCn5sn9i2+npvuWPTFFqp7sMq8Rs5yWM9pyWLJf/ED5oIlOfb
 23xcWKjAA0SUHtgBUOI8e4lABqdiU1p6c3IzFRQPb0NDbPeUis3gODBO0q3Soejp0WCy
 amlA==
X-Gm-Message-State: AOAM531PMMWDWhvIxmy/y9qHaPGmuiXZT9Fx/HLOEyGvCA/6iUJRB6Pq
 6r3Q6I4FUaM3Zi9EyL1mhuZ0jOsEojQ0YfOjt9Qpk/OZtiT0jO9YclqoP38UFyvuiq7SQeLQTpM
 xiKlsgNsFC8ajeoM=
X-Received: by 2002:a05:600c:21d6:: with SMTP id
 x22mr11292093wmj.112.1596794599441; 
 Fri, 07 Aug 2020 03:03:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvsK/iqGjyGp8R6BmoF7x/aewOr9toRJgp7Sb1+1qnRxmsDE8EbS9nEbyIX/NOW3ZNEfoWhw==
X-Received: by 2002:a05:600c:21d6:: with SMTP id
 x22mr11292072wmj.112.1596794599219; 
 Fri, 07 Aug 2020 03:03:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id 62sm9984482wrq.31.2020.08.07.03.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 03:03:18 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
 <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
 <6f6e9c9b-fdf6-951e-9112-3913fe44c455@redhat.com>
 <ac18da61-6f54-b9d4-7591-e1296f9d3a32@redhat.com>
 <353ff6f7-c67f-7665-b631-967512417fa2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9590bf6-91b7-db6f-3545-873337a4990c@redhat.com>
Date: Fri, 7 Aug 2020 12:03:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <353ff6f7-c67f-7665-b631-967512417fa2@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 armbru@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 11:52, Thomas Huth wrote:
>> At least the Debian container started to compile, but then fails here:
>>
>>  ../hw/display/virtio-gpu.c:43:10: fatal error: virglrenderer.h: No such
>> file or directory
>>  https://gitlab.com/huth/qemu/-/jobs/675665451

Likely just a rebase issue:

diff --git a/hw/display/meson.build b/hw/display/meson.build
index efe18f2..ffcccc0 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -81,13 +81,6 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
                      if_true: virtio_gpu_ss)
 endif
 
-specific_ss.add(when: [pixman, 'CONFIG_VIRTIO_GPU'], if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c', 'virtio-gpu-3d.c'), virgl])
-specific_ss.add(when: [pixman, 'CONFIG_VHOST_USER_GPU'], if_true: files('vhost-user-gpu.c'))
-specific_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-gpu-pci.c'))
-specific_ss.add(when: ['CONFIG_VHOST_USER_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('vhost-user-gpu-pci.c'))
-specific_ss.add(when: 'CONFIG_VIRTIO_VGA', if_true: files('virtio-vga.c'))
-specific_ss.add(when: 'CONFIG_VHOST_USER_VGA', if_true: files('vhost-user-vga.c'))
-
 specific_ss.add(when: [x11, opengl, 'CONFIG_MILKYMIST_TMU2'], if_true: files('milkymist-tmu2.c'))
 specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
 


> And yet another error, this time on Travis with --disable-system :
> 
>  ../hw/display/meson.build:42:22: ERROR: Unknown variable
> "config_all_devices".
>  https://travis-ci.com/github/huth/qemu/jobs/369657010#L1035

diff --git a/meson.build b/meson.build
index 5635f8e..ddd73d4 100644
--- a/meson.build
+++ b/meson.build
@@ -491,10 +491,10 @@ if have_system
     command: [grepy, '@INPUT@'],
   )
   config_all_devices = keyval.load(config_all_devices_mak)
-  config_all = config_all_devices
 else
-  config_all = {}
+  config_all_devices = {}
 endif
+config_all = config_all_devices
 config_all += config_host
 config_all += config_all_disas
 config_all += {


More type checking.  I'll finish my current round of testing and push again.

Paolo


