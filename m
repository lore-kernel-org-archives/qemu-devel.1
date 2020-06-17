Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727F2C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4273821556
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N93UO6W1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4273821556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlatt-0002i9-I5
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jlatC-0002FR-6Q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:26:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jlatA-0002Xz-GN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592411171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvXmZ9amsph62miWniNK8wUvw67b1tdT95WTVOUtGeg=;
 b=N93UO6W1KtDl2CPQRh2KIqYOYMu1GveH7EMYAFDvTO1tyBKu/8Q3YXtOftmMz6TvWmp5jY
 RWTPol4jFGGCkZtz4x1BYnt3kao4uqKsOlR755Kvzw8fAV0gHPkkWRfhs3AeEi9PD+3Eh2
 7o7qgh3h4hteb9pIelRxr2p9m5nA4kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-xwkno9i0PZWOU-iQOojAnQ-1; Wed, 17 Jun 2020 12:26:08 -0400
X-MC-Unique: xwkno9i0PZWOU-iQOojAnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7450102C817;
 Wed, 17 Jun 2020 16:25:54 +0000 (UTC)
Received: from localhost (ovpn-113-21.phx2.redhat.com [10.3.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E769E80885;
 Wed, 17 Jun 2020 16:25:39 +0000 (UTC)
Date: Wed, 17 Jun 2020 12:25:38 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Christophe de Dinechin <cdupontd@redhat.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
Message-ID: <20200617162538.GC2366737@habkost.net>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <20200616171021.GV2366737@habkost.net>
 <56BCFEC0-DEEF-46A9-9BC4-8A75ABD158CF@redhat.com>
MIME-Version: 1.0
In-Reply-To: <56BCFEC0-DEEF-46A9-9BC4-8A75ABD158CF@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
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
Cc: pedro.principeza@canonical.com, dann.frazier@canonical.com,
 "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 christian.ehrhardt@canonical.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, lersek@redhat.com, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 10:17:55AM +0200, Christophe de Dinechin wrote:
> 
> 
> > Le 16 Jun 2020 à 19:10, Eduardo Habkost <ehabkost@redhat.com> a écrit :
> > 
> > On Tue, Jun 16, 2020 at 05:57:46PM +0100, Dr. David Alan Gilbert wrote:
> >> * Gerd Hoffmann (kraxel@redhat.com) wrote:
> >>>  Hi,
> >>> 
> >>>> (a) We could rely in the guest physbits to calculate the PCI64 aperture.
> >>> 
> >>> I'd love to do that.  Move the 64-bit I/O window as high as possible and
> >>> use -- say -- 25% of the physical address space for it.
> >>> 
> >>> Problem is we can't.
> >>> 
> >>>> failure. Also, if the users are not setting the physbits in the guest,
> >>>> there must be a default (seems to be 40bit according to my experiments),
> >>>> seems to be a good idea to rely on that.
> >>> 
> >>> Yes, 40 is the default, and it is used *even if the host supports less
> >>> than that*.  Typical values I've seen for intel hardware are 36 and 39.
> >>> 39 is used even by recent hardware (not the xeons, but check out a
> >>> laptop or a nuc).
> >>> 
> >>>> If guest physbits is 40, why to have OVMF limiting it to 36, right?
> >>> 
> >>> Things will explode in case OVMF uses more physbits than the host
> >>> supports (host physbits limit applies to ept too).  In other words: OVMF
> >>> can't trust the guest physbits, so it is conservative to be on the safe
> >>> side.
> >>> 
> >>> If we can somehow make a *trustable* physbits value available to the
> >>> guest, then yes, we can go that route.  But the guest physbits we have
> >>> today unfortunately don't cut it.
> >> 
> >> In downstream RH qemu, we run with host-physbits as default; so it's reasonably
> >> trustworthy; of course that doesn't help you across a migration between
> >> hosts with different sizes (e.g. an E5 Xeon to an E3).
> >> Changing upstream to do the same would seem sensible to me, but it's not
> >> a foolproof config.
> > 
> > Yeah, to make it really trustworthy we would need to prevent
> > migration to hosts with mismatching phys sizes.
> 
> Wouldn't it be sufficient to prevent guestphysbits > hostphysbits?

It probably would, for the OVMF issue we're discussing here.
But it's not a guarantee we give today.

If we make additional guarantees to guest software, we need to
communicate them unambiguously to the guest.

-- 
Eduardo


