Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B1BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD402070A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXu3dSzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD402070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQ4h-0005wH-Ut
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jwPwO-0000px-Kc
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:58:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24019
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jwPwJ-0000FM-Eg
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594990689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iitbr53o8Vv4F/7AQ/8a0H48Ht4k5lSmvWWi/uyNmZw=;
 b=MXu3dSzkzOyQ57TOfDnfZj0TDvCSowjmSnGR9GACuK+1SzJevqsqGLVTG8cMmfzBW+i3HV
 0BbXHmH2lYkmdz8mQSni9dgXAQKtmfNV8eVCKzSIuGrrle6rjp5tEFxerQAB1y3NecsLR/
 UNpS5SyYr0igI937SPEIibLx7LDx8nA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-tZ0zAxZ4PFGvZDnoFSLHNw-1; Fri, 17 Jul 2020 08:58:05 -0400
X-MC-Unique: tZ0zAxZ4PFGvZDnoFSLHNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71A6100AA31;
 Fri, 17 Jul 2020 12:58:04 +0000 (UTC)
Received: from localhost (unknown [10.40.208.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F63D61982;
 Fri, 17 Jul 2020 12:58:01 +0000 (UTC)
Date: Fri, 17 Jul 2020 14:57:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [RFC 2/3] x86: cphp: prevent guest crash on CPU hotplug when
 broadcast SMI is in use
Message-ID: <20200717145759.04a4399f@redhat.com>
In-Reply-To: <e3598f14-2e91-436c-9a8c-c3b3a36b9190@redhat.com>
References: <20200710161704.309824-1-imammedo@redhat.com>
 <20200710161704.309824-3-imammedo@redhat.com>
 <e3598f14-2e91-436c-9a8c-c3b3a36b9190@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
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
Cc: boris.ostrovsky@oracle.com, liran.alon@oracle.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 12:56:50 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 07/10/20 18:17, Igor Mammedov wrote:
[...]

> > @@ -1508,6 +1508,17 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >          return;
> >      }
> >
> > +    if (pcms->acpi_dev) {
> > +        Error *local_err = NULL;
> > +
> > +        hotplug_handler_pre_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
> > +                                 &local_err);
> > +        if (local_err) {
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
> > +    }
> > +
> >      init_topo_info(&topo_info, x86ms);
> >
> >      env->nr_dies = x86ms->smp_dies;
> >  
> 
> (6) This looks sane to me, but I have a question for the *pre-patch*
> code.

(not so short introduction)

plug callbacks were designed for wiring up hotplugged device, hence
it has check for acpi_dev which is one of HW connections needed to make
it work. Later on coldplug was consolidated with it, so plug callbacks
are also handling coldplugged devices.

then later plug callback was split on pre_ and plug_, where pre_
part is called right before device_foo.realize() and plug_ right after.
Split was intended to make graceful failure easier, where pre_ is taking
care of checking already set properties and optionally setting additional
properties and can/should fail without side-effects, and plug_ part
should not fail (maybe there is still cleanup to do there) and used to
finish wiring after the device had been realized.


> 
> I notice that hotplug_handler_pre_plug() is already called from the
> (completely unrelated) function pc_memory_pre_plug().
> 
> In pc_memory_pre_plug(), we have the following snippet:
> 
>     /*
>      * When -no-acpi is used with Q35 machine type, no ACPI is built,
>      * but pcms->acpi_dev is still created. Check !acpi_enabled in
>      * addition to cover this case.
>      */
>     if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
>         error_setg(errp,
>                    "memory hotplug is not enabled: missing acpi device or acpi disabled");
>         return;
>     }
> 
> Whereas in pc_cpu_pre_plug(), the present patch only adds a
> "pcms->acpi_dev" nullity check.
> 
> Should pc_cpu_pre_plug() check for ACPI enablement similarly to
> pc_memory_pre_plug()?
extra check is not must have in pc_memory_pre_plug() as it should not break anything
(modulo MMIO memhp interface, which went unnoticed since probably nobody
uses MMIO memhp registers directly (i.e. QEMU's ACPI tables is sole user))
 
> I'm asking for two reasons:
> 
> (6a) for the feature at hand (CPU hotplug with SMI), maybe we should
> write:
> 
>     if (pcms->acpi_dev && x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
pretty harmless in the same sense as in pc_memory_pre_plug(),
but I'd rather avoid checks that are not must have.


> (6b) or maybe more strictly, copy the check from memory hotplug (just
> update the error message):
> 
>     if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
>         error_setg(errp,
>                    "CPU hotplug is not enabled: missing acpi device or acpi disabled");
can't do it as it will break CPU clodplug when -no-cpi is used

>         return;
>     }
> 
> Because CPU hotplug depends on ACPI too, just like memory hotplug,
> regardless of firmware, and regardless of guest-SMM. Am I correct to
> think that?

We have pcms->acpi_dev check in x86 code because isapc/piix4 machines
will/might not create the pm device (which implements acpi hw). 

(1) if (pcmc->pci_enabled && x86_machine_is_acpi_enabled(X86_MACHINE(pcms)))

if that weren't the case, calls to acpi_dev would be unconditional

I'm adding check into pre_plug so we can gracefully reject device_add
in case firmware is not prepared for handling hotplug SMI. Since
the later might crash the guest. It's for the sake of better user
experience since QEMU might easily run older firmware.

If we don't care about that, we can drop negotiation and the check,
send SMI on hotplug when SMI broadcast is enabled, that might
crash guest since it might be not supported by used fw, but that
was already the case for quite a while and I've heard only few
complaints. (I guess most users have sense not to use something
not impl./supported)


> Basically, I'm asking if we should replicate original commit
> 8cd91acec8df ("pc: fail memory hot-plug/unplug with -no-acpi and Q35
> machine type", 2018-01-12) for CPU hotplug first (in a separate patch!),
> before dealing with "lpc->smi_negotiated_features" in this patch.

I'd rather leave hw part decoupled from acpi tables part,
nothing prevents users implementing their own fw/os which uses
our cpuhp interface directly without ACPI.

> Hmm... I'm getting confused. I *do* see similar checks in pc_cpu_plug()
> and pc_cpu_unplug_request_cb(). But:
> 
> - I don't understand what determines whether we put the ACPI check in
> *PRE* plug functions, or the plug functions,
I beleive [1] answers that

> - and I don't understand why pc_cpu_plug() and
> pc_cpu_unplug_request_cb() only check "pcms->acpi_dev", and not
> x86_machine_is_acpi_enabled().

x86_machine_is_acpi_enabled() is not must have in this case as
callbacks implement only hw part of cpuhp protocol (QEMU part),
what guest uses to handle it (fw tables(qemu generated),
or some custom code) is another story.


> (7) According to my request under patch#1, I propose that we should
> implement a similar rejection for CPU hot-unplug, in this series. (Can
> be a separate patch, of course.)
> 
> Thanks!
> Laszlo
> 
> 


