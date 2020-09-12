Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEBDC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8370620731
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 06:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gy/7ovWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8370620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGz0r-000561-It
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 02:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGyyv-0003m4-6O
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:25:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49009
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGyyt-0004Nd-47
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 02:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599891950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYXOz7Jg1YlweMugGqR2U38OSj1tAH5FKWMiCtRy8hg=;
 b=gy/7ovWXrYvNCSlDbR5wARDAPFREXDxGRcNtYxQpEYMFRGelEhAxkk9Z2qDPnJ4RvuVC9R
 hVse5c69Dr6GagIYNmS/EoL3gUoALKjcEUdzX2dYsfeaOfJE1OoXgK9EgMgdWV8u36ZhVF
 LYXnXK3LBk43GAbvAVp9Y3b0ww9OsPQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-0MzW7beENy-iG5B4-ZacrA-1; Sat, 12 Sep 2020 02:25:48 -0400
X-MC-Unique: 0MzW7beENy-iG5B4-ZacrA-1
Received: by mail-wr1-f71.google.com with SMTP id v5so4031446wrs.17
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 23:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BYXOz7Jg1YlweMugGqR2U38OSj1tAH5FKWMiCtRy8hg=;
 b=JniDpKLR33Q0vLCLBm5n8xWAYsK4z7qf1nnajMQV4yEEFAQ+bwRAm6zpw0X3zYa6SW
 R8EZ3FC9OOsPKLjED6h4j7rw5tlVIJjvfup7EjR+2BqMUSlrf0BfMGMse8Na5zsS8RHx
 ZMowxlL1oQDT4X5PH3OVkqfdey48byidbQ5KirA6Lv6bXT7kPmq+gwxCFAP20CXpkAUS
 9JQb82CAU4hIeysL4lQzqsCI+WySWYS/3h62I4TnHMf+25oor98y8GnrValopbho8DyG
 crZ2egGAmZWdSZ6UkDyiQXflTlBJBhExURp84eKnaB3Qb+oStwmVIiloq0SbkdRkqZPZ
 AJVw==
X-Gm-Message-State: AOAM533bR+z/4wp+xHNwvW6zchyrdEG1ukJBu9HpJ4qYfAzHy1Vm+mXp
 ayA+RwDHlOpnR0YX+Jj40GzczA+urUgbi4Qzef991rAIKuFDN+xs9storg9rNiu5sL7KQWK4sS0
 pq+W+Qu7/XWXquEc=
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr5442766wms.36.1599891946725; 
 Fri, 11 Sep 2020 23:25:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnkJY3rZjPSnXc1zq0f9JxxItZwv6RUV0FiqbKamUh30yOfuoh8aj4IXhcpvefG9ZgS00KSA==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr5442753wms.36.1599891946435; 
 Fri, 11 Sep 2020 23:25:46 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id 91sm9088439wrq.9.2020.09.11.23.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 23:25:45 -0700 (PDT)
Subject: Re: [PATCH v2] Simplify the .gitignore file
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200909080305.258961-1-thuth@redhat.com>
 <2fdc9691-2fd6-d453-be45-8140b0afa429@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2910b67-fd79-ad08-4232-b314b83dcbe0@redhat.com>
Date: Sat, 12 Sep 2020 08:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2fdc9691-2fd6-d453-be45-8140b0afa429@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:25:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/20 18:07, Philippe Mathieu-Daudé wrote:
> On 9/9/20 10:03 AM, Thomas Huth wrote:
>> Now that we always do out-of-tree builds (and the in-tree builds are
>> faked via a "build" directory), we can simplify out .gitignore file
>> quite a bit.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued, thanks.

Paolo

>> ---
>>  v2: Do not delete the .sdk, stgit and coccinelle lines 
>>
>>  .gitignore | 152 -----------------------------------------------------
>>  1 file changed, 152 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index b6fdd34ddf..5515f595e6 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -1,163 +1,11 @@
>>  /GNUmakefile
>>  /build/
>> -/.doctrees
>> -/config-devices.*
>> -/config-host.*
>> -/config-target.*
>> -/config.status
>> -/config-temp
>> -/tools/virtiofsd/50-qemu-virtiofsd.json
>> -/elf2dmp
>> -/trace-events-all
>> -/trace/generated-events.h
>> -/trace/generated-events.c
>> -/trace/generated-helpers-wrappers.h
>> -/trace/generated-helpers.h
>> -/trace/generated-helpers.c
>> -/trace/generated-tcg-tracers.h
>> -/ui/shader/texture-blit-frag.h
>> -/ui/shader/texture-blit-vert.h
>> -/ui/shader/texture-blit-flip-vert.h
>> -/ui/input-keymap-*.c.inc
>> -*-timestamp
>> -/*-softmmu
>> -/*-darwin-user
>> -/*-linux-user
>> -/*-bsd-user
>> -/ivshmem-client
>> -/ivshmem-server
>> -/libdis*
>> -/libuser
>> -/linux-headers/asm
>> -/qga/qapi-generated
>> -/qapi-gen-timestamp
>> -/qapi/qapi-builtin-types.[ch]
>> -/qapi/qapi-builtin-visit.[ch]
>> -/qapi/qapi-commands-*.[ch]
>> -**/qapi/qapi-commands.[ch]
>> -**/qapi/qapi-emit-events.[ch]
>> -/qapi/qapi-events-*.[ch]
>> -**/qapi/qapi-events.[ch]
>> -**/qapi/qapi-init-commands.[ch]
>> -**/qapi/qapi-introspect.[ch]
>> -/qapi/qapi-types-*.[ch]
>> -**/qapi/qapi-types.[ch]
>> -/qapi/qapi-visit-*.[ch]
>> -!/qapi/qapi-visit-core.c
>> -**/qapi/qapi-visit.[ch]
>> -**/qapi/qapi-doc.texi
>> -/qemu-edid
>> -/qemu-img
>> -/qemu-nbd
>> -/qemu-options.def
>> -/qemu-options.texi
>> -/qemu-img-cmds.texi
>> -/qemu-img-cmds.h
>> -/qemu-io
>> -/qemu-ga
>> -/qemu-bridge-helper
>> -/qemu-keymap
>> -/qemu-monitor.texi
>> -/qemu-monitor-info.texi
>> -/qemu-storage-daemon
>> -/qemu-version.h
>> -/qemu-version.h.tmp
>> -/module_block.h
>> -/scsi/qemu-pr-helper
>> -/vhost-user-scsi
>> -/vhost-user-blk
>> -/vhost-user-gpu
>> -/vhost-user-input
>> -/fsdev/virtfs-proxy-helper
>> -*.tmp
>> -*.[1-9]
>> -*.a
>> -*.aux
>> -*.cp
>> -*.exe
>> -*.msi
>> -*.dll
>> -*.so
>> -*.fn
>> -*.ky
>> -*.log
>> -*.pdf
>> -*.pod
>> -*.cps
>> -*.fns
>> -*.kys
>> -*.pg
>> -*.pyc
>> -*.toc
>> -*.tp
>> -*.vr
>> -*.d
> 
> Yeah!
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>> -!/.gitlab-ci.d
>> -!/scripts/qemu-guest-agent/fsfreeze-hook.d
>> -*.o
>>  .sdk
>> -*.gcda
>> -*.gcno
>> -*.gcov
>> -/pc-bios/bios-pq/status
>> -/pc-bios/edk2-*.fd
>> -/pc-bios/vgabios-pq/status
>> -/pc-bios/optionrom/linuxboot.asm
>> -/pc-bios/optionrom/linuxboot.bin
>> -/pc-bios/optionrom/linuxboot.raw
>> -/pc-bios/optionrom/linuxboot.img
>> -/pc-bios/optionrom/linuxboot_dma.asm
>> -/pc-bios/optionrom/linuxboot_dma.bin
>> -/pc-bios/optionrom/linuxboot_dma.raw
>> -/pc-bios/optionrom/linuxboot_dma.img
>> -/pc-bios/optionrom/pvh.asm
>> -/pc-bios/optionrom/pvh.bin
>> -/pc-bios/optionrom/pvh.raw
>> -/pc-bios/optionrom/pvh.img
>> -/pc-bios/optionrom/multiboot.asm
>> -/pc-bios/optionrom/multiboot.bin
>> -/pc-bios/optionrom/multiboot.raw
>> -/pc-bios/optionrom/multiboot.img
>> -/pc-bios/optionrom/kvmvapic.asm
>> -/pc-bios/optionrom/kvmvapic.bin
>> -/pc-bios/optionrom/kvmvapic.raw
>> -/pc-bios/optionrom/kvmvapic.img
>> -/pc-bios/s390-ccw/s390-ccw.elf
>> -/pc-bios/s390-ccw/s390-ccw.img
>> -/docs/built
>> -/docs/interop/qemu-ga-qapi.texi
>> -/docs/interop/qemu-ga-ref.html
>> -/docs/interop/qemu-ga-ref.info*
>> -/docs/interop/qemu-ga-ref.txt
>> -/docs/interop/qemu-qmp-qapi.texi
>> -/docs/interop/qemu-qmp-ref.html
>> -/docs/interop/qemu-qmp-ref.info*
>> -/docs/interop/qemu-qmp-ref.txt
>> -/docs/version.texi
>> -/contrib/vhost-user-gpu/50-qemu-gpu.json
>> -*.tps
>>  .stgit-*
>>  .git-submodule-status
>>  cscope.*
>>  tags
>>  TAGS
>> -docker-src.*
>>  *~
>>  *.ast_raw
>>  *.depend_raw
>> -trace.c
>> -trace-ust.h
>> -trace-ust.h
>> -trace-dtrace.h
>> -trace-dtrace.dtrace
>> -trace-root.h
>> -trace-root.c
>> -trace-ust-root.h
>> -trace-ust-root.h
>> -trace-ust-all.h
>> -trace-ust-all.c
>> -trace-dtrace-root.h
>> -trace-dtrace-root.dtrace
>> -trace-ust-all.h
>> -trace-ust-all.c
>> -/target/arm/decode-sve.c.inc
>>
> 


