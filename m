Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B3C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E446C20663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfKDeWtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E446C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv0ka-00072m-63
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 11:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jv0jW-0006ZQ-RK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:51:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52129
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jv0jP-0007fY-VS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594655462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vsqsfFCZTVQG0neIpQgF1lkBj+N8YXUMrTxcNBKEjs=;
 b=cfKDeWtRzpyrDB+e+BZPMvOPNsk+tWehHpYJMcNGXxXF1+CxOfwdJMsLvKZIZ3R2yns7uT
 wIZPXJdx3/nV/XFxTfgG7E32aU484MiRbEtb/xDXsdpm2602PlauzThRaWxqL2qGP1e2LS
 VW1Y0ajeTfB6fwfAkzIU5LqfBWoi+SI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-_ifLNb1_MTWkPP1gshK5NA-1; Mon, 13 Jul 2020 11:51:00 -0400
X-MC-Unique: _ifLNb1_MTWkPP1gshK5NA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8CF9800597;
 Mon, 13 Jul 2020 15:50:59 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 376DA6FEDF;
 Mon, 13 Jul 2020 15:50:58 +0000 (UTC)
Date: Mon, 13 Jul 2020 17:50:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 20/25] x86: Fix x86_cpu_new() error API violations
Message-ID: <20200713175053.2dd20026@redhat.com>
In-Reply-To: <875zbeugvl.fsf@dusky.pond.sub.org>
References: <20200624083737.3086768-1-armbru@redhat.com>
 <20200624083737.3086768-21-armbru@redhat.com>
 <20200624161703.153c7905@redhat.com>
 <875zbeugvl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 14:54:38 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > On Wed, 24 Jun 2020 10:37:32 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> >> pointer to a variable containing NULL.  Passing an argument of the
> >> latter kind twice without clearing it in between is wrong: if the
> >> first call sets an error, it no longer points to NULL for the second
> >> call.
> >> 
> >> x86_cpu_new() is wrong that way: it passes &local_err to
> >> object_property_set_uint() without checking it, and then to
> >> qdev_realize().  Harmless, because the former can't actually fail
> >> here.
> >> 
> >> Fix by checking for failure right away.  While there, replace
> >> qdev_realize(); object_unref() by qdev_realize_and_unref().
> >> 
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Richard Henderson <rth@twiddle.net>
> >> Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  hw/i386/x86.c | 12 +++---------
> >>  1 file changed, 3 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> >> index 34229b45c7..3a7029e6db 100644
> >> --- a/hw/i386/x86.c
> >> +++ b/hw/i386/x86.c
> >> @@ -118,16 +118,10 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> >>  
> >>  void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
> >>  {
> >> -    Object *cpu = NULL;
> >> -    Error *local_err = NULL;
> >> +    Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
> >>  
> >> -    cpu = object_new(MACHINE(x86ms)->cpu_type);
> >> -
> >> -    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
> >> -    qdev_realize(DEVICE(cpu), NULL, &local_err);
> >> -
> >> -    object_unref(cpu);
> >> -    error_propagate(errp, local_err);
> >> +    object_property_set_uint(cpu, apic_id, "apic-id", &error_abort);  
> > it may fail here if user specified wrong cpu flags, but there is nothing we can do to fix it.  
> 
> Really?
> 
> object_property_set_uint() fails when property "apic-id" doesn't exist,
> has no ->set() method, or its ->set() fails.
> 
> Property "apic-id" is defined in x86_cpu_properties[] as
> 
>     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
> 
> This means "apic-id" exists, and its ->set() is set_uint32().  That
> leaves only set_uint32() as possible source of failure.
> 
> It fails when
> 
> * the device is already realized: programming error
> 
> * the value to be stored is not an integer: object_property_set_uint()
>   makes it one, can't fail
> 
> * the value is not representable as uint32_t: @api_id is declared as
>   int64_t, but:
> 
>   - pc_hot_add_cpu() passes x86_cpu_apic_id_from_index(), which is
>     uint32_t, converted to int64_t.  Can't fail.
> 
>   - x86_cpus_init() passes possible_cpus->cpus[i].arch_id, which is
>     uint64_t.  Is this the "if user specified wrong cpu flags" case?

looking more on it, object_property_set_uint() can't really fail

>   Aside: should the integer types be cleaned up?

apic_id is x86 specific subset of .arch_id.
The later is used by other targets which may need larger than 32bit integer
(if I recall correctly virt-arm uses 64bit id). 


> To assess the bug's impact, we need to know when the other call in this
> error pileup fails.  If we can make both fail, we have a crash bug.
> Else, we have a harmless API violation.
> 
> Any ideas on how to make the qdev_realize() fail?
qemu CLI case
  QEMU -cpu qemu64,enforce,topoext

legacy hotplug case:
  QEMU -smp 1,maxcpus=2
  (monitor) cpu-add 1
  (monitor) cpu-add 1  <= fail
 



