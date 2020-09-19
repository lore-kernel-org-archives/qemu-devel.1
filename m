Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A85C43465
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FF2208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFSMDqhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FF2208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfJf-00079d-Js
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGq-000556-BM
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGk-0007JG-Dy
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkKR887fLWOo4DC15+qJV+odLhc3rljp4gn44gOfM4I=;
 b=AFSMDqhZQ/6GpOp3KC3o6rtZ8BOh0UrUwYgsZ1jwUnd66MDG/EzkDB69A/urhfEwH1eOYU
 KvXVX+k2l2I6G7aEi4Zhnb4vkn6yollAMUqrqakIWuyYtVIyuEQ3yIdCEoeoYQH8KJ1FLW
 KzGJ4XD3AmQKLH3wj5Buu5SHgjUSUhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-l-l6LvZdMmehgVSnlkp_aw-1; Sat, 19 Sep 2020 11:59:19 -0400
X-MC-Unique: l-l6LvZdMmehgVSnlkp_aw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD8CE1074659
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 679DF1002388;
 Sat, 19 Sep 2020 15:59:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/57] ninjatool: rebuild multi-output targets if outputs are
 missing
Date: Sat, 19 Sep 2020 11:58:23 -0400
Message-Id: <20200919155916.1046398-5-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 06:41:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "stamp file trick" used to group targets of a single multi-output rule
prevents the user from deleting one such target in order to force its
rebuild.  Doing so will not touch the stamp file, and therefore only
the dummy ":" command will be executed.

With this patch, ninjatool writes rules that force-rebuild the stamp
file if any of its outputs are missing.  Rebuilding the missing
target therefore causes the stamp file to be rebuilt too.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/ninjatool.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
index 627a1cab45..6f0e35c727 100755
--- a/scripts/ninjatool.py
+++ b/scripts/ninjatool.py
@@ -908,6 +908,9 @@ class Ninja2Make(NinjaParserEventsWithVars):
             else:
                 stamp = '%s@%s.stamp' % (rule, sha1_text(targets)[0:11])
             self.print('%s: %s; @:' % (targets, stamp))
+            self.print('ifneq (%s, $(wildcard %s))' % (targets, targets))
+            self.print('.PHONY: %s' % (stamp, ))
+            self.print('endif')
             self.print('%s: %s | %s; ${ninja-command-restat}' % (stamp, inputs, orderonly))
             self.rule_targets[rule].append(stamp)
             self.stamp_targets[rule].append(stamp)
-- 
2.26.2



