Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72C9C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E87420674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dP0PhhVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E87420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icYdw-0001jn-Mf
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 12:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1icY6D-0005J7-KI
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1icY6A-0005eK-8c
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:06:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1icY6A-0005JV-2q
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575479157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YgmH04qOhqZ1gIRxsoKF0FXDgFaY1TPFDkxlQAG7NI=;
 b=dP0PhhVVKf9+iesnUAIvXCFJfKc4IAPiWPXkY2zELEoAGJzc9DPhBp8B/NuJA46B5/+oU+
 gzrnGU+M6oNrJ7NgsUSeucLRvmLwfQsVpLTS4j3A9zf0exBmr3QvP5AyPkwM5INlALQwsm
 Gx/E84AXbnryZiVYNcLr4mdaa82K80Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-JFkVjHXSN--ThxFbu4Kv-g-1; Wed, 04 Dec 2019 12:05:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 183CF1005512
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 17:05:55 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E14B35D6BB;
 Wed,  4 Dec 2019 17:05:53 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 6/8] acpi: cpuhp: spec: add typical usecases
Date: Wed,  4 Dec 2019 18:05:45 +0100
Message-Id: <1575479147-6641-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: JFkVjHXSN--ThxFbu4Kv-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document work-flows for
  * finding a CPU with pending 'insert/remove' event
  * enumerating present and possible CPUs

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index f3c552d..58c16c6 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -64,6 +64,7 @@ write access:
     [0x0-0x3] CPU selector: (DWORD access)
               selects active CPU device. All following accesses to other
               registers will read/store data from/to selected CPU.
+              Valid values: [0 .. max_cpus)
     [0x4] CPU device control fields: (1 byte access)
         bits:
             0: reserved, OSPM must clear it before writing to register.
@@ -96,3 +97,31 @@ write access:
                  ACPI_DEVICE_OST QMP event from QEMU to external applicati=
ons
                  with current values of OST event and status registers.
             other values: reserved
+
+    Typical usecases:
+        - Get a cpu with pending event
+          1. Store 0x0 to the 'CPU selector' register.
+          2. Store 0x0 to the 'Command field' register.
+          3. Read the 'CPU device status fields' register.
+          4. If both bit#1 and bit#2 are clear in the value read, there is=
 no CPU
+             with a pending event and selected CPU remains unchanged.
+          5. Otherwise, read the 'Command data' register. The value read i=
s the
+             selector of the CPU with the pending event (which is already
+             selected).
+
+        - Enumerate CPUs present/non present CPUs
+          01. Set the present CPU count to 0.
+          02. Set the iterator to 0.
+          03. Store 0x0 to the 'CPU selector' register, to ensure that it'=
s in
+              a valid state and that access to other registers won't be ig=
nored.
+          04. Store 0x0 to the 'Command field' register to make 'Command d=
ata'
+              register return 'CPU selector' value of selected CPU
+          05. Read the 'CPU device status fields' register.
+          06. If bit#0 is set, increment the present CPU count.
+          07. Increment the iterator.
+          08. Store the iterator to the 'CPU selector' register.
+          09. Read the 'Command data' register.
+          10. If the value read is not zero, goto 05.
+          11. Otherwise store 0x0 to the 'CPU selector' register, to put i=
t
+              into a valid state and exit.
+              The iterator at this point equals "max_cpus".
--=20
2.7.4


