Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0321FC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34FC20665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mbu05iIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34FC20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0b2-0004mM-NQ
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 11:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ia0Kl-0002KH-S3
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ia0Kk-0006WP-Qc
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:38:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39597
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ia0Kk-0006W3-M6
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574872710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7yNzDDk2GTk2YCs7lVj3e1j/hoyxiaD105Kq+L93H0=;
 b=Mbu05iIH/hQ0ItOFJFdUQj3Ci7MEIkJyxALT9/N1Oipwc/72xh4uDF8sA69+e2nfItrcDs
 MxLxdd3LF2G0bN0O/8DE8xqQh0NnnK3WoXxBGFQPMAyF82cfHFYKAhV3OuwHaB48IIUDgU
 RXTuSmMWUwpmV9GfMgA9bNvVzTag2GA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-cfSXTgSTNhugc9G20wDnvQ-1; Wed, 27 Nov 2019 11:38:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DABF0803065;
 Wed, 27 Nov 2019 16:38:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A862C60C81;
 Wed, 27 Nov 2019 16:38:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A087B16E18; Wed, 27 Nov 2019 17:38:23 +0100 (CET)
Date: Wed, 27 Nov 2019 17:38:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH] usbredir: remove 'remote wake' capability from
 configuration descriptor
Message-ID: <20191127163823.cylqikhogdypxpyp@sirius.home.kraxel.org>
References: <20191126212245.27735-1-yuri.benditovich@daynix.com>
 <87a78hltbq.fsf@dusky.pond.sub.org>
 <CAOEp5OdsYhxD4LE9Qu981uiB+33Xc81z8H=cuwTS6tbU9x_UkA@mail.gmail.com>
 <20191127094012.vgpckaztez77dsgz@sirius.home.kraxel.org>
 <CAOEp5Ocit+8tXxP1873YBD=mMQTeZNcr7pMezw_PU6vMFrg2bA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Ocit+8tXxP1873YBD=mMQTeZNcr7pMezw_PU6vMFrg2bA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: cfSXTgSTNhugc9G20wDnvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Yan Vugenfirer <yan@daynix.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Indeed, it would be good to call usb_wakeup(), but ... there is no
> trigger to do that.
>=20
> When the guest places the device to D2, it cancels all the urbs that
> were pending, so there are no request that will be completed on spice
> client side that can call usb_wakeup on qemu side.
> The device on spice client side is powered up without any active
> request so the device will not produce wake up event.

Well, the device will produce a wakeup event for sure (unless it is
buggy), so the kernel will notice.  It might be that the kernel doesn't
forward the event to userspace though.

For "normal" usb applications the kernel can transparently handle
suspend+wakeup and just re-submit pending urbs to the hardware after
receiving a wakeup event, so powermanagement works automagically without
the app doing anything special.

For qemu + spice-client that approach doesn't work though, we need
explicit instead of automatic power management so we can properly
forward any events to the guest and let the guest deal with it.

Skimming the libusb docs it seems there is no support for that though.
So no easy way out.  Guess patching the descriptor is the best thing we
can do here.

> Similar problem happens with local redirection, BTW. But this is for
> another patch.

Can you make a small series for both?  I guess the actual descriptor
checking and patching is pretty simliar and can be handled by a shared
helper function.

thanks,
  Gerd


