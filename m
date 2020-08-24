Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361ECC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018FE20578
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxOBsEVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018FE20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFck-000591-5x
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAFbk-0004Fd-8p
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:46:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25071
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAFbg-0000Tb-J6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598287562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1XzbNWeNpDcedTyqVpwbUo6zXZYGCvIVa0hYb0Avi8=;
 b=VxOBsEVA2cRI1Wk/WAGjRvtC4hed4Rm00ijyWWo4XMlk+80q/2knJYGLJpg3+etRhLNdCM
 vu7Ak+eq8VQQ/O3tI/BUdgLNpiNcc2DPMGld+jKHYqQFqvbtklFwvMwyEylUzdH2PvPVU7
 BKXjOOUV8j3ZHPkF8y69U/CNoFQeRUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-HSmc7CefNX2U691luYbQRQ-1; Mon, 24 Aug 2020 12:45:59 -0400
X-MC-Unique: HSmc7CefNX2U691luYbQRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70D911052BB4;
 Mon, 24 Aug 2020 16:45:56 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 973A3756B3;
 Mon, 24 Aug 2020 16:45:54 +0000 (UTC)
Date: Mon, 24 Aug 2020 12:45:52 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: Suspicious QOM types without instance/class size
Message-ID: <20200824164552.GP642093@habkost.net>
References: <20200820215529.GH642093@habkost.net>
 <20200821105352.GA89922@SPB-NB-133.local>
 <20200821172927.GJ642093@habkost.net>
 <20200821174802.GK642093@habkost.net>
 <20200824164134.GA41106@SPB-NB-133.local>
MIME-Version: 1.0
In-Reply-To: <20200824164134.GA41106@SPB-NB-133.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 03:41:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Cameron Esfahani <dirty@apple.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 07:41:34PM +0300, Roman Bolshakov wrote:
> On Fri, Aug 21, 2020 at 01:48:02PM -0400, Eduardo Habkost wrote:
> > On Fri, Aug 21, 2020 at 01:29:38PM -0400, Eduardo Habkost wrote:
> > > On Fri, Aug 21, 2020 at 01:53:52PM +0300, Roman Bolshakov wrote:
> > > > On Thu, Aug 20, 2020 at 05:55:29PM -0400, Eduardo Habkost wrote:
> > > > > While trying to convert TypeInfo declarations to the new
> > > > > OBJECT_DECLARE* macros, I've stumbled on a few suspicious cases
> > > > > where instance_size or class_size is not set, despite having type
> > > > > checker macros that use a specific type.
> > > > > 
> > > > > The ones with "WARNING" are abstract types (maybe not serious if
> > > > > subclasses set the appropriate sizes).  The ones with "ERROR"
> > > > > don't seem to be abstract types.
> > > > > 
> > > > 
> > > > > ERROR: target/i386/hvf/hvf.c:908:1: instance_size should be set to sizeof(HVFState)?
> > > > 
> > > 
> > > > BTW, the object definition for hvf seems different from KVM (and perhaps
> > > > wrong?), e.g. HVFState is allocated within init_machine handler and then
> > > > assigned to a global variable:
> > > 
> > > Interesting.  It looks like hvf_state is _not_ the actual QOM
> > > object instance.  The actual TYPE_HVF_ACCEL instance is created
> > > by do_configure_accelerator().  That would explain why the lack
> > > of instance_init never caused any problems.
> > > 
> > > Luckily, no code ever used the HVF_STATE macro.  If
> > > HVF_STATE(hvf_state) got called, it would crash because of
> > > uninitialized object instance data.  If HVF_STATE(machine->accel)
> > > got called, it would return an invalid HVFState pointer (not
> > > hvf_state).
> > > 
> > > I believe the simplest short term solution here is to just delete
> > > the HVF_STATE macro and HVFState::parent field.  We can worry
> > > about actually moving hvf_state to the machine->accel QOM object
> > > later.
> > 
> > Actually, it might be easier to do the full QOM conversion in a
> > single patch instead of deleting the incomplete code.
> > 
> 
> I agree full QOM conversion is better, perhaps we can later move
> certains bits to accel/hvf.c like it's done for kvm/tcg/qtest.
> 
> > Can you check if the following patch works?  I don't have a host
> > where I can test it.
> > 
> 
> Sure, thanks :)
> 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> > index d81f569aed..81d1662d06 100644
> > --- a/target/i386/hvf/hvf.c
> > +++ b/target/i386/hvf/hvf.c
> > @@ -878,13 +878,11 @@ static int hvf_accel_init(MachineState *ms)
> >  {
> >      int x;
> >      hv_return_t ret;
> > -    HVFState *s;
> > +    HVFState *s = HVF_STATE(ms->accelerator);
> 
> The file also needs definition of MachineState:
> #include "hw/boards.h"
> 
> >  
> >      ret = hv_vm_create(HV_VM_DEFAULT);
> >      assert_hvf_ok(ret);
> >  
> > -    s = g_new0(HVFState, 1);
> > - 
> >      s->num_slots = 32;
> >      for (x = 0; x < s->num_slots; ++x) {
> >          s->slots[x].size = 0;
> > @@ -908,6 +906,7 @@ static void hvf_accel_class_init(ObjectClass *oc, void *data)
> >  static const TypeInfo hvf_accel_type = {
> >      .name = TYPE_HVF_ACCEL,
> >      .parent = TYPE_ACCEL,
> > +    .instance_size = sizeof(HVFState),
> >      .class_init = hvf_accel_class_init,
> >  };
> >  
> >  
> 
> Unfortunately it fails to start (even without the HVF patch):
> ERROR:../qom/object.c:314:type_initialize: assertion failed: (parent->class_size <= ti->class_size)
> Bail out! ERROR:../qom/object.c:314:type_initialize: assertion failed: (parent->class_size <= ti->class_size)
[...]
> It doesn't seem related to HVF QOM changes 🤔
> 
> Bisected it to:
> 
> b717702de21461138ac0e1d6775da0bd0482c013 is the first bad commit
> commit b717702de21461138ac0e1d6775da0bd0482c013
> Author: Daniel P. Berrangé <berrange@redhat.com>
> Date:   Wed Aug 19 20:12:35 2020 -0400
> 
>     crypto: use QOM macros for declaration/definition of secret types
> 
>     This introduces the use of the OBJECT_DEFINE and OBJECT_DECLARE macro
>     families in the secret types, in order to eliminate boilerplate code.
> 
>     Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>     Message-Id: <20200723181410.3145233-4-berrange@redhat.com>
>     [ehabkost: rebase, update to pass additional arguments to macro]
>     Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>     Message-Id: <20200820001236.1284548-58-ehabkost@redhat.com>

Oh, that's a bug in my QOM series.  Thanks for debugging it!  I
will fix it in v3.

However, the hvf patch above shouldn't require it.  You should be
able to apply and test it on top of qemu.git master.

-- 
Eduardo


