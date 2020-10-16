Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05AC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F49920848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXTa10Wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F49920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTPv6-0004dI-96
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTPrE-0000Pg-3v
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTPrB-00017C-II
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602855196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLqABXddYwZW31C1B8FNPfh4vpp4lDSuMpSoGHdQDQA=;
 b=iXTa10Wfm055Am2DF4kPPSDCls3hUbBChGEZqXNwksvqsLMGnZT6zwzTRpU4DKGzmvjg5V
 /ToDKAs+glyLGnGYPs60yOa9c7EyYvnpH5CgIRyK7U3idJVGOwbNJ50HIJDk9aRECMCwIW
 pS5J0ocb9q6Qql8wYwsctG5nEgYn5Yo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-g6WTEpV1PCi-MQ1g5S33-A-1; Fri, 16 Oct 2020 09:33:11 -0400
X-MC-Unique: g6WTEpV1PCi-MQ1g5S33-A-1
Received: by mail-wr1-f71.google.com with SMTP id 31so1476292wrg.12
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 06:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oLqABXddYwZW31C1B8FNPfh4vpp4lDSuMpSoGHdQDQA=;
 b=pJerW0TLYnlkbvHJYiXilaRaUpO/LOHWotrhaTLcDfX+p/6tNyeM6p1PNg0/s4rkP1
 alMu1yqixowk8PvR7Ivzj0urHhuvE9Opz3uRdZbhx1chB5ki3nQnfmZX+ImGAUOE9AsJ
 GKCwFHZZyKNzDIpU5UMRGa42FDI0MCY8dyqp1CSyt5Mnz5LQ3h8NajVFnTHkuqPXFoUb
 uF1bRpLHjSaEhIDMY9hXPrVVw0Xc7RuiR6yl2MFmflXo+PUZcrY68/H7wgSE9VJILQ+9
 e82VURV9X6Kkcu5jB+kuH0huzXBHj+uWkugmJQp3x01qXJ0JWdYXSJdw4U85bTf4VbHq
 BNmg==
X-Gm-Message-State: AOAM532mmXUzkfa5ATXmLiSu6SkBzXqV18iqlAgJG/3Z9U3F4N0s+oqq
 Lj9q32Oh4T0JUG3l1ZJVDQfkG+lJ4xORirMk9BJ/WfG15ChowRycYHr89lCzl7Qyz9Rvw/mlZn6
 VM8D2NqKBDZQlojU=
X-Received: by 2002:a05:6000:18d:: with SMTP id
 p13mr3991464wrx.248.1602855189931; 
 Fri, 16 Oct 2020 06:33:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytbg5ofqRL/dnLzmWAEt3w6T4MqGmGZ6H+n0Fn/xVkDisSX7R5aYwYTq8Xjxr287+ierRdGg==
X-Received: by 2002:a05:6000:18d:: with SMTP id
 p13mr3991436wrx.248.1602855189694; 
 Fri, 16 Oct 2020 06:33:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3?
 ([2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3])
 by smtp.gmail.com with ESMTPSA id g83sm2843505wmf.15.2020.10.16.06.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 06:33:09 -0700 (PDT)
Subject: Re: [PATCH v4 00/16] Add a General Virtual Device Fuzzer
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201015134137.205958-1-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95e52b8e-6a52-947c-3ab1-ef432c92137b@redhat.com>
Date: Fri, 16 Oct 2020 15:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015134137.205958-1-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, dimastep@yandex-team.ru,
 f4bug@amsat.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you have to do a v5, the correct word is generic not general. :)

Otherwise looks great.

Paolo

On 15/10/20 15:41, Alexander Bulekov wrote:
> v4:
>     - Replace yaml + c template-based oss-fuzz configs, with C code to
>       register a FuzzTarget for each config (as suggested by Paolo)
>     - Replicate the functionality of address_space_write_rom to ensure
>       matching behavior when QTEST_LOG is enabled
>     - Improve code documentation/comments
>     - Small formatting changes
> v3:
> 	- Use flatviews to help select regions for fuzzing 
> 	- Meson-related changes
>     - Add some documentation
> 	- Improve minimalization script to trim write{bwlq} commands
> v2:
> 	- Remove QOS dependency.
> 	- Add a custom crossover function
> 	- Fix broken minimization scripts
> 	- Fixes to the IO region and DMA handling code
> 
> This is a general virtual-device fuzzer, designed to fuzz devices over Port IO,
> MMIO, and DMA.
> 
> To get started with this:
>  1. Build the fuzzers (see docs/devel/fuzzing.txt)
>     Note: Build with --enable-sanitizers, or create a "dictionary file":
>     echo kw1=\"FUZZ\" > dict
>     and pass it as an argument to libFuzzer with -dict=./dict
>     This magic value is a command separator that lets the fuzzer perform
>     multiple IO actions with a single input.
> 
>  2. Pick the qemu arguments you wish to fuzz:
>     export QEMU_FUZZ_ARGS="-M q35 -device virtio-balloon"
> 
>  3. Tell the fuzzer which QOM objects or MemoryRegion names to fuzz. I find the
>  "info qom-tree", "info qtree" and "info mtree" commands useful for identifying
>  these. Supports globbing. Here I will try to simultaneously fuzz(for no good
>  reason) virtio-balloon and e1000e, which is included by default in the q35:
>     export QEMU_FUZZ_OBJECTS='virtio* e1000*'
>     You can also try to fuzz the whole machine:
>     export QEMU_FUZZ_OBJECTS='*'
> 
>  4. Run the fuzzer for 0 inputs. The fuzzer should output a list of
>  MemoryRegions/PCI Devices it will try to fuzz. Confirm that these match your
>  expectations.
>     ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-fuzz -runs=0
> 
>  5. Run the fuzzer:
>     ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=general-fuzz 
> 
> 
> Basically, at the core, this fuzzer is an interpreter that splits the input
> into a series of commands, such as mmio_write, pio_write, etc. We structure
> these commands to hit only MemoryRegions that are associated with the devices
> specified in QEMU_FUZZ_OBJECTS. Additionally, these patches add "hooks" to
> functions that are typically used by virtual-devices to read from RAM (DMA).
> These hooks attempt to populate these DMA regions with fuzzed data, just in
> time.
> 
> Some of the issues I have found or reproduced with this fuzzer:
> https://bugs.launchpad.net/bugs/1525123
> https://bugs.launchpad.net/bugs/1681439
> https://bugs.launchpad.net/bugs/1777315
> https://bugs.launchpad.net/bugs/1878034
> https://bugs.launchpad.net/bugs/1878043
> https://bugs.launchpad.net/bugs/1878054
> https://bugs.launchpad.net/bugs/1878057
> https://bugs.launchpad.net/bugs/1878067
> https://bugs.launchpad.net/bugs/1878134
> https://bugs.launchpad.net/bugs/1878136
> https://bugs.launchpad.net/bugs/1878253
> https://bugs.launchpad.net/bugs/1878255
> https://bugs.launchpad.net/bugs/1878259
> https://bugs.launchpad.net/bugs/1878263
> https://bugs.launchpad.net/bugs/1878323
> https://bugs.launchpad.net/bugs/1878641
> https://bugs.launchpad.net/bugs/1878642
> https://bugs.launchpad.net/bugs/1878645
> https://bugs.launchpad.net/bugs/1878651
> https://bugs.launchpad.net/bugs/1879223
> https://bugs.launchpad.net/bugs/1879227
> https://bugs.launchpad.net/bugs/1879531
> https://bugs.launchpad.net/bugs/1880355
> https://bugs.launchpad.net/bugs/1880539
> https://bugs.launchpad.net/bugs/1884693
> https://bugs.launchpad.net/bugs/1886362
> https://bugs.launchpad.net/bugs/1887303
> https://bugs.launchpad.net/bugs/1887309
> https://bugs.launchpad.net/bugs/697510
> 
> Alexander Bulekov (16):
>   memory: Add FlatView foreach function
>   fuzz: Add general virtual-device fuzzer
>   fuzz: Add PCI features to the general fuzzer
>   fuzz: Add DMA support to the generic-fuzzer
>   fuzz: Declare DMA Read callback function
>   fuzz: Add fuzzer callbacks to DMA-read functions
>   fuzz: Add support for custom crossover functions
>   fuzz: add a DISABLE_PCI op to general-fuzzer
>   fuzz: add a crossover function to generic-fuzzer
>   scripts/oss-fuzz: Add script to reorder a general-fuzzer trace
>   scripts/oss-fuzz: Add crash trace minimization script
>   fuzz: Add instructions for using general-fuzz
>   fuzz: add an "opaque" to the FuzzTarget struct
>   fuzz: add general-fuzz configs for oss-fuzz
>   fuzz: register predefined general-fuzz configs
>   scripts/oss-fuzz: remove the general-fuzz target
> 
>  docs/devel/fuzzing.txt                        |  39 +
>  include/exec/memory.h                         |  21 +
>  include/exec/memory_ldst_cached.h.inc         |   3 +
>  memory_ldst.c.inc                             |   4 +
>  scripts/oss-fuzz/build.sh                     |   6 +
>  scripts/oss-fuzz/minimize_qtest_trace.py      | 157 +++
>  .../oss-fuzz/reorder_fuzzer_qtest_trace.py    | 103 ++
>  softmmu/memory.c                              |  23 +
>  softmmu/physmem.c                             |   2 +
>  tests/qtest/fuzz/fuzz.c                       |  13 +
>  tests/qtest/fuzz/fuzz.h                       |  28 +
>  tests/qtest/fuzz/general_fuzz.c               | 948 ++++++++++++++++++
>  tests/qtest/fuzz/general_fuzz_configs.c       | 140 +++
>  tests/qtest/fuzz/general_fuzz_configs.h       |  24 +
>  tests/qtest/fuzz/meson.build                  |   1 +
>  15 files changed, 1512 insertions(+)
>  create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py
>  create mode 100755 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
>  create mode 100644 tests/qtest/fuzz/general_fuzz.c
>  create mode 100644 tests/qtest/fuzz/general_fuzz_configs.c
>  create mode 100644 tests/qtest/fuzz/general_fuzz_configs.h
> 


