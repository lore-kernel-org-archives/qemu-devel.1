Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3BDC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F1A20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRuTmzrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F1A20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOxp-0000Wn-Tn
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOvy-0006yU-7d
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOvt-0002KY-GO
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:01:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLfK-0008MU-3t
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5F5VGUrhvJ/6dwp4oORH6NykPEQT94CUfCEwFf8jKAI=;
 b=gRuTmzrlipJ+G0VE/i9jILhxh4/WUuefnDmrs1cg4WJosgegZGxzsarSwjJGSclsYu6Vab
 U6TL1mx4a1kViSdS2eQDQ0FiI4wR1S3EP7eJsm1u0Lgi0VKreK3JMzPb5sGfcWeZqsxKr/
 DcCKc6jy7QL2iKUzgnO2Qc8cY7RC6RY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-j-iFQrp8NIuLMlyoDjyX-A-1; Tue, 14 Apr 2020 09:31:44 -0400
X-MC-Unique: j-iFQrp8NIuLMlyoDjyX-A-1
Received: by mail-wm1-f69.google.com with SMTP id n127so3769576wme.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TyZlA8S5K4aOaRBq4xW9gDApmrrmteGX4XubxYmsTLk=;
 b=L+4DzkCE+sYx2MXMIBFQPPWYx5DNX81I6uTbu8U2RzoLIGpOOwMYn6S19TpWp6di/2
 N0dl9RY3Dibm1r0YS2ZxyqfE18OFXrlv8osX8spXdc/QsqVFsy45dHj9mCnT04Yayu2G
 7YdqxD4Ho1MWCIhCo9mkb5FIM+Hm8DJQ/F+fHoT7HWBM8oRhWhdajEXQviPr8MiO3a20
 kVEMGdM9s4tRvQthc4dl7w2UbKmOOqsg7R9p5Fen7yZfhg85LK/ETbJjvpUmJM7bNsmY
 Hz6RegsMYAbQDl00mgOMhs/AEI7RdpGotQUSURAvXQ3ZaOubDBYgj7uqwpjVO5lBnzj6
 bXuw==
X-Gm-Message-State: AGi0PuZtO6YSssKFGKQ9+xPpi6Y5nY7/H/qCONYIJ2aGxqBENAiiPuMB
 DH+WIpvRVPpi+7aYZFlsiulDyOc0PBQg61I2IGc3J5BLnW3eptJtQVXhhSdiqUHYF1QUVJuCijh
 JhHbMUxliip62bxI=
X-Received: by 2002:adf:f1c2:: with SMTP id z2mr25296875wro.40.1586871101510; 
 Tue, 14 Apr 2020 06:31:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypJP6fHl4xNW7Nqa11UFZNTCw4vVRGUyy4CcjNllaD1Gvcu9E5d3AraZgLgF6aFxBzGxafB78g==
X-Received: by 2002:adf:f1c2:: with SMTP id z2mr25296846wro.40.1586871101209; 
 Tue, 14 Apr 2020 06:31:41 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j68sm19680265wrj.32.2020.04.14.06.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 06:31:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 09/12] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
Date: Tue, 14 Apr 2020 15:30:49 +0200
Message-Id: <20200414133052.13712-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414133052.13712-1-philmd@redhat.com>
References: <20200414133052.13712-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Zhang Zi Ming <1015138407@qq.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Zhang Zi Ming reported a heap overflow in the Drawing Engine of
the SM501 companion chip model, in particular in the COPY_AREA()
macro in sm501_2d_operation().

Add a simple check to avoid the heap overflow.

This fixes:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  =3D=3D20518=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x7f6f4c3fffff at pc 0x55b1e1d358f0 bp 0x7ffce464dfb0 sp 0x7ffce464dfa8
  READ of size 1 at 0x7f6f4c3fffff thread T0
      #0 0x55b1e1d358ef in sm501_2d_operation hw/display/sm501.c:788:13
      #1 0x55b1e1d32c38 in sm501_2d_engine_write hw/display/sm501.c:1466:13
      #2 0x55b1e0cd19d8 in memory_region_write_accessor memory.c:483:5
      #3 0x55b1e0cd1404 in access_with_adjusted_size memory.c:544:18
      #4 0x55b1e0ccfb9d in memory_region_dispatch_write memory.c:1476:16
      #5 0x55b1e0ae55a8 in flatview_write_continue exec.c:3125:23
      #6 0x55b1e0ad3e87 in flatview_write exec.c:3165:14
      #7 0x55b1e0ad3a24 in address_space_write exec.c:3256:18

  0x7f6f4c3fffff is located 4194303 bytes to the right of 4194304-byte regi=
on [0x7f6f4bc00000,0x7f6f4c000000)
  allocated by thread T0 here:
      #0 0x55b1e0a6e715 in __interceptor_posix_memalign (ppc64-softmmu/qemu=
-system-ppc64+0x19c0715)
      #1 0x55b1e31c1482 in qemu_try_memalign util/oslib-posix.c:189:11
      #2 0x55b1e31c168c in qemu_memalign util/oslib-posix.c:205:27
      #3 0x55b1e11a00b3 in spapr_reallocate_hpt hw/ppc/spapr.c:1560:23
      #4 0x55b1e11a0ce4 in spapr_setup_hpt hw/ppc/spapr.c:1593:5
      #5 0x55b1e11c2fba in spapr_machine_reset hw/ppc/spapr.c:1644:9
      #6 0x55b1e1368b01 in qemu_system_reset softmmu/vl.c:1391:9
      #7 0x55b1e1375af3 in qemu_init softmmu/vl.c:4436:5
      #8 0x55b1e2fc8a59 in main softmmu/main.c:48:5
      #9 0x7f6f8150bf42 in __libc_start_main (/lib64/libc.so.6+0x23f42)

  SUMMARY: AddressSanitizer: heap-buffer-overflow hw/display/sm501.c:788:13=
 in sm501_2d_operation
  Shadow bytes around the buggy address:
    0x0fee69877fa0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0fee69877fb0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0fee69877fc0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0fee69877fd0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0fee69877fe0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  =3D>0x0fee69877ff0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa[fa]
    0x0fee69878000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0fee69878010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0fee69878020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0fee69878030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0fee69878040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  Shadow byte legend (one shadow byte represents 8 application bytes):
    Addressable:           00
    Partially addressable: 01 02 03 04 05 06 07
    Heap left redzone:       fa
    Freed heap region:       fd
    Poisoned by user:        f7
    ASan internal:           fe
  =3D=3D20518=3D=3DABORTING

Cc: qemu-stable@nongnu.org
Fixes: 07d8a50cb0e ("sm501: add 2D engine copyrect support")
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1786026
Reported-by: Zhang Zi Ming <1015138407@qq.com>
Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200413220100.18628-1-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/display/sm501.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index de0ab9d977..902acb3875 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -726,6 +726,12 @@ static void sm501_2d_operation(SM501State *s)
     int crt =3D (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
     int fb_len =3D get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt=
);
=20
+    if (rtl && (src_x < operation_width || src_y < operation_height)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "sm501: Illegal RTL address (%i, %i=
)\n",
+                      src_x, src_y);
+        return;
+    }
+
     if (addressing !=3D 0x0) {
         printf("%s: only XY addressing is supported.\n", __func__);
         abort();
--=20
2.21.1


