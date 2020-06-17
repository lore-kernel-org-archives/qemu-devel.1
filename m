Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A4CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E45208B8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcA0XCXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E45208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYQu-00012E-9q
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlYPF-0007ht-Ga
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:47:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlYPB-0007MS-MW
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592401624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZPItyO0BW2fXmWr7d2juoYJHE/REMr33EQH9eBh9s7Q=;
 b=CcA0XCXUzU+uvTtrKQdp7/uEb3Q2MoEt8eXcQDfbiVa2j/W5UfJx/F3OTO1iB0vmezRu5X
 +4TjvN4AQ62hKVjF4jKFgY1oVdwwK/UEu1sHuhAxsqQ3MW8as8wQFcqTCkHeIe9XNlngUm
 vL/9rbyAexLtSLKIoeXqMKz5qeqIa4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-px9fOG0TPRivBvR8GUDx5w-1; Wed, 17 Jun 2020 09:47:02 -0400
X-MC-Unique: px9fOG0TPRivBvR8GUDx5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF894107B472;
 Wed, 17 Jun 2020 13:47:00 +0000 (UTC)
Received: from work-vm (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D457F5D9D3;
 Wed, 17 Jun 2020 13:46:54 +0000 (UTC)
Date: Wed, 17 Jun 2020 14:46:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
Message-ID: <20200617134652.GE2776@work-vm>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>, ehabkost@redhat.com,
 Dann Frazier <dann.frazier@canonical.com>,
 Guilherme Piccoli <gpiccoli@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Gerd Hoffmann <kraxel@redhat.com>, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laszlo Ersek (lersek@redhat.com) wrote:
> On 06/16/20 19:14, Guilherme Piccoli wrote:
> > Thanks Gerd, Dave and Eduardo for the prompt responses!
> > 
> > So, I understand that when we use "-host-physical-bits", we are
> > passing the *real* number for the guest, correct? So, in this case we
> > can trust that the guest physbits matches the true host physbits.
> > 
> > What if then we have OVMF relying in the physbits *iff*
> > "-host-phys-bits" is used (which is the default in RH and a possible
> > machine configuration on libvirt XML in Ubuntu), and we have OVMF
> > fallbacks to 36-bit otherwise?
> 
> I've now read the commit message on QEMU commit 258fe08bd341d, and the
> complexity is simply stunning.
> 
> Right now, OVMF calculates the guest physical address space size from
> various range sizes (such as hotplug memory area end, default or
> user-configured PCI64 MMIO aperture), and derives the minimum suitable
> guest-phys address width from that address space size. This width is
> then exposed to the rest of the firmware with the CPU HOB (hand-off
> block), which in turn controls how the GCD (global coherency domain)
> memory space map is sized. Etc.
> 
> If QEMU can provide a *reliable* GPA width, in some info channel (CPUID
> or even fw_cfg), then the above calculation could be reversed in OVMF.
> We could take the width as a given (-> produce the CPU HOB directly),
> plus calculate the *remaining* address space between the GPA space size
> given by the width, and the end of the memory hotplug area end. If the
> "remaining size" were negative, then obviously QEMU would have been
> misconfigured, so we'd halt the boot. Otherwise, the remaining area
> could be used as PCI64 MMIO aperture (PEI memory footprint of DXE page
> tables be darned).
> 
> > Now, regarding the problem "to trust or not" in the guests' physbits,
> > I think it's an orthogonal discussion to some extent. It'd be nice to
> > have that check, and as Eduardo said, prevent migration in such cases.
> > But it's not really preventing OVMF big PCI64 aperture if we only
> > increase the aperture _when  "-host-physical-bits" is used_.
> 
> I don't know what exactly those flags do, but I doubt they are clearly
> visible to OVMF in any particular way.

The firmware should trust whatever it reads from the cpuid and thus gets
told from qemu; if qemu is doing the wrong thing there then that's our
problem and we need to fix it in qemu.

Dave

> Thanks
> Laszlo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


