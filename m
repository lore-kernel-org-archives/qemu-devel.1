Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F854C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE925223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhjRIzzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE925223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka6w3-0001gh-LW
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6ms-0006Bo-23
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6mq-0004oP-9j
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fB1rH87GsDpMYD9z/NEMczfG2TJxteUGF9x5BkNa1OY=;
 b=hhjRIzztpRRXx76SitCnufDBv70LZ1rWZKwBzCW9VACx6yxlpQRofE0xgvdHr9m5ad2MwZ
 Zp937b6lExzZq2tyZnHWU+5QzWkSnWWfzeTHO4IyNPM4cuO0c3gaQBV5a3lRcKUnlbOUDL
 QKVDxAjHS0YFevBwtxuamkmpEMeWm98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-ap_egA23MsC9IgMjNxH5FA-1; Tue, 03 Nov 2020 19:36:25 -0500
X-MC-Unique: ap_egA23MsC9IgMjNxH5FA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56AB0186842A
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:21 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D7A155766;
 Wed,  4 Nov 2020 00:36:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/72] scripts/qom-fuse: Apply pylint rules
Date: Tue,  3 Nov 2020 19:34:57 -0500
Message-Id: <20201104003602.1293560-8-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Catch specific exceptions from QMP
- Reraise errors with explicit context
- method parameters should match parent's names

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/qmp/qom-fuse | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index ca30e928679e..805e99c8ecde 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -23,7 +23,7 @@ from fuse import FUSE, FuseOSError, Operations
 
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+from qemu.qmp import QEMUMonitorProtocol, QMPResponseError
 
 
 fuse.fuse_python_api = (0, 2)
@@ -47,7 +47,7 @@ class QOMFS(Operations):
         try:
             self.qmp.command('qom-list', path=path)
             return True
-        except:
+        except QMPResponseError:
             return False
 
     def is_property(self, path):
@@ -59,7 +59,7 @@ class QOMFS(Operations):
                 if item['name'] == prop:
                     return True
             return False
-        except:
+        except QMPResponseError:
             return False
 
     def is_link(self, path):
@@ -73,10 +73,10 @@ class QOMFS(Operations):
                         return True
                     return False
             return False
-        except:
+        except QMPResponseError:
             return False
 
-    def read(self, path, length, offset, fh):
+    def read(self, path, size, offset, fh):
         if not self.is_property(path):
             return -ENOENT
 
@@ -86,13 +86,13 @@ class QOMFS(Operations):
         try:
             data = self.qmp.command('qom-get', path=path, property=prop)
             data += '\n'  # make values shell friendly
-        except:
-            raise FuseOSError(EPERM)
+        except QMPResponseError as err:
+            raise FuseOSError(EPERM) from err
 
         if offset > len(data):
             return ''
 
-        return bytes(data[offset:][:length], encoding='utf-8')
+        return bytes(data[offset:][:size], encoding='utf-8')
 
     def readlink(self, path):
         if not self.is_link(path):
-- 
2.26.2


