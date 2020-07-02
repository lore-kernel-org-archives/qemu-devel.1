Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 04:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7A8206A1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 04:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diL4x78R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7A8206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqrDH-00044o-En
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 00:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqrCh-0003eg-2U
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 00:52:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqrCe-00036m-H6
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 00:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593665522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcChpwd+kQkHznA1dNOwzqk5nFfjEs4WmkilHaCqwug=;
 b=diL4x78RgJRDLn8wiM4msIitX3WfTXk29KfW9NlKPT0FeXTujCZvYKnY8z0dxrWSrNjrfE
 cJ8DbJFYHxZ5oXl3oxQ904tzE9mcbwV8GbXZC2/STCCB+v/g+3P4+mxJ9KUSUPSSHxFyKe
 vBSx540DFzTze4plMGACg+ZaG2enJ4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-LflIq6G3NbanTXot-vnqCQ-1; Thu, 02 Jul 2020 00:52:00 -0400
X-MC-Unique: LflIq6G3NbanTXot-vnqCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83EFC8014D7;
 Thu,  2 Jul 2020 04:51:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51F4C779EB;
 Thu,  2 Jul 2020 04:51:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE3C011384A6; Thu,  2 Jul 2020 06:51:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 20/26] x86: Fix x86_cpu_new() error handling
References: <20200630090351.1247703-1-armbru@redhat.com>
 <20200630090351.1247703-21-armbru@redhat.com>
Date: Thu, 02 Jul 2020 06:51:57 +0200
In-Reply-To: <20200630090351.1247703-21-armbru@redhat.com> (Markus
 Armbruster's message of "Tue, 30 Jun 2020 11:03:45 +0200")
Message-ID: <87h7uq7c42.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 00:52:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor, Paolo, you showed me the error in v2.  Could you have a look at
this revision?

Markus Armbruster <armbru@redhat.com> writes:

> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>
> x86_cpu_new() is wrong that way: it passes &local_err to
> object_property_set_uint() without checking it, and then to
> qdev_realize().  If both fail, we'll trip error_setv()'s assertion.
> To assess the bug's impact, we'd need to figure out how to make both
> calls fail.  Too much work for ignorant me, sorry.
>
> Fix by checking for failure right away.
>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/i386/x86.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 34229b45c7..93f7371a56 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -118,14 +118,16 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>  
>  void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
>  {
> -    Object *cpu = NULL;
>      Error *local_err = NULL;
> -
> -    cpu = object_new(MACHINE(x86ms)->cpu_type);
> +    Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
>  
>      object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
>      qdev_realize(DEVICE(cpu), NULL, &local_err);
>  
> +out:
>      object_unref(cpu);
>      error_propagate(errp, local_err);
>  }


