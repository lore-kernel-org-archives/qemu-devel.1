Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5A6C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B7920880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B7920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDPpo-0003EA-3d
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 04:40:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPla-00089J-H5
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlZ-0003dz-Cd
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDPlZ-0003dE-3p
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66CA0307D963;
	Mon,  8 Apr 2019 08:36:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F5E25DA2A;
	Mon,  8 Apr 2019 08:36:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0523011329F5; Mon,  8 Apr 2019 10:36:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 10:36:22 +0200
Message-Id: <20190408083627.7479-11-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-1-armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 08 Apr 2019 08:36:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 10/15] vl: Make -machine $TYPE,
 help and -accel help print to stdout
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408083622.AmNSSeluCyev82A6raiWSteyB4JTig-N_7DzmO9j9Og@z>

Command line help help explicitly requested by the user should be
printed to stdout, not stderr.  We do elsewhere.  Adjust -machine
$TYPE,help and -accel help to match: use printf() instead of
error_printf().

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index c696ad2a13..792ef36001 100644
--- a/vl.c
+++ b/vl.c
@@ -1556,12 +1556,12 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
             continue;
         }
 
-        error_printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
-                     prop->name, prop->type);
+        printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
+                    prop->name, prop->type);
         if (prop->description) {
-            error_printf(" (%s)\n", prop->description);
+            printf(" (%s)\n", prop->description);
         } else {
-            error_printf("\n");
+            printf("\n");
         }
     }
 
@@ -3643,7 +3643,7 @@ int main(int argc, char **argv, char **envp)
                                                      optarg, true);
                 optarg = qemu_opt_get(accel_opts, "accel");
                 if (!optarg || is_help_option(optarg)) {
-                    error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
+                    printf("Possible accelerators: kvm, xen, hax, tcg\n");
                     exit(0);
                 }
                 opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
-- 
2.17.2


