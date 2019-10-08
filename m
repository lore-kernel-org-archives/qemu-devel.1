Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F932C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A43E2064A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="OnPx92mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A43E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqF0-0003vN-R6
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iHq6H-0002RI-Cp
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iHq6A-0001d0-AF
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:04:27 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:12094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iHq67-0000eZ-P7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:04:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1570543460; h=Content-Type: Cc: To: Subject: Message-ID: Date: From:
 In-Reply-To: References: MIME-Version: Sender;
 bh=ARcmfoo+pNlCLcWaW1bmfG72qrKEQJ7pT54h3e3Iz6g=;
 b=OnPx92mgoHZ1kOlPZAwHsDV1gynRlK6FY/GjLvg5vieSbSBKRvQW0oWfryaZPymL92+bGUTZ
 hui0gUP2dYmrdRrDIb1YRFuHSqNLttEBszBaAzVulhaO5Qlttpzy24qLWV9u4MqwHjdVsOaT
 QQb2ZzmiBcGvqER6f2SyALnO0sZnw9rC0XL0HJsnpt0ng+jxBvikYpoqumwK9es4VKqhvDJs
 GsbtkB3Wyr5G9Vdrku3lSXAHv+S00q3D66K8fCsNoe9FJ8ZPkzw2/c3OSJkdBe5EaAzb1EM2
 aZJz696iMoB+GZIgiwgmQ4o75y8OEtKSiu9t8870VrUjffqkeIaRKw==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by mxa.mailgun.org with ESMTP id 5d9c975f.7f04ba04ddb0-smtp-out-n02;
 Tue, 08 Oct 2019 14:04:15 -0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id y23so17666699lje.9;
 Tue, 08 Oct 2019 07:04:14 -0700 (PDT)
X-Gm-Message-State: APjAAAXRLyH+BNBeIn5LusIqoI6hvUF8lizoRj79HnsfLqDlUJTDKfhd
 dn3eAXpIDBT3MXjgGQA6G6vpvLdJWlUe3I8ZOeg=
X-Google-Smtp-Source: APXvYqwHj7+W5g+aM0u0KXofntuYBm4LWkZSX4gDECu0K1UMJZZ5WtsTb/n25vXK0iYSVIilrmkmw8bWIc3vQBaAPJw=
X-Received: by 2002:a2e:29dc:: with SMTP id p89mr22872031ljp.228.1570543452435; 
 Tue, 08 Oct 2019 07:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191008001318.219367-1-jonathan@fintelia.io>
 <20191008001318.219367-3-jonathan@fintelia.io>
 <CAEUhbmWcwUhVjO97z7z3prg1WYU4ushOBgDMW9_ruaMk4___Zg@mail.gmail.com>
In-Reply-To: <CAEUhbmWcwUhVjO97z7z3prg1WYU4ushOBgDMW9_ruaMk4___Zg@mail.gmail.com>
From: Jonathan Behrens <jonathan@fintelia.io>
Date: Tue, 8 Oct 2019 10:03:07 -0400
X-Gmail-Original-Message-ID: <CANnJOVHmJfyRmkeCTebCSc92bMEjBx6UYryS9MD4WhiJHvq+fA@mail.gmail.com>
Message-ID: <CANnJOVHmJfyRmkeCTebCSc92bMEjBx6UYryS9MD4WhiJHvq+fA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] target/riscv: Expose priv register for GDB for
 reads
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.61.151.224
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 8, 2019 at 8:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Tue, Oct 8, 2019 at 8:18 AM Jonathan Behrens <jonathan@fintelia.io> wrote:
> >
> > This patch enables a debugger to read the current privilege level via a virtual
> > "priv" register. When compiled with CONFIG_USER_ONLY the register is still
> > visible but always reports the value zero.
> >
> > Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> > ---
> >  configure                       |  4 ++--
> >  gdb-xml/riscv-32bit-virtual.xml | 11 +++++++++++
> >  gdb-xml/riscv-64bit-virtual.xml | 11 +++++++++++
> >  target/riscv/gdbstub.c          | 23 +++++++++++++++++++++++
> >  4 files changed, 47 insertions(+), 2 deletions(-)
> >  create mode 100644 gdb-xml/riscv-32bit-virtual.xml
> >  create mode 100644 gdb-xml/riscv-64bit-virtual.xml
> >
> > diff --git a/configure b/configure
> > index 30544f52e6..6118a6a045 100755
> > --- a/configure
> > +++ b/configure
> > @@ -7520,13 +7520,13 @@ case "$target_name" in
> >      TARGET_BASE_ARCH=riscv
> >      TARGET_ABI_DIR=riscv
> >      mttcg=yes
> > -    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml"
> > +    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
> >    ;;
> >    riscv64)
> >      TARGET_BASE_ARCH=riscv
> >      TARGET_ABI_DIR=riscv
> >      mttcg=yes
> > -    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
> > +    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
> >    ;;
> >    sh4|sh4eb)
> >      TARGET_ARCH=sh4
> > diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-virtual.xml
> > new file mode 100644
> > index 0000000000..905f1c555d
> > --- /dev/null
> > +++ b/gdb-xml/riscv-32bit-virtual.xml
> > @@ -0,0 +1,11 @@
> > +<?xml version="1.0"?>
> > +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
> > +
> > +     Copying and distribution of this file, with or without modification,
> > +     are permitted in any medium without royalty provided the copyright
> > +     notice and this notice are preserved.  -->
> > +
> > +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > +<feature name="org.gnu.gdb.riscv.virtual">
> > +  <reg name="priv" bitsize="32"/>
> > +</feature>
> > diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-virtual.xml
> > new file mode 100644
> > index 0000000000..62d86c237b
> > --- /dev/null
> > +++ b/gdb-xml/riscv-64bit-virtual.xml
> > @@ -0,0 +1,11 @@
> > +<?xml version="1.0"?>
> > +<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
> > +
> > +     Copying and distribution of this file, with or without modification,
> > +     are permitted in any medium without royalty provided the copyright
> > +     notice and this notice are preserved.  -->
> > +
> > +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > +<feature name="org.gnu.gdb.riscv.virtual">
> > +  <reg name="priv" bitsize="64"/>
> > +</feature>
> > diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> > index cb5bfd3d50..33cf7c4c7d 100644
> > --- a/target/riscv/gdbstub.c
> > +++ b/target/riscv/gdbstub.c
> > @@ -373,6 +373,23 @@ static int riscv_gdb_set_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
> >      return 0;
> >  }
> >
> > +static int riscv_gdb_get_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
> > +{
> > +    if (n == 0) {
> > +#ifdef CONFIG_USER_ONLY
> > +        return gdb_get_regl(mem_buf, 0);
> > +#else
> > +        return gdb_get_regl(mem_buf, cs->priv);
> > +#endif
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
> > +{
> > +    return 0;
> > +}
> > +
> >  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
> >  {
> >      RISCVCPU *cpu = RISCV_CPU(cs);
> > @@ -385,6 +402,9 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
> >
> >      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
> >                               240, "riscv-32bit-csr.xml", 0);
> > +
> > +    gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
> > +                             1, "riscv-32bit-csr.xml", 0);
>
> This should be riscv-32bit-virtual.xml

Good catch. I'll fix this in the next version.


>
> >  #elif defined(TARGET_RISCV64)
> >      if (env->misa & RVF) {
> >          gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
> > @@ -393,5 +413,8 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
> >
> >      gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
> >                               240, "riscv-64bit-csr.xml", 0);
> > +
> > +    gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
> > +                             1, "riscv-64bit-virtual.xml", 0);
> >  #endif
> >  }
>
> Regards,
> Bin
>

