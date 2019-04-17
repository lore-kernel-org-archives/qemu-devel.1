Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4619FC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18477206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18477206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58189 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGpyP-00034T-7Y
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:11:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptP-0007eD-Bo
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptO-0003ZW-Dh
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGptO-0003Ye-3W
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BEC83002F52;
	Wed, 17 Apr 2019 19:06:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 278595D6A6;
	Wed, 17 Apr 2019 19:06:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 176D411329CF; Wed, 17 Apr 2019 21:06:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:06:35 +0200
Message-Id: <20190417190641.26814-10-armbru@redhat.com>
In-Reply-To: <20190417190641.26814-1-armbru@redhat.com>
References: <20190417190641.26814-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 17 Apr 2019 19:06:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 09/15] vl: Make -machine $TYPE,
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
Message-ID: <20190417190635.c7LlcBsAZqnEGWWJkVGTjontso3OvAnO5bd0qmJXFpI@z>

Command line help help explicitly requested by the user should be
printed to stdout, not stderr.  We do elsewhere.  Adjust -machine
$TYPE,help and -accel help to match: use printf() instead of
error_printf().

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index 9877972d97..190c773176 100644
--- a/vl.c
+++ b/vl.c
@@ -1556,12 +1556,12 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
             continue;
         }
 
-        error_printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
-                     prop->name, prop->type);
+        printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
+               prop->name, prop->type);
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


