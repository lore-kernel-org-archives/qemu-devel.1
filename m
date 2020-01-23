Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897CAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B8D21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6AcyHt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B8D21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufUq-00006q-00
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuh-0001rq-9A
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucug-0001SI-55
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56097
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucug-0001Ry-1j
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1DjEVvZ73yL/gkpoadGqlLEaUysWh+reLYcqqaGytt0=;
 b=H6AcyHt3AJqBv9qDaYKV+7jyH/jHFDZNYvksrx/kJXpegtXyMQ+iFAAdqqEa8aVKSJrTUA
 ALTXbYJ4TSuOuJnSusenH6Eq/EtXRqpbcT7rP5tgzGUoNsiHjSSNPnlm+rN5SabHQMC9ko
 1CAdxY55NZlDTP9AUCU3mtS4XVn0ccE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-d_HK_42uPIq7-KsM17BdgA-1; Thu, 23 Jan 2020 08:52:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6AB8801E78
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:46 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A45318575C;
 Thu, 23 Jan 2020 13:52:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 57/59] target/i386: Add the 'model-id' for Skylake -v3 CPU
 models
Date: Thu, 23 Jan 2020 14:50:47 +0100
Message-Id: <1579787449-27599-58-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: d_HK_42uPIq7-KsM17BdgA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kashyap Chamarthy <kchamart@redhat.com>

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
Message-Id: <20200123090116.14409-1-kchamart@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5fa6acc..32efa46 100644
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
1.8.3.1



