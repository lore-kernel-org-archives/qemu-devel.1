Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB19C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 06:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EAD20757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 06:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5J2NHOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EAD20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKGBt-0005GD-PY
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 02:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jKGAC-00031I-66
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jKGAA-0002p1-TC
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:50:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44652
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jKGAA-0002no-PS
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 02:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585896646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNX23+0EkkuuLBnny3uByfNuL03aQcE/4SjHEFpKkdw=;
 b=K5J2NHOfX2nzbykgmR1ggzLKbdXLUXY9n/Gc4bFrtVfvh+cDqloCFI+ec3L348G3I2ZLSg
 FV+9OKOzlPVt67wMmbsykk9UMAc4vbNKnVG2n+l5l8uajFoau4BCqHJjsrpe/lj+ct+XDF
 PfhwJsJYniYlvEn6BUHouOphsXRbkzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-nbygjGG3MXe-eNwULuhMzg-1; Fri, 03 Apr 2020 02:50:44 -0400
X-MC-Unique: nbygjGG3MXe-eNwULuhMzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB05E8017CE;
 Fri,  3 Apr 2020 06:50:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5601619756;
 Fri,  3 Apr 2020 06:50:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8001D1747F; Fri,  3 Apr 2020 08:50:42 +0200 (CEST)
Date: Fri, 3 Apr 2020 08:50:42 +0200
From: kraxel <kraxel@redhat.com>
To: =?utf-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>
Subject: Re: is just a wrong function name of libusb_get_port_number? request
 for a review of the bug fix
Message-ID: <20200403065042.cirj4ih3fl45wlqb@sirius.home.kraxel.org>
References: <02a07a59c3964199b73b1145e4abe0e9@tencent.com>
MIME-Version: 1.0
In-Reply-To: <02a07a59c3964199b73b1145e4abe0e9@tencent.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: hdegoede <hdegoede@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 11:47:17AM +0000, bauerchen(=E9=99=88=E8=92=99=E8=
=92=99) wrote:
> From 6bfb3087866606ed36a21e7bd05f0674e6a97158 Mon Sep 17 00:00:00 2001
> From: Bauerchen <bauerchen@tencent.com>
> Date: Thu, 2 Apr 2020 19:19:00 +0800
> Subject: [PATCH] Fix:fix the wrong function name of libusb_get_port_numbe=
r
>=20
> [desc]:
> libusb_get_port_numbers is called in function
> usb_host_get_port, and qemu crashed with:
> symbol lookup error: undefined symbol: libusb_get_port_numbers
> I check /lib64/libusb-1.0.so.0 and output is libusb_get_port_number, I
> change it to libusb_get_port_number, crash problem is gone;
> so is it just a function name bug?
>=20
> Signed-off-by: Bauerchen <bauerchen@tencent.com>
> ---
> =C2=A0hw/usb/host-libusb.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index 2ac7a93..713db8d 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -285,7 +285,7 @@ static int usb_host_get_port(libusb_device *dev, char=
 *port, size_t len)
> =C2=A0 =C2=A0 =C2=A0int rc, i;
> =C2=A0
> =C2=A0#if LIBUSB_API_VERSION >=3D 0x01000102
> - =C2=A0 =C2=A0rc =3D libusb_get_port_numbers(dev, path, 7);
> + =C2=A0 =C2=A0rc =3D libusb_get_port_number(dev, path, 7);

Surely not that simple.  libusb_get_port_number isn't a drop-in
replacement for libusb_get_port_numbers.  Also it was probably added
later to libusb, so some LIBUSB_API_VERSION #ifdef will be needed so the
one or the other will be used depending on the library version.

cheers,
  Gerd


