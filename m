Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF48C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B2E206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEH4Q38C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B2E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEto-0003WL-Kg
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjW-0005Sh-UJ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:46:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58268
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjV-00004t-GB
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591134363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iGSpQJVJCdKjrWxqDYE2XmRQvkmLt6rW5uM+LnGK5c=;
 b=QEH4Q38CIiHCvoPdFdtbCROluO448/GjSUWlX4SQhH36YYW4lni+EjTSwHb4DCe53TRwzZ
 7df2g8g68Intl+ye2aQVuMH16nZA/r5p6T0+kevZtCziOjog7C2pQJvBsdLy8wByhq2v5E
 iJ3Xf753A8IwpH7eDnYG2ISJ/5rWvqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-CY2zF2epM6i2REwh6ocz0A-1; Tue, 02 Jun 2020 17:46:01 -0400
X-MC-Unique: CY2zF2epM6i2REwh6ocz0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D841EA0BD9;
 Tue,  2 Jun 2020 21:46:00 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 712AC60BE1;
 Tue,  2 Jun 2020 21:45:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/16] iotests.py: Adjust HMP kwargs typing
Date: Tue,  2 Jun 2020 17:45:27 -0400
Message-Id: <20200602214528.12107-16-jsnow@redhat.com>
In-Reply-To: <20200602214528.12107-1-jsnow@redhat.com>
References: <20200602214528.12107-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mypy wants to ensure there's consistency between the kwargs arguments
types and any unspecified keyword arguments. In this case, conv_keys is
a bool, but the remaining keys are Any type. Mypy (correctly) infers the
**kwargs type to be **Dict[str, str], which is not compatible with
conv_keys: bool.

Because QMP typing is a little fraught right now anyway, re-type kwargs
to Dict[str, Any] which has the benefit of silencing this check right
now.

A future re-design might type these more aggressively, but this will
give us a baseline to work from with minimal disruption.

(Thanks Kevin Wolf for the debugging assist here)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7c1773bba37..19b22bee618 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -553,7 +553,7 @@ def add_incoming(self, addr):
 
     def hmp(self, command_line: str, use_log: bool = False) -> QMPMessage:
         cmd = 'human-monitor-command'
-        kwargs = {'command-line': command_line}
+        kwargs: Dict[str, Any] = {'command-line': command_line}
         if use_log:
             return self.qmp_log(cmd, **kwargs)
         else:
-- 
2.21.3


