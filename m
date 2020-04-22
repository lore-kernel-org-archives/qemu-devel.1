Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA17C5518C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19702073A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1zUiJcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19702073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRCyL-0002vm-1P
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 06:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRCx8-0001va-Tk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRCwy-0003kd-90
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:50:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54605
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jRCwx-0003gT-Ro
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587552591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oD3W30BaI9geOMlAEwm6bK5HPFf+rqEtoexxvlfrxfQ=;
 b=X1zUiJcbBMEwYEPn1I9ZQfarh8J40jgX41KYU5HInQQRQ1RLKnS7LjIYFH7wejgAa377KW
 kWKBHcoZoC/1RUd2MZiZ9YU8lr8YqaPgYYLFJ63l0qANvEtzLN9CX+pxyAV0yfMLdaOc94
 Z7rjxeO/0M7wvlKAbGrocRXKBwpK2y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-G8EY_T8NO8SOvJiuQSFIKQ-1; Wed, 22 Apr 2020 06:49:47 -0400
X-MC-Unique: G8EY_T8NO8SOvJiuQSFIKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49EED800FF0;
 Wed, 22 Apr 2020 10:49:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EA28600D2;
 Wed, 22 Apr 2020 10:49:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 73F8816E2C; Wed, 22 Apr 2020 12:49:41 +0200 (CEST)
Date: Wed, 22 Apr 2020 12:49:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-vga: fix virtio-vga bar ordering
Message-ID: <20200422104941.qp4lkblm7txlglm2@sirius.home.kraxel.org>
References: <20200421214853.14412-1-anthoine.bourgeois@gmail.com>
 <20200422020354-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200422020354-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 02:04:36AM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 21, 2020 at 11:48:53PM +0200, Anthoine Bourgeois wrote:
> > With virtio-vga, pci bar are reordered. Bar #2 is used for compatibilit=
y
> > with stdvga. By default, bar #2 is used by virtio modern io bar.
> > This bar is the last one introduce in the virtio pci bar layout and it'=
s
> > crushed by the virtio-vga reordering. So virtio-vga and
> > modern-pio-notify are incompatible because virtio-vga failed to
> > initialize with this option.
> >=20
> > This fix exchange the modern io bar with the modern memory bar,
> > replacing the msix bar that is never impacted anyway.
> >=20
> > Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
>=20
> Such changes generally need to be tied to machine version.

Given that modern-pio-notify is off by default and
virtio-vga,modern-pio-notify=3Don is broken I think we don't need to worry
about compatibility in this specific case (assuming the patch is updated
to not shuffle around the msix bar, see other reply).

cheers,
  Gerd


