Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF34C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A4E2080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApNyVWAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A4E2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTnL-0005co-1Q
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlTmg-000588-G4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:51:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40122
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlTme-0008Mr-4Z
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592383857;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KA0b4yD8xE+iivBEdg9p5OgqVOQlnW87utOeoP5/44M=;
 b=ApNyVWAyKX3Yr+a52GwAxKltDmOrwZZSvtdtxJIHYklqbZZhxMVXP6LV9WynuiNrMGGxD8
 7F2vty1v/RnzIlnR/oBmylCKK2FFkwy1TBGwLflV7FxdZiHr/sxOY1NLw1EZiFgPEqKgkj
 T5tkqlS7wyHrci/saS59//o8gYMqNXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-ydCC6V3yNkmPUcL0Av8Qig-1; Wed, 17 Jun 2020 04:50:44 -0400
X-MC-Unique: ydCC6V3yNkmPUcL0Av8Qig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21FC4134CC;
 Wed, 17 Jun 2020 08:50:43 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA1A15EE0E;
 Wed, 17 Jun 2020 08:50:36 +0000 (UTC)
Date: Wed, 17 Jun 2020 09:50:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
Message-ID: <20200617085033.GB568347@redhat.com>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <20200616171021.GV2366737@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616171021.GV2366737@habkost.net>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: pedro.principeza@canonical.com, dann.frazier@canonical.com,
 "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 christian.ehrhardt@canonical.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, lersek@redhat.com, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 16, 2020 at 01:10:21PM -0400, Eduardo Habkost wrote:
> On Tue, Jun 16, 2020 at 05:57:46PM +0100, Dr. David Alan Gilbert wrote:
> > * Gerd Hoffmann (kraxel@redhat.com) wrote:
> > >   Hi,
> > > 
> > > > (a) We could rely in the guest physbits to calculate the PCI64 aperture.
> > > 
> > > I'd love to do that.  Move the 64-bit I/O window as high as possible and
> > > use -- say -- 25% of the physical address space for it.
> > > 
> > > Problem is we can't.
> > > 
> > > > failure. Also, if the users are not setting the physbits in the guest,
> > > > there must be a default (seems to be 40bit according to my experiments),
> > > > seems to be a good idea to rely on that.
> > > 
> > > Yes, 40 is the default, and it is used *even if the host supports less
> > > than that*.  Typical values I've seen for intel hardware are 36 and 39.
> > > 39 is used even by recent hardware (not the xeons, but check out a
> > > laptop or a nuc).
> > > 
> > > > If guest physbits is 40, why to have OVMF limiting it to 36, right?
> > > 
> > > Things will explode in case OVMF uses more physbits than the host
> > > supports (host physbits limit applies to ept too).  In other words: OVMF
> > > can't trust the guest physbits, so it is conservative to be on the safe
> > > side.
> > > 
> > > If we can somehow make a *trustable* physbits value available to the
> > > guest, then yes, we can go that route.  But the guest physbits we have
> > > today unfortunately don't cut it.
> > 
> > In downstream RH qemu, we run with host-physbits as default; so it's reasonably
> > trustworthy; of course that doesn't help you across a migration between
> > hosts with different sizes (e.g. an E5 Xeon to an E3).
> > Changing upstream to do the same would seem sensible to me, but it's not
> > a foolproof config.
> 
> Yeah, to make it really trustworthy we would need to prevent
> migration to hosts with mismatching phys sizes.  We would need to
> communicate that to the guest somehow (with new hypervisor CPUID
> flags, maybe).

QEMU should be able to validate the hostphysbits >= guestphysbits when
accepting incoming migration, and abort it.

Meanwhile libvirt should be enhanced to report hostphysbits, so that
management apps can determine that they shouldn't even pick bad hosts
in the first place.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


