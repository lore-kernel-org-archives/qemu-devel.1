Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24EBC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877EF24655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpZZJAft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877EF24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWhR-0002JF-1U
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWdH-0005su-BM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdG-0007vX-57
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdG-0007tg-1X
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZL7cOBRrNjS5xV9Me0lJk0ipNP0N1056GF7w4b0GCrQ=;
 b=CpZZJAftO5SrwcQc89uHW797BEG9aeNCOCP6BkzJOElF7axCTYx2zNNjMKc5l/m/5RNdN/
 wlWfTGO8T++w8vfcwCvNgvK1RoXXSarqQfCg8tWLr6j+mIgKiPAAVySnF3Tg5X5dQZuvpe
 fXoA77haNVDvHsalLB2pYJIWIAjxO8E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-Xggtf5yFMteKKsi3uRM-JQ-1; Thu, 23 Jan 2020 02:10:21 -0500
Received: by mail-wr1-f70.google.com with SMTP id f10so1303385wro.14
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0NReYyn4JQkVdN7PoAGTBso0lphxyHmehPnh64blNL8=;
 b=hWKPGRxXxLcdV6/pujAxhmnwiiUIH8YULaOw8NsSKVRPFrKDerieGaCNGX13w7XMUJ
 FD0L1lD9/4H767MeinlVFHMfIXLO0c4pKPXdxWsz4FVPhGYVGoibbJSFzAxCUiPZ5MVd
 lqQ96jdhX5Mrm1mxckBCNuAnh0YSYFBPbgP5ObsG4l9+JYf6Wa4YJ/tAD5L2pniyHrYD
 vxNdchSMTlg+rnzzm9wydH/PV6W4i6MR8j0O1bE3K6G7Qs9nvJxwgMiQkAAPIV5lAC0m
 cji2Lz1V5ky95bDDEJmAVAukJ4K2V5p6jEtXD9/VOFKD7R2PrHV7qVI3qEob9Hnwm+nj
 Hudg==
X-Gm-Message-State: APjAAAUt4fxVm1DJVoAg/FlMChhRjY/6SQmLxOdXnw6JinfhAUs/UBla
 lAHCk36zxOZOke0p9L4zgdMc7gwJL4+bMIa0ytxENMz8hqNXInp+fBcLOF7bqNkRe1SVQOAgSUB
 ef2OoMXAlPDYpGJg=
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr15576028wrn.384.1579763420259; 
 Wed, 22 Jan 2020 23:10:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwN/R/1APgnH2EBXncPvXLbN6i0/kbQO/0iZqxZI7ioLiC84ma/MSkdmc0POU/FnFa4JsMknQ==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr15576005wrn.384.1579763420064; 
 Wed, 22 Jan 2020 23:10:20 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 i16sm1507914wmb.36.2020.01.22.23.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:19 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 04/18] acpi: cpuhp: spec: fix 'Command data' description
Message-ID: <20200123070913.626488-5-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: Xggtf5yFMteKKsi3uRM-JQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Correct returned value description in case 'Command field' =3D=3D 0x0,
it's not PXM but CPU selector value with pending event

In addition describe 0 blanket value in case of not supported
'Command field' value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <1575896942-331151-6-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index 4e65286ff5..d5108720bf 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -56,9 +56,8 @@ read access:
            3-7: reserved and should be ignored by OSPM
     [0x5-0x7] reserved
     [0x8] Command data: (DWORD access)
-          in case of error or unsupported command reads is 0xFFFFFFFF
-          current 'Command field' value:
-              0: returns PXM value corresponding to device
+          contains 0 unless value last stored in 'Command field' is one of=
:
+              0: contains 'CPU selector' value of a CPU with pending event=
[s]
=20
 write access:
     offset:
@@ -81,9 +80,9 @@ write access:
           value:
             0: selects a CPU device with inserting/removing events and
                following reads from 'Command data' register return
-               selected CPU (CPU selector value). If no CPU with events
-               found, the current CPU selector doesn't change and
-               corresponding insert/remove event flags are not set.
+               selected CPU ('CPU selector' value).
+               If no CPU with events found, the current 'CPU selector' doe=
sn't
+               change and corresponding insert/remove event flags are not =
modified.
             1: following writes to 'Command data' register set OST event
                register in QEMU
             2: following writes to 'Command data' register set OST status
--=20
MST


