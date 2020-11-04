Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44179C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF92223AB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abjMoJEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF92223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7GK-0008FJ-M1
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6ny-0007VM-JH
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nw-0004yL-Sn
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MguaJi7qsX+yMjl4mE0Iu+XWpMdwiaBCv2zhtIeLKwI=;
 b=abjMoJEsCUn7hrLW7CfJzKcJsiBcNEFpEoehDVsx+uL4iB6X9Go2GzQhjRiyPN/klke/0D
 vOoa2G8N/7AFvzCz+CiGAayxfF5CbQy8ilnY2Ww//PA37uKwU2kURpiaimDnNhQ8cA0yew
 ffDlWqCb20X66zYElKeRkw3RBOZEDgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-8Jv4MU0iN-OwIV9VYZzd6g-1; Tue, 03 Nov 2020 19:37:34 -0500
X-MC-Unique: 8Jv4MU0iN-OwIV9VYZzd6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45BAA6D240
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:33 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A19855766;
 Wed,  4 Nov 2020 00:37:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 65/72] scripts/qmp-shell: Remove too-broad-exception
Date: Tue,  3 Nov 2020 19:35:55 -0500
Message-Id: <20201104003602.1293560-66-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are only anticipating QMPShellErrors here, for syntax we weren't able
to understand. Other errors, if any, should be allowed to percolate
upwards.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 78e4eae00754..8d5845ab4815 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -291,10 +291,13 @@ class QMPShell(qmp.QEMUMonitorProtocol):
     def _execute_cmd(self, cmdline: str) -> bool:
         try:
             qmpcmd = self.__build_cmd(cmdline)
-        except Exception as err:
-            print('Error while parsing command line: %s' % err)
-            print('command format: <command-name> ', end=' ')
-            print('[arg-name1=arg1] ... [arg-nameN=argN]')
+        except QMPShellError as err:
+            print(
+                f"Error while parsing command line: {err!s}\n"
+                "command format: <command-name> "
+                "[arg-name1=arg1] ... [arg-nameN=argN",
+                file=sys.stderr
+            )
             return True
         # For transaction mode, we may have just cached the action:
         if qmpcmd is None:
-- 
2.26.2


