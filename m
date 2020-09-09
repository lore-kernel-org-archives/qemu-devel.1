Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6257EC2D0E0
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40822080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cj/rL/Jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40822080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFpga-0001Ub-1w
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 22:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFpfU-0000ev-Cb
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 22:17:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45418
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFpfS-0007FM-Ov
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 22:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599617821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USmDx7kTijCclqTuiJGKfqhD+cCE/n+/SX8ndXPf/qA=;
 b=cj/rL/JycNtHxqHSitQFiZ1aD4s03Askvw186GaCvaxRYxkrs7VsoMA14Ehcl86O3pfrot
 hYoA1I2Brw3D1cPqCCTISzC9jBUW2JS1Oe20h11Q12jeA1F4utgSx8YPwEOUoUC4bC3TGQ
 A5E4oiATqRPDthOh7j7/tRX+3wgWuRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-pmunT8zpOhCsHI6YeYyJZg-1; Tue, 08 Sep 2020 22:16:59 -0400
X-MC-Unique: pmunT8zpOhCsHI6YeYyJZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B364107464A;
 Wed,  9 Sep 2020 02:16:58 +0000 (UTC)
Received: from [10.72.12.24] (ovpn-12-24.pek2.redhat.com [10.72.12.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28D115D9E8;
 Wed,  9 Sep 2020 02:16:49 +0000 (UTC)
Subject: Re: [RFC 0/4] Add a 'in_mmio' device flag to avoid the DMA to MMIO
To: Li Qiang <liq3ea@163.com>, dmitry.fleytman@gmail.com, kraxel@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 alxndr@bu.edu, peter.maydell@linaro.org, f4bug@amsat.org
References: <20200908164157.47108-1-liq3ea@163.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f50624b9-dac7-c6ab-cce9-71cd9de477e1@redhat.com>
Date: Wed, 9 Sep 2020 10:16:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908164157.47108-1-liq3ea@163.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 20:56:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/9 上午12:41, Li Qiang wrote:
> Currently the qemu device fuzzer find some DMA to MMIO issue. If the
> device handling MMIO currently trigger a DMA which the address is MMIO,
> this will reenter the device MMIO handler. As some of the device doesn't
> consider this it will sometimes crash the qemu.
>
> This patch tries to solve this by adding a per-device flag 'in_mmio'.
> When the memory core dispatch MMIO it will check/set this flag and when
> it leaves it will clean this flag.


What's the plan for fixing the irq issues pointed out by Peter?

Thanks


>
>
> Li Qiang (4):
>    memory: add memory_region_init_io_with_dev interface
>    memory: avoid reenter the device's MMIO handler while processing MMIO
>    e1000e: use the new memory_region_init_io_with_dev interface
>    hcd-xhci: use the new memory_region_init_io_with_dev interface
>
>   hw/net/e1000e.c        |  8 ++++----
>   hw/usb/hcd-xhci.c      | 25 ++++++++++++++---------
>   include/exec/memory.h  |  9 +++++++++
>   include/hw/qdev-core.h |  1 +
>   softmmu/memory.c       | 46 +++++++++++++++++++++++++++++++++++++++---
>   5 files changed, 72 insertions(+), 17 deletions(-)
>


