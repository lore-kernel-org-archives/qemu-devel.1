Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A96C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA4D20848
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REPgk9Bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA4D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j976M-0006UT-9x
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 07:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j975a-0005ps-Dp
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j975X-0007iQ-3P
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:55:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j975W-0007i1-GC
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583240152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLhe/kKqCVtvxBdE22/XwWd33eNtzhTJHW6pvMBfwzs=;
 b=REPgk9BoBEY/brUVyNJg8+jhYEf/52E26GtdiXp7+R1QuhdGK1fdEIhCWyB04l11PSP39H
 bOOx9Ycr081OJDfzpd8W3a4Bg4yPp6SbONKFRmZDz11AllgUstOrZgM1RXV7IE8BuQVdyc
 Q5jiKV+4KPWWQGTW9xwCJccm2yVyjJQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-F8eL_0NDPO6UFWYSWTUpAA-1; Tue, 03 Mar 2020 07:55:49 -0500
X-MC-Unique: F8eL_0NDPO6UFWYSWTUpAA-1
Received: by mail-wr1-f71.google.com with SMTP id o9so1182023wrw.14
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 04:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mLhe/kKqCVtvxBdE22/XwWd33eNtzhTJHW6pvMBfwzs=;
 b=j3GBdPt73ysLIqhPhQB83Um3WQXpX4jQ+UDFxgIjbQQXiVJMGfUijppQFY0y1UB2Eq
 N/Je6EGYzcRHpzusADcL0LKRDOYywzTMWuZ6ekDQFcrbIgP8FlbQpSVWDuSDUwZEH3iC
 4+dN5/2/RSgm/mGf5AkYLbne9V3TDRu9/kiocmhjY6viUUHBwfLrYrQ19GvPKvs337XR
 +4xPKKlRXYGEy4xHgnWv35gVm14scwuuSiWmgPK4h1T1NjjRssA/3cksH58hRNPp+IzR
 +0TKUONOtiogc6ADpTc5Jo/JyfvuXs5of/8oAF4qnIBx0p2iSplrXWTYPoECkExRrSIk
 +dHA==
X-Gm-Message-State: ANhLgQ2211GSZIQydIHxHiLqDV+QGTpVHUV7pD5v476xC50XcIx0Ai25
 /tBl0LBCyveTTIizWfjWEJArSLRFv2D8n0kSbaUDJeaTzRwLxE2qYEFPAetKhpXbSCzlIyXVUVv
 fjh5iWIHK6HwwdRocFWOHwOTz+zE7eH8=
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr5839055wro.204.1583240148044; 
 Tue, 03 Mar 2020 04:55:48 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuWfvTmX8aJLWmj2B8dpMqjzyAzIOutV7XyTEuzseFu922RUcqj1tuV3TfBt3FBVaBPlFE+43jGZSrC3lcnhUo=
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr5839036wro.204.1583240147816; 
 Tue, 03 Mar 2020 04:55:47 -0800 (PST)
MIME-Version: 1.0
References: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1582810056-22646-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAFEAcA_ZL8kd+DaHz-debq7A2simEdB8GNzty890sfc=SjrByw@mail.gmail.com>
 <BN6PR2201MB12519E5CF54B5C921CD4404AC6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <741a03d4-4aa0-4782-771b-98468042c060@redhat.com>
In-Reply-To: <741a03d4-4aa0-4782-771b-98468042c060@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 3 Mar 2020 13:55:35 +0100
Message-ID: <CAP+75-WyFM7jKmBxiti5PMSJskmztQ7RLrTK72aW9LiLAWh+cw@mail.gmail.com>
Subject: Re: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux
 logos displayed on framebuffer
To: Peter Maydell <peter.maydell@linaro.org>, 
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Cleber Rosa <crosa@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber,

 On Tue, Mar 3, 2020 at 12:40 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 3/2/20 9:58 PM, Aleksandar Markovic wrote:
> >> From: Peter Maydell <peter.maydell@linaro.org>
> >> Sent: Monday, March 2, 2020 9:26 PM
> >> To: Aleksandar Markovic
> >> Cc: QEMU Developers; Aleksandar Markovic; Philippe Mathieu-Daud=C3=A9
> >> Subject: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux=
 logos displayed on framebuffer
> >>
> >> On Thu, 27 Feb 2020 at 13:28, Aleksandar Markovic
> >> <aleksandar.markovic@rt-rk.com> wrote:
> >>>
> >>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>
> >>> Add a test that verifies that each core properly displays the Tux
> >>> logo on the framebuffer device.
> >>>
> >>> We simply follow the OpenCV "Template Matching with Multiple Objects"
> >>> tutorial, replacing Lionel Messi by Tux:
> >>> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.ht=
ml
> >>
> >> Hi -- this doesn't seem to work on my system:
> >>
> >
> > Thank you for bringing this to our attention.
> >
> > It looks like an honest mistake to me. Too bad
> > none of us tested the case of environment like
> > yours, even though it looked reasonable to test it.
>
> I'm sorry I missed that, I'm pretty sure I tested it as we noticed this
> "bug" in Avocado more than 1 year ago already (bug =3D class decorator no=
t
> working).

I see in commit 2fe6f4d9ba you moved the @skip decorators to the setUp() me=
thod.
Is this a kind of kludge to not use it on all the test_*() methods?
(since we can not use it on an AvocadoTest class)

> I suppose I forgot to test that on Travis-CI and all my
> systems have opencv2 installed.
>
> >
> > Philippe, Peter's solution looks good to me. What
> > do you think?
>
> Yes this is correct. Alex suggested it earlier and I resend his patch
> fixed which is exactly the diff Peter pasted (I am just noticing it now):
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00389.html
>
> >
> > Peter, would you like me to submit a patch with your
> > proposal, authored by you, and than soon send it as
> > a part of a small pull request?
> >
> > Thanks again,
> > Aleksandar
> >
> >>   (38/74) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachi=
ne.test_integratorcp_console:
> >> SKIP: untrusted code
> >>   (39/74) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachi=
ne.test_framebuffer_tux_logo:
> >> SKIP: Python NumPy not installed
> >>   (40/74) tests/acceptance/machine_arm_n8x0.py:N8x0Machine.test_n800:
> >> SKIP: untrusted code
> >>   (41/74) tests/acceptance/machine_arm_n8x0.py:N8x0Machine.test_n810:
> >> SKIP: untrusted code
> >>   (42/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.te=
st_bootrom_framebuffer_size:
> >> PASS (3.47 s)
> >>   (43/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.te=
st_bootrom_framebuffer_ocr_with_tesseract_v3:
> >> SKIP: tesseract v3 OCR tool not available
> >>   (44/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.te=
st_bootrom_framebuffer_ocr_with_tesseract_v4:
> >> SKIP: tesseract v4 OCR tool not available
> >>   (45/74) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuff=
er.test_mips_malta_i6400_framebuffer_logo_1core:
> >> ERROR: name 'cv2' is not defined (5.43 s)
> >>
> >> It looks like the @skipUnless directive on the class didn't
> >> have any effect. Moving it to the individual test functions seems
> >> to cause them to be skipped as intended (as the integratorcp
> >> framebuffer test is):
> >>
> >> diff --git a/tests/acceptance/machine_mips_malta.py
> >> b/tests/acceptance/machine_mips_malta.py
> >> index 92b4f28a112..98463f77573 100644
> >> --- a/tests/acceptance/machine_mips_malta.py
> >> +++ b/tests/acceptance/machine_mips_malta.py
> >> @@ -30,8 +30,6 @@ except ImportError:
> >>       CV2_AVAILABLE =3D False
> >>
> >>
> >> -@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> >> -@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> >>   class MaltaMachineFramebuffer(Test):
> >>
> >>       timeout =3D 30
> >> @@ -91,6 +89,8 @@ class MaltaMachineFramebuffer(Test):
> >>               cv2.imwrite(debug_png, screendump_bgr)
> >>           self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
> >>
> >> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> >> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> >>       def test_mips_malta_i6400_framebuffer_logo_1core(self):
> >>           """
> >>           :avocado: tags=3Darch:mips64el
> >> @@ -99,6 +99,8 @@ class MaltaMachineFramebuffer(Test):
> >>           """
> >>           self.do_test_i6400_framebuffer_logo(1)
> >>
> >> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> >> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> >>       def test_mips_malta_i6400_framebuffer_logo_7cores(self):
> >>           """
> >>           :avocado: tags=3Darch:mips64el
> >> @@ -108,6 +110,8 @@ class MaltaMachineFramebuffer(Test):
> >>           """
> >>           self.do_test_i6400_framebuffer_logo(7)
> >>
> >> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> >> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
> >>       def test_mips_malta_i6400_framebuffer_logo_8cores(self):
> >>           """
> >>           :avocado: tags=3Darch:mips64el
> >>
> >> thanks
> >> -- PMM
> >
> >


