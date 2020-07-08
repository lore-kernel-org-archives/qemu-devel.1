Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BE3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216DF20708
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vh7JwQQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216DF20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIMv-00082i-7j
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtHmV-000848-4o
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:39:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45501
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtHmT-0003UV-Ck
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3+fq5ijgR0VamgvH7ma7Z99lWeh8Y3IhzT0JgAf4JY=;
 b=Vh7JwQQLcEqZaOuiH5Crf7lzQeo/xHbNuC3u6v0qIkctdvvnREI42DTWvNBD7K8KV8GRPB
 2NCBQT3QjPIlHuWnS5astE0t/Z3D4D4O2vwHNrkL3D5wzUjDdJ/HdCbLSp7KgYOCd3d6cS
 PwL2GwFyqpjvrABsI/SwhvEiAZA2aV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-pFN4I6LvPzSDYKhK3-lsGw-1; Wed, 08 Jul 2020 17:39:03 -0400
X-MC-Unique: pFN4I6LvPzSDYKhK3-lsGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C93F5800C64;
 Wed,  8 Jul 2020 21:39:01 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 935745D9DD;
 Wed,  8 Jul 2020 21:39:01 +0000 (UTC)
Date: Wed, 8 Jul 2020 17:39:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
Message-ID: <20200708213900.GD780932@habkost.net>
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net>
 <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <da4b5a4c-7a72-6e07-b423-1487ad358c31@redhat.com>
MIME-Version: 1.0
In-Reply-To: <da4b5a4c-7a72-6e07-b423-1487ad358c31@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 06:45:57PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/8/20 5:25 PM, Eduardo Habkost wrote:
> > On Wed, Jul 08, 2020 at 02:14:03PM +0100, Peter Maydell wrote:
> >> On Wed, 8 Jul 2020 at 12:12, David Gibson <david@gibson.dropbear.id.au> wrote:
> >>> On Wed, Jul 08, 2020 at 10:38:29AM +0200, Philippe Mathieu-DaudÃ© wrote:
> >>>> Class boolean field certainly sounds better, but I am not sure this
> >>>> is a property of the machine. Rather the arch? So move the field
> >>>> to CPUClass? Maybe not, let's discuss :)
> >>>
> >>> It is absolutely a property of the machine.  e.g. I don't think we
> >>> want this for powernv.  pseries is a bit of a special case since it is
> >>> explicitly a paravirt platform.  But even for emulated hardware, the
> >>> board can absolutely strap things so that cpus do or don't start
> >>> immediately.
> >>
> >> It's a property of the individual CPU, I think. One common setup
> >> for Arm systems is that the primary CPU starts powered up but
> >> the secondaries all start powered down.
> > 
> > Both statements can be true.  It can be a property of the
> > individual CPU (although I'm not convinced it has to), but it
> > still needs to be controlled by the machine.
> 
> From what said Peter, I understand this is a property of the
> chipset. Chipsets are modelled unevenly.
> 
> IIUC QEMU started with single-core CPUs.
> CPUState had same meaning for 'core' or 'cpu', 1-1 mapping.
> 
> Then multicore CPUs could be easily modelled using multiple
> single-core CPUs, usually created in the machine code.
> 
> Then we moved to SoC models, creating the cores in the SoC.
> Some SoCs have array of cores, eventually heterogeneous
> (see the ZynqMP). We have containers of CPUState.
> 
> On an ARM-based SoC, you might have the first core started
> (as said Peter) or not.
> 
> BCM2836 / BCM2837 and ZynqMP start will all ARM cores off.
> On the BCM chipsets, a DSP core will boot the ARM cores.
> On the ZynqMP, a MicroBlaze core boots them.
> As QEMU doesn't models heterogeneous architectures, we start
> modelling after the unmodelled cores booted us, so either one
> or all cores on.
> 
> In this case, we narrowed down the 'start-powered-off' field
> to the SoC, which happens to be how ARM SoCs are modelled.

I was not aware of the start-powered-off property.  If we make it
generic, we can just let spapr use it.

> 
> 
> Chipsets providing a JTAG interface can have a SRST signal,
> the "system reset". When a JTAG probe is attached, it can
> keeps the whole chipset in a reset state. This is equivalent
> to QEMU '-S' mode (single step mode).
> 
> 
> I don't know about pseries hardware, but if this is 'explicit
> to paravirt platform', then I expect this to be the same with
> other accelerators/architectures.
> 
> If paravirtualized -> cores start off by default. Let the
> hypervisor start them. So still a property of the CPUState
> depending on the accelerator used?

I don't understand this part.  Why would this depend on the
accelerator?

-- 
Eduardo


