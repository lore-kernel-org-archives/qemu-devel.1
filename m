Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC6FC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 04:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3703F216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 04:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+wNw9Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3703F216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkhL9-0001L0-HP
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 00:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hkhIj-0000X2-Jd
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hkhIh-0007Vd-Od
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:00:21 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35217)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1hkhIZ-0007JQ-MK; Tue, 09 Jul 2019 00:00:12 -0400
Received: by mail-pl1-x643.google.com with SMTP id w24so9349530plp.2;
 Mon, 08 Jul 2019 21:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MywKGIWHhYx6+3uyRA+KWyEmtwfHUd3+7N47je1pKRw=;
 b=r+wNw9IzX/5HPx7TgANB2WWGHu9LI84xrTh6VX0WIlZxrCVYADDnlYElGh6/bmWV4z
 p4s2b9JbzFXLbxMiIJTIsLPEdcmc9XcaBURXXeOBTAx77sBEy4gTFSjiIVV5zwUS3I6F
 J+QM2l1+LFXCMpu6jvB1niM8Gfl6II5njW99HSrfN5jxAna5ZR5t6D2w2i06iGGDFJtL
 fk5697xn5QKcPLKH+cLtkjDQNTksPLVDFxOeNfuB57RAR1+uM46bpTVo4/kqiClkdJXp
 RsrtAIhHZxlrLbN2QZkpVwzNJOCAEJtIK9dqd2abnO8lWOZHyXTvVJbRDXyrQ8aIDLoM
 xjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MywKGIWHhYx6+3uyRA+KWyEmtwfHUd3+7N47je1pKRw=;
 b=ZpeAHr8dM37MHBiznqiI2SVZAFssCpHtiGWhmawjxO7rXUZYNpIjikcBTeSfLyCPi1
 GOwLgHl9LTrrFWt/TTiY9Z+nklimTDoEZAC4T74PKeaMu774Sq+g18BLgvG+G0wAfLoT
 FmG9euJAPSY038/gSzm6xxuJI2qrlLI5cN38wVY3UfaJFSMnlJ/h5XXi0oOmJKmsZ8zh
 jypIjdZdwL7Xb74/ocqlN23RPTW4jGxI/+seoIRjdj3eaCM9OGNUaYIvXtZ4Or6ODdAh
 kSOPMHOLcQajVwkwPY+4gaVPnLB8dPiRmtHIPYX4feCzCTjusWYECZvzPAWoob+KSJra
 B7Hg==
X-Gm-Message-State: APjAAAXYA49WveIk1XFlFKU8Kmc9TKKfZ6mcs/eGKXkPVUbkVjo1KSVy
 eYpnKW6jsm3AokcO7EXmsYRyrmdH
X-Google-Smtp-Source: APXvYqxU0ZTa/YR0MPK8MRatLJOMHWT3Yy3drexQk985bF6toYhS+icoxcLI9YQJIIh256Aa9MIwTQ==
X-Received: by 2002:a17:902:381:: with SMTP id
 d1mr28861062pld.331.1562644809405; 
 Mon, 08 Jul 2019 21:00:09 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id j1sm20969536pfe.101.2019.07.08.21.00.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Jul 2019 21:00:08 -0700 (PDT)
Message-ID: <1562644804.2073.7.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 09 Jul 2019 14:00:04 +1000
In-Reply-To: <20190704045954.GV9442@umbus.fritz.box>
References: <20190701061946.32636-1-sjitindarsingh@gmail.com>
 <20190703061239.GK9442@umbus.fritz.box>
 <1562211719.10832.15.camel@gmail.com>
 <20190704045954.GV9442@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH v3] powerpc/spapr: Add host
 threads parameter to ibm, get_system_parameter
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-07-04 at 14:59 +1000, David Gibson wrote:
> On Thu, Jul 04, 2019 at 01:41:59PM +1000, Suraj Jitindar Singh wrote:
> > On Wed, 2019-07-03 at 16:12 +1000, David Gibson wrote:
> > > On Mon, Jul 01, 2019 at 04:19:46PM +1000, Suraj Jitindar Singh
> > > wrote:
> > > > The ibm,get_system_parameter rtas call is used by the guest to
> > > > retrieve
> > > > data relating to certain parameters of the system. The SPLPAR
> > > > characteristics option (token 20) is used to determin
> > > > characteristics of
> > > > the environment in which the lpar will run.
> > > > 
> > > > It may be useful for a guest to know the number of physical
> > > > host
> > > > threads
> > > > present on the underlying system where it is being run. Add the
> > > > characteristic "HostThrs" to the SPLPAR Characteristics
> > > > ibm,get_system_parameter rtas call to expose this information
> > > > to a
> > > > guest and provide an implementation which determines this
> > > > information
> > > > based on the number of interrupt servers present in the device
> > > > tree.
> > > > 
> > > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > 
> > > Hrm, as I said on our call, I have some misgivings about this.
> > > 
> > > Starting with the most general: this again publishes host
> > > information
> > > to the guest without filtering, which has caused us problems
> > > before
> > > (e.g. security issues with publishing the host serial and model
> > > information).  Now, I can't immediately see what harm a guest
> > > could
> > > do
> > > with the host # threads (especially since it could in theory
> > > deduce
> > > it
> > > from the PVR, I think) but it still makes me uneasy.
> > 
> > Correct, a guest could pretty reliably determine this information
> > anyway based on the PVR. It can't account for a POWER8 operating in
> > split core mode, but I don't know any harm that could be done by
> > introducing this information.
> > 
> > Additionally it doesn't really tell you anything about how you're
> > going
> > to be scheduled (at least on POWER9) since vcpus are scheduled on a
> > per
> > thread, not per core basis.
> 
> Hmm.
> 
> > > Secondly, the "HostThrs" tag doesn't seem to be documented in
> > > PAPR as
> > > something that this system-parameter will include.  I don't much
> > > like
> > > the idea of adding ad-hoc bits of information here without some
> > > thought going into designing and specifying it first.
> > 
> > This isn't documented in papr, it has been decided that this is how
> > the
> > information will be communicated to a guest. This is the most
> > appropriate place to put this information and the HostThrs name is
> > consistent with the naming of other information in this property.
> 
> Grr.  If someone can decide this, they can bloody well document it
> somewhere.
> 
> > We have other non-papr information in qemu, for example hcall
> > numbers,
> > so this isn't exactly a precedent.
> 
> I suppose
> 
> > > > ---
> > > > 
> > > > V1 -> V2:
> > > > - Take into account that the core may be operating in split
> > > > core
> > > > mode
> > > >   meaning a single core may be split into multiple subcores.
> > > > V2 -> V3:
> > > > - Add curly braces for single line if statements
> > > > ---
> > > >  hw/ppc/spapr_rtas.c | 62
> > > > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 62 insertions(+)
> > > > 
> > > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > > index 5bc1a93271..1bab71c90c 100644
> > > > --- a/hw/ppc/spapr_rtas.c
> > > > +++ b/hw/ppc/spapr_rtas.c
> > > > @@ -229,6 +229,58 @@ static inline int sysparm_st(target_ulong
> > > > addr, target_ulong len,
> > > >      return RTAS_OUT_SUCCESS;
> > > >  }
> > > >  
> > > > +#define CPUS_PATH       "/proc/device-tree/cpus/"
> > > > +#define
> > > > SUBCORE_PATH    "/sys/devices/system/cpu/subcores_per_core"
> > > > +
> > > > +static int rtas_get_num_host_threads(void)
> > > > +{
> > > > +    int num_threads = -1;
> > > > +    unsigned long len;
> > > > +    const char *entry;
> > > > +    char *buf;
> > > > +    GDir *dir;
> > > > +
> > > > +    if (!kvm_enabled()) {
> > > > +        return 1;
> > > > +    }
> > > > +
> > > > +    /* Read interrupt servers to determine number of threads
> > > > per
> > > > core */
> > > > +    dir = g_dir_open(CPUS_PATH, 0, NULL);
> > > > +    if (!dir) {
> > > > +        return -1;
> > > > +    }
> > > > +
> > > > +    while ((entry = g_dir_read_name(dir))) {
> > > > +        if (!strncmp(entry, "PowerPC,POWER",
> > > > strlen("PowerPC,POWER"))) {
> > > > +            char *path;
> > > > +
> > > > +            path = g_strconcat(CPUS_PATH, entry, "/ibm,ppc-
> > > > interrupt-server#s",
> > > > +                               NULL);
> > > > +            if (g_file_get_contents(path, &buf, &len, NULL)) {
> > > > +                num_threads = len / sizeof(int);
> > > > +                g_free(buf);
> > > > +            }
> > > > +
> > > > +            g_free(path);
> > > > +            break;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    g_dir_close(dir);
> > > > +
> > > > +    /* Check if split core mode in use */
> > > > +    if (g_file_get_contents(SUBCORE_PATH, &buf, &len, NULL)) {
> > > > +        int subcores = g_ascii_strtoll(buf, NULL, 10);
> > > > +
> > > > +        if (subcores) {
> > > > +            num_threads /= subcores;
> > > > +        }
> > > > +        g_free(buf);
> > > > +    }
> > > 
> > > Finally, all the logic above is built on the assumption of a ppc
> > > host
> > > - and not just that but an IBM POWER host...
> > 
> > RTAS services are defined as being provided by a papr platform, and
> > the
> > existence of the ibm,ppc-interrupt-server#s device tree property is
> > a
> > requirement of a papr platform. So I don't see this being an issue.
> 
> The *guest* is a PAPR platform, there's no guarantee the host has to
> be a PAPR platform (in fact it usually won't be, it's just that
> powernv has a lot of the same device tree properties).

Well I think technically the host is a papr platform which supplies an
environment to the papr guest partition. But the terminology isn't
really important here.

> 
> > > 
> > > > +    return num_threads;
> > > > +}
> > > > +
> > > >  static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
> > > >                                            SpaprMachineState
> > > > *spapr,
> > > >                                            uint32_t token,
> > > > uint32_t
> > > > nargs,
> > > > @@ -250,6 +302,16 @@ static void
> > > > rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
> > > >                                            current_machine-
> > > > > ram_size / MiB,
> > > > 
> > > >                                            smp_cpus,
> > > >                                            max_cpus);
> > > > +        int num_host_threads = rtas_get_num_host_threads();
> > > > +
> > > > +        if (num_host_threads > 0) {
> > > 
> > > ... this sort of implements a fallback in other cases (KVM PR
> > > with a
> > > non-IBM host, TCG, but the boundary conditions are not really
> > > well
> > > defined.
> > 
> > This is essentially catching the error case of
> > rtas_get_num_host_threads() returning a negative number or not
> > finding
> > the required properties (which as mentioned above are required).
> > The
> > KVM-PR case will work the same as the KVM-HV case where the host
> > device
> > tree will be queried.
> 
> Not if you're using PR on, say, an embedded ppc or an old Apple
> machine that doesn't have the PAPR-ish properties in the host device
> tree.

In which case we won't find the device tree property and so we don't
have a reliable way to determine the number of host threads, so we will
omit the property.

> 
> > For TCG we just default to 1 since this
> > information shouldn't be relevant to a TCG guest.
> 
> Uh.. it doesn't though, it omits it entirely.

No,
if (!kvm_enabled()) return 1;
above

> 
> Also I don't really understand how it's relevant to a KVM guest in
> the
> first place.

There are registers which were previously scaled based on the threads
per core, for example the PURR, but which aren't on POWER9 when running
in lpar per thread mode and instead count per thread. This will look
different to a guest OS, and so for whatever reason the guest might
want to scale these registers based on the host threading mode.

> 
> > 
> > > 
> > > > +            char *hostthr_val, *old = param_val;
> > > > +
> > > > +            hostthr_val = g_strdup_printf(",HostThrs=%d",
> > > > num_host_threads);
> > > > +            param_val = g_strconcat(param_val, hostthr_val,
> > > > NULL);
> > > > +            g_free(hostthr_val);
> > > > +            g_free(old);
> > > > +        }
> > > >          ret = sysparm_st(buffer, length, param_val,
> > > > strlen(param_val) + 1);
> > > >          g_free(param_val);
> > > >          break;
> > > 
> > > 
> 
> 

