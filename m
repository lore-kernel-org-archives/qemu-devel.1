Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF7DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0364F20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyh6cD2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0364F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9BAt-0000hw-B1
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k9B9H-0007Jg-SX
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:48:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k9B9G-0003pU-3X
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598032096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glssGzmq9HUIBQ09eR+HoYrcatuE3EsMPvRBftXM6Lg=;
 b=gyh6cD2JQ2NvDYkxbUIAoDglOX2rr+x/jmkBzUnYpVS5mXb3L43XeJQrcw2WwntCvMEvW6
 UYxCy+Yib32UDJycmTDAAUatzCjCJpZ3NyQU2pSEqgmvmBV3R4IGe5ps0hDTdViqgv4k7n
 naUV3hisaTrvn8yqN5vbDyBrdhIYcPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-ESTjzdxIPxqDRUXpF0K40g-1; Fri, 21 Aug 2020 13:48:14 -0400
X-MC-Unique: ESTjzdxIPxqDRUXpF0K40g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 638311885D89;
 Fri, 21 Aug 2020 17:48:12 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DD175C1D0;
 Fri, 21 Aug 2020 17:48:03 +0000 (UTC)
Date: Fri, 21 Aug 2020 13:48:02 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: Suspicious QOM types without instance/class size
Message-ID: <20200821174802.GK642093@habkost.net>
References: <20200820215529.GH642093@habkost.net>
 <20200821105352.GA89922@SPB-NB-133.local>
 <20200821172927.GJ642093@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200821172927.GJ642093@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

On Fri, Aug 21, 2020 at 01:29:38PM -0400, Eduardo Habkost wrote:
> On Fri, Aug 21, 2020 at 01:53:52PM +0300, Roman Bolshakov wrote:
> > On Thu, Aug 20, 2020 at 05:55:29PM -0400, Eduardo Habkost wrote:
> > > While trying to convert TypeInfo declarations to the new
> > > OBJECT_DECLARE* macros, I've stumbled on a few suspicious cases
> > > where instance_size or class_size is not set, despite having type
> > > checker macros that use a specific type.
> > > 
> > > The ones with "WARNING" are abstract types (maybe not serious if
> > > subclasses set the appropriate sizes).  The ones with "ERROR"
> > > don't seem to be abstract types.
> > > 
> > 
> > > ERROR: target/i386/hvf/hvf.c:908:1: instance_size should be set to sizeof(HVFState)?
> > 
> > Hi Eduardo,
> > 
> > How do you get the error?
> 
> My script looks for corresponding type checking macros, and check
> if instance_size is set to sizeof(T) with the right type from the
> type checking macro.
> 
> The code is here:
> https://github.com/ehabkost/qemu-hacks/blob/920b2c521ad2a29fa663256854e24ed2059ba9cd/scripts/codeconverter/codeconverter/qom_type_info.py#L136
> 
> 
> > 
> > Given your changes, instance size should really be sizeof(HVFState).
> > 
> 
> The changes I've made shouldn't make any difference (if there's
> an issue, it is there before or after my series).
> 
> > BTW, the object definition for hvf seems different from KVM (and perhaps
> > wrong?), e.g. HVFState is allocated within init_machine handler and then
> > assigned to a global variable:
> 
> Interesting.  It looks like hvf_state is _not_ the actual QOM
> object instance.  The actual TYPE_HVF_ACCEL instance is created
> by do_configure_accelerator().  That would explain why the lack
> of instance_init never caused any problems.
> 
> Luckily, no code ever used the HVF_STATE macro.  If
> HVF_STATE(hvf_state) got called, it would crash because of
> uninitialized object instance data.  If HVF_STATE(machine->accel)
> got called, it would return an invalid HVFState pointer (not
> hvf_state).
> 
> I believe the simplest short term solution here is to just delete
> the HVF_STATE macro and HVFState::parent field.  We can worry
> about actually moving hvf_state to the machine->accel QOM object
> later.

Actually, it might be easier to do the full QOM conversion in a
single patch instead of deleting the incomplete code.

Can you check if the following patch works?  I don't have a host
where I can test it.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index d81f569aed..81d1662d06 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -878,13 +878,11 @@ static int hvf_accel_init(MachineState *ms)
 {
     int x;
     hv_return_t ret;
-    HVFState *s;
+    HVFState *s = HVF_STATE(ms->accelerator);
 
     ret = hv_vm_create(HV_VM_DEFAULT);
     assert_hvf_ok(ret);
 
-    s = g_new0(HVFState, 1);
- 
     s->num_slots = 32;
     for (x = 0; x < s->num_slots; ++x) {
         s->slots[x].size = 0;
@@ -908,6 +906,7 @@ static void hvf_accel_class_init(ObjectClass *oc, void *data)
 static const TypeInfo hvf_accel_type = {
     .name = TYPE_HVF_ACCEL,
     .parent = TYPE_ACCEL,
+    .instance_size = sizeof(HVFState),
     .class_init = hvf_accel_class_init,
 };
 
 
-- 
Eduardo


