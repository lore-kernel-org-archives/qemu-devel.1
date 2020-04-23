Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4E9C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA06E20781
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/Tl9S4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA06E20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcTk-00085H-1k
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRcSO-000760-Dl
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRcSN-0004x1-Tv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:04:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49244
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jRcSN-0004wf-Bl
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587650638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzMgDRFUeMxJPseBr+Cs7fZP2+yKHotgq+3nvwBlsic=;
 b=U/Tl9S4/aFdoFGe3LDMx6axTv1fVi+kOdylbzcSX3DSa/IiRnzPPTDFTNvu5uWWjxv+TiF
 vgDW0lg2jnGcdx2tsB4drB1Y6J3p16X+yNJyh4GGKOwy6RWDl+F0XQyMRwn4CdIRmXdrLM
 mmD38HUotEcFV/jHClVTUNPTWn31xRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-Ybluly46PKi-NntDMU6XHg-1; Thu, 23 Apr 2020 10:03:56 -0400
X-MC-Unique: Ybluly46PKi-NntDMU6XHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF3FE10082EA;
 Thu, 23 Apr 2020 14:03:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CADBA600F5;
 Thu, 23 Apr 2020 14:03:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 050401753B; Thu, 23 Apr 2020 16:03:51 +0200 (CEST)
Date: Thu, 23 Apr 2020 16:03:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/2] virtio-vga: fix virtio-vga bar ordering
Message-ID: <20200423140350.tlsfvoktrbb7zamx@sirius.home.kraxel.org>
References: <20200422215455.10244-1-anthoine.bourgeois@gmail.com>
 <20200423085202-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200423085202-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 08:52:58AM -0400, Michael S. Tsirkin wrote:
> On Wed, Apr 22, 2020 at 11:54:54PM +0200, Anthoine Bourgeois wrote:
> > With virtio-vga, pci bar are reordered. Bar #2 is used for compatibilit=
y
> > with stdvga. By default, bar #2 is used by virtio modern io bar.
> > This bar is the last one introduce in the virtio pci bar layout and it'=
s
> > crushed by the virtio-vga reordering. So virtio-vga and
> > modern-pio-notify are incompatible because virtio-vga failed to
> > initialize with this option.
> >=20
> > This fix sets the modern io bar to the bar #5 to avoid conflict.
> >=20
> > Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
>=20
> Gerd, would you say it's required for 5.0?

Given that modern-pio-notify is off by default I wouldn't classify this
as release blocker, i.e. I wouldn't delay the release for that.

We are at -rc4 (last rc) already, so I'd tend to say no.  Maybe if we
need -rc5 for other reasons.

cheers,
  Gerd


