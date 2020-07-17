Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC74C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B1F204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4nm4FAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B1F204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwSh7-0000oE-L7
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jwSgX-0000Nv-MA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:54:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40313
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jwSgV-0003jZ-Ec
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595001241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnAmVihZhGe2HkgVc0kUE8EB+LfY8Y0I3/40LKGDMaw=;
 b=W4nm4FAV/KFS5QtVew6qQNZP8XZVraqnXH5UC+JBZcGDhvhPQzkHSQfbXjt8bKc9F5cujV
 PiXJJhg0X2A7two1JIw7CzrGn6rk8Ac9KWBDW+j3nCpPOawvSvcjDxoATd/kGf76/Gwwy+
 fFMLxnuOQP+2I1n9S/dhdmVKXoiFwKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-M0E5Sv30N2eom4iyAuHpeg-1; Fri, 17 Jul 2020 11:53:57 -0400
X-MC-Unique: M0E5Sv30N2eom4iyAuHpeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB0CC107BEF5;
 Fri, 17 Jul 2020 15:53:55 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D038C6FEF7;
 Fri, 17 Jul 2020 15:53:54 +0000 (UTC)
Date: Fri, 17 Jul 2020 09:53:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 3/9] vfio: add quirk device write method
Message-ID: <20200717095352.45845d8a@x1.home>
In-Reply-To: <CAFEAcA-1EhD=0vU1r=48HhFPpovns2M5DBgTu7g2074kueaEuw@mail.gmail.com>
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-4-ppandit@redhat.com>
 <CAFEAcA-1EhD=0vU1r=48HhFPpovns2M5DBgTu7g2074kueaEuw@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 P J P <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 18:46:33 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 30 Jun 2020 at 13:30, P J P <ppandit@redhat.com> wrote:
> >
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > Add vfio quirk device mmio write method to avoid NULL pointer
> > dereference issue.
> >
> > Reported-by: Lei Sun <slei.casper@gmail.com>
> > Reviewed-by: Li Qiang <liq3ea@gmail.com>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > ---
> >  hw/vfio/pci-quirks.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > Update v3: Add Reviewed-by: ...  
> >   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09406.html  
> >
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index d304c81148..cc6d5dbc23 100644
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -14,6 +14,7 @@
> >  #include "config-devices.h"
> >  #include "exec/memop.h"
> >  #include "qemu/units.h"
> > +#include "qemu/log.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/main-loop.h"
> >  #include "qemu/module.h"
> > @@ -264,8 +265,15 @@ static uint64_t vfio_ati_3c3_quirk_read(void *opaque,
> >      return data;
> >  }
> >
> > +static void vfio_ati_3c3_quirk_write(void *opaque, hwaddr addr,
> > +                                        uint64_t data, unsigned size)
> > +{
> > +    qemu_log_mask(LOG_GUEST_ERROR, "%s not implemented\n", __func__);
> > +}
> > +
> >  static const MemoryRegionOps vfio_ati_3c3_quirk = {
> >      .read = vfio_ati_3c3_quirk_read,
> > +    .write = vfio_ati_3c3_quirk_write,
> >      .endianness = DEVICE_LITTLE_ENDIAN,
> >  };  
> 
> 
> Alex (Williamson) -- as the vfio maintainer, do you have a view
> on whether we should be logging write accesses to port 0x3c3
> here as guest-errors or unimplemented-QEMU-functionality?
> 
> Guest-error seems plausible to me, anyway.

I believe the intention was that writes would be dropped, so if this
generates logging that is going to cause users to file bugs, that would
be undesirable.  Thanks,

Alex


