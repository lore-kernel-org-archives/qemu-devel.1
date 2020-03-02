Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B52AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267D121D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qIgOxgH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267D121D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8rfF-000073-Cn
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 15:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8reT-000896-AY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8reR-0002j2-Na
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:26:57 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:40533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8reR-0002in-HW
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:26:55 -0500
Received: by mail-oi1-x234.google.com with SMTP id j80so580400oih.7
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 12:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tFjBFDX+CYCuWQeFwI4hjQmG3H4hz4hHH6LqWbQXrBI=;
 b=qIgOxgH5KsT8F53wBTglZF5/eaKZEqcEhitCafmKlhsrpW4vVaYofqEo2LogqZQfd8
 LhISJGgEdQiwAEMo8W+ZlxD3Fe5vOz05G0749ruMI6+74bO7h/5S5a1RgjSeC2B4evFf
 UruWIeMZgLBHpgPg3AfGjMrHbyU/fCdluz48k9S+keDqa7BJj9SsFCVwuHZBRlgaYuRs
 5eC1W0X8Ab/d19OR2xbLYR9apHRNySeteP0qEU4K5jVkuY9I+e5URxgv0Cig3HDXwQP3
 W1N+uD5TEqvc4YbAoBkwXr7His0qbh8Y+MjB5ZEuSFto6CyyrqbLAs7EL8Hbnq9phPaD
 8IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tFjBFDX+CYCuWQeFwI4hjQmG3H4hz4hHH6LqWbQXrBI=;
 b=LydlD1Sq5G6ZMx7NyiTIDhqQeZfz1OjYva9c+co8ImGeoZT4tEHaPRkKZvUTPsY4Ch
 WeAKwv0jV+xpQCQN6IwoqlymjDGa8q6SPHcqRKe1dTRl9eAWJ30qJ8dMgdH9lTPjqZRM
 31MqbwlXPCTqRLqzgWcHMnftZN71GksqfG9XW+XoGax5VSXCHlBjw4b8+7mgMum0vfGl
 Sc7WHbX8XDrhg4Bt02Rbm3EPoIIPFpfUDTLbgqDF14wKZAnmbLfApRLv6zxd1ZpX90Wx
 x1Mc5FwzwGSegCgQDG6KVYtIsPCFwHu6ir8USz+1RrTe4rXMZpZaiKP9sBQ3dF88GQmf
 LqrA==
X-Gm-Message-State: ANhLgQ0dKcPru8o0y3ouAqRZ1ptQEnKZy/s1tQIzHsZcrSPu/9h8AMat
 Nwc+U89mwHMLnCltmY2bb1uQ/2KczpWNwr2TkxetgA==
X-Google-Smtp-Source: ADFU+vuAbUk9qYE65Rds5Hts+m14pzebWpZnS2fb4oAM8yr34VZgBoGFhsIYA2znLE0H6k4l5rikrVLcM4K8k2hAd2M=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr162263oid.98.1583180814500;
 Mon, 02 Mar 2020 12:26:54 -0800 (PST)
MIME-Version: 1.0
References: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1582810056-22646-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1582810056-22646-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 20:26:43 +0000
Message-ID: <CAFEAcA_ZL8kd+DaHz-debq7A2simEdB8GNzty890sfc=SjrByw@mail.gmail.com>
Subject: Re: [PULL 5/5] tests/acceptance: Count multiple Tux logos displayed
 on framebuffer
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 13:28, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Add a test that verifies that each core properly displays the Tux
> logo on the framebuffer device.
>
> We simply follow the OpenCV "Template Matching with Multiple Objects"
> tutorial, replacing Lionel Messi by Tux:
> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html

Hi -- this doesn't seem to work on my system:

 (38/74) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachine.tes=
t_integratorcp_console:
SKIP: untrusted code
 (39/74) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachine.tes=
t_framebuffer_tux_logo:
SKIP: Python NumPy not installed
 (40/74) tests/acceptance/machine_arm_n8x0.py:N8x0Machine.test_n800:
SKIP: untrusted code
 (41/74) tests/acceptance/machine_arm_n8x0.py:N8x0Machine.test_n810:
SKIP: untrusted code
 (42/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_boo=
trom_framebuffer_size:
PASS (3.47 s)
 (43/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_boo=
trom_framebuffer_ocr_with_tesseract_v3:
SKIP: tesseract v3 OCR tool not available
 (44/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test_boo=
trom_framebuffer_ocr_with_tesseract_v4:
SKIP: tesseract v4 OCR tool not available
 (45/74) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.tes=
t_mips_malta_i6400_framebuffer_logo_1core:
ERROR: name 'cv2' is not defined (5.43 s)

It looks like the @skipUnless directive on the class didn't
have any effect. Moving it to the individual test functions seems
to cause them to be skipped as intended (as the integratorcp
framebuffer test is):

diff --git a/tests/acceptance/machine_mips_malta.py
b/tests/acceptance/machine_mips_malta.py
index 92b4f28a112..98463f77573 100644
--- a/tests/acceptance/machine_mips_malta.py
+++ b/tests/acceptance/machine_mips_malta.py
@@ -30,8 +30,6 @@ except ImportError:
     CV2_AVAILABLE =3D False


-@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
-@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
 class MaltaMachineFramebuffer(Test):

     timeout =3D 30
@@ -91,6 +89,8 @@ class MaltaMachineFramebuffer(Test):
             cv2.imwrite(debug_png, screendump_bgr)
         self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)

+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
     def test_mips_malta_i6400_framebuffer_logo_1core(self):
         """
         :avocado: tags=3Darch:mips64el
@@ -99,6 +99,8 @@ class MaltaMachineFramebuffer(Test):
         """
         self.do_test_i6400_framebuffer_logo(1)

+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
     def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         :avocado: tags=3Darch:mips64el
@@ -108,6 +110,8 @@ class MaltaMachineFramebuffer(Test):
         """
         self.do_test_i6400_framebuffer_logo(7)

+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
     def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         """
         :avocado: tags=3Darch:mips64el

thanks
-- PMM

