Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D8C2BA17
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349AB208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ec8wybJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349AB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKIot-0001Gi-9b
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 05:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jKIoC-0000Nj-Fn
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jKIoA-00034C-M3
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:40:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52679
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jKIoA-00033S-Gw
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585906813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEKXOIfbzh+Wg3ed5tPYgQhyxf1p2lpVsu3fnDQwn8A=;
 b=Ec8wybJyGkFQHJoDIgX0TP4OQ+mn5WsFtcun2wvOq7sQMtoYlHrAbQHPe81Nh68SgHM0o/
 Pl8wn84Nvl6hW0njlRR6n148lERBSe018Va2vP37Ew2XxfS9BY/QdgOiqTQly+Hm3u4FEf
 wuPwvPf6ZNLfLflHg2WcErhjy2gu2LA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-ugQvl97hOSSdghqnx78oCQ-1; Fri, 03 Apr 2020 05:40:12 -0400
X-MC-Unique: ugQvl97hOSSdghqnx78oCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05003800D53;
 Fri,  3 Apr 2020 09:40:11 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4D49102BD8A;
 Fri,  3 Apr 2020 09:40:05 +0000 (UTC)
Date: Fri, 3 Apr 2020 11:40:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-5.0 v2] xen: fixup RAM memory region initialization
Message-ID: <20200403114004.60e27e38@redhat.com>
In-Reply-To: <80d74c4b-b46b-705c-ecc2-d680fcf7bf66@redhat.com>
References: <20200402145418.5139-1-imammedo@redhat.com>
 <80d74c4b-b46b-705c-ecc2-d680fcf7bf66@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, anthony.perard@citrix.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 20:57:14 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 02/04/20 16:54, Igor Mammedov wrote:
> > Since bd457782b3b0 ("x86/pc: use memdev for RAM") Xen
> > machine fails to start with:
> >    qemu-system-i386: xen: failed to populate ram at 0
> > 
> > The reason is that xen_ram_alloc() which is called by
> > memory_region_init_ram(), compares memory region with
> > statically allocated 'global' ram_memory memory region
> > that it uses for RAM, and does nothing in case it matches.
> > 
> > While it's possible feed machine->ram to xen_ram_alloc()
> > in the same manner to keep that hack working, I'd prefer
> > not to keep that circular dependency and try to untangle that.
> > 
> > However it doesn't look trivial to fix, so as temporary
> > fixup opt out Xen machine from memdev based RAM allocation,
> > and let xen_ram_alloc() do its trick for now.
> > 
> > Reported-by: Anthony PERARD <anthony.perard@citrix.com>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v2:
> >   * make it work with -M pc,accel=xen
> > ---
> >  hw/xen/xen-common.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> > index 15650d7f6a..a15070f7f6 100644
> > --- a/hw/xen/xen-common.c
> > +++ b/hw/xen/xen-common.c
> > @@ -19,6 +19,7 @@
> >  #include "sysemu/runstate.h"
> >  #include "migration/misc.h"
> >  #include "migration/global_state.h"
> > +#include "hw/boards.h"
> >  
> >  //#define DEBUG_XEN
> >  
> > @@ -151,6 +152,8 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
> >  
> >  static int xen_init(MachineState *ms)
> >  {
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +
> >      xen_xc = xc_interface_open(0, 0, 0);
> >      if (xen_xc == NULL) {
> >          xen_pv_printf(NULL, 0, "can't open xen interface\n");
> > @@ -170,6 +173,10 @@ static int xen_init(MachineState *ms)
> >          return -1;
> >      }
> >      qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
> > +    /*
> > +     * opt out of system RAM being allocated by generic code
> > +     */
> > +    mc->default_ram_id = NULL;
> >      return 0;
> >  }
> >  
> >   
> 
> Monkey patching the class is slightly disgusting. :)  It would be better
> to use a new ms->default_ram_id, and assign it from the class in
> instance_init, but I've queued it anyway.

it's disgusting, I hope to drop this after fixing xen properly.

> 
> Paolo
> 
> 


