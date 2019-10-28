Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A155DCA9EC0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E22208C0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glkLJMlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E22208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPF49-0007pB-KU
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 20:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPEn4-00030E-TJ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPEmR-0003xv-5A
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:50:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54486
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPEmR-0003xC-1X
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572306634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cgQukRAWddgzjzbqA/mcrum0TVlpYTggbK1d81oqY4=;
 b=glkLJMlbj+KfxcNCEnJhDObyZ7634sdCb6GDR+98u4EHxw9ZB0l8Me/G1Lt5n+0d9xJJW5
 o1KfX7xQB4O4toAtGRgZudwSXdIn2Tvs36hSv88+0P7V4KWpe4Y0HzyaoANgfUHPT5kTbe
 YeIRuHnvGgbs8EAOzhrY5dLx0kzF2Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-yeC7rHUWO2ybIsovaoSUFQ-1; Mon, 28 Oct 2019 19:50:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D66981A334;
 Mon, 28 Oct 2019 23:50:29 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 869705C1B2;
 Mon, 28 Oct 2019 23:50:24 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PULL 5/16] tests/acceptance: Fix wait_for_console_pattern() hangs
Date: Mon, 28 Oct 2019 19:49:51 -0400
Message-Id: <20191028235002.17691-6-crosa@redhat.com>
In-Reply-To: <20191028235002.17691-1-crosa@redhat.com>
References: <20191028235002.17691-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: yeC7rHUWO2ybIsovaoSUFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Because of a possible deadlock (QEMU waiting for the socket to
become writable) let's close the console socket as soon as we
stop to use it.

Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191028073441.6448-4-philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
[Cleber: corrected small typo in commit message]
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 772771e205..393fc33f35 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -75,6 +75,7 @@ def wait_for_console_pattern(test, success_message, failu=
re_message=3DNone):
         if success_message in msg:
             break
         if failure_message and failure_message in msg:
+            console.close()
             fail =3D 'Failure message found in console: %s' % failure_mess=
age
             test.fail(fail)
=20
--=20
2.21.0


