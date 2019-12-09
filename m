Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B50C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7624C2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVfxKMUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7624C2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieRaM-0006JL-IX
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 17:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ieRZZ-0005rm-Mx
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ieRZV-0003CR-PF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:32:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37935
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ieRZT-00039y-1d
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575930722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xemli+i88rH7BNSPXUGoxSqWPocyNhTOQPWcdjHN0+4=;
 b=CVfxKMUIb0fkfg4lNKsczSQJb1id2GzeeNZ/h946RgAwRSYpDBViOsBrYNXRU+jH5kkRDI
 Z0fFrZn2sv9Bnd+5+fQsmSBSYEQp1J2dfyjlRELoYO7dm62+kWSfiTzpjByNl2lNaeyJ0F
 akPkrL/RCVHdSJajqM/mEfAJU1ylA8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-AjwqUhLNN2SmPe-N7QC0UQ-1; Mon, 09 Dec 2019 17:31:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A87EDB23;
 Mon,  9 Dec 2019 22:31:57 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01CAE60484;
 Mon,  9 Dec 2019 22:31:53 +0000 (UTC)
Date: Mon, 9 Dec 2019 19:31:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v2 1/2] usb-host: remove 'remote wakeup' flag from
 configuration descriptor
Message-ID: <20191209223152.GL498046@habkost.net>
References: <20191203190716.18917-1-yuri.benditovich@daynix.com>
 <20191203190716.18917-2-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20191203190716.18917-2-yuri.benditovich@daynix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: AjwqUhLNN2SmPe-N7QC0UQ-1
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
Cc: yan@daynix.com, kraxel@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 03, 2019 at 09:07:15PM +0200, Yuri Benditovich wrote:
> If the redirected device has this capability, Windows guest may
> place the device into D2 and expect it to wake when the device
> becomes active, but this will never happen. For example, when
> internal Bluetooth adapter is redirected, keyboards and mice
> connected to it do not work. Current commit removes this
> capability (starting from machine 4.2)
> Set 'usb-host.suppress-remote-wake' property to 'off' to keep
> 'remote wake' as is or to 'on' to remove 'remote wake' on
> 4.1 or earlier.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/core/machine.c    |  1 +
>  hw/usb/host-libusb.c | 20 ++++++++++++++++++++
>  hw/usb/trace-events  |  1 +
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1689ad3bf8..8c0eaad091 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -29,6 +29,7 @@
> =20
>  GlobalProperty hw_compat_4_1[] =3D {
>      { "virtio-pci", "x-pcie-flr-init", "off" },
> +    { "usb-host", "suppress-remote-wake", "off" },
>  };
>  const size_t hw_compat_4_1_len =3D G_N_ELEMENTS(hw_compat_4_1);

In case this doesn't get merged in QEMU 4.2.0, the patch needs to
be updated to change hw_compat_4_2 instead (after applying the
5.0 machine type patch[1]).

[1] https://patchew.org/QEMU/20191112104811.30323-1-cohuck@redhat.com/

--=20
Eduardo


