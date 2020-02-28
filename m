Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F32C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559FA24695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGHbZ3B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559FA24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eGK-0007tj-Jy
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e8e-0002El-Ni
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e8d-0001hT-Mo
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:49:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e8d-0001gN-Ih
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTdLeO/j/e6eP/jAK/QSTo2ZeP6lsa0GUR9L2pxBWEY=;
 b=RGHbZ3B+ihNxayMtFx5j2HT3AWCW+IpN2CjJpRxtba9xQfWG7z115NITwdPkmznDXOMwgM
 esEr4XjPkIkTKSdgHDrue5Kxjwd+mnBUqOb/13i3j4QMp0wyBuki7YwOjVQChJhaHnSVt0
 /QAWQLruU6fQd0sW3haGYxg4FEMa0/I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-dWDFremBO2SYb7vTO0lotQ-1; Fri, 28 Feb 2020 06:48:59 -0500
X-MC-Unique: dWDFremBO2SYb7vTO0lotQ-1
Received: by mail-wm1-f70.google.com with SMTP id r19so1060149wmh.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dgOorqpkh3gN4b7sAM5gmxbiZ9joAGYWI1QUJBzOx9g=;
 b=p1+9/hHXoWqiuhpvlkzN0SkRFHk9Js2jfjq96IE0EVwYel8EsxIPkBWt68zxiNjm9E
 R4bGbaFZJQb1hECaxf8lJwDDz0kWScNLj6vT8qdNurGY3RW4Oob704bguEmuNoX/YxZy
 9qcpRKTo31cLjuw1wDStq+eeI9JGDa8TG9lVUKeHvQnPtjCD6ddAskk97M7uvSvDE/US
 NOxzip+t0h8sP7i9A5+kAvM1HNeTxMLXehHD6aPlLUlpgfEYJeNiR8DcM4b8B8HTR9JT
 Li/IaeOF2Rfm+Si0/M00WqTomr02aiKtS9TlXU1VEFq9itOOMAmn22pnkT4Ra1BFUGEo
 my8w==
X-Gm-Message-State: APjAAAVsWOK1TOmDXAhT3bzjn+CyuxeYseWJbB31BFyBQaBrzVoRI1P/
 eqmAkgIF7qtYB1AL+7eW2fDupXPInw/lgaU3Fhvh4JpYZlBtW3x6Fp40IiyJBAN7LmVsmtzQ6zP
 SgsNfEjM6zYVwiY4=
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr4483317wmg.146.1582890538278; 
 Fri, 28 Feb 2020 03:48:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSECnXVOCZYvsdQaRgO3slzYjheg1QWBdEwrqqjtLopf28EMMyXYnzPgpXVuQahIv26lkZyQ==
X-Received: by 2002:a7b:cf39:: with SMTP id m25mr4483298wmg.146.1582890538096; 
 Fri, 28 Feb 2020 03:48:58 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id 133sm2082799wmd.5.2020.02.28.03.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:48:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/18] hw/i386/pc: Clean up includes
Date: Fri, 28 Feb 2020 12:46:49 +0100
Message-Id: <20200228114649.12818-19-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228114649.12818-1-philmd@redhat.com>
References: <20200228114649.12818-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various headers are not required by hw/i386/pc.h:

 - "qemu/range.h"
 - "qemu/bitmap.h"
 - "qemu/module.h"
 - "exec/memory.h"
 - "hw/pci/pci.h"
 - "hw/mem/pc-dimm.h"
 - "hw/mem/nvdimm.h"
 - "net/net.h"

Remove them.

Add 3 headers that were missing:

 - "hw/hotplug.h"

   PCMachineState::acpi_dev is of type HotplugHandler

 - "qemu/notify.h"

   PCMachineState::machine_done is of type Notifier

 - "qapi/qapi-types-common.h"

   PCMachineState::vmport/smm is of type OnOffAuto

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i386/pc.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d5ac76d54e..6ab6eda046 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -1,20 +1,15 @@
 #ifndef HW_PC_H
 #define HW_PC_H
=20
-#include "exec/memory.h"
+#include "qemu/notify.h"
+#include "qapi/qapi-types-common.h"
 #include "hw/boards.h"
 #include "hw/block/fdc.h"
 #include "hw/block/flash.h"
-#include "net/net.h"
 #include "hw/i386/x86.h"
=20
-#include "qemu/range.h"
-#include "qemu/bitmap.h"
-#include "qemu/module.h"
-#include "hw/pci/pci.h"
-#include "hw/mem/pc-dimm.h"
-#include "hw/mem/nvdimm.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "hw/hotplug.h"
=20
 #define HPET_INTCAP "hpet-intcap"
=20
--=20
2.21.1


