Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B5EC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C1720722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXzFcuji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C1720722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lgi-0006ov-2J
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXd-00067M-UO
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXc-0005em-1f
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32140
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXa-0005bv-6x
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582204013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnDlGhkDMc438YGrbvBovs3YxQJGj712XxeOh8S513U=;
 b=bXzFcujiUy8WThLAzWiyrVojuXhqpd51Xvn+J2tRCvL8TH2DdyGhwQTqowbuj7edFVT/ZR
 /Bn/AkdrraGHTAklTb6bcWdmzsgNzFNf5l3ipQS+X1slezfWLZ3PwKNwCu3YQqjLETpVVL
 3KsXvf0D2XG1BQk6yW+fB9PaaxwQXrQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-cMDgiJUsPiORV_ejrrfMPQ-1; Thu, 20 Feb 2020 08:06:51 -0500
Received: by mail-wr1-f69.google.com with SMTP id 50so1721328wrc.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U6IlttQWg5GixafQJKz3fjDa/v6plglwkRJYH67W75E=;
 b=TrlOYIYqb3piVS48NoxVhY1+nLdo37HAtkhy0GOLS/kO56o1UfyfCvehM8EGXUPAtc
 uEU1nA/6gFvOtsLSIQ0T3jRKufOU2Fa6E+r4Ok+51TKafo5E8gjEWDat8mjiiDnUaT/M
 EQAHv8sooaI7AgTsBur1kCNyO9H4yWkG+KBeQm9UVs/O41P11jTVG+ioFvoFb3niYwqa
 R9cPZwh6kq2EJqCPbA38OdNGBj24r/jO3rBJSp7SbUYHvZbC1YhgY+MH7U50mnONulq2
 QFX0lIHmYo6zel4I4K3H+k4KHhXM1ItbAVqaAKhRBr5AKYaFx4sMCP8ppRn8+fkkMAZx
 9rtQ==
X-Gm-Message-State: APjAAAVoN2PsbKGXF8/Jg5mWB/knTbqkqO4TAHULQIfo2LulepMK8y/T
 ViH9sYdGHvzmUSeuqz8zuIDikP+bagcBq+b+xNVlRUMd6YHIO2my06YGKwo8TuGxj81Ta4Oqlm9
 vAaRh7Wov+xVM4bY=
X-Received: by 2002:adf:cd92:: with SMTP id q18mr41684788wrj.261.1582204010381; 
 Thu, 20 Feb 2020 05:06:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVav3x+evHlrydubRXhyXAQPy/0YGFnLq+pw2hyskD3NJLge6kmK8LKicTlkzB4cX/rXzZiw==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr41684732wrj.261.1582204010138; 
 Thu, 20 Feb 2020 05:06:50 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 15/20] exec: Let address_space_unmap() use a boolean
 'is_write' argument
Date: Thu, 20 Feb 2020 14:05:43 +0100
Message-Id: <20200220130548.29974-16-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: cMDgiJUsPiORV_ejrrfMPQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'is_write' argument is either 0 or 1.
Convert it to a boolean type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/memory.h | 2 +-
 exec.c                | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index afee185eae..1614d9a02c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2329,7 +2329,7 @@ void *address_space_map(AddressSpace *as, hwaddr addr=
,
  * @is_write: indicates the transfer direction
  */
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
-                         int is_write, hwaddr access_len);
+                         bool is_write, hwaddr access_len);
=20
=20
 /* Internal functions, part of the implementation of address_space_read.  =
*/
diff --git a/exec.c b/exec.c
index 01437be691..16974d4f4b 100644
--- a/exec.c
+++ b/exec.c
@@ -3598,11 +3598,11 @@ void *address_space_map(AddressSpace *as,
 }
=20
 /* Unmaps a memory region previously mapped by address_space_map().
- * Will also mark the memory as dirty if is_write =3D=3D 1.  access_len gi=
ves
+ * Will also mark the memory as dirty if is_write is true.  access_len giv=
es
  * the amount of memory that was actually read or written by the caller.
  */
 void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
-                         int is_write, hwaddr access_len)
+                         bool is_write, hwaddr access_len)
 {
     if (buffer !=3D bounce.buffer) {
         MemoryRegion *mr;
--=20
2.21.1


