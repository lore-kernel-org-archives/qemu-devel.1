Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B69C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417D6208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOMg4dwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417D6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iae5F-0005F3-7i
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iadD3-0000XS-Sy
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iadCm-0004d1-Ln
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:08:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iadCm-0004OW-I8
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575022128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JntduGVPnovslM3w6eXjQkNXJznSTMtCtIW0cq3CicQ=;
 b=bOMg4dwJb+SGKZ9yhh2T+iZd9eDdjL+HfL/NqwbuKg+ZsY4AT9bx+dboMmxEdcit8Yj9hd
 fkwrlWA3OvOfKzIJV38iwz3Wrqymjt+XJiGtgNCgWkUoGh6rY79cJHEmKpGsAFQvSCmv6f
 1AOQCT+JwNiPyiALfKPqr2I2+wiLlf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-1qtNUzIvNN-VB31_-Fb4NQ-1; Fri, 29 Nov 2019 05:08:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66DAC801E58;
 Fri, 29 Nov 2019 10:08:43 +0000 (UTC)
Received: from thuth.com (ovpn-116-159.ams2.redhat.com [10.36.116.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B20605D6D2;
 Fri, 29 Nov 2019 10:08:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/2] pc-bios/s390-ccw: fix sclp_get_loadparm_ascii
Date: Fri, 29 Nov 2019 11:08:34 +0100
Message-Id: <20191129100835.21734-2-thuth@redhat.com>
In-Reply-To: <20191129100835.21734-1-thuth@redhat.com>
References: <20191129100835.21734-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 1qtNUzIvNN-VB31_-Fb4NQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

The existing s390 bios gets the LOADPARM information from the system using
an SCLP call that specifies a buffer length too small to contain all the
output.

The recent fixes in the SCLP code have exposed this bug, since now the
SCLP call will return an error (as per architecture) instead of
writing partially and completing successfully.

The solution is simply to specify the full page length as the SCCB
length instead of a smaller size.

Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
Fixes: 9a22473c70f3 ("pc-bios/s390-ccw: get LOADPARM stored in SCP Read Inf=
o")

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-Id: <1574944437-31182-1-git-send-email-imbrenda@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/sclp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index c0223fab0b..7251f9af4d 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -112,7 +112,7 @@ void sclp_get_loadparm_ascii(char *loadparm)
     ReadInfo *sccb =3D (void *)_sccb;
=20
     memset((char *)_sccb, 0, sizeof(ReadInfo));
-    sccb->h.length =3D sizeof(ReadInfo);
+    sccb->h.length =3D SCCB_SIZE;
     if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
         ebcdic_to_ascii((char *) sccb->loadparm, loadparm, LOADPARM_LEN);
     }
--=20
2.18.1


