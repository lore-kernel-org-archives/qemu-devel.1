Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CBCC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2F621670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 17:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVde4+VM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2F621670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjS2l-000427-SV
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 13:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <radoslaw.biernacki@linaro.org>) id 1hjS1L-0002vu-85
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <radoslaw.biernacki@linaro.org>) id 1hjS1J-0006p7-MU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:29:15 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:44056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <radoslaw.biernacki@linaro.org>)
 id 1hjS1J-0006mj-Bz
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 13:29:13 -0400
Received: by mail-yw1-xc42.google.com with SMTP id l79so2610217ywe.11
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZvZbHnHKY40AYBx1Em/XDDCmTCC1HGBzq8XM12/ILNw=;
 b=hVde4+VMc9kDjl9iiNL7YfNPBWov+qF5JxmIYnMrPnkCkcqUKUBccQOSvPAEg25VUg
 VZIndB7ukTLl/s8qILGPu8oUzXVFtQgs0DlKwq+kNF1Lsbv8fsLZg7E/273AH52b16yC
 mov+pGpOoHEaBMujcGxDnsXkpRpRXInN8REfQLGJThD4qYtiiBUqsnMnrb330JddTH14
 e+6J8HDl9NBEgvhd3iBMRIjcfJIDtxuAp5+5LDvdpd5gsXZYJUIqqrpVZwq9Q4TK9bKc
 lEXri0EoXAaLYGux7+1QiOdEx9HF/tWJFVCtShYUMvLt52Yy5blKDBbPWSTu6F2BJRZl
 93uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZvZbHnHKY40AYBx1Em/XDDCmTCC1HGBzq8XM12/ILNw=;
 b=a3uwkYevAdEuxeDmhGK0DJ0xLWd93Q2/rFFFEo+DaSSsOYKU9kFKRhYPjyLZgu1cfd
 iNLioyP9Pe6DZFfBSBYmMzgT/vI2EO3iLWouz/PTKzTJz1KK3THJT7RnlQkkEMz4u/cP
 lg/njqSwDHSFDydWkQApQNSdeLBGP39Y15zsb28F9gNrTb5vkmleTs838TZXTYzw4Y/H
 tY+yBu8kyHX8nWwhJXZeRyZ8pA+UqVXH9463Fb3vrb/I5U1d+/56zlvkGWOp2zTygwiT
 WNKKi/0pJ+qry8o7f8qMifU/ZyAcoc/j3xkliwA9PNki1eyw7tDXj4I2odQCQgrPWTNM
 UuKw==
X-Gm-Message-State: APjAAAUMGGailbWU5tEJZSf4uKREKDlL/UD+ipw9f4wPjB5sQMbFBBQ2
 pVzHS49gfvH/hTXhpUfoy4e45ImjZKE8uJaps8XJMg==
X-Google-Smtp-Source: APXvYqwbKNLIbAzRer+rYD8Hu7VW1N+rcAlTusI24v2gWiVp6or/syloVQOW47uQmu1laI3zeKMg8Xab3z7bs68v7QA=
X-Received: by 2002:a81:1f42:: with SMTP id f63mr2754476ywf.184.1562347751818; 
 Fri, 05 Jul 2019 10:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190704142004.7150-1-peter.maydell@linaro.org>
 <3bb189fa-8e47-acb0-89a2-9b5121c2269f@redhat.com>
In-Reply-To: <3bb189fa-8e47-acb0-89a2-9b5121c2269f@redhat.com>
From: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
Date: Fri, 5 Jul 2019 19:29:00 +0200
Message-ID: <CAEK-wK=2B4Jj_VNrAuCM3-KG_m=LPyKgjyp=Qm=D5J-oVuJCjg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/sbsa-ref: Remove
 unnecessary check for secure_sysmem == NULL
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 at 10:51, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> On 7/4/19 4:20 PM, Peter Maydell wrote:
> > In the virt machine, we support TrustZone being either present or
> > absent, and so the code must deal with the secure_sysmem pointer
> > possibly being NULL. In the sbsa-ref machine, TrustZone is always
> > present, but some code and comments copied from virt still treat
> > it as possibly not being present.
> >
> > This causes Coverity to complain (CID 1407287) that we check
> > secure_sysmem for being NULL after an unconditional dereference.
> > Simplify the code so that instead of initializing the variable
> > to NULL, unconditionally assigning it, and then testing it for NULL,
> > we just initialize it correctly in the variable declaration and
> > then assume it to be non-NULL. We also delete a comment which
> > only applied to the non-TrustZone config.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Not a bug as such, but we should put it in for 4.1 to
> > keep Coverity happy.
> > ---
> >  hw/arm/sbsa-ref.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index ee53f0ff60d..6f315b79445 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -254,8 +254,6 @@ static void sbsa_flash_map(SBSAMachineState *sms,
> >       * sysmem is the system memory space. secure_sysmem is the secure
> view
> >       * of the system, and the first flash device should be made visibl=
e
> only
> >       * there. The second flash device is visible to both secure and
> nonsecure.
> > -     * If sysmem =3D=3D secure_sysmem this means there is no separate =
Secure
> > -     * address space and both flash devices are generally visible.
> >       */
> >      hwaddr flashsize =3D sbsa_ref_memmap[SBSA_FLASH].size / 2;
> >      hwaddr flashbase =3D sbsa_ref_memmap[SBSA_FLASH].base;
> > @@ -588,7 +586,7 @@ static void sbsa_ref_init(MachineState *machine)
> >      SBSAMachineState *sms =3D SBSA_MACHINE(machine);
> >      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> >      MemoryRegion *sysmem =3D get_system_memory();
> > -    MemoryRegion *secure_sysmem =3D NULL;
> > +    MemoryRegion *secure_sysmem =3D g_new(MemoryRegion, 1);
> >      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> >      bool firmware_loaded;
> >      const CPUArchIdList *possible_cpus;
> > @@ -612,13 +610,11 @@ static void sbsa_ref_init(MachineState *machine)
> >       * containing the system memory at low priority; any secure-only
> >       * devices go in at higher priority and take precedence.
> >       */
> > -    secure_sysmem =3D g_new(MemoryRegion, 1);
> >      memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory"=
,
> >                         UINT64_MAX);
> >      memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> >
> > -    firmware_loaded =3D sbsa_firmware_init(sms, sysmem,
> > -                                         secure_sysmem ?: sysmem);
> > +    firmware_loaded =3D sbsa_firmware_init(sms, sysmem, secure_sysmem)=
;
> >
> >      if (machine->kernel_filename && firmware_loaded) {
> >          error_report("sbsa-ref: No fw_cfg device on this machine, "
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Thank you Peter.

Tested-by: Rados=C5=82aw Biernacki <radoslaw.biernacki@linaro.org>
Reviewed-by: Rados=C5=82aw Biernacki <radoslaw.biernacki@linaro.org>
