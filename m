Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E52DC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 09:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C70206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 09:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzqqORQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C70206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH1el-0001s0-R6
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 05:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kH1dt-00015S-8a
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 05:16:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kH1dr-0007L9-Ai
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 05:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599902178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33U7r5nkTKWdKhIFSi84WrqS3xprdPkfWtDOBehv8ko=;
 b=NzqqORQKX7rFGBBxeuY020CrqIJCgiGYV8KjxAttvto68hwUrMdkBlDNoL3cjqRe6PXcjs
 sbOzTiZxmEvmkh2MUsenn9gEUi6RB8OeLyGVb3I1JUBPOXRPa6KyUfJk/A+/ZdutJCr2as
 yTBGrTlTqZCm0MbLSp4eEBW/QuvqfkI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-to0-lK4AN7qmy8lxVuWHWA-1; Sat, 12 Sep 2020 05:16:16 -0400
X-MC-Unique: to0-lK4AN7qmy8lxVuWHWA-1
Received: by mail-ed1-f71.google.com with SMTP id d27so6392654edj.21
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 02:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=33U7r5nkTKWdKhIFSi84WrqS3xprdPkfWtDOBehv8ko=;
 b=pFntJI3HVwOx2lH+13u2FIpUmKKtSaFdxH3+T5Mw8pkLSyzDCXIIghLLqypMxCceHr
 ro/50QIsA+HpgJdb4cQn27jIVWczLnIb95CG8+gfAfQ/VKoFc9+oVmVT35cXrY0lpRsf
 swNgSm/yE0v0Heaffc0PddFcu0UgcHbnfpClCSvid7Ma8nZW8Ju5jFQKrlk4k5iec6Nt
 GSbgW3l1GkPksZXvPUddqhdtbOD/D2fto2cDpQByRmk4jFBp4jsf5JwvTiDEy354N3Om
 oQVes32l5IY7pHdu238KitL8XNC8q6midKokyWIGIsUPLhLhIDvy+NzsHrIEBPBwxPUz
 MQNg==
X-Gm-Message-State: AOAM531C9d/hBb93Hk8VUi2JDevqJMyUaJ6QEyAHTCA2cQK7Zpvnk5lw
 TpfkD8yBJU5orqqoXy1gJZqX/AFz1bfCS92T/II7a5Yw8RLY54FHSJzhu3EGv0ZSZRHnF9VwR1Z
 0e/iuJe9IV2FjzpU=
X-Received: by 2002:a50:bb65:: with SMTP id y92mr7182168ede.53.1599902175476; 
 Sat, 12 Sep 2020 02:16:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUWulKcnenV3+QmWT/UEyHixk7euFJh+Q3MO5WejQTr+ghO7NO5+k9vtSLOGDz25ysPsSZAA==
X-Received: by 2002:a50:bb65:: with SMTP id y92mr7182145ede.53.1599902175321; 
 Sat, 12 Sep 2020 02:16:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8825:3b3:6c1e:a82d?
 ([2001:b07:6468:f312:8825:3b3:6c1e:a82d])
 by smtp.gmail.com with ESMTPSA id r16sm4246046edc.57.2020.09.12.02.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 02:16:14 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] user-mode: Prune build dependencies (part 2)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200910152225.524322-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8c9c94c-9b27-6c16-bde1-1a0a91287563@redhat.com>
Date: Sat, 12 Sep 2020 11:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910152225.524322-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 05:14:35
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/20 17:22, Philippe Mathieu-Daudé wrote:
> This is the second part of a series reducing user-mode
> dependencies. By stripping out unused code, the build
> and testing time is reduced (as is space used by objects).
> 
> Part 2:
> - Extract code not related to user-mode from qapi/misc.json
> 
> Since v3:
> - Rebased (Meson)
> - Addressed Markus comments:
>   - Use g_assert_not_reached() in stub
>   - Add commit descriptions
>   - Extract ACPI / PCI
>   - MEMORY not extracted as no feedback from Igor/MST
> 
> Since v2:
> - Addressed Igor review comments (move query-uuid to machine)
> - Addressed David review comments (fix balloon documentation)
> 
> Since v1:
> - Do not extract the 'add_client' command (elmarco)
> 
> CI:
> https://gitlab.com/philmd/qemu/-/pipelines/188367944
> 
> Philippe Mathieu-Daudé (9):
>   target/i386: Restrict X86CPUFeatureWord to X86 targets
>   qapi: Restrict LostTickPolicy enum to machine code
>   qapi: Correct balloon documentation
>   qapi: Restrict balloon-related commands to machine code
>   qapi: Restrict query-vm-generation-id command to machine code
>   qapi: Restrict query-uuid command to machine code
>   qapi: Restrict device memory commands to machine code
>   qapi: Extract ACPI commands to 'acpi.json'
>   qapi: Extract PCI commands to 'pci.json'
> 
>  qapi/acpi.json                       | 141 +++++
>  qapi/machine-target.json             |  45 ++
>  qapi/machine.json                    | 430 ++++++++++++--
>  qapi/misc.json                       | 820 ---------------------------
>  qapi/pci.json                        | 316 +++++++++++
>  qapi/qapi-schema.json                |   2 +
>  include/hw/acpi/acpi_dev_interface.h |   2 +-
>  include/hw/mem/memory-device.h       |   2 +-
>  include/hw/rtc/mc146818rtc.h         |   2 +-
>  include/hw/virtio/virtio-pmem.h      |   2 +-
>  include/sysemu/balloon.h             |   2 +-
>  block/iscsi.c                        |   2 +-
>  hw/acpi/core.c                       |   2 +-
>  hw/acpi/cpu.c                        |   2 +-
>  hw/acpi/memory_hotplug.c             |   3 +-
>  hw/acpi/vmgenid.c                    |   2 +-
>  hw/core/qdev-properties.c            |   1 +
>  hw/i386/kvm/i8254.c                  |   2 +-
>  hw/pci/pci-stub.c                    |   2 +-
>  hw/pci/pci.c                         |   2 +-
>  hw/virtio/virtio-balloon.c           |   2 +-
>  hw/virtio/virtio-mem-pci.c           |   1 +
>  monitor/hmp-cmds.c                   |   2 +
>  monitor/qmp-cmds.c                   |   1 +
>  softmmu/balloon.c                    |   2 +-
>  stubs/uuid.c                         |   2 +-
>  stubs/vmgenid.c                      |   2 +-
>  target/i386/cpu.c                    |   2 +-
>  target/i386/machine-stub.c           |  23 +
>  MAINTAINERS                          |   2 +
>  qapi/meson.build                     |   2 +
>  target/i386/meson.build              |   1 +
>  32 files changed, 944 insertions(+), 880 deletions(-)
>  create mode 100644 qapi/acpi.json
>  create mode 100644 qapi/pci.json
>  create mode 100644 target/i386/machine-stub.c
> 

I'm not sure about the first.  It's a bit ugly to have a property whose
getter aborts.

For patches 2-9 though:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


