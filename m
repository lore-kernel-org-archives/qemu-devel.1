Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70011C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E5820866
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXxK/FiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E5820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqRr-000178-Id
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqR7-0000Cq-Ko
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kAqR5-0004bb-U9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598429135;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFDWzhffgHT0QS8qC9AD7o9JYYlIaLMf7gtouYw5uzA=;
 b=JXxK/FiTyI0m/xuniIy4AklDMEm2xX5OlRs1s0o1ctLRn1mPnHHsLv+SbUZZT0zdq2Ydz9
 +ri6kVHotkLFlRMtpEx9chfOfTFovUjPWgTYxOm9SD49t/BI++fSjLQ0AS6/G6AwI5D8lr
 1zU2n0Xc7Zxv9IVasAf6iMj2gxL0yKY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-klFzA_npOTaJC7g9Ts83iA-1; Wed, 26 Aug 2020 04:05:31 -0400
X-MC-Unique: klFzA_npOTaJC7g9Ts83iA-1
Received: by mail-wr1-f69.google.com with SMTP id b18so234847wrn.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 01:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NImKQq5ezsHefkpdy9SfbA9+4hFpj3XxE5AoedYCYBg=;
 b=UQLx30KGkCRE1JpPk8Wut3F8BmAZ3tolLRBqDBeOKl4jtC0u6QWqN90EFe/KhPjGO2
 ipIMGqWHE7I8FfWWaVhct6SGSXZKkBMpFVLuRfDCkJ7tUcjextgdhaHwY7LKELOIjpAA
 nkKc+NRIGzT8ESlqmXI70VviIene29GasBobaf3p7jxu+tAPWhDNa6whhLzNArUwB9qp
 zKZFkjuWFlH0QLZ30RRgCAxrFgvw9MNWV9ZdTEgBTxswU8OOrcssPU63QbzO0PoH0AIl
 256BrbvCu/Nqlz1kWFNtvPbQLWEaV61uMufa2/pu41vH4Qd7QvLjPof6wRT3Jqt3ylMr
 qkTQ==
X-Gm-Message-State: AOAM531NDvvAkQtDgLEKo04xGkX1Q42Tuj9ICxBlwbaY86BF9E2S0gYz
 RVtHFRgUWAci5Q45phET0SOgu27rODr5wNFUstu+adpVzebKw4P4rZovpdUYDgsS2HNwZtnFO+B
 rKPfgfF6pQB14EUA=
X-Received: by 2002:adf:eec4:: with SMTP id a4mr14022211wrp.325.1598429130568; 
 Wed, 26 Aug 2020 01:05:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgV0qEJw4SvfJJWICezdAreWgvFDuo0MZfhubnxoYYQuYepB/xRHiBkFBXO890vClnc3da7Q==
X-Received: by 2002:adf:eec4:: with SMTP id a4mr14022174wrp.325.1598429130323; 
 Wed, 26 Aug 2020 01:05:30 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id d11sm4063512wrw.77.2020.08.26.01.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 01:05:29 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 64/74] [automated] Move QOM typedefs and add missing
 includes
In-Reply-To: <20200825192110.3528606-65-ehabkost@redhat.com> (Eduardo
 Habkost's message of "Tue, 25 Aug 2020 15:21:00 -0400")
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-65-ehabkost@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 26 Aug 2020 10:05:28 +0200
Message-ID: <87o8mxygqf.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Cc: qemu-riscv@nongnu.org, kvm@vger.kernel.org, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


[dropped people from CC]

Eduardo Habkost <ehabkost@redhat.com> wrote:
> Some typedefs and macros are defined after the type check macros.
> This makes it difficult to automatically replace their
> definitions with OBJECT_DECLARE_TYPE.
>
> Patch generated using:
>
>  $ ./scripts/codeconverter/converter.py -i \
>    --pattern=3DQOMStructTypedefSplit $(git grep -l '' -- '*.[ch]')
>
> which will split "typdef struct { ... } TypedefName"
> declarations.
>
> Followed by:
>
>  $ ./scripts/codeconverter/converter.py -i --pattern=3DMoveSymbols \
>     $(git grep -l '' -- '*.[ch]')
>
> which will:
> - move the typedefs and #defines above the type check macros
> - add missing #include "qom/object.h" lines if necessary
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3:
> * Removed hunks due to rebase conflicts: hw/arm/integratorcp.c
>   hw/arm/versatilepb.c hw/arm/vexpress.c hw/sd/pl181.c
>   include/hw/ppc/xive.h
> * Removed hunks due to conflicts with other patches in this
>   series: include/hw/block/swim.h include/hw/display/macfb.h
>   include/hw/rdma/rdma.h migration/migration.h
>   target/rx/cpu-qom.h
> * Reviewed-by line from Daniel was kept, as no additional hunks
>   are introduced in this version
>
> Changes v1 -> v2:
> * Re-ran script after moving a few macros and typedefs.  Now the
>   patch also changes:
>   - SysbusAHCIState at hw/ide/ahci.h
>   - VhostUserGPU at hw/virtio/virtio-gpu.h
>   - I8257State at hw/dma/i8257.h
>   - AllwinnerAHCIState at hw/ide/ahci.h
>   - ISAKBDState at hw/input/i8042.h
>   - PIIXState at hw/southbridge/piix.h
>   - VFIOPCIDevice at hw/vfio/pci.h
>   - missing include at hw/net/rocker/rocker.h
>   - missing include at hw/scsi/mptsas.h
>   - missing include at include/hw/arm/pxa.h
>   - missing include at include/sysemu/kvm.h
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

> diff --git a/migration/rdma.c b/migration/rdma.c
> index 15ad985d26..e3eac913bc 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -35,6 +35,7 @@
>  #include <arpa/inet.h>
>  #include <rdma/rdma_cma.h>
>  #include "trace.h"
> +#include "qom/object.h"
> =20
>  /*
>   * Print and error on both the Monitor and the Log file.
> @@ -397,10 +398,10 @@ typedef struct RDMAContext {
>  } RDMAContext;
> =20
>  #define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
> +typedef struct QIOChannelRDMA QIOChannelRDMA;
>  #define QIO_CHANNEL_RDMA(obj)                                     \
>      OBJECT_CHECK(QIOChannelRDMA, (obj), TYPE_QIO_CHANNEL_RDMA)
> =20
> -typedef struct QIOChannelRDMA QIOChannelRDMA;
> =20
> =20
>  struct QIOChannelRDMA {

Reviewed-by: Juan Quintela <quintela@redhat.com>


