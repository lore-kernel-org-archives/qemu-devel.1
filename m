Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E702C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 09:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6977721734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 09:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTHxVIQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6977721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuYNc-0000MC-GO
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 04:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iuYMk-0008I2-79
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 04:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iuYMi-0002Jy-1t
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 04:01:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iuYMh-0002Gu-PK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 04:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579770086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JX42LSmQzRago9pH2mgSEb/OlV1JUNJ/DkuJ5CjTSnI=;
 b=FTHxVIQbCO3+L5YoHzYnfX7ystQRt0uZL15c5/NOoUE2jw0HpEgCc4uWygVb8NyPby/8xW
 63oL1XiQpcflaCK/DmFildpoXTdBL3t6q60yJd0i3t2rdSKj1ZH+g2NLYXg13NAxAHJaCN
 jBjynnjcjaxeRL9xjR5CSQF6WxZIUyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-T-0IFKC4MiqMwJJGJcQp5Q-1; Thu, 23 Jan 2020 04:01:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2271918C43C0;
 Thu, 23 Jan 2020 09:01:22 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-180.ams2.redhat.com
 [10.36.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 975BF5DA7D;
 Thu, 23 Jan 2020 09:01:20 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: Add the 'model-id' for Skylake -v3 CPU models
Date: Thu, 23 Jan 2020 10:01:15 +0100
Message-Id: <20200123090116.14409-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: T-0IFKC4MiqMwJJGJcQp5Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes a confusion in the help output.  (Although, if you squint
long enough at the '-cpu help' output, you _do_ notice that
"Skylake-Client-noTSX-IBRS" is an alias of "Skylake-Client-v3";
similarly for Skylake-Server-v3.)

Without this patch:

    $ qemu-system-x86 -cpu help
    ...
    x86 Skylake-Client-v1     Intel Core Processor (Skylake)
    x86 Skylake-Client-v2     Intel Core Processor (Skylake, IBRS)
    x86 Skylake-Client-v3     Intel Core Processor (Skylake, IBRS)
    ...
    x86 Skylake-Server-v1     Intel Xeon Processor (Skylake)
    x86 Skylake-Server-v2     Intel Xeon Processor (Skylake, IBRS)
    x86 Skylake-Server-v3     Intel Xeon Processor (Skylake, IBRS)
    ...

With this patch:

    $ ./qemu-system-x86 -cpu help
    ...
    x86 Skylake-Client-v1     Intel Core Processor (Skylake)
    x86 Skylake-Client-v2     Intel Core Processor (Skylake, IBRS)
    x86 Skylake-Client-v3     Intel Core Processor (Skylake, IBRS, no TSX)
    ...
    x86 Skylake-Server-v1     Intel Xeon Processor (Skylake)
    x86 Skylake-Server-v2     Intel Xeon Processor (Skylake, IBRS)
    x86 Skylake-Server-v3     Intel Xeon Processor (Skylake, IBRS, no TSX)
    ...

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 41f28cebf946c7dd77a066eac55623a7370730d5..821cab7f2a4eda43631359a95f7=
b3bb301b9788f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2905,6 +2905,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
                 .props =3D (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
+                    { "model-id",
+                      "Intel Core Processor (Skylake, IBRS, no TSX)" },
                     { /* end of list */ }
                 }
             },
@@ -3028,6 +3030,8 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
                 .props =3D (PropValue[]) {
                     { "hle", "off" },
                     { "rtm", "off" },
+                    { "model-id",
+                      "Intel Xeon Processor (Skylake, IBRS, no TSX)" },
                     { /* end of list */ }
                 }
             },
--=20
2.21.0


