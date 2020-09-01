Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACE3C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 19:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C152071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 19:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gnsw2a5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C152071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDBXe-0007Jz-CL
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 15:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDBWe-0006cR-6V
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 15:01:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDBWb-0002sF-E8
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 15:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598986855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWxqEHY2lVLQSq0EOLoGApvgBuQ9a9z6qX4Yx1uoJSg=;
 b=Gnsw2a5L9oMpjegnLfU7r5WWyRD30FwhsYvWMs0PwRTbPeDKB6AdFlQH46uEagVASmcs+O
 ZnT4M+69wWrnS922HcMoeLtFKKOFv3zmS1iiq8ykVe/+s2LOcDsjOnsp0NjzbVP5UKAFS1
 h+DExUYx3dNR3Hlnu+O2BPMWe0RvW/I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-aL7sJhpaPFSsFoI_NhcsaA-1; Tue, 01 Sep 2020 15:00:51 -0400
X-MC-Unique: aL7sJhpaPFSsFoI_NhcsaA-1
Received: by mail-wr1-f70.google.com with SMTP id a12so931662wrg.13
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 12:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZWxqEHY2lVLQSq0EOLoGApvgBuQ9a9z6qX4Yx1uoJSg=;
 b=uOlSOk4BfFwZ5u8F3f+WLze/V65xewGYUAF1uMR8roIUEZUattxcMbrsfWMs5lD1MO
 WM3OxgLC0lR6vOx6+5sra41BNC4FJ7KbIZzx9Jek5Kbk88H3Ek6sbXaS/S3rebNZKrjz
 vJpIhvvl4TIhwJXJtO1Ku/S9EFqDs9vXzxxj2IL8LRkn+RSd53N/Rh5aIHja1RdosYgW
 3YRhJOdTNWtpNXrSIAn4TFoGSbfwyIolOZQAvX+l8fkBg+vyx+iJ0DENuK4hVaQ8StzN
 s7c9od2esc2nKnvKgXSTNdnFC2RmZ5Y6qoJjLe5v8UxuntNgBxTq/MKUf3gWkITj52si
 fXfw==
X-Gm-Message-State: AOAM533HKQZd0lLgwTUDH+4e/2I98ZOA8xVRSmNhhbnZSgdvcIpkQwev
 ixF43SfaJejWpa5LtoHW+rSA/Wasg70IgaaJrEgisRmMhJD8ae4P8/G19TC7rWt5/ghaeTnhQgk
 qCVdmhaWpq1crFzU=
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr3184877wrt.13.1598986849754; 
 Tue, 01 Sep 2020 12:00:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8Yd52UsggVtfIh+U+GUntKm1QLIvBQFYzVbWIsiClyB2Bg02xmWauGfV7dyyYJjPk2dSEmw==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr3184847wrt.13.1598986849478; 
 Tue, 01 Sep 2020 12:00:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7fbd:8007:1fa7:ed17?
 ([2001:b07:6468:f312:7fbd:8007:1fa7:ed17])
 by smtp.gmail.com with ESMTPSA id b14sm3549413wrj.93.2020.09.01.12.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 12:00:49 -0700 (PDT)
Subject: Re: [PATCH] fuzz: Add support for custom fuzzing library
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <9dfe703d-5c78-36d0-bc15-17ff6f9179d7@redhat.com>
 <20200901181800.326382-1-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e47f86a-e35c-12f5-d421-da1b64478b39@redhat.com>
Date: Tue, 1 Sep 2020 21:00:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901181800.326382-1-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Bandan Das <bsd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/09/20 20:18, Alexander Bulekov wrote:
> ---
>  configure                    | 12 ++++++++++--
>  meson.build                  |  6 +++++-
>  tests/qtest/fuzz/meson.build |  5 ++---
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> 
> Hi Paolo,
> Here I'm trying to specify the linker-script with
> add_project_link_arguments. How I'm testing this:
> 
> $ CC=clang-10 CXX=clang++-10 ../configure --enable-fuzzing
> $ make V=1 "-j$(nproc)" qemu-fuzz-i386
> 
> clang++-10  -o qemu-fuzz-i386 qemu-fuzz-i386.p/tests_qtest_fuzz_qtest_wrappers.c.o \
> ... libblock.fa chardev/libchardev.fa \
> -Wl,--start-group tests/qtest/libqos/libqos.a -Wl,--no-whole-archive \
> -Wl,-T,/home/alxndr/Development/qemu/tests/qtest/fuzz/fork_fuzz.ld \
> ... \
> -Wl,-rpath-link,/home/alxndr/Development/qemu/build/ -lstdc++ -Wl,--end-group
> 
> Maybe if I can get the oss-fuzz LIB_FUZZING_ENGINE
> (/usr/lib/libFuzzingEngine.a) into the --start-group, that could also
> solve the issue... I'll take another look at exactly what the oss-fuzz
> build container does.

Actually your patch is pretty close, just by hacking

diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 19931b9248..2bc46c5a84 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -52,6 +52,6 @@ libqos = static_library('qos',
         'arm-xilinx-zynq-a9-machine.c',
         'ppc64_pseries-machine.c',
         'x86_64_pc-machine.c',
-), build_by_default: false)
+), name_suffix: 'fa', build_by_default: false)

 qos = declare_dependency(link_whole: libqos)

I can get it to work.  Better find a way to fix it in Meson though,
because relying on the ".a" suffix is very brittle.

Paolo


