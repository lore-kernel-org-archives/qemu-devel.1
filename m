Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CF3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D1222243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8ufQSks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D1222243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZwYc-00042w-0j
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 08:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZwWk-0003Ke-Tr
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:39:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZwWh-0003Qf-QV
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604410746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1f5+xH4i2m0AowV9ik36IATx8cpsYqDLWw7xKLhClVQ=;
 b=Y8ufQSks/CDNJG2LiUjmNgjqsrGVbVHhsQB0aXChWVY3dDRJqUqxMQVVZb07peKUUls7VM
 NaVF+TMFmS9l4An7OHb49z3E9FDmgI0NerVjLmnJjg85cJDPRegKQh59kdJOec3UvfYRDH
 FsJEAs4ULSGNsIQ7WKMBj7At82AqWMU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-tGY1n_9UOx2gJXsQ6f4vzA-1; Tue, 03 Nov 2020 08:39:03 -0500
X-MC-Unique: tGY1n_9UOx2gJXsQ6f4vzA-1
Received: by mail-wm1-f71.google.com with SMTP id 13so4623943wmf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 05:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1f5+xH4i2m0AowV9ik36IATx8cpsYqDLWw7xKLhClVQ=;
 b=LAAktbO2jRVuKU9ZqrvTkoa78LKdD/DKTzDe1jsTNkY5pbQzLjJuDFr50TZISDqemR
 J/z/dXh06GlwfaAUL+cl6LEEyxDrr4eO0Nr6zhF7KOrDKGx1WksTbyOokycVz+D4C7t7
 IGWk+kEbIpVNciA+D6XqfGjI33T1fWtu49ZlNCKNyFw8+fkTKzcBW7/SPq3n7yB2d9u6
 Je19VtUXXue5Urt9GAZXYjIMKj+B1kXYRx/bOoqALuT8hexT6CLpZkCdww3p4z4mIaKO
 9VktEjIOsav1wyZvjNIJIWIh+Z/pDSnl9vVrlvXa1fRQobX7BBR/szb5zlmiiwn1I4HI
 YjgA==
X-Gm-Message-State: AOAM531MDOCg0Y5se0jlUZQmKq5HAtilab6d9uQhQvaybq2QflsEXwPJ
 LR+2BbkH67tsWums1QsUURI9nYsorDSDuKm0/PXnsD/JPmodh1T4vB/BrO2CfoGwESV7X1IhGAf
 xoMbRz6hW2NTiUSk=
X-Received: by 2002:a5d:61ce:: with SMTP id q14mr25391258wrv.378.1604410742812; 
 Tue, 03 Nov 2020 05:39:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQTXRvo3kL/qteTl4LmJy1IKSBnUtNSYDZhICs0qraSpXBrauDUy4Dxo+pDBQf7+mS41dyuA==
X-Received: by 2002:a5d:61ce:: with SMTP id q14mr25391237wrv.378.1604410742559; 
 Tue, 03 Nov 2020 05:39:02 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id j9sm26188673wrp.59.2020.11.03.05.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 05:39:01 -0800 (PST)
Subject: Re: [PULL v8 062/152] meson: infrastructure for building emulators
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200821102329.29777-1-pbonzini@redhat.com>
 <20200821102329.29777-63-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f896a0d5-721e-2346-58c2-38e26c2c352e@redhat.com>
Date: Tue, 3 Nov 2020 14:39:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200821102329.29777-63-pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 12:21 PM, Paolo Bonzini wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile               |  74 ++----------------
>  Makefile.target        |  19 +++--
>  configure              |   6 --
>  hw/i386/fw_cfg.c       |   2 +-
>  hw/i386/pc.c           |   2 +-
>  hw/i386/pc_piix.c      |   2 +-
>  hw/i386/x86.c          |   2 +-
>  hw/vfio/pci-quirks.c   |   2 +-
>  hw/virtio/virtio-mem.c |   2 +-
>  include/qemu/osdep.h   |   2 +-
>  meson.build            | 166 ++++++++++++++++++++++++++++++++++++++++-
>  rules.mak              |   8 --
>  scripts/create_config  |   2 +
>  scripts/grepy.sh       |   3 +
>  scripts/minikconf.py   |   0
>  softmmu/qtest.c        |   2 +-
>  16 files changed, 192 insertions(+), 102 deletions(-)
>  create mode 100755 scripts/grepy.sh
>  mode change 100755 => 100644 scripts/minikconf.py
...

> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index c55abfb01a..33441ad484 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -22,7 +22,7 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "e820_memory_layout.h"
>  #include "kvm_i386.h"
> -#include "config-devices.h"
> +#include CONFIG_DEVICES

Suggestion: add a comment to this include, because it is hard to
figure out what it does (if you don't have minikconf + meson
background). At least it was not obvious to me. (other
occurrences in the codebase).

Regards,

Phil.


