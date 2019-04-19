Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A841C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 06:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11694217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 06:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11694217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51863 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHMoR-0006Nn-5m
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 02:15:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMmc-00055k-26
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMmb-0004l9-4n
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHMma-0004kq-VQ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:13:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3504283F3A;
	Fri, 19 Apr 2019 06:13:56 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B02735D9C5;
	Fri, 19 Apr 2019 06:13:55 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 03:13:34 -0300
Message-Id: <20190419061349.17094-3-ehabkost@redhat.com>
In-Reply-To: <20190419061349.17094-1-ehabkost@redhat.com>
References: <20190419061349.17094-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 19 Apr 2019 06:13:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 02/17] vl.c: make find_default_machine() local
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mammedov <imammedo@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419061334.nKZk2320rzvS5yNbrubPhq9Jyqsqf0ICqc45Fl2P85c@z>

From: Wei Yang <richardw.yang@linux.intel.com>

Function find_default_machine() is introduced by commit 2c8cffa599b7
"vl: make find_default_machine externally visible", and it was used
outside of vl.c until commit a904410af5f1 "pc_sysfw: remove the rom_only
property".

Commit a904410af5f1 "pc_sysfw: remove the rom_only property" removed the
only user of find_default_machine() outside vl.c, but neglected to make
it static. Do that now.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Message-Id: <20190405064121.23662-2-richardw.yang@linux.intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h | 1 -
 vl.c                | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index fe1885cbff..6f7916f88f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -57,7 +57,6 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
 #define MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(MachineClass, (klass), TYPE_MACHINE)
 
-MachineClass *find_default_machine(void);
 extern MachineState *current_machine;
 
 void machine_run_board_init(MachineState *machine);
diff --git a/vl.c b/vl.c
index c696ad2a13..9d6a519d74 100644
--- a/vl.c
+++ b/vl.c
@@ -1488,7 +1488,7 @@ static MachineClass *find_machine(const char *name)
     return mc;
 }
 
-MachineClass *find_default_machine(void)
+static MachineClass *find_default_machine(void)
 {
     GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
     MachineClass *mc = NULL;
-- 
2.18.0.rc1.1.g3f1ff2140


