Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E1AC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4232081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4232081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMaR4-0000wm-Th
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:49:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hMaOQ-0007qb-IC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hMaOO-0000SE-Id
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:46:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1hMaOM-0000Q5-IP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:46:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EE7A3082A28;
	Fri,  3 May 2019 15:46:28 +0000 (UTC)
Received: from paraplu.redhat.com (ovpn-116-130.ams2.redhat.com
	[10.36.116.130])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58CBD2C167;
	Fri,  3 May 2019 15:46:25 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 17:46:13 +0200
Message-Id: <20190503154613.4192-2-kchamart@redhat.com>
In-Reply-To: <20190503154613.4192-1-kchamart@redhat.com>
References: <20190503154613.4192-1-kchamart@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 03 May 2019 15:46:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] VirtIO-RNG: Update default entropy source to
 `/dev/urandom`
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
Cc: rjones@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>,
	armbru@redhat.com, amit@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503154613.e-szgBF2k4tM08NOZUtBJw7W8RvsYqfuo06MLMTeaG8@z>

When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
source of entropy, and that source needs to be "non-blocking", like
`/dev/urandom`.  However, currently QEMU defaults to the problematic
`/dev/random`, which is "blocking" (as in, it waits until sufficient
entropy is available).

So change the entropy source to the recommended `/dev/urandom`.

Related discussion in these[1][2] past threads.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
    -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
[2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724.html
    -- "[RFC] Virtio RNG: Consider changing the default entropy source to
       /dev/urandom"

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 backends/rng-random.c | 2 +-
 qemu-options.hx       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/rng-random.c b/backends/rng-random.c
index e2a49b0571..eff36ef140 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -112,7 +112,7 @@ static void rng_random_init(Object *obj)
                             rng_random_set_filename,
                             NULL);
 
-    s->filename = g_strdup("/dev/random");
+    s->filename = g_strdup("/dev/urandom");
     s->fd = -1;
 }
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 51802cbb26..a525609149 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4276,7 +4276,7 @@ Creates a random number generator backend which obtains entropy from
 a device on the host. The @option{id} parameter is a unique ID that
 will be used to reference this entropy backend from the @option{virtio-rng}
 device. The @option{filename} parameter specifies which file to obtain
-entropy from and if omitted defaults to @option{/dev/random}.
+entropy from and if omitted defaults to @option{/dev/urandom}.
 
 @item -object rng-egd,id=@var{id},chardev=@var{chardevid}
 
-- 
2.17.2


