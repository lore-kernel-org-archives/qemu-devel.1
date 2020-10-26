Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8636C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7A820759
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEPNy5g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7A820759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyeW-0008Kf-45
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kWydn-0007ZO-Pg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kWydk-00051B-Ud
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603703886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bIX1h/cfL//04l0KeIJuXgxCTkB/h/ORzwAOXq/Yoq4=;
 b=gEPNy5g+AnatORLczKhZLIBvrONVInZ4N6pVUdZPPllhVGHR0xhu1RNKLhjpcfPhO22EfF
 7D/ALwjepigxJfN8OY7Znzkwi+7W2DD96T2SJPe7Pbuus0rTq/AktAMKgw11jJOBYD3ojv
 laTUqstnusylQi9Z6hk/61jhU/k/g/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-m46A_zaYMWiCYTzETC_1CA-1; Mon, 26 Oct 2020 05:18:04 -0400
X-MC-Unique: m46A_zaYMWiCYTzETC_1CA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB7B48049D9;
 Mon, 26 Oct 2020 09:18:03 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59F535C1DC;
 Mon, 26 Oct 2020 09:17:52 +0000 (UTC)
Date: Mon, 26 Oct 2020 10:17:49 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201026091749.GB727443@angien.pipo.sk>
References: <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
 <20201023144901.5bd908a1@yekko.fritz.box>
 <CAC_L=vUh8LU5c8c00OhnbEiW7EzZFWKU61vOdub7c11wDMXeRg@mail.gmail.com>
 <20201023115029-mutt-send-email-mst@kernel.org>
 <20201023192755.1845b060@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023192755.1845b060@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pkrempa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Libvirt Mailing List <libvir-list@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 David Gibson <dgibson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 19:27:55 +0200, Igor Mammedov wrote:
> On Fri, 23 Oct 2020 11:54:40 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Oct 23, 2020 at 09:47:14AM +0300, Marcel Apfelbaum wrote:
> > > Hi David,
> > > 
> > > On Fri, Oct 23, 2020 at 6:49 AM David Gibson <dgibson@redhat.com> wrote:
> > > 
> > >     On Thu, 22 Oct 2020 11:01:04 -0400
> > >     "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > >     > On Thu, Oct 22, 2020 at 05:50:51PM +0300, Marcel Apfelbaum wrote:
> > >     >Ã‚Â  [...]Ã‚Â 
> > >     >
> > >     > Right. After detecting just failing unconditionally it a bit too
> > >     > simplistic IMHO.  
> > > 
> > >     There's also another factor here, which I thought I'd mentioned
> > >     already, but looks like I didn't: I think we're still missing some
> > >     details in what's going on.
> > > 
> > >     The premise for this patch is that plugging while the indicator is in
> > >     transition state is allowed to fail in any way on the guest side.Ã‚Â  I
> > >     don't think that's a reasonable interpretation, because it's unworkable
> > >     for physical hotplug.Ã‚Â  If the indicator starts blinking while you're in
> > >     the middle of shoving a card in, you'd be in trouble.
> > > 
> > >     So, what I'm assuming here is that while "don't plug while blinking" is
> > >     the instruction for the operator to obey as best they can, on the guest
> > >     side the rule has to be "start blinking, wait a while and by the time
> > >     you leave blinking state again, you can be confident any plugs or
> > >     unplugs have completed".Ã‚Â  Obviously still racy in the strict computer
> > >     science sense, but about the best you can do with slow humans in the
> > >     mix.
> > > 
> > >     So, qemu should of course endeavour to follow that rule as though it
> > >     was a human operator on a physical machine and not plug when the
> > >     indicator is blinking.Ã‚Â  *But* the qemu plug will in practice be fast
> > >     enough that if we're hitting real problems here, it suggests the guest
> > >     is still doing something wrong.
> > > 
> > > 
> > > I personally think there is a little bit of over-engineeringÃ‚Â here.
> > > Let's start with the spec:
> > > 
> > > Ã‚Â  Ã‚Â  Power Indicator Blinking
> > > Ã‚Â  Ã‚Â  A blinking Power Indicator indicates that the slot is powering up or
> > > powering down and that
> > > Ã‚Â  Ã‚Â  insertion or removal of the adapter is not permitted.
> > > 
> > > What exactly is an interpretation here?
> > > As you stated, the races are theoretical, the whole point of the indicator
> > > is to let the operator know he can't plug the device just yet.
> > > 
> > > I understand it would be more user friendly if the QEMU would wait internally
> > > for the
> > > blinking to end, but the whole point of the indicator is to let the operatorÃ‚Â 
> > > (human or machine)
> > > know they can't plug the device at a specific time.
> > > Should QEMU take the responsibilityÃ‚Â of the operator? Is it even correct?
> > > 
> > > Even if we would want such a feature, how is it related to this patch?
> > > The patch simply refuses to start a hotplug operation when it knows it will not
> > > succeed.Ã‚Â 
> > > Ã‚Â 
> > > Another way that would make sense to me would beÃ‚Â  is a new QEMU interface other
> > > than
> > > "add_device", let's say "adding_device_allowed", that would return true if the
> > > hotplug is allowed
> > > at this point of time. (I am aware of the theoretical races)Ã‚Â   
> > 
> > Rather than adding_device_allowed, something like "query slot"
> > might be helpful for debugging. That would help user figure out
> > e.g. why isn't device visible without any races.
> 
> Would be new command useful tough? What we end up is broken guest
> (if I read commit message right) and a user who has no idea if 
> device_add was successful or not.
> So what user should do in this case
>   - wait till it explodes?
>   - can user remove it or it would be stuck there forever?
>   - poll slot before hotplug, manually?
> 
> (if this is the case then failing device_add cleanly doesn't sound bad,
> it looks similar to another error we have "/* Check if hot-plug is disabled on the slot */"
> in pcie_cap_slot_pre_plug_cb)
> 
> CCing libvirt, as it concerns not only QEMU.

The only reason a separate command might make sense is if libvirt would
want to provide a specific error to the user/upper management layer that
the operation failed due to a transient failure (so that it can be
retried later).

We don't really want to go to a policy decision of how long to wait in
such case, so unless qemu waits libvirt will plainly want to report an
error.

That said IMO 'device_add' should still fail if it's certain that the
device won't be plugged in. This will fix any client which is currently
in use. Adding a separate command is worth only for pre-checking for
saner error handling.

> > > The above will at least mimic the mechanics of the pyhsÃ‚Â world.Ã‚Â  The operator
> > > looks at the indicator,
> > > the management software checks if adding the device is allowed.
> > > Since it is a corner case I would prefer the device_add to fail rather than
> > > introducing a new interface,
> > > but that's just me.
> > > 
> > > Thanks,
> > > Marcel
> > >   
> > 
> > I think we want QEMU management interface to be reasonably
> > abstract and agnostic if possible. Pushing knowledge of hardware
> > detail to management will just lead to pain IMHO.
> > We supported device_add which practically never fails for years,
> 
> For CPUs and RAM, device_add can fail so maybe management is also
> prepared to handle errors on PCI hotplug path.

While it was me who implemented device_add for cpu/memory I don't
remmeber any more whether we are really prepared for it.

We certainly want to do it if there's a possibility to do it.


