Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB4C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 15:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A167206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 15:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmpti/B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A167206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imJvA-0000Oc-48
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 10:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imJuW-0008Ho-73
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imJuS-0007X2-R2
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:58:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imJuR-0007Pm-WB
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577807894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HwbGIU1N8EAavXtV1pjR0F4a/t5As6SmniJ8cEwT67U=;
 b=Tmpti/B/OUp170mjHcJWU+mM+LnSNdQh2YJCOugmBmAEdhAUVokrG9yXOFqpPfB9C1s9QK
 vf08zjKa3tsovvNvm4K3VbO328Yj6voyg6qI8m6QH7lfuJFi8zGRY44KHlKqYAJX/Kmu5w
 rsgkdI1boxzedXRqn6fMh2o1rwKB89c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-PWHb541EMnirMgfi0KHHzA-1; Tue, 31 Dec 2019 10:58:13 -0500
Received: by mail-wr1-f72.google.com with SMTP id d8so12768785wrq.12
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 07:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HwbGIU1N8EAavXtV1pjR0F4a/t5As6SmniJ8cEwT67U=;
 b=sNCiVz0bFyEYmUYPnx4vmZJWf7eYnN+3GB6p5T97udZkNxQ5sO3MgL/aDOelO3HEi/
 J1ULoj0djg+O0o0Ezdrr94V5oqm510bcZNKpKPsu4rz4O3lhjTkHb3cETLWYP9ur+OEh
 6u0R73CdM+0687Ec4dB8EXyGDWvkR8rrVMy0XBMJezOAqsj+0lsgSCZwotuzbWKO/Loh
 7VdZEalreyBypu1VhcNNmPEeRgJC1ZbroLnrunoExEhywczCKph7rIOx1mFpJ7za/cNC
 C45ikMziyGR/HWTu0lBsHMc4Ajiexn6L8iMrncTCAdugGOw1QkZcjCHHCTF3mirBM/1i
 RTSg==
X-Gm-Message-State: APjAAAXhiRV0acoZ+6Cyw/3D3+HkwwtDuxqVnorZ0JUNOh8E0PmntjWd
 cvdsNud0DN9XgRUoFzHJ8KNJwxWC3u5cX2/asw+OVW2SfCfhjxntIDD7LuG5H/iJKkIidNZY7Ol
 +0P42O850epfL/oY=
X-Received: by 2002:a5d:6441:: with SMTP id d1mr72904822wrw.93.1577807891884; 
 Tue, 31 Dec 2019 07:58:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrVCbbh+o2lW16W5a5x9EU0td4NQ18yAhVDk39MAVeBx6uTTE2dMn5b5zPAjrKWfGjhiQkpQ==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr72904792wrw.93.1577807891574; 
 Tue, 31 Dec 2019 07:58:11 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id o4sm48700297wrx.25.2019.12.31.07.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 07:58:11 -0800 (PST)
Subject: Re: [PATCH 00/86] refactor main RAM allocation to use hostmem backend
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2d1f51d-a204-ec82-1b0a-bf91161b819f@redhat.com>
Date: Tue, 31 Dec 2019 16:58:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: PWHb541EMnirMgfi0KHHzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Hi Igor,

On 12/31/19 2:02 PM, Igor Mammedov wrote:
> Series removes ad hoc RAM allocation API (memory_region_allocate_system_memory)
> and consolidates it around hostmem backend. It allows to
>   * resolve conflicts between global -mem-prealloc and hostmem's "policy" option
>     fixing premature allocation before binding policy is applied
>   * simplify complicated memory allocation routines which had to deal with 2 ways
>     to allocate RAM.
>   * it allows to reuse hostmem backends of a choice for main RAM without adding
>     extra CLI options to duplicate hostmem features.
>     Recent case was -mem-shared, to enable vhost-user on targets that don't
>     support hostmem backends [1] (ex: s390)
>   * move RAM allocation from individual boards into generic machine code and
>     provide them with prepared MemoryRegion.
>   * clean up deprecated NUMA features which were tied to the old API (see patches)
>      - "numa: remove deprecated -mem-path fallback to anonymous RAM"
>      - "numa: remove deprecated implicit RAM distribution between nodes"
>      - "forbid '-numa node,mem' for 5.0 and newer machine types"
> 
> Conversion introduces a new machine.ram-memdev property and wrapper code that
> aliases global -mem-path and -mem-alloc into automatically created hostmem
> backend properties (provided ram-memdev was not set explicitly by user).
> And then follows bulk of trivial patches that incrementally convert individual
> boards to using machine.ram-memdev provided MemoryRegion.
> 
> Board conversion typically involves:
>   * providing MachineClass::default_ram_size and MachineClass::default_ram_id
>     so generic code could create default backend if user didn't explicitly provide
>     ram-memdev or -m options
>   * dropping memory_region_allocate_system_memory() call
>   * using covinience MachineState::ram MemoryRegion, which points to MemoryRegion
>     allocated by ram-memdev
> On top of that for some boards:
>   * added missing ram_size checks (typically it were boards with fixed ram size)
>   * ram_size fixups were replaced by checks and hard errors, forcing user to
>     provide correct "-m" values instead of ignoring it and continuing running.
>     
> After all boards are converted the old API is removed and memory allocation
> routines are cleaned up.

I'm replying to the cover because multiple patches are concerned.

Compiling arm/lm32/mips64el/ppc on 32-bit host I get:

   CC      hw/arm/digic_boards.o
hw/arm/digic_boards.c: In function 'digic4_board_init':
hw/arm/digic_boards.c:57:22: error: format '%lli' expects argument of 
type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned 
int}' [-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/arm/digic_boards.o' failed
make: *** [hw/arm/digic_boards.o] Error 1
   CC      hw/arm/musicpal.o
hw/arm/musicpal.c: In function 'musicpal_init':
hw/arm/musicpal.c:1598:22: error: format '%lli' expects argument of type 
'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}' 
[-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/arm/musicpal.o' failed
make: *** [hw/arm/musicpal.o] Error 1
   CC      hw/arm/nseries.o
hw/arm/nseries.c: In function 'n8x0_init':
hw/arm/nseries.c:1316:22: error: format '%lli' expects argument of type 
'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}' 
[-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/arm/nseries.o' failed
make: *** [hw/arm/nseries.o] Error 1
   CC      hw/arm/omap_sx1.o
hw/arm/omap_sx1.c: In function 'sx1_init':
hw/arm/omap_sx1.c:119:22: error: format '%lli' expects argument of type 
'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}' 
[-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/arm/omap_sx1.o' failed
make: *** [hw/arm/omap_sx1.o] Error 1
   CC      hw/arm/palm.o
hw/arm/palm.c: In function 'palmte_init':
hw/arm/palm.c:202:22: error: format '%lli' expects argument of type 
'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}' 
[-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/arm/palm.o' failed
make: *** [hw/arm/palm.o] Error 1
   CC      hw/arm/collie.o
hw/arm/collie.c: In function 'collie_init':
hw/arm/collie.c:32:22: error: format '%lli' expects argument of type 
'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}' 
[-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/arm/collie.o' failed
make: *** [hw/arm/collie.o] Error 1
   CC      hw/arm/mps2.o
hw/arm/mps2.c: In function 'mps2_common_init':
hw/arm/mps2.c:121:22: error: format '%lli' expects argument of type 
'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}' 
[-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/arm/mps2.o' failed
make: *** [hw/arm/mps2.o] Error 1
   CC      hw/arm/mps2-tz.o
hw/arm/mps2-tz.c: In function 'mps2tz_common_init':
hw/arm/mps2-tz.c:391:22: error: format '%lli' expects argument of type 
'long long int', but argument 2 has type 'ram_addr_t {aka unsigned int}' 
[-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/arm/mps2-tz.o' failed
make: *** [hw/arm/mps2-tz.o] Error 1
   CC      hw/lm32/lm32_boards.o
hw/lm32/lm32_boards.c: In function 'lm32_evr_init':
hw/lm32/lm32_boards.c:89:22: error: format '%lli' expects argument of 
type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned 
int}' [-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
hw/lm32/lm32_boards.c: In function 'lm32_uclinux_init':
hw/lm32/lm32_boards.c:179:22: error: format '%lli' expects argument of 
type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned 
int}' [-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/lm32/lm32_boards.o' failed
make: *** [hw/lm32/lm32_boards.o] Error 1
   CC      hw/lm32/milkymist.o
hw/lm32/milkymist.c: In function 'milkymist_init':
hw/lm32/milkymist.c:100:22: error: format '%lli' expects argument of 
type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned 
int}' [-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
   CC      hw/mips/mips_fulong2e.o
hw/mips/mips_fulong2e.c: In function 'mips_fulong2e_init':
hw/mips/mips_fulong2e.c:317:22: error: format '%ld' expects argument of 
type 'long int', but argument 2 has type 'long long int' [-Werror=format=]
          error_report("Invalid RAM size, should be %ld", 256 * MiB);
                       ^
cc1: all warnings being treated as errors
   CC      hw/ppc/ppc405_boards.o
hw/ppc/ppc405_boards.c: In function 'ref405ep_init':
hw/ppc/ppc405_boards.c:165:22: error: format '%lli' expects argument of 
type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned 
int}' [-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
hw/ppc/ppc405_boards.c: In function 'taihu_405ep_init':
hw/ppc/ppc405_boards.c:435:22: error: format '%lli' expects argument of 
type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned 
int}' [-Werror=format=]
          error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/ppc/ppc405_boards.o' failed
make: *** [hw/ppc/ppc405_boards.o] Error 1
   CC      hw/ppc/ppc4xx_devs.o
hw/ppc/ppc4xx_devs.c: In function 'ppc4xx_sdram_adjust':
hw/ppc/ppc4xx_devs.c:704:39: error: format '%lli' expects argument of 
type 'long long int', but argument 3 has type 'ram_addr_t {aka const 
unsigned int}' [-Werror=format=]
              char *t = g_strdup_printf("%s%" PRIi64 "%s", s, 
sdram_bank_sizes[i],
                                        ^
hw/ppc/ppc4xx_devs.c:709:22: error: format '%lli' expects argument of 
type 'long long int', but argument 2 has type 'ram_addr_t {aka unsigned 
int}' [-Werror=format=]
          error_report("Invalid RAM size, unable to fit all RAM into RAM 
banks"
                       ^
cc1: all warnings being treated as errors
rules.mak:69: recipe for target 'hw/ppc/ppc4xx_devs.o' failed
make: *** [hw/ppc/ppc4xx_devs.o] Error 1
   CC      hw/ppc/e500.o
hw/ppc/e500.c: In function 'ppce500_init':
hw/ppc/e500.c:909:22: error: format '%ld' expects argument of type 'long 
int', but argument 2 has type 'long long int' [-Werror=format=]
          error_report("RAM size must be multiple of %ld", RAM_SIZES_ALIGN);
                       ^
cc1: all warnings being treated as errors


