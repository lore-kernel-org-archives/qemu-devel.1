Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA75C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666AC21D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULHAnfSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666AC21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvij-0002Ll-Cv
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQp-00033V-6R
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQf-0000Bc-H5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mU75RHHzFC7gQ5DS7Khzv/NDdxI3ENG1gh7VLj3KTvg=;
 b=ULHAnfSCZ0N7BKBFyc5tueP+hcxv2u++qHK3zzl1yz+nQrHX/qbg3oLHJHdaHyboMmkfIt
 YGVVulQLkOQuDIirDCIqkv+Wg0jqBvFgUOzEpB4X+vmCl1tgAxx69DCSEKkYVrRGAhtX74
 9NFc9DCEwXO0R8+8U7VosUT5OgybQUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-oBXu5DiqMHOb2KSLuJTHlw-1; Tue, 20 Oct 2020 13:28:04 -0400
X-MC-Unique: oBXu5DiqMHOb2KSLuJTHlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B400A803F62;
 Tue, 20 Oct 2020 17:28:03 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C39DB1992D;
 Tue, 20 Oct 2020 17:28:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/21] python/qemu/console_socket.py: Correct type of recv()
Date: Tue, 20 Oct 2020 13:27:34 -0400
Message-Id: <20201020172742.1483258-14-jsnow@redhat.com>
In-Reply-To: <20201020172742.1483258-1-jsnow@redhat.com>
References: <20201020172742.1483258-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The type and parameter names of recv() should match socket.socket().

OK, easy enough, but in the cases we don't pass straight through to the
real socket implementation, we probably can't accept such flags. OK, for
now, assert that we don't receive flags in such cases.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20201006235817.3280413-13-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/console_socket.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
index 69f604c77f..cb3400a038 100644
--- a/python/qemu/console_socket.py
+++ b/python/qemu/console_socket.py
@@ -92,13 +92,14 @@ def _drain_socket(self):
         for c in string:
             self._buffer.extend(c)
 
-    def recv(self, bufsize=1):
+    def recv(self, bufsize: int = 1, flags: int = 0) -> bytes:
         """Return chars from in memory buffer.
            Maintains the same API as socket.socket.recv.
         """
         if self._drain_thread is None:
             # Not buffering the socket, pass thru to socket.
-            return socket.socket.recv(self, bufsize)
+            return socket.socket.recv(self, bufsize, flags)
+        assert not flags, "Cannot pass flags to recv() in drained mode"
         start_time = time.time()
         while len(self._buffer) < bufsize:
             time.sleep(self._sleep_time)
-- 
2.26.2


