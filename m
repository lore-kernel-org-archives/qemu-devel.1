Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86259C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80C62223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWc23sjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80C62223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvoP-00028m-Mb
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvRD-0003eY-2s
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQo-0000DL-VX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCEWcLdb4RhnaR+lgGPfAijEe+Wg7+ii/omcpWJHwVE=;
 b=UWc23sjtyZFlPB/0qJbB6GuicjOFNaIWGnjFy4OHWcsnmGdTtndHUa18GVGj2xxm9R28Ts
 xxYk3bZiZaTBnbxQ8ER9XFbqSrQWuBvEkkrvEynl816QA6VfLxxzjbawoHzizVaqc2KxV6
 lTH0lVxAMCZsWCkscKYTqRtn1VCf+KQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-lIJh6EgqP0-eFcr1tFeeZw-1; Tue, 20 Oct 2020 13:28:11 -0400
X-MC-Unique: lIJh6EgqP0-eFcr1tFeeZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DD32803F4E;
 Tue, 20 Oct 2020 17:28:10 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 897641992D;
 Tue, 20 Oct 2020 17:28:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/21] python/qemu/qmp.py: Preserve error context on re-raise
Date: Tue, 20 Oct 2020 13:27:39 -0400
Message-Id: <20201020172742.1483258-19-jsnow@redhat.com>
In-Reply-To: <20201020172742.1483258-1-jsnow@redhat.com>
References: <20201020172742.1483258-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the "from ..." phrasing when re-raising errors to preserve their
initial context, to help aid debugging when things go wrong.

This also silences a pylint 2.6.0+ error.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20201006235817.3280413-18-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 9223307ed8..d911999da1 100644
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


