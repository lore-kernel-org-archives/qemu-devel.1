Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBBEC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5A42080A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dacR37Ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5A42080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ5lV-0000fu-62
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 05:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ5kt-0008W3-LQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:29:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:56234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ5kq-00083a-JF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:29:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id d4so1539611wmd.5
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/hNZPjZ9WvEhyG9rJ+9mXwP/eEmTwUSEEvcX6A8ZY0U=;
 b=dacR37Ob6ihIN0EVqXunlmG+GdxBT17penTUb+pVL3qa7h79UwBtt/TU2loXM7AM+D
 y1vBkHqcRNaIly97nY1k5Xe5Vp27bHDBg1Ye334fuTrROrr7azgafLCSSFBhuf7kuB3T
 nEn08nVsmIaDnW3jEo2HrHX5/1eWXSqWsXfbc09LN8T6KltMwOcQALyLVWtt3Byq9gnB
 vG2FS9LZpKtKENSMlrctrIcrcOgbPtzJqdKHrCLjnNZ8HUhLA84QQz8hs0LMKI9MvsL7
 eiqFBc+ocPTnWE8Si6hVzbJ2mns8J4e+8QfNVqmkg0m9rpJ2IGcoOp1xbcW+Z/8hMuJi
 Xbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/hNZPjZ9WvEhyG9rJ+9mXwP/eEmTwUSEEvcX6A8ZY0U=;
 b=TEMHRXHnMm6mkAMlIc4ogqzhjM77y0+f0gI9Xmm2PY/XjDg0f0y9KDRvT71ZEEtEkj
 TYT17ySmAjUKKFhJn3SUhIfGsAkKQCjuRGTbRHQK+xhKGX8SdTlOW4dfDAkgz8/obnA5
 LnK5/3Wv8mIWX0DbD1GcUIk3io08Bdd1FgUOxLpFXQR/ln8EfvbkGByOfQ3SoF7iBL2A
 LVixm4HzU8re08gLbOSVmSHJ2Zqg5yoaoM6qvD+/4US2gUclDN6ys6s1grsGHSHoScj+
 Bl2k5Lmy7tiJKiBM4rIcu9yyz8zlZYypnX0Zt9FcA1uCMvarY9ybnxveIot+UJYi9I2K
 3bOw==
X-Gm-Message-State: AOAM532YjbAnNNLSDPLqUGYiFcIlfG4+O10VLn1q5IejpEuKOaghXEVa
 r68pIGRXEZ8fNWduIsqLOyUtPw==
X-Google-Smtp-Source: ABdhPJyTDwKtH79sZ85njCgtVZwL5aYJRQIaAFeTKjRut8hnXcZoKacxOws9nAH4jCGgovL6hhYjzg==
X-Received: by 2002:a1c:7f97:: with SMTP id a145mr2387510wmd.160.1602062938657; 
 Wed, 07 Oct 2020 02:28:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z127sm1943298wmc.2.2020.10.07.02.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 02:28:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 77EE51FF7E;
 Wed,  7 Oct 2020 10:28:56 +0100 (BST)
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
 <20200908051953.1616885-20-david@gibson.dropbear.id.au>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PULL 19/33] mips/cps: Use start-powered-off CPUState property
In-reply-to: <20200908051953.1616885-20-david@gibson.dropbear.id.au>
Date: Wed, 07 Oct 2020 10:28:56 +0100
Message-ID: <87h7r61j1j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, danielhb413@gmail.com, groug@kaod.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 bauerman@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Gibson <david@gibson.dropbear.id.au> writes:

> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> Instead of setting CPUState::halted to 1 in main_cpu_reset(), use the
> start-powered-off property which makes cpu_common_reset() initialize it
> to 1 in common code.
>
> Also change creation of CPU object from cpu_create() to object_new() and
> qdev_realize_and_unref() because cpu_create() realizes the CPU and it's n=
ot
> possible to set a property after the object is realized.
>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Message-Id: <20200826055535.951207-6-bauerman@linux.ibm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

I've finally bisected the breakage in check-acceptance to this patch:

  10:24:09 [alex.bennee@hackbox2:~/l/q/b/bisect] (102ca966=E2=80=A6)|BISECT=
ING|=E2=9C=94 + ./tests/venv/bin/avocado run tests/acceptance/machine_mips_=
malta.py
  /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python3.6/si=
te-packages/avocado/plugins/run.py:214: FutureWarning: The following argume=
nts will be changed to boolean soon: sysinfo, output-check, failfast, keep-=
tmp and ignore-missing-references.
    FutureWarning)
  JOB ID     : 1a71a0a81cf9fb9a387d2ab105f8196a26cab84e
  JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-07T10.24-1=
a71a0a/job.log
   (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.tes=
t_mips_malta_i6400_framebuffer_logo_1core: PASS (5.70 s)
   (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.tes=
t_mips_malta_i6400_framebuffer_logo_7cores: INTERRUPTED: Test interrupted b=
y SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n=
{'name': '2-tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_7cores',
  'logdir': '/home/alex.bennee/avocado/job-r... (28.91 s)
   (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.tes=
t_mips_malta_i6400_framebuffer_logo_8cores: INTERRUPTED: Test interrupted b=
y SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n=
{'name': '3-tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_8cores',
  'logdir': '/home/alex.bennee/avocado/job-r... (30.58 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 | =
CANCEL 0
  JOB TIME   : 70.12 s
  10:25:27 [alex.bennee@hackbox2:~/l/q/b/bisect] (102ca966=E2=80=A6)|BISECT=
ING|=E2=9C=94 8 + make -j30
  make[1]: Entering directory '/home/alex.bennee/lsrc/qemu.git/slirp'
  make[1]: Nothing to be done for 'all'.
  make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/slirp'
  Generating qemu-version.h with a meson_exe.py custom command
  Compiling C object libqemu-mips64el-softmmu.fa.p/hw_mips_cps.c.o
  Compiling C object libqemu-mips64-softmmu.fa.p/hw_mips_cps.c.o
  Compiling C object libqemu-mipsel-softmmu.fa.p/hw_mips_cps.c.o
  Compiling C object libqemu-mips-softmmu.fa.p/hw_mips_cps.c.o
  Linking target qemu-system-mips
  Linking target qemu-system-mips64el
  Linking target qemu-system-mips64
  Linking target qemu-system-mipsel
  10:26:26 [alex.bennee@hackbox2:~/l/q/b/bisect] (a2c93f06=E2=80=A6)|BISECT=
ING|=E2=9C=94 + ./tests/venv/bin/avocado run tests/acceptance/machine_mips_=
malta.py
  /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python3.6/si=
te-packages/avocado/plugins/run.py:214: FutureWarning: The following argume=
nts will be changed to boolean soon: sysinfo, output-check, failfast, keep-=
tmp and ignore-missing-references.
    FutureWarning)
  JOB ID     : ccf294ef4e5ebdf19b3a0b53479d574df4ea54ea
  JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-07T10.26-c=
cf294e/job.log
   (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.tes=
t_mips_malta_i6400_framebuffer_logo_1core: PASS (5.82 s)
   (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.tes=
t_mips_malta_i6400_framebuffer_logo_7cores: PASS (15.16 s)
   (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.tes=
t_mips_malta_i6400_framebuffer_logo_8cores: PASS (15.97 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 40.01 s

> ---
>  hw/mips/cps.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 615e1a1ad2..23c0f87e41 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -52,9 +52,6 @@ static void main_cpu_reset(void *opaque)
>      CPUState *cs =3D CPU(cpu);
>=20=20
>      cpu_reset(cs);
> -
> -    /* All VPs are halted on reset. Leave powering up to CPC. */
> -    cs->halted =3D 1;
>  }
>=20=20
>  static bool cpu_mips_itu_supported(CPUMIPSState *env)
> @@ -76,7 +73,17 @@ static void mips_cps_realize(DeviceState *dev, Error *=
*errp)
>      bool saar_present =3D false;
>=20=20
>      for (i =3D 0; i < s->num_vp; i++) {
> -        cpu =3D MIPS_CPU(cpu_create(s->cpu_type));
> +        cpu =3D MIPS_CPU(object_new(s->cpu_type));
> +
> +        /* All VPs are halted on reset. Leave powering up to CPC. */
> +        if (!object_property_set_bool(OBJECT(cpu), "start-powered-off", =
true,
> +                                      errp)) {
> +            return;
> +        }
> +
> +        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
> +            return;
> +        }
>=20=20
>          /* Init internal devices */
>          cpu_mips_irq_init_cpu(cpu);


--=20
Alex Benn=C3=A9e

