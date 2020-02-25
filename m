Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25148C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 08:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44132176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 08:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYKlJyUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44132176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6VPE-0006NG-4f
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 03:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6VOd-0005wi-2p
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6VOY-0004Gj-M9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:16:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53742
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6VOY-0004G8-Ht
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 03:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582618604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qvu9T23HBCe/vpzvRPzT5lVTtsLRzZvPEVfBqNaVdnA=;
 b=dYKlJyUgaNwAfTR0OotqMNy4D0NkYjmFkIAeugHXkj/gNhRX1w8B+xgtxIbqRlTdkTmvSI
 0uX4KqW3Ufx9z29c/K5+RtysOPvGpXlY6Ra2Hs0RoBrEm8pAlep4WXGmzmPKaWCldOXcwr
 qwKfBTVJjJdXLIfQLtm8nF41rxfaI9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-Bacb9bmeNoyl9Tc154G9_w-1; Tue, 25 Feb 2020 03:16:39 -0500
X-MC-Unique: Bacb9bmeNoyl9Tc154G9_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CBEC107ACCD;
 Tue, 25 Feb 2020 08:16:38 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 328CE60BF7;
 Tue, 25 Feb 2020 08:16:34 +0000 (UTC)
Date: Tue, 25 Feb 2020 09:16:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v4 12/16] hw/i386: Use the apicid handlers from
 X86MachineState
Message-ID: <20200225091632.047f3a31@redhat.com>
In-Reply-To: <20200224223149.GF4440@habkost.net>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161786628.48948.1813866541108702762.stgit@naples-babu.amd.com>
 <20200224181903.19790bad@redhat.com>
 <1a7b1dae-9600-1d29-d4d4-4fdfb6832b6f@amd.com>
 <20200224223149.GF4440@habkost.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Babu Moger <babu.moger@amd.com>, rth@twiddle.net, pbonzini@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Feb 2020 17:31:49 -0500
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Feb 24, 2020 at 11:58:09AM -0600, Babu Moger wrote:
> > 
> > 
> > On 2/24/20 11:19 AM, Igor Mammedov wrote:  
> > > On Thu, 13 Feb 2020 12:17:46 -0600
> > > Babu Moger <babu.moger@amd.com> wrote:
> > >   
> > >> Check and Load the apicid handlers from X86CPUDefinition if available.
> > >> Update the calling convention for the apicid handlers.  
> > > 
> > > Previous and this patch look too complicated for the task at the hand.
> > > In particular, cpu_x86_init_apicid_fns() from previous patch adds 1 more
> > > reference to Machine into i386/cpu.c (even though it's just a helper function)
> > > and I think un-necessary hooks to X86CPUDefinition (it's not really CPU's
> > > businesses to make up APIC-IDs).
> > > 
> > > I'd rather do opposite and get rid of the last explicit dependency to
> > > ms->smp.cpus from cpu.c. But well, it's out of scope of this series,
> > > so for this series I'd just try to avoid adding more Machine dependencies.
> > > 
> > > All 11/16 does is basically using hooks as a switch "I'm EPYC" to
> > > set epyc specific encoding topo routines.
> > > 
> > > It could be accomplished by a simple Boolean flag like
> > >  X86CPUDefinition::use_epyc_apic_id_encoding
> > > 
> > > and then cpu_x86_init_apicid_fns() could be replaced with trivial
> > > helper like:
> > > 
> > >   x86_use_epyc_apic_id_encoding(char *cpu_type)
> > >   {
> > >       X86CPUClass *xcc = ... cpu_type ...
> > >       return xcc->model->cpudef->use_epyc_apic_id_encoding
> > >   }
> > > 
> > > then machine could override default[1] hooks using this helper
> > > as the trigger
> > >   x86_cpus_init()
> > >   {
> > >       // no need in dedicated function as it's the only instance it's going to be called ever
> > >       if (x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> > >             x86ms->apicid_from_cpu_idx = ...epyc...
> > >             x86ms->topo_ids_from_apicid = ...epyc...
> > >             x86ms->apicid_from_topo_ids = ...epyc...
> > >             x86ms->apicid_pkg_offset = ...epyc...
> > >       }
> > >   }
> > > 
> > > That would be less invasive and won't create non necessary dependencies.  
> > 
> > Yes. We can achieve the task here with your approach mentioned above. But,
> > we still will have a scaling issue. In future if a "new cpu model" comes
> > up its own decoding, then we need to add another bolean flag use_new
> > _cpu_apic_id_encoding. And then do that same check again. In that sense,
> > the current approach is bit generic. Lets also hear from Eduardo.

Without another encoding on horizon, it looks like over-engineering.
So lets think of a more generic approach later when need arises.
 

> To be honest, I really hope the number of APIC ID initialization
> variations won't grow in the future.
> In either case, X86MachineState really doesn't seem to be the
> right place to save the function pointers.  Whether we choose a
> boolean flag or a collection of function pointers, model-specific
> information belong to x86CPUClass and/or X86CPUDefinition, not
> MachineState.

That's where I disagree, generating APIC ID and it's assignment
shouldn't be part of CPU model. On real machines it's done by
board/firmware, there board is purpose build for specific CPU.

The same should be in QEMU case, where universal QEMU board
adapts its APIC initialization to used CPU and not other way
around (i.e. it's not CPU's job to generate IDs).
So hooks in machine look like a good approach to me.

I's fine to add small helper to CPU code to help board decide
what APIC encoding to use, but I strongly disagree in putting
more logic/data than that into CPU model.

What CPU does inside (I mean CPUID handling) it's separate
business and in that case CPU usually knows what it's encoding
and can use epyc/non_epyc functions directly if necessary.
 
> See the reply I sent at:
> https://lore.kernel.org/qemu-devel/20200128200438.GJ18770@habkost.net/
> 
> ] If you need a CPU model to provide special behavior,
> ] you have two options:
> ] 
> ] * Add a method pointer to X86CPUClass and/or X86CPUDefinition
> ] * Add a QOM property to enable/disable special behavior, and
> ]   include the property in the CPU model definition.
> ] 
> ] The second option might be preferable long term, but might
> ] require more work because the property would become visible in
> ] query-cpu-model-expansion and in the command line.  The first
> ] option may be acceptable to avoid extra user-visible complexity
> ] in the first version.
> ] 
> ] 
> ] 
> ] > +        pcms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx_epyc;
> ] > +        pcms->topo_ids_from_apicid = x86_topo_ids_from_apicid_epyc;
> ] > +        pcms->apicid_from_topo_ids = x86_apicid_from_topo_ids_epyc;
> ] 
> ] Why do you need to override the function pointers in
> ] PCMachineState instead of just looking up the relevant info at
> ] X86CPUClass?
> 


