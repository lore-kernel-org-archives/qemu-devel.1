Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB96C742C2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FBD206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FBD206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwdO-0004cK-D4
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45143)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hlwbf-0006V6-0W
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hlwbd-00023C-JX
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:33:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hlwbd-00022s-AH
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:33:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 672F34E908;
 Fri, 12 Jul 2019 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E7EA608C2;
 Fri, 12 Jul 2019 14:32:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 16:32:07 +0200
Message-Id: <20190712143207.4214-20-quintela@redhat.com>
In-Reply-To: <20190712143207.4214-1-quintela@redhat.com>
References: <20190712143207.4214-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 12 Jul 2019 14:33:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 19/19] migration: allow private destination ram
 with x-ignore-shared
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Xu Wang <xu@hyper.sh>,
 Jiangshan Lai <laijs@hyper.sh>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peng Tao <tao.peng@linux.alibaba.com>

By removing the share ram check, qemu is able to migrate
to private destination ram when x-ignore-shared capability
is on. Then we can create multiple destination VMs based
on the same source VM.

This changes the x-ignore-shared migration capability to
work similar to Lai's original bypass-shared-memory
work(https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00003.html)
which enables kata containers (https://katacontainers.io)
to implement the VM templating feature.

An example usage in kata containers(https://katacontainers.io):
1. Start the source VM:
   qemu-system-x86 -m 2G \
     -object memory-backend-file,id=3Dmem0,size=3D2G,share=3Don,mem-path=3D=
/tmpfs/template-memory \
     -numa node,memdev=3Dmem0
2. Stop the template VM, set migration x-ignore-shared capability,
   migrate "exec:cat>/tmpfs/state", quit it
3. Start target VM:
   qemu-system-x86 -m 2G \
     -object memory-backend-file,id=3Dmem0,size=3D2G,share=3Doff,mem-path=
=3D/tmpfs/template-memory \
     -numa node,memdev=3Dmem0 \
     -incoming defer
4. connect to target VM qmp, set migration x-ignore-shared capability,
migrate_incoming "exec:cat /tmpfs/state"
5. create more target VMs repeating 3 and 4

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: Jiangshan Lai <laijs@hyper.sh>
Cc: Xu Wang <xu@hyper.sh>
Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <1560494113-1141-1-git-send-email-tao.peng@linux.alibaba.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8a6ad61d3d..8622b4dc49 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3426,7 +3426,6 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
)
         }
         if (migrate_ignore_shared()) {
             qemu_put_be64(f, block->mr->addr);
-            qemu_put_byte(f, ramblock_is_ignored(block) ? 1 : 0);
         }
     }
=20
@@ -4393,12 +4392,6 @@ static int ram_load(QEMUFile *f, void *opaque, int=
 version_id)
                     }
                     if (migrate_ignore_shared()) {
                         hwaddr addr =3D qemu_get_be64(f);
-                        bool ignored =3D qemu_get_byte(f);
-                        if (ignored !=3D ramblock_is_ignored(block)) {
-                            error_report("RAM block %s should %s be migr=
ated",
-                                         id, ignored ? "" : "not");
-                            ret =3D -EINVAL;
-                        }
                         if (ramblock_is_ignored(block) &&
                             block->mr->addr !=3D addr) {
                             error_report("Mismatched GPAs for block %s "
--=20
2.21.0


