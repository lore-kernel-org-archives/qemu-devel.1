Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00963C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFCE24658
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8d+E3uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFCE24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9W2e-0000Aw-UT
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9W1h-0007Ao-Qz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9W1g-0003qb-PU
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44241
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9W1g-0003pM-M2
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583336016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q8+T2y2EUOXy4UOGSX8jY7OAnypdhI625RaxfhFsFz4=;
 b=I8d+E3uZ0OeOOBTf+MV7V6qf48mgwXVsX+WiYvuZXRxor4xC7zJQ5KeXlPdhtEqN2gwokg
 8BdFybskyT0yQW5D7VtpjAyxkT2tvo1T49PX83RGdiaEv1o/jfOlz9FELlRdt3OBHsrGca
 vCfWRpktuyqCxT8o8KCpv1TUE0o9EqI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-W-CXajbFMNale2BSYjGOAQ-1; Wed, 04 Mar 2020 10:33:32 -0500
X-MC-Unique: W-CXajbFMNale2BSYjGOAQ-1
Received: by mail-wm1-f70.google.com with SMTP id p186so705604wmp.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 07:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fYLVugFhvyMP9VPep4uY2EfonI9dvYdGAuHljfXSuxI=;
 b=Cj37vjadsXLm0UIHDaZjOxvgjkMPbQBpfap5TIz59ES4mYwUx5BiDFkgURG1V1PoN0
 oTN3Sq62fC+DDCs0ozXgrCezUQc18m7xb8X8VgS7PsarmdcguLpM1km4IYFugX5QaosJ
 z/5wCJI+ogNTPDhIqXqWfC2dNDz0G6Fzc3H+1VSwMjhbBJhzi7fjb3RMQMP/3z8Zkk9x
 ZOhRMyAGoSRZNTg3P0BHc2LCZvUUvgCdRno+mUayj9HFqI6Qq95u9vZ3C6MPX6owgeBY
 E0IilwwroepBjHmnVvLrW9jKu1wfIU0/yMIqnbwOreEdwM8zOOsWvkEWJq66TKN1ntno
 AnOA==
X-Gm-Message-State: ANhLgQ1uOExDuAtcccExO3Wmlywd+MeWDn+1BIEvelGbEdOWkiM4EdeM
 oDzId2yERAU7FdXT9L1VE1hcUfMGqxeXwcUPc3+gAOrZY3Bfuu2cOdmFzbJRoY4GeLuecdEw9Tg
 BZ/6bLissSJOKewU=
X-Received: by 2002:adf:f285:: with SMTP id k5mr4429584wro.45.1583336011488;
 Wed, 04 Mar 2020 07:33:31 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuDkTGaqvdahmJHBnwKXtZiQU18mwPT4++o/UW+A7a4NJqr/eYRcw0RPJowCxODkLgsnC4uUA==
X-Received: by 2002:adf:f285:: with SMTP id k5mr4429569wro.45.1583336011289;
 Wed, 04 Mar 2020 07:33:31 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id e8sm40950884wrr.69.2020.03.04.07.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 07:33:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/scsi/spapr_vscsi: Simplify a bit
Date: Wed,  4 Mar 2020 16:33:09 +0100
Message-Id: <20200304153311.22959-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304153311.22959-1-philmd@redhat.com>
References: <20200304153311.22959-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already have a ui pointer, use it (to simplify the next commit).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/scsi/spapr_vscsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 7e397ed797..3cb5a38181 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -261,9 +261,9 @@ static int vscsi_send_rsp(VSCSIState *s, vscsi_req *req=
,
     if (status) {
         iu->srp.rsp.sol_not =3D (sol_not & 0x04) >> 2;
         if (req->senselen) {
-            req->iu.srp.rsp.flags |=3D SRP_RSP_FLAG_SNSVALID;
-            req->iu.srp.rsp.sense_data_len =3D cpu_to_be32(req->senselen);
-            memcpy(req->iu.srp.rsp.data, req->sense, req->senselen);
+            iu->srp.rsp.flags |=3D SRP_RSP_FLAG_SNSVALID;
+            iu->srp.rsp.sense_data_len =3D cpu_to_be32(req->senselen);
+            memcpy(iu->srp.rsp.data, req->sense, req->senselen);
             total_len +=3D req->senselen;
         }
     } else {
--=20
2.21.1


