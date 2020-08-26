Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3703C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F018207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QaKSXMUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F018207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB2tk-0005aG-5Z
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k8-0008Pf-7M
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:36217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k4-0002VF-CO
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476432;
 bh=HXCvduzOIXsCQA5SfxLwuvEJdZ32wS45EDx3y1nQsa0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QaKSXMUD3P/1jeQeexokiKtj9BmQ+XUZzeJPthN7vMbZXv5lPAZ8lKlS9vOjy9qjL
 czPRXfymQJqrRNkC6JLA7GrQpGvy9NMzLGOlZxmE8rVJPtaJJRJROpsx3Mccmb02gx
 N+NkufX4aBSGY32L0khFgUq6dFMZxS9bggKlH2Ks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1kVzy10Rl7-00wpry; Wed, 26
 Aug 2020 23:13:52 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 12/12] hw/display/artist: Fix invalidation of lines near
 screen border
Date: Wed, 26 Aug 2020 23:13:45 +0200
Message-Id: <20200826211345.14295-13-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
References: <20200826211345.14295-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RDBnKHFf4kGQXA/YHvyQ9glHI3HKTUNV5XMnUmzEr9wSBdpMmug
 U5KHWtwxJQq+biP4eL/oTCPAmwnOMeyvje5jugKGdbIi6kcfZIDcIOO4Ysz+IobWkASU6iF
 T1rYo5uDXJD2xT/IteuqzrHyhLcbFXbZJHrHXBw4AdlthAo3OCHLLqRDYvU98Q98GKryPR4
 npMfCdcyrBlvJuAg/PBvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VD5TO7CI/F4=:mZky4WX7sw2QnUlebBVkJT
 qgsBZOrixgFAqYZBs0JZbs2frNs5XyegIsi4uNMffsdwtCnCmg2krpzWyEBWhjeB84YLDYdRh
 VTFocVJ3rW/6jj5ftnYzGcB6lPIM7nJ5u0Rk6EmPQuSCZQjkACUtKvRESa1RFxMNESOItpwzW
 9oCWEyPq89YoWzwqzj+Zlw9/Atz3HJ2eNnwUtw/RP3ONm7iaNPtE3dZUmWceBbtBlKSdHSbGJ
 ivLChlWK5/6pt6bjLfl8SrjB4wQH8zhJuOJoh8IvKx/1IWMUkm5VUvIOix04VnJX7Nd1MY6Zr
 eYe4YMiF6Yh9Qo0NoAVOZf0ZO69VO4ZipkJNWfvfGwL03Vstp/S/A1nhhtDu2fBYm+wA9cE3i
 rR4ZdN7befr0G5Xiwc6wG8AdIL/UMBXauxtMVOLtiLumxjFIahMEnlFxgDr5mEUNseZQgcB/F
 C4fhxCOaLqV82sFabAW0hMZ3JhWo0v6gH7iHVgLPAeBlK7EqsginUJU1oGpDCJ2pht1nMyyX6
 TokiOPzso7DwErjOQetokmHSb2p4DzhCBhSUNfFFBL9wJp4zui2uMEWuITV2IHEKV2uL3IysY
 6caKbtei+hb/UG0/uFSbTUvKHs3KGX3iasz7JMz+/3gBMnAy8BYmPYekGUmRVcve3WdKMmzNb
 nZxdVTHBt2wFZME2VI2jqim6ahVH5UpJBbOzFOsXlHEJwxVG8HvSPYMXNRKfEa/CoY7KE3y1Y
 WSMH/479FGM6bF7POlfgsaUiip34TDJlzDGKS9/BshaGT0/vnRdD6kgQEkecQS/kLpl06+m34
 kTyIHXoA1EjKihyYtCZjbWZCF9dqaXiOCe/0OjbGQMN2Hxoo2okgFVpCy1qAIpdsxB85xXYW8
 b5rectzPycoGCru2TVTOiebgSnk5rJw1UBLJNbbkCRKNZGFqjXxYxuHahKZWYY7VUcybfgitD
 YjZ4c0MYe6cN2HGU1BBfbvC6WcTsF5qow4u4Lm6r2lNPCTp64z7Yjev61La1Y3fmPNCqrt7Zs
 rEVl1CicVogu52a4G3baDyfm2SK2iWMW1+UG3qXwog62Zm7vllvgyCy5NcibnCIMzKL0i82Ow
 W3OuyqqFQ1gzpD2RRZSOVotn+j8aiD6tt+CLWx/fs9WOPFkZbqBK87pg3QneAAlg8frtyFUr2
 oe5bM7WAeB8ZLW4TjzbAdw7+9ltthJDCutf0R2n3kmQOKyRTH0bSQpfB/ybxAOzapw5XXYv5r
 b1dgCcxH4MlpaQixw
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 17:13:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sven Schnelle <svens@stackframe.org>

If parts of the invalidated screen lines are outside of the VRAM buffer,
the code skips the whole invalidate. This is incorrect when only parts
of the buffer are invisble - which is the case when the mouse cursor is
located near the screen border.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index a959b2c158..71982559c6 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -206,7 +206,12 @@ static void artist_invalidate_lines(struct vram_buffe=
r *buf,
                                     int starty, int height)
 {
     int start =3D starty * buf->width;
-    int size =3D height * buf->width;
+    int size;
+
+    if (starty + height > buf->height)
+        height =3D buf->height - starty;
+
+    size =3D height * buf->width;

     if (start + size <=3D buf->size) {
         memory_region_set_dirty(&buf->mr, start, size);
=2D-
2.21.3


