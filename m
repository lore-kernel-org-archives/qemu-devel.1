Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF1C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB02C2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivB19W9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB02C2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j459h-0003PR-U7
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j458w-00030I-0v
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j458u-0007CY-Dh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:50:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j458u-0007C7-95
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582041035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9ndbJf79h4jM+tgyfijGzR+OopYFCFe3rnhfZHQ6uM=;
 b=ivB19W9Olyivs/m5SUGN2HjnQZKUJNldIesM+MqsuyTo8if8+QfngGaABilWpeT6M9QCIk
 LyFPDm4OnDp7BWbwO5O34p9/5hzgwS13SkavrujSBOLr/y2DQzxfYVyUMS6bxHduK/1yk3
 P1Cp6S7i5LeutxhFhl+nPEa7tXsXELE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-0ykcK67rMCi4OA53LzNQ1Q-1; Tue, 18 Feb 2020 10:50:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1832107ACC5
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 15:50:31 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B15D5DA60;
 Tue, 18 Feb 2020 15:50:31 +0000 (UTC)
Date: Tue, 18 Feb 2020 16:50:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 00/79] refactor main RAM allocation to use hostmem
 backend
Message-ID: <20200218165029.66d6ec1c@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 0ykcK67rMCi4OA53LzNQ1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Mon, 17 Feb 2020 12:33:33 -0500
Igor Mammedov <imammedo@redhat.com> wrote:

Paolo,

Can you merge this via your tree if possible, pls?
(You said that's about the time you'd be preparing pull req)

> v5:
>   - pick up new Reviewed-by-s
>   - drop "ppc/prep: use memdev for RAM" since machine was removed
>   - add patch "mips/mips_jazz: add max ram size check"
>   - extend comment for "default_ram_id" to clarify that's setting it serves
>     as optin flag for -m support. [03/79]
>   - rebase "arm/raspi: use memdev for RAM" once more
> 
> v4:
>   - pick up new Reviewed-by-s
>   - Fix access to uninitialized pagesize/hpsize in
>     "[PATCH REPOST v3 74/80] exec: cleanup  qemu_minrampagesize()/qemu_maxrampagesize()"
>   - Make explicitly provided memory-backend work by using string property instead
>     of link so it would be possible to delay access to the backend to the time
>     when backends are initialized.
>   - added new patches to make explicit backend work nice with -m and do sanity
>     check on ram_size
>       'vl.c: move -m parsing after memory backends has been processed'
>       'vl.c: ensure that ram_size matches size of machine.memory-backend"
>     all this ram_size business needs cleanup too, but that's out of the scope
>     of this series.
>   - include m68k/q800 board into conversion
>   - drop patches that were merged through other trees
> 
> v3:
>   - due to libvirt not being ready, postpone till 5.1
>      * [PATCH v2 82/86] numa: forbid '-numa node,  mem' for 5.0 and newer machine types
>      and depended
>        [PATCH v2 86/86] numa: remove deprecated implicit RAM distribution  between nodes
>   - drop as not related "[PATCH v2 85/86] numa: make exit() usage consistent"
>   - drop "[PATCH v2 76/86] post conversion default_ram_id cleanup"
>     so that default memory-backedend won't be created for boards that do not care
>     about -m. Which makes -m optin feature. We should decide  what do in  case
>     board doesn't use -m (but that's out of scope of this series)
>   - use object_register_sugar_prop() instead of hacking compat props directly
>   - simplified/reworked aspeed patches
>   - s/RAM_ADDR_FMT/size_to_str()/
>   - rename 'ram-memdev' property to 'memory-backend'
>   - minor fixes to numa-test
>   - fixes for issues noticed during review of
>        [PATCH v2 66/86] ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup
> 
> v2:
>   - fix compile errors on mingw32 host by introducing RAM_ADDR_UFMT [11/86]
>   - replace "[PATCH 43/86] hppa: drop RAM size fixup" with alternative
>     patches made by Philippe (which effectively do the same thing but other
>     way around)
>   - ppc440: fix crash and add suggested valid RAM size in error output.
>     s/ppc4xx_sdram_adjust/ppc4xx_sdram_prep/ and simplify it by removing
>     not necessary nested loop
>   - rebase on current master due to new conflicts
> 
> 
> Series removes ad hoc RAM allocation API (memory_region_allocate_system_memory)
> and consolidates it around hostmem backend. It allows to
>  * resolve conflicts between global -mem-prealloc and hostmem's "policy" option
>    fixing premature allocation before binding policy is applied
>  * simplify complicated memory allocation routines which had to deal with 2 ways
>    to allocate RAM.
>  * it allows to reuse hostmem backends of a choice for main RAM without adding
>    extra CLI options to duplicate hostmem features.
>    Recent case was -mem-shared, to enable vhost-user on targets that don't
>    support hostmem backends [1] (ex: s390)
>  * move RAM allocation from individual boards into generic machine code and
>    provide them with prepared MemoryRegion.
>  * clean up deprecated NUMA features which were tied to the old API (see patches)
>     - "numa: remove deprecated -mem-path fallback to anonymous RAM"
>     - (POSTPONED, waiting on libvirt side) "forbid '-numa node,mem' for 5.0 and newer machine types"
>     - (POSTPONED) "numa: remove deprecated implicit RAM distribution between nodes"
> 
> Conversion introduces a new machine.memory-backend property and wrapper code that
> aliases global -mem-path and -mem-alloc into automatically created hostmem
> backend properties (provided memory-backend was not set explicitly given by user).
> And then follows bulk of trivial patches that incrementally convert individual
> boards to using machine.memory-backend provided MemoryRegion.
> 
> Board conversion typically involves:
>  * providing MachineClass::default_ram_size and MachineClass::default_ram_id
>    so generic code could create default backend if user didn't explicitly provide
>    memory-backend or -m options
>  * dropping memory_region_allocate_system_memory() call
>  * using convenience MachineState::ram MemoryRegion, which points to MemoryRegion
>    allocated by ram-memdev
> On top of that for some boards:
>  * added missing ram_size checks (typically it were boards with fixed ram size)
>  * ram_size fixups were replaced by checks and hard errors, forcing user to
>    provide correct "-m" values instead of ignoring it and continuing running.
> 
> After all boards are converted the old API is removed and memory allocation
> routines are cleaned up.
> 
> git tree for testing:
>   https://github.com/imammedo/qemu convert_main_ram_to_memdev_v5
> 
> previous rev:
>   https://github.com/imammedo/qemu convert_main_ram_to_memdev_v4
> 
> CC: Paolo Bonzini <pbonzini@redhat.com>
> 
[...]


