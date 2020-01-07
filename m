Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3269C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9922073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkRtPj0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9922073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolH0-0003gK-SE
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iojTr-0007ox-78
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iojTp-00030w-Sn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:40:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28795
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iojTp-00030e-Ov
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61pSPygZCz488OMzA3zcMxDZq3d7HemMISO1Ir5Y6qI=;
 b=BkRtPj0GVrVNArrgrkcmlZwwStmZmvmELD0kEADxMasyiBuEQSxy7ragrdE+eaC6AtqKKc
 3DQcMp6BNwHBA2861N+5EpP3BZPuDzKShQS9VKtp9GNhf05eviBhODBdK5wfF664NDsjdC
 bq+V20D5TAfwTzaL6M3JGPBYrzd/kLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-2ifxPT97N0S0NUzbl7FRew-1; Tue, 07 Jan 2020 02:40:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBE24802B85;
 Tue,  7 Jan 2020 07:40:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7634060C88;
 Tue,  7 Jan 2020 07:40:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 63ACF11AAA; Tue,  7 Jan 2020 08:40:41 +0100 (CET)
Date: Tue, 7 Jan 2020 08:40:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v2 1/2] usb-host: remove 'remote wakeup' flag from
 configuration descriptor
Message-ID: <20200107074041.lpmsg32ktorqdfbc@sirius.home.kraxel.org>
References: <20191203190716.18917-1-yuri.benditovich@daynix.com>
 <20191203190716.18917-2-yuri.benditovich@daynix.com>
 <20191209223152.GL498046@habkost.net>
 <CAOEp5Od9Xo=mz0PX6y9oj+mQCu27eC6jAu6y1womrTBsAZC82Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Od9Xo=mz0PX6y9oj+mQCu27eC6jAu6y1womrTBsAZC82Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2ifxPT97N0S0NUzbl7FRew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Yan Vugenfirer <yan@daynix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > >  GlobalProperty hw_compat_4_1[] =3D {
> > >      { "virtio-pci", "x-pcie-flr-init", "off" },
> > > +    { "usb-host", "suppress-remote-wake", "off" },
> > >  };
> > >  const size_t hw_compat_4_1_len =3D G_N_ELEMENTS(hw_compat_4_1);
> >
> > In case this doesn't get merged in QEMU 4.2.0, the patch needs to
> > be updated to change hw_compat_4_2 instead (after applying the
> > 5.0 machine type patch[1]).
>=20
> Of course I will resubmit if needed.

Ping.  Submission was too close to the release, so it'll go into 5.0.
Please resend with compat properties updated accordingly (otherwise the
patches are fine).

thanks,
  Gerd


