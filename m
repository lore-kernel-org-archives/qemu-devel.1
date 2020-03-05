Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D96C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731CA2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dmg0APr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731CA2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9o5K-0005mi-Jt
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9o4V-000592-1i
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9o4U-0005Tp-2f
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:49:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40149
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9o4O-0005R9-Lz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583405376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjATUW/5m3yTKYSiJ131MJpBOfWBVsXMfEsSS1NFroE=;
 b=Dmg0APr1L7faBRsme8xA/FrIUBG2i6patfSoCUrp66W9cdwjRTnrHWIOYXDRF3Nue0kgqo
 j0vZS5liGv8Z3VTQqfFbK9Zk0SmdK8Vp5VH4UGtyB9t2XSRtiAUoSIbHXgIQNyBywNKGxi
 Vn6beEHrZnY2GILdQZRJ0D6DGHqHmI8=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321--qEzOblWP0SWAOD1IxJuUA-1; Thu, 05 Mar 2020 05:49:32 -0500
X-MC-Unique: -qEzOblWP0SWAOD1IxJuUA-1
Received: by mail-vk1-f199.google.com with SMTP id r80so1856513vke.17
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 02:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KjATUW/5m3yTKYSiJ131MJpBOfWBVsXMfEsSS1NFroE=;
 b=QcpVHwGiIk1KRztXWuSGACJsZ3N8oLiF3K3ZnDSQ04X41HzWnphdvxsYEmUW9+F7mg
 brfA0xJU7HNPF+Sjv7nyaEVhzsV4ihgAh22EAZbNl1jYzlSg9YiP/LtK0EwzcrJvZCai
 TlnL6x11Zej0Lwz4h07Jz4SF0dCYMFa9t3ySyDRqGGlSXTsd0cOoxesaTV555ky36evF
 bJYezpQvOKMwUCiDMTBQXjSebfCf2l7ky4EaIjn05QlmfNwybD88JfnQkob184HE5wW4
 73Hb+wDjVI838we3g5ggTLzeoCQRPcan8dvhtyuurYeqUQyJSyqLlcEJt+rz54/QSnYL
 lY7A==
X-Gm-Message-State: ANhLgQ2rqaOlaU3bDvifq/LumzsWCK6pn+V0/80UPnHfFNLkbrpiqYVb
 vzhXD/gN/hqtro4eAItWcj+tZuoq8PbLFUn3++29Em+8yO3lMrYrw4A8r81H0d2EDHMHC8sXWsH
 zU8o1EeNULB0HpQvOi+15327lX6W6BgU=
X-Received: by 2002:a67:f296:: with SMTP id m22mr4460449vsk.237.1583405372087; 
 Thu, 05 Mar 2020 02:49:32 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsFs/p/Py5fwqBoWxmfdA2gU4jv9MGYe0k1KetSxux7/LHbtiuv9T+LxzpjB0/34fSVCUNaMjU8tcGAwPDVMrI=
X-Received: by 2002:a67:f296:: with SMTP id m22mr4460438vsk.237.1583405371794; 
 Thu, 05 Mar 2020 02:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20200304221807.25212-1-philmd@redhat.com>
 <20200304221807.25212-4-philmd@redhat.com>
 <20200305080237.j2a7waokxominirn@sirius.home.kraxel.org>
 <a5b6cddf-5887-be27-db76-2e515daa2c11@redhat.com>
In-Reply-To: <a5b6cddf-5887-be27-db76-2e515daa2c11@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 5 Mar 2020 11:49:20 +0100
Message-ID: <CAP+75-XBbTPHbQJWxn5nEYsz4hdGXSTLTqKRRR-sx-APbPN2Sg@mail.gmail.com>
Subject: Re: [PATCH 3/6] hw/usb/quirks: Use smaller types to reduce .rodata by
 10KiB
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 11:41 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 3/5/20 9:02 AM, Gerd Hoffmann wrote:
> >>   struct usb_device_id {
> >> -    int vendor_id;
> >> -    int product_id;
> >> -    int interface_class;
> >> -    int interface_subclass;
> >> -    int interface_protocol;
> >> +    int16_t vendor_id;
> >> +    int16_t product_id;
> >> +    int8_t interface_class;
> >> +    int8_t interface_subclass;
> >> +    int8_t interface_protocol;
> >
> > I guess we should better use the uint variants here ...
>
> I tried it first but I got:
>
>    CC      hw/usb/quirks.o
> hw/usb/quirks.c:25:34: error: result of comparison of constant -1 with
> expression of type 'const uint16_t' (aka 'const unsigned short') is
> always true [-Werror,-Wtautological-constant-out-of-range-compare]
>      for (i =3D 0; ids[i].vendor_id !=3D -1; i++) {
>                  ~~~~~~~~~~~~~~~~ ^  ~~
> hw/usb/quirks.c:28:37: error: result of comparison of constant -1 with
> expression of type 'const uint8_t' (aka 'const unsigned char') is always
> false [-Werror,-Wtautological-constant-out-of-range-compare]
>              (ids[i].interface_class =3D=3D -1 ||
>               ~~~~~~~~~~~~~~~~~~~~~~ ^  ~~
>
> And went this less intrusive way.
>
> I'll respin with s/-1/UINT8_MAX/.

Problem, now this entry is ignored (interface_class=3D=3D-1):

    { USB_DEVICE_AND_INTERFACE_INFO(MICROCHIP_VID, MICROCHIP_USB_BOARD_PID,
                                    0xff, 0xff, 0x00) },


