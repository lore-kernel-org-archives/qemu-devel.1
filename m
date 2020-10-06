Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F8FC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C2B206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5lFqhRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C2B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPxB8-00018K-7F
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwrU-0000DP-Ce
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwrP-0002Oq-RN
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wXzabkXZlXAv4NbEkdTh8mJjGPhjdHauSjMHiWu9HY=;
 b=B5lFqhRR2UkQY14vkdMGU2l3zT4IQXqQXysX0QomaSJ9lMXU8ywcncB+OGFBIVqADOp9ZL
 DOWt1k77kMAzL2GnlMV6RCwmjdsGY0CjUbqw3kpbLMkle/Gptt5jaCM344nbsM4u5heKEj
 yxLtQvQ4nJY1oQXpY6RGk3T0QtDBXJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-M0qQsXwHPnqNNBisroUocg-1; Tue, 06 Oct 2020 19:59:09 -0400
X-MC-Unique: M0qQsXwHPnqNNBisroUocg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A46810866AD;
 Tue,  6 Oct 2020 23:59:08 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C50C460BFA;
 Tue,  6 Oct 2020 23:59:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/20] python/qemu/qmp.py: Preserve error context on re-raise
Date: Tue,  6 Oct 2020 19:58:14 -0400
Message-Id: <20201006235817.3280413-18-jsnow@redhat.com>
In-Reply-To: <20201006235817.3280413-1-jsnow@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the "from ..." phrasing when re-raising errors to preserve their
initial context, to help aid debugging when things go wrong.

This also silences a pylint 2.6.0+ error.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 9223307ed81..d911999da1f 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -181,10 +181,11 @@ def __get_events(self, wait: Union[bool, float] = False) -> None:
                 self.__sock.settimeout(wait)
             try:
                 ret = self.__json_read(only_event=True)
-            except socket.timeout:
-                raise QMPTimeoutError("Timeout waiting for event")
-            except:
-                raise QMPConnectError("Error while reading from socket")
+            except socket.timeout as err:
+                raise QMPTimeoutError("Timeout waiting for event") from err
+            except Exception as err:
+                msg = "Error while reading from socket"
+                raise QMPConnectError(msg) from err
             if ret is None:
                 raise QMPConnectError("Error while reading from socket")
             self.__sock.settimeout(None)
-- 
2.26.2


