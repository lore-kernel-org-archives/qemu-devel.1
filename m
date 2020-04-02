Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C46EC2BA80
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A4B2074D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFNRMXGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A4B2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0sS-00064L-Fp
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jK0rk-0005b1-Mb
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jK0rj-0006EV-FH
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:30:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27942
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jK0rj-0006E9-B3
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585837842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6V1SCDQSCUVhLKHpKUZKSDS3yhnjAC3DhdluAl+Xhc4=;
 b=jFNRMXGsfYg9wMvFs0HzESVt6HJCiiDnMBrm3vhMRLUbS84JzHMVfkyJzrT5nTdjNyWCOZ
 jUuIgvLTnL//WVVV3Yn5ApJzpMHJs/ZckP8SwkZIfakGc/vm/RH9xdjseuUJerDd5E7OPz
 2iqvq4tLrwdrTRbO9LC8yVSXXUkLx/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-m4Fh2J45Mom02LvrsXABRw-1; Thu, 02 Apr 2020 10:30:41 -0400
X-MC-Unique: m4Fh2J45Mom02LvrsXABRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 156F21922964;
 Thu,  2 Apr 2020 14:30:40 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42D9CDA11D;
 Thu,  2 Apr 2020 14:30:35 +0000 (UTC)
Date: Thu, 2 Apr 2020 16:30:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH for-5.0] xen: fixup RAM memory region initialization
Message-ID: <20200402163033.45585e70@redhat.com>
In-Reply-To: <20200402132530.GS4088@perard.uk.xensource.com>
References: <20200327104828.12647-1-imammedo@redhat.com>
 <20200330165248.GR4088@perard.uk.xensource.com>
 <20200402142925.75e0c482@redhat.com>
 <20200402132530.GS4088@perard.uk.xensource.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org,
 ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 14:25:30 +0100
Anthony PERARD <anthony.perard@citrix.com> wrote:

> On Thu, Apr 02, 2020 at 02:29:25PM +0200, Igor Mammedov wrote:
> > On Mon, 30 Mar 2020 17:52:48 +0100
> > Anthony PERARD <anthony.perard@citrix.com> wrote:
> >   
> > > On Fri, Mar 27, 2020 at 06:48:28AM -0400, Igor Mammedov wrote:  
> > > > Since bd457782b3b0 ("x86/pc: use memdev for RAM") Xen
> > > > machine fails to start with:
> > > >    qemu-system-i386: xen: failed to populate ram at 0
> > > > 
> > > > The reason is that xen_ram_alloc() which is called by
> > > > memory_region_init_ram(), compares memory region with
> > > > statically allocated 'global' ram_memory memory region
> > > > that it uses for RAM, and does nothing in case it matches.
> > > > 
> > > > While it's possible feed machine->ram to xen_ram_alloc()
> > > > in the same manner to keep that hack working, I'd prefer
> > > > not to keep that circular dependency and try to untangle that.
> > > > 
> > > > However it doesn't look trivial to fix, so as temporary
> > > > fixup opt out Xen machine from memdev based RAM allocation,
> > > > and let xen_ram_alloc() do its trick for now.
> > > > 
> > > > Reported-by: Anthony PERARD <anthony.perard@citrix.com>
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>    
> > > 
> > > Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> > > 
> > > That should work on most configs. But we also sometime use the "pc"
> > > machine with accel=xen, to run without the "xen-platform" pci device,
> > > but that would be less common.  
> > 
> > does following work for you in case of pc machine?
> > 
> > diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> > index 15650d7f6a..f19c0883ae 100644
> > --- a/hw/xen/xen-common.c
> > +++ b/hw/xen/xen-common.c
> > @@ -151,6 +151,8 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
> >  
> >  static int xen_init(MachineState *ms)
> >  {
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +
> >      xen_xc = xc_interface_open(0, 0, 0);
> >      if (xen_xc == NULL) {
> >          xen_pv_printf(NULL, 0, "can't open xen interface\n");
> > @@ -170,6 +172,10 @@ static int xen_init(MachineState *ms)
> >          return -1;
> >      }
> >      qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
> > +    /*
> > +     * opt out of system RAM being allocated by generic code
> > +     */
> > +    m->default_ram_id = NULL;
> >      return 0;  
> 
> After fixing the build issues, it does work, yes. I've tested both "xenfv"
> and "pc,accel=xen".

thanks, I'll post a formal patch

however it's all workarounds,
we need to fix ram allocation properly later on
so far I only have questions, hope you can help with clarifying them

1. why xen uses memory_region_init_ram() which does not allocate anything
   can it use plain memory_region_init() instead?
2. how main ram is allocated?
3. code has
           /*                                                                       
         * Xen does not allocate the memory continuously, it keeps a             
         * hole of the size computed above or passed in.                         
         */                                                                      
        block_len = (1ULL << 32) + x86ms->above_4g_mem_size; 
   which fixes up size ram memory region
   can we allocate 1 memory region of ram_size and then
   alias lower and upper memory instead of that?
4. how RAM migration works in case of xen?

> 
> Build issue:
> - I've added #include "hw/boards.h"
> - and s/m->/mc->/
ccccccgndiej> gngfiehlivuil

> Thanks!nbchihheikhjlnervve
> 


