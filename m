Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B341FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2612166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2612166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvyi7-0002qP-Oz
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 02:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvyg8-0000sL-Aw
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvyg4-0001le-1m
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvyg3-0001jU-8K
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B3A842CD811
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:47:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F1C860BF3;
 Fri,  9 Aug 2019 06:46:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84BEF11384AA; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:22 +0200
Message-Id: <20190809064645.22656-7-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 09 Aug 2019 06:47:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 06/29] trace: Eliminate use of TARGET_FMT_plx
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/tpm/trace-events uses TARGET_FMT_plx formats with uint64_t
arguments.  That's wrong, TARGET_FMT_plx takes hwaddr.  Since hwaddr
happens to be uint64_t, it works anyway.  Messed up in commit
ec427498da5, v2.12.0.  Clean up by replacing TARGET_FMT_plx with its
macro expansion.

scripts/tracetool/format/log_stap.py (commit 62dd1048c0b, v4.0.0) has
a special case for TARGET_FMT_plx.  Delete it.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/tpm/trace-events                  | 4 ++--
 scripts/tracetool/format/log_stap.py | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 0b94aa1526..89804bcd64 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -1,8 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
 # tpm_crb.c
-tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read =
0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
-tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB writ=
e 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
+tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read =
0x%016" PRIx64 " len:%u val: 0x%" PRIx32
+tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB writ=
e 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
=20
 # tpm_passthrough.c
 tpm_passthrough_handle_request(void *cmd) "processing command %p"
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/for=
mat/log_stap.py
index 3ccbc09d61..9ab0cf2cce 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -30,9 +30,6 @@ def c_macro_to_format(macro):
     if macro.startswith("PRI"):
         return macro[3]
=20
-    if macro =3D=3D "TARGET_FMT_plx":
-        return "%016x"
-
     raise Exception("Unhandled macro '%s'" % macro)
=20
 def c_fmt_to_stap(fmt):
--=20
2.21.0


