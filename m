Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5655EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF50E2074A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXDJMBIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF50E2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAYnB-0006y3-57
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kAYma-0006Or-Nc
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kAYmZ-00035f-30
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598361273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IgK5yO+j4BZWSns8DwVr32Fx2bPEirLdfFhg2XNPv64=;
 b=fXDJMBIKjetJ2hYL+CI8HpVS7TkwiEQ/CsojL/oM4A4xxv8C/B0z9bV2FpLOaeCwv1cUnH
 7Q200+wVbo6Vj7ObsIP75R6hcJr7AetIKsI+M7aAocVDy3g8XnsDXfJLrqHC4fc+uOeVPu
 LRVWAs5j4e9MpzsXM2oMYEkfvY7ZWog=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-nZL0ajoZNfCb_sj04PAZOg-1; Tue, 25 Aug 2020 09:14:29 -0400
X-MC-Unique: nZL0ajoZNfCb_sj04PAZOg-1
Received: by mail-yb1-f200.google.com with SMTP id e1so15045907ybk.14
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 06:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IgK5yO+j4BZWSns8DwVr32Fx2bPEirLdfFhg2XNPv64=;
 b=Zz/0rE3Jw4uhcNAP9bUdtTR78KNG0BwDIG2DAHdMYGw8/45kR45OPkDIB+M7hF84Az
 +D8RXAf6jXFj3kd5WfFhqSDybBLVtwoy21Kne1Tz1ersuOCGhPb766IO0/iwt8IfQYsF
 HzUFsoJFPtquFs5GST8dTGG/Jf6m5yu/9Z4sWmcqAHp6KLIIGW/3tD6NDHv89+M9wKOs
 pYYgPZ+t9BVGClJeTZMeGgoYBlCCEK1kXZ/9FIdo6MhMacncFqak++lsj4KU7zotM+rn
 tIPUwW4iR2EEa7XEtDqTgKo0fRRNRuFe048iEWvCTIHCN4z3fOtD/46zwcrH8eQCaquZ
 b/zQ==
X-Gm-Message-State: AOAM5332VVD1qFlzh6oTWVOhhZLNStLgIpJMfrV1+FizHsRR6AR3aigv
 lrYzlFb7zORiRHDYQhEQK27QZ8kmi+U0BWtjjn+H5kPW7Q4qcV73rwniQavzB28cIf0ZkV7LBgN
 BB0XUd5DMsqINaI4VG4Iv1znef5p+BBY=
X-Received: by 2002:a25:68d3:: with SMTP id d202mr13893941ybc.81.1598361268611; 
 Tue, 25 Aug 2020 06:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHiW44PAKbtDIWcp5v6WQd/ETfZVEwtkYuw167ficPisTRYaDx3+jBkjPiPfpXnq3ttp0NZojwzd731oUEEQI=
X-Received: by 2002:a25:68d3:: with SMTP id d202mr13893880ybc.81.1598361268344; 
 Tue, 25 Aug 2020 06:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200818215227.181654-2-jusual@redhat.com>
 <7220698b-3a7c-cd36-9ca5-5bb9a06a8fd6@redhat.com>
In-Reply-To: <7220698b-3a7c-cd36-9ca5-5bb9a06a8fd6@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Tue, 25 Aug 2020 15:14:17 +0200
Message-ID: <CAMDeoFV8k8wBc1z1C4Ff7Y5xsD6x2X4qLDAUnMUuuWC04O-bXA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] hw/acpi/ich9: Trace ich9_gpe_readb()/writeb()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 5:14 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 8/18/20 11:52 PM, Julia Suvorova wrote:
> > Add trace events similar to piix4_gpe_readb() to check gpe status.
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/acpi/ich9.c       | 7 ++++++-
> >  hw/acpi/trace-events | 4 ++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> > index 6a19070cec..a2a1742aa6 100644
> > --- a/hw/acpi/ich9.c
> > +++ b/hw/acpi/ich9.c
> > @@ -36,6 +36,7 @@
> >  #include "hw/acpi/acpi.h"
> >  #include "hw/acpi/tco.h"
> >  #include "exec/address-spaces.h"
> > +#include "trace.h"
> >
> >  #include "hw/i386/ich9.h"
> >  #include "hw/mem/pc-dimm.h"
> > @@ -59,13 +60,17 @@ static void ich9_pm_update_sci_fn(ACPIREGS *regs)
> >  static uint64_t ich9_gpe_readb(void *opaque, hwaddr addr, unsigned wid=
th)
> >  {
> >      ICH9LPCPMRegs *pm =3D opaque;
> > -    return acpi_gpe_ioport_readb(&pm->acpi_regs, addr);
> > +    uint64_t val =3D acpi_gpe_ioport_readb(&pm->acpi_regs, addr);
> > +
> > +    trace_ich9_gpe_readb(addr, width, val);
> > +    return val;
> >  }
> >
> >  static void ich9_gpe_writeb(void *opaque, hwaddr addr, uint64_t val,
> >                              unsigned width)
> >  {
> >      ICH9LPCPMRegs *pm =3D opaque;
> > +    trace_ich9_gpe_writeb(addr, width, val);
> >      acpi_gpe_ioport_writeb(&pm->acpi_regs, addr, val);
> >      acpi_update_sci(&pm->acpi_regs, pm->irq);
> >  }
> > diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
> > index afbc77de1c..b9f4827afc 100644
> > --- a/hw/acpi/trace-events
> > +++ b/hw/acpi/trace-events
> > @@ -32,6 +32,10 @@ cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
> >  cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] =
OST EVENT: 0x%"PRIx32
> >  cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx3=
2"] OST STATUS: 0x%"PRIx32
> >
> > +# ich9.c
> > +ich9_gpe_readb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%=
" PRIx64 " width: %d =3D=3D> 0x%" PRIx64
> > +ich9_gpe_writeb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x=
%" PRIx64 " width: %d <=3D=3D 0x%" PRIx64
>
> Nitpick, val could be uint8_t.

Since 'val' is an argument and its type is uint64_t it's better to
avoid implicit cast to a smaller type. Also, acpi_gpe_ioport_readb()
does not return uint8_t.


