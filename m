Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98855C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CEF20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvspnNgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CEF20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip8Pp-0001Mk-0w
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ip8Oy-0000c5-Td
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ip8Ox-0004tY-11
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:17:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50951
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ip8Ow-0004sV-Gz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578478641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ydGXKZ0s3+VKfRTPHrNTXUxm3Fu1cG0BVChdnQ6D5s=;
 b=QvspnNgrIACQ22V14akLn/g2da/tBvzImO3BUQHAgy4E3bIK0jnNtOUB/vfMai0eFX9hN+
 8ce64E823SxrMywYQgx8R9Ko8nsP4wHFsVHJXIcHWMKXRKTcoiEwubeM0zcjB+ZiPRjJTj
 fQ1rT4r0wW87XrsKkyAPDSCaelNPonE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-LR3lMflHPkagC4svfNfSNw-1; Wed, 08 Jan 2020 05:17:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 484A6800EBF;
 Wed,  8 Jan 2020 10:17:19 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4E9560FC4;
 Wed,  8 Jan 2020 10:17:17 +0000 (UTC)
Date: Wed, 8 Jan 2020 11:17:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] accel/kvm: Make "kernel_irqchip" default on
Message-ID: <20200108111715.4897b19c.cohuck@redhat.com>
In-Reply-To: <05532242-3a70-b547-3765-0ab29583c4b0@redhat.com>
References: <20191228104326.21732-1-xiaoyao.li@intel.com>
 <05532242-3a70-b547-3765-0ab29583c4b0@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LR3lMflHPkagC4svfNfSNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020 11:32:42 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 28/12/19 11:43, Xiaoyao Li wrote:
> > Commit 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an
> > accelerator property") moves kernel_irqchip property from "-machine" to
> > "-accel kvm", but it forgets to set the default value of
> > kernel_irqchip_allowed and kernel_irqchip_split.
> > 
> > Also cleaning up the three useless members (kernel_irqchip_allowed,
> > kernel_irqchip_required, kernel_irqchip_split) in struct MachineState.

FWIW, this also fixes s390x, which requires kernel_irqchip=on.

> > 
> > Fixes: 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an accelerator property")
> > Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> > Changes in v2:
> >   - Add Reported-by tag;
> >   - Initialize kernel_irqchip_split in init_machine();  
> 
> Now that I am actually reviewing the patch on something other than a
> phone, I think this would break "-machine kernel_irqchip=split".  I'll
> test, and squash if it works, something like this:
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index afbbe0a1af..ea35433170 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -98,7 +98,7 @@ struct KVMState
>      int kvm_shadow_mem;
>      bool kernel_irqchip_allowed;
>      bool kernel_irqchip_required;
> -    bool kernel_irqchip_split;
> +    OnOffAuto kernel_irqchip_split;
>      bool sync_mmu;
>      bool manual_dirty_log_protect;
>      /* The man page (and posix) say ioctl numbers are signed int, but
> @@ -1799,7 +1799,7 @@ static void kvm_irqchip_create(KVMState *s)
>       * in-kernel irqchip for us */
>      ret = kvm_arch_irqchip_create(s);
>      if (ret == 0) {
> -        if (s->kernel_irqchip_split) {
> +        if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
>              perror("Split IRQ chip mode not supported.");
>              exit(1);
>          } else {
> @@ -2070,7 +2070,9 @@ static int kvm_init(MachineState *ms)
>          goto err;
>      }
>  
> -    s->kernel_irqchip_split = mc->default_kernel_irqchip_split;
> +    if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
> +        s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +    }
>  
>      if (s->kernel_irqchip_allowed) {
>          kvm_irqchip_create(s);
> @@ -3007,17 +3009,17 @@ static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
>          case ON_OFF_SPLIT_ON:
>              s->kernel_irqchip_allowed = true;
>              s->kernel_irqchip_required = true;
> -            s->kernel_irqchip_split = false;
> +            s->kernel_irqchip_split = ON_OFF_AUTO_OFF;
>              break;
>          case ON_OFF_SPLIT_OFF:
>              s->kernel_irqchip_allowed = false;
>              s->kernel_irqchip_required = false;
> -            s->kernel_irqchip_split = false;
> +            s->kernel_irqchip_split = ON_OFF_AUTO_OFF;
>              break;
>          case ON_OFF_SPLIT_SPLIT:
>              s->kernel_irqchip_allowed = true;
>              s->kernel_irqchip_required = true;
> -            s->kernel_irqchip_split = true;
> +            s->kernel_irqchip_split = ON_OFF_AUTO_ON;
>              break;
>          default:
>              /* The value was checked in visit_type_OnOffSplit() above. If
> @@ -3040,7 +3042,7 @@ bool kvm_kernel_irqchip_required(void)
>  
>  bool kvm_kernel_irqchip_split(void)
>  {
> -    return kvm_state->kernel_irqchip_split;
> +    return kvm_state->kernel_irqchip_split == ON_OFF_AUTO_ON;
>  }
>  
>  static void kvm_accel_instance_init(Object *obj)
> @@ -3049,6 +3051,7 @@ static void kvm_accel_instance_init(Object *obj)
>  
>      s->kvm_shadow_mem = -1;
>      s->kernel_irqchip_allowed = true;
> +    s->kernel_irqchip_split = ON_OFF_AUTO_AUTO;
>  }
>  
>  static void kvm_accel_class_init(ObjectClass *oc, void *data)

These changes looks sane to me (but did not test).

> 
> As a follow up, kernel_irqchip_allowed and kernel_irqchip_required could also be changed to a single OnOffAuto field, I think.

That would probably be a nice cleanup.

> 
> Paolo
> 
> 


