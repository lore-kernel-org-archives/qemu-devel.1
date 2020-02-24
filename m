Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1A5C35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776422080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKA0LEc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776422080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j69Nf-0000Dm-L4
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 03:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j69Mb-00085K-8X
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:45:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j69Ma-0008ER-11
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:45:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45798
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j69MZ-0008CL-T3
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582533915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvinuKTjDH3ztyabT5+VrlssgcGfo9pEET1m1zaHK6A=;
 b=FKA0LEc6coBm/2IKDZBQpqMKThdAMmaiTNPrVELKqQUwYZHh/3ut+oWo0HfOTLOUHrNKf4
 6ejoW9SQ2xQcc8iJsNa3rPnrIrUWwZupIQ1l6mnQ5y5yLDF6dsofT1syFyH1hVNbx1+2JO
 MpEvs5qJrdE7ZyT1CBd2VuhZXKS6IU0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-PEUu_1T3MauOQzToTHIT5w-1; Mon, 24 Feb 2020 03:45:13 -0500
X-MC-Unique: PEUu_1T3MauOQzToTHIT5w-1
Received: by mail-ed1-f71.google.com with SMTP id k6so6135017edq.8
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 00:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AvinuKTjDH3ztyabT5+VrlssgcGfo9pEET1m1zaHK6A=;
 b=RAOcgQkXWAks/PIPwCaMzXKIWP63kqkOXL2xirX1aOEWzGjrzNxdXnrbkUcZB7lzBo
 OvjBe3Q4BBhznUAA0TF0pwKC7JvnKfZITkEbrcqJH+t2NA0KAybDS59qovAcsT7auxOg
 u2USHl+fxZlm07bCSzWmhBYWn5RIoVMuXVnHm/XuTeFecrpUxGHIGsDry7/71Dpau1Sj
 RGy8t+WS/RosYvGfCAbO9PMHw6YQNZxOh2U5/crbGNR/O1pD73pXDxkAeFC+GT+Uz+bJ
 mFCh8iysaAm/sMB3PQbXHTi3dDTTVE8ieOkrpEHaICVdxyijcLW7bae2LytKbCRyPSJi
 DfIw==
X-Gm-Message-State: APjAAAWdrbIV1ORSm8dm+2BPWrvu9HkfdOrG1Sj9S/zCniZIwrI6EZOf
 06pwH/gQ8nVtFfJ7pxcpAiP0egHI5ERtGVptULX5p4VIKxJbN436wRk5X8cmiU+E+ctEh44v1Od
 3jueZMwy4nDBhJVA=
X-Received: by 2002:a05:6402:b9b:: with SMTP id
 cf27mr45339848edb.11.1582533912687; 
 Mon, 24 Feb 2020 00:45:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqEGw66owkHyVf5Kz1NRlAy9S8oDqeOi/bRG+wLL1zUCAjmUXpVdN8xHq9M9ZJpKcMriYp2Q==
X-Received: by 2002:a05:6402:b9b:: with SMTP id
 cf27mr45339837edb.11.1582533912432; 
 Mon, 24 Feb 2020 00:45:12 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r19sm939614edy.4.2020.02.24.00.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 00:45:11 -0800 (PST)
Subject: Re: [PATCH v6 00/79] refactor main RAM allocation to use hostmem
 backend
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200219160953.13771-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <09a2f9da-998c-545b-ea15-f1ae3490fb54@redhat.com>
Date: Mon, 24 Feb 2020 09:45:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 2/19/20 5:08 PM, Igor Mammedov wrote:
[...]
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
>      - (POSTPONED, waiting on libvirt side) "forbid '-numa node,mem' for 5.0 and newer machine types"
>      - (POSTPONED) "numa: remove deprecated implicit RAM distribution between nodes"
> 
> Conversion introduces a new machine.memory-backend property and wrapper code that
> aliases global -mem-path and -mem-alloc into automatically created hostmem
> backend properties (provided memory-backend was not set explicitly given by user).
> And then follows bulk of trivial patches that incrementally convert individual
> boards to using machine.memory-backend provided MemoryRegion.
> 
> Board conversion typically involves:
>   * providing MachineClass::default_ram_size and MachineClass::default_ram_id
>     so generic code could create default backend if user didn't explicitly provide
>     memory-backend or -m options
>   * dropping memory_region_allocate_system_memory() call
>   * using convenience MachineState::ram MemoryRegion, which points to MemoryRegion
>     allocated by ram-memdev
> On top of that for some boards:
>   * added missing ram_size checks (typically it were boards with fixed ram size)
>   * ram_size fixups were replaced by checks and hard errors, forcing user to
>     provide correct "-m" values instead of ignoring it and continuing running.
> 
> After all boards are converted the old API is removed and memory allocation
> routines are cleaned up.

I wonder about the pre-QOM machines. As they don't call 
memory_region_allocate_system_memory(), the conversion is not required? 
(See for example pxa270_init).


