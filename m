Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE01C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD4521534
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4YzUKGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD4521534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlaw9-000436-1g
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jlavR-0003Nf-T3
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:28:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49542
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jlavO-0002wD-Mw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592411309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nSztPQF/WkwqA5OUcsmQwEdU7av3c1hOLUZNRjQ1738=;
 b=P4YzUKGfk9K1nNU1pjRR4fnM9eJ90ivUn8Etjv/ssEeLfQ6odps+EWIII7R7HW4mJZhnKc
 jUPHj+I31OTf7mxnzHdZvt7T7PD9jH9TZ/NVWcCBCGhdl1u6XLaTPDnjnw2CW5BiqE2K2v
 dgqLOd/n+Jvq2r0dcpsUuzKGEYnA7vk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-kDask9hNPy2O37F0ue14fw-1; Wed, 17 Jun 2020 12:28:28 -0400
X-MC-Unique: kDask9hNPy2O37F0ue14fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B89EC1005513;
 Wed, 17 Jun 2020 16:28:26 +0000 (UTC)
Received: from localhost (ovpn-113-21.phx2.redhat.com [10.3.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 531565D9D3;
 Wed, 17 Jun 2020 16:28:20 +0000 (UTC)
Date: Wed, 17 Jun 2020 12:28:19 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
Message-ID: <20200617162819.GD2366737@habkost.net>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
 <20200617134652.GE2776@work-vm>
 <20200617154959.GZ2366737@habkost.net>
 <20200617160412.GG2776@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200617160412.GG2776@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>, libvir-list@redhat.com,
 Dann Frazier <dann.frazier@canonical.com>,
 Guilherme Piccoli <gpiccoli@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+libvir-list

On Wed, Jun 17, 2020 at 05:04:12PM +0100, Dr. David Alan Gilbert wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
> > On Wed, Jun 17, 2020 at 02:46:52PM +0100, Dr. David Alan Gilbert wrote:
> > > * Laszlo Ersek (lersek@redhat.com) wrote:
> > > > On 06/16/20 19:14, Guilherme Piccoli wrote:
> > > > > Thanks Gerd, Dave and Eduardo for the prompt responses!
> > > > > 
> > > > > So, I understand that when we use "-host-physical-bits", we are
> > > > > passing the *real* number for the guest, correct? So, in this case we
> > > > > can trust that the guest physbits matches the true host physbits.
> > > > > 
> > > > > What if then we have OVMF relying in the physbits *iff*
> > > > > "-host-phys-bits" is used (which is the default in RH and a possible
> > > > > machine configuration on libvirt XML in Ubuntu), and we have OVMF
> > > > > fallbacks to 36-bit otherwise?
> > > > 
> > > > I've now read the commit message on QEMU commit 258fe08bd341d, and the
> > > > complexity is simply stunning.
> > > > 
> > > > Right now, OVMF calculates the guest physical address space size from
> > > > various range sizes (such as hotplug memory area end, default or
> > > > user-configured PCI64 MMIO aperture), and derives the minimum suitable
> > > > guest-phys address width from that address space size. This width is
> > > > then exposed to the rest of the firmware with the CPU HOB (hand-off
> > > > block), which in turn controls how the GCD (global coherency domain)
> > > > memory space map is sized. Etc.
> > > > 
> > > > If QEMU can provide a *reliable* GPA width, in some info channel (CPUID
> > > > or even fw_cfg), then the above calculation could be reversed in OVMF.
> > > > We could take the width as a given (-> produce the CPU HOB directly),
> > > > plus calculate the *remaining* address space between the GPA space size
> > > > given by the width, and the end of the memory hotplug area end. If the
> > > > "remaining size" were negative, then obviously QEMU would have been
> > > > misconfigured, so we'd halt the boot. Otherwise, the remaining area
> > > > could be used as PCI64 MMIO aperture (PEI memory footprint of DXE page
> > > > tables be darned).
> > > > 
> > > > > Now, regarding the problem "to trust or not" in the guests' physbits,
> > > > > I think it's an orthogonal discussion to some extent. It'd be nice to
> > > > > have that check, and as Eduardo said, prevent migration in such cases.
> > > > > But it's not really preventing OVMF big PCI64 aperture if we only
> > > > > increase the aperture _when  "-host-physical-bits" is used_.
> > > > 
> > > > I don't know what exactly those flags do, but I doubt they are clearly
> > > > visible to OVMF in any particular way.
> > > 
> > > The firmware should trust whatever it reads from the cpuid and thus gets
> > > told from qemu; if qemu is doing the wrong thing there then that's our
> > > problem and we need to fix it in qemu.
> > 
> > It is impossible to provide a MAXPHYADDR that the guest can trust
> > unconditionally and allow live migration to hosts with different
> > sizes at the same time.
> 
> It would be nice to get to a point where we could say that the reported
> size is no bigger than the physical hardware.
> The gotcha here is that (upstream) qemu is still reporting 40 by default
> when even modern Intel desktop chips are 39.

I agree it would be nice.  We just need a method to tell guest
software that we are really making this additional guarantee.

> 
> > Unless we want to drop support live migration to hosts with
> > different sizes entirely, we need additional bits to tell the
> > guest how much it can trust MAXPHYADDR.
> 
> Could we go with host-phys-bits=true by default, that at least means the
> normal behaviour is correct; if people want to migrate between different
> hosts with different sizes they should set phys-bits (or
> host-phys-limit) to the lowest in their set of hardware.

Host-dependent defaults may be convenient for end users running
QEMU directly, but not a good idea if a stable guest ABI is
expected from your VM configuration (which is the case for
software using the libvirt API).

-- 
Eduardo


