Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFBEC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F5D2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/r+oscZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F5D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFNH8-00082a-CH
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 15:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jFNGC-0007ON-VM
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jFNGB-0003GQ-RY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:24:48 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:46989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jFNGB-0003FH-LU; Fri, 20 Mar 2020 15:24:47 -0400
Received: by mail-qv1-xf41.google.com with SMTP id m2so3601912qvu.13;
 Fri, 20 Mar 2020 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FOvd847W0q0TdYoTAUUAvSlonLs5p3GVpVVE/l1dbiY=;
 b=d/r+oscZLrJOrrPFMuCH5lwT8HdSWChgdC5brD3Hc5po3VWNugsz1YnhCeZjY0/Tsk
 VzSKouflzWKshNlyblKbdvDssNvz3duI4M1BdrAU1jiRQOAo5g1wmaBAoFl1tambsRtr
 jzmnaPpu/9wVYmp1vleRfUVkUnYyANwV46qFTm8DSiG9sKcGVr3bx94XTukB6gGKsrJ2
 O1xqVV5MH4nXlFxajmDPUskbTW4SVT/gfICq3m/G+rqKPzI+5SxRlMhAIH9n3DE30wEq
 M8LGRngnyYoxmsNzDqyX5ZhmwEzS0S7z9YNnsX8Z5SI/M/nlMJBwZDXTGiPbU4v3aII9
 95PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FOvd847W0q0TdYoTAUUAvSlonLs5p3GVpVVE/l1dbiY=;
 b=ttfu5YHJJU+7RKsaha5SqJ0azOUjQumz40Ktx2RqDcIvkF2+X4CVE70OGhqE1cAd/1
 J/DSCEexcaiC/w4+Sv6B7WkiL/oUY/Zh4SMB5o+HV2gBriqzQjUEf8xpp/GQqp+235ls
 ysbLO3xUJOepGtxAFJwYKBvb+JIVY1pgbUHsDpGVuXh/FQLTaQxTCrTWsHCbQ6zBz3RZ
 moNcsLyxBD00dR2edgDgUe4kZelOyMhK+G7re3sgCIkn7/zjBDIrNLBD6uZb/jH4iQ4J
 EVOWl9XBgOxYJNLf/wWBJ5WLbweRiGDfJRcxQqOnvZUMIJOMtzN3vrK1kuBSNyU4tCgS
 91fg==
X-Gm-Message-State: ANhLgQ0M1D2v7Ox1+7ZemLJ3Pf6Hk61FLsxWzidEGkyYkC9lyLar+BeH
 e8m9QjNmG9EmOZdCHcPVGn3yR1UN04pZ7W/GdnA=
X-Google-Smtp-Source: ADFU+vscM2/I+xqd4Ql3m717dcrcauKWiJBdKPp8HzmRasFeGbMPihPaku7/JPSHDJs07DcNIe9I3sF0CQe4btajgFQ=
X-Received: by 2002:a0c:ec02:: with SMTP id y2mr9592030qvo.171.1584732286582; 
 Fri, 20 Mar 2020 12:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200318200303.11322-1-andrzej.jakowski@linux.intel.com>
 <20200320154505.GD138042@stefanha-x1.localdomain>
 <74c9c6e8-9407-a0fb-0070-b8758b7a46eb@linux.intel.com>
In-Reply-To: <74c9c6e8-9407-a0fb-0070-b8758b7a46eb@linux.intel.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 20 Mar 2020 19:24:35 +0000
Message-ID: <CAJSP0QUGPP3YX4-eVQAToSai3JHqv8sFvpvmW-3xvNjFJ7=YCw@mail.gmail.com>
Subject: Re: [PATCH v3] block/nvme: introduce PMR support from NVMe 1.4 spec
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu block <qemu-block@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Zhang Yi <yi.z.zhang@linux.intel.com>, "He,
 Junyan" <junyan.he@intel.com>, kbusch@kernel.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 5:48 PM Andrzej Jakowski
<andrzej.jakowski@linux.intel.com> wrote:
>
> On 3/20/20 8:45 AM, Stefan Hajnoczi wrote:
> > Please use qemu_ram_writeback() so that pmem_persist() and qemu_msync()
> > are used as appropriate.
>
> Thx!
> qemu_ram_writeback() doesn't return any status. How can I know that actual msync succeds?

If the warn_report() message that is already printed by
qemu_ram_writeback() is insufficient in terms of error reporting, I
suggest propagating the return value from qemu_ram_writeback() and
qemu_ram_block_writeback().

> Also qemu_ram_writeback() requires me to include #include "exec/ram_addr.h".
> After including it when I compile code I'm getting following error:
>
> In file included from hw/block/nvme.c:49:
> /root/sources/pmr/qemu/include/exec/ram_addr.h:23:10: fatal error: cpu.h: No such file or directory
>    23 | #include "cpu.h"
>       |          ^~~~~~~
> compilation terminated.
> make: *** [/root/sources/pmr/qemu/rules.mak:69: hw/block/nvme.o] Error 1
>
> Why this is happening and what should be changed.

Generally object files are built as part of common-obj-y in
Makefile.objs.  These object files are built only once across all QEMU
targets (e.g. qemu-system-x86_64, qemu-system-arm, ...).

Some code embeds target-specific information and is therefore not
suitable for common-obj-y.  These object files are built as part of
obj-y in Makefile.objs.

You can fix this compilation issue by changing hw/block/Makefile.objs
to like this:

diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 4b4a2b338d..12d5d5dac6 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -7,11 +7,11 @@ common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
 common-obj-$(CONFIG_XEN) += xen-block.o
 common-obj-$(CONFIG_ECC) += ecc.o
 common-obj-$(CONFIG_ONENAND) += onenand.o
-common-obj-$(CONFIG_NVME_PCI) += nvme.o
 common-obj-$(CONFIG_SWIM) += swim.o

 common-obj-$(CONFIG_SH4) += tc58128.o

+obj-$(CONFIG_NVME_PCI) += nvme.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o

Stefan

