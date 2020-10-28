Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F439C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7121B247C5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRqS9dxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7121B247C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnNe-0005rO-9x
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kXnHX-0005Qi-RF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kXnHV-0006oH-Er
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603898550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k+QTxfh5NtWdv5KSF/Fp4k6VPCAq/RTvsgimFdnyt4g=;
 b=NRqS9dxZgdwMwXXj2k/7+KGNH/4XqvfRd6fcUeja3UYqH9m+24HkB8xLTZjuhigQBxvTrS
 51cGlrl9bcbDwQpkOg+E08TrpFaraeKuDd5q4QaCMzJ6LH/ZevHcNDe9vybCcAvqYm0pkt
 1L6KnaVcHSyRuTSpheiw2icquuput18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-hM0dIzUgNHuJbN0Dlju1Tg-1; Wed, 28 Oct 2020 11:22:27 -0400
X-MC-Unique: hM0dIzUgNHuJbN0Dlju1Tg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 863B710082E6;
 Wed, 28 Oct 2020 15:22:25 +0000 (UTC)
Received: from localhost (unknown [10.40.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E49515C1D7;
 Wed, 28 Oct 2020 15:22:18 +0000 (UTC)
Date: Wed, 28 Oct 2020 16:22:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 4/5] spapr: Pass &error_abort when getting some PC DIMM
 properties
Message-ID: <20201028162216.0f33e0ef@redhat.com>
In-Reply-To: <20201027161858.590329a7@bahia>
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309732180.2739814.7243774674998010907.stgit@bahia.lan>
 <20201023211509.5c316c01@redhat.com>
 <20201025162444.0fdec88a@bahia.lan>
 <20201027125424.13833af8@redhat.com>
 <20201027161858.590329a7@bahia>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 16:18:58 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Tue, 27 Oct 2020 12:54:24 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Sun, 25 Oct 2020 16:24:44 +0100
> > Greg Kurz <groug@kaod.org> wrote:
> >   
> > > On Fri, 23 Oct 2020 21:15:09 +0200
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >   
> > > > On Mon, 19 Oct 2020 10:48:41 +0200
> > > > Greg Kurz <groug@kaod.org> wrote:
> > > >     
> > > > > Both PC_DIMM_SLOT_PROP and PC_DIMM_ADDR_PROP are defined in the
> > > > > default property list of the PC DIMM device class:
> > > > > 
> > > > >     DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),
> > > > > 
> > > > >     DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
> > > > >                       PC_DIMM_UNASSIGNED_SLOT),
> > > > > 
> > > > > They should thus be always gettable for both PC DIMMs and NVDIMMs.
> > > > > An error in getting them can only be the result of a programming
> > > > > error. It doesn't make much sense to propagate the error in this
> > > > > case. Abort instead.
> > > > > 
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>    
> > > > 
> > > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > > 
> > > > TODO for future,
> > > > get rid of local_err in spapr_memory_plug() altogether, it should not fail.
> > > > it needs moving check from spapr_drc_attach() to spapr_memory_pre_plug() time.
> > > > 
> > > > that will clear up (a bit) road for dropping errp in spapr_memory_plug()    
> > > 
> > > Igor,
> > > 
> > > I could find time to look a bit into attaching DRCs at pre-plug and I
> > > think this isn't possible. The problem is that there doesn't seem to be
> > > a reverse operation for pre-plug. If realize fails for the DIMM device,
> > > spapr_drc_detach() wouldn't be called, which would be wrong.  
> > 
> > probably I was clear enough, I didn't suggest to move spapr_drc_detach()
> > to pre_plug time but rather do a bit of surgery along the lines:
> >   
> 
> Ok, I get it now. I realize now I actually misread your suggestion. Sorry...
> 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 2db810f73a..59a229b4fa 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3474,6 +3474,11 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >          return;
> >      }
> >  
> > +    get drc
> > +    if (!spapr_drc_attachable(drc)) {
> > +        error out
> > +    }
> > +  
> 
> It might require some more code refactoring because the way regular
> PC-DIMMs are broken down into a set of logical memory blocks (LMBs),
> each one having its own DRC but it's certainly doable. Probably for
> QEMU 6.0 though since we're entering soft freeze and David already
> fired a PR today.

as far as it's not forgotten, it can be done later.

> 
> >      if (is_nvdimm) {
> >          spapr_nvdimm_validate(hotplug_dev, NVDIMM(dev), size, &local_err);
> >          if (local_err) {
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index fe998d8108..ae049bc202 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -371,14 +371,16 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
> >      } while (fdt_depth != 0);
> >  }
> >  
> > -void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp)
> > +
> > +bool spapr_drc_attachable(SpaprDrc *drc)
> > +{
> > +   return !drc->dev;
> > +}
> > +
> > +void spapr_drc_attach(SpaprDrc *drc, DeviceState *d)
> >  {
> >      trace_spapr_drc_attach(spapr_drc_index(drc));
> >  
> > -    if (drc->dev) {
> > -        error_setg(errp, "an attached device is still awaiting release");
> > -        return;
> > -    }
> >      g_assert((drc->state == SPAPR_DRC_STATE_LOGICAL_UNUSABLE)
> >               || (drc->state == SPAPR_DRC_STATE_PHYSICAL_POWERON));
> >   
> > > 
> > > Am I missing something ?
[...]


