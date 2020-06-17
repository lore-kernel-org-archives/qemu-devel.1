Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE033C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D1D2080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQ+vbfeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D1D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlan0-0005Ja-AK
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlal5-0003jd-4o
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:17:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42313
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlal3-0001Gg-2D
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592410667;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OIEaOra8VcmDV+zBeRmQdBGbXIjdaysSxNy00YYDqDo=;
 b=EQ+vbfeZUlL6fld8oSHqRwbwKnxMrDM5W9cGSEeG3oBmhYRVIsOOzHEQFRFAmA+2DEiuIX
 BUunapot3azOOyxVkDMzonRRvlSXaEbyypfa8lk4inr+kf5G5/Xz8B44SKyVpavsAWY+TT
 YPeHcC+PcShHZSbiPTDHA4YmBzXB5uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-GRXhOEk0N4aV6ndHB1WoPQ-1; Wed, 17 Jun 2020 12:17:28 -0400
X-MC-Unique: GRXhOEk0N4aV6ndHB1WoPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6870F94B22;
 Wed, 17 Jun 2020 16:17:26 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF4797CAA0;
 Wed, 17 Jun 2020 16:17:20 +0000 (UTC)
Date: Wed, 17 Jun 2020 17:17:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
Message-ID: <20200617161717.GC660974@redhat.com>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
 <20200617134652.GE2776@work-vm>
 <20200617154959.GZ2366737@habkost.net>
 <20200617160412.GG2776@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617160412.GG2776@work-vm>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Pedro Principeza <pedro.principeza@canonical.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Dann Frazier <dann.frazier@canonical.com>,
 Guilherme Piccoli <gpiccoli@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
> 
> > Unless we want to drop support live migration to hosts with
> > different sizes entirely, we need additional bits to tell the
> > guest how much it can trust MAXPHYADDR.
> 
> Could we go with host-phys-bits=true by default, that at least means the
> normal behaviour is correct; if people want to migrate between different
> hosts with different sizes they should set phys-bits (or
> host-phys-limit) to the lowest in their set of hardware.

Is there any sense in picking the default value based on -cpu selection ?

If user has asked for -cpu host, there's no downside to host-phys-bits=true,
as the user has intentionally traded off live migration portability already.

If the user askes for -cpu $MODEL, then could we set phys-bits=NNN for some
NNN that is the lowest value for CPUs that are capable of running $MODEL ?
Or will that get too complicated with the wide range of SKU variants, in
particular server vs desktop CPUs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


