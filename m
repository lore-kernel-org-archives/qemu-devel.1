Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8260EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF612072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S12HAy7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF612072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUoy-0005x5-Ue
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWX-00061z-47
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWU-0002X6-Rs
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22358
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWT-0002SG-BT
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6X5EBo5dshZ/LBY7+llNds3TSh1Xu5KuWlr5SUktLQ=;
 b=S12HAy7RKSnI05k49he1u+hvKM2NBYMvLatd3u+2uApS2CQUGa7huL+fHrimg9DOIqD6+/
 hZveThhLNwS9Vg/+FtJgUJ9YCipAAciC0c3Tpk9MQFAWohxiTlvqdVATPVP3ZS5G7ujqDa
 NnteCbZ7UsVMTwe4anoEZtcQ76vhOHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-63fbUR12Ozy-VxVCkGacsA-1; Wed, 18 Dec 2019 03:17:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CAC3800D5A;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 286567D903;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB660113642E; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 30/35] hw/tpm: rename Error ** parameter to more common errp
Date: Wed, 18 Dec 2019 09:17:16 +0100
Message-Id: <20191218081721.23520-31-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 63fbUR12Ozy-VxVCkGacsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20191205174635.18758-17-vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/tpm/tpm_emulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 22f9113432..10d587ed40 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -155,7 +155,7 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_e=
mu,
                                      const uint8_t *in, uint32_t in_len,
                                      uint8_t *out, uint32_t out_len,
                                      bool *selftest_done,
-                                     Error **err)
+                                     Error **errp)
 {
     ssize_t ret;
     bool is_selftest =3D false;
@@ -165,20 +165,20 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm=
_emu,
         is_selftest =3D tpm_util_is_selftest(in, in_len);
     }
=20
-    ret =3D qio_channel_write_all(tpm_emu->data_ioc, (char *)in, in_len, e=
rr);
+    ret =3D qio_channel_write_all(tpm_emu->data_ioc, (char *)in, in_len, e=
rrp);
     if (ret !=3D 0) {
         return -1;
     }
=20
     ret =3D qio_channel_read_all(tpm_emu->data_ioc, (char *)out,
-              sizeof(struct tpm_resp_hdr), err);
+              sizeof(struct tpm_resp_hdr), errp);
     if (ret !=3D 0) {
         return -1;
     }
=20
     ret =3D qio_channel_read_all(tpm_emu->data_ioc,
               (char *)out + sizeof(struct tpm_resp_hdr),
-              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), err);
+              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), errp);
     if (ret !=3D 0) {
         return -1;
     }
--=20
2.21.0


