Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F2AC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC9F21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYL+DwFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC9F21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1C1-0000qT-7J
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iS111-0005iv-3s
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iS10z-00039i-TH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:45:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30930
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iS10z-000399-Pd
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572968705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=of2jOjGBNqbSHc+4D9qC9W0BhVuS1WGPzMhVsgmwVQg=;
 b=DYL+DwFM1/Ov4D/UiZe0gwZxQHVRysK9CnnXdk9YuVT6qI9raACbxSTAjEpoTKNG71UL+5
 fRWaYD75gLrZc2joecosfpKidCtmbnPESY3PP5O+mPS5rBGCO370azD0uSHgOY6Gg7/RsX
 OCNS98uMbjdvVaxkWeHuevY+ufh3cww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-i9zF3yJ3OGawer8ccnookw-1; Tue, 05 Nov 2019 10:45:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3D8E800C73;
 Tue,  5 Nov 2019 15:45:00 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 479725C240;
 Tue,  5 Nov 2019 15:44:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] image-fuzzer: Run using python3
Date: Tue,  5 Nov 2019 16:43:30 +0100
Message-Id: <20191105154332.181417-10-stefanha@redhat.com>
In-Reply-To: <20191105154332.181417-1-stefanha@redhat.com>
References: <20191105154332.181417-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: i9zF3yJ3OGawer8ccnookw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

image-fuzzer is now supposed to be ready to run using Python 3.
Remove the __future__ imports and change the interpreter line to
"#!/usr/bin/env python3".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20191016192430.25098-10-ehabkost@redhat.com
Message-Id: <20191016192430.25098-10-ehabkost@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/image-fuzzer/qcow2/__init__.py | 1 -
 tests/image-fuzzer/qcow2/layout.py   | 1 -
 tests/image-fuzzer/runner.py         | 3 +--
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/image-fuzzer/qcow2/__init__.py b/tests/image-fuzzer/qcow=
2/__init__.py
index 09ef59821b..ed3af5da86 100644
--- a/tests/image-fuzzer/qcow2/__init__.py
+++ b/tests/image-fuzzer/qcow2/__init__.py
@@ -1,2 +1 @@
-from __future__ import absolute_import
 from .layout import create_image
diff --git a/tests/image-fuzzer/qcow2/layout.py b/tests/image-fuzzer/qcow2/=
layout.py
index 01bff4d05e..57ebe86e9a 100644
--- a/tests/image-fuzzer/qcow2/layout.py
+++ b/tests/image-fuzzer/qcow2/layout.py
@@ -16,7 +16,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
-from __future__ import absolute_import
 import random
 import struct
 from . import fuzz
diff --git a/tests/image-fuzzer/runner.py b/tests/image-fuzzer/runner.py
index 94cab5bd93..0793234815 100755
--- a/tests/image-fuzzer/runner.py
+++ b/tests/image-fuzzer/runner.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
=20
 # Tool for running fuzz tests
 #
@@ -18,7 +18,6 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
-from __future__ import print_function
 import sys
 import os
 import signal
--=20
2.23.0


