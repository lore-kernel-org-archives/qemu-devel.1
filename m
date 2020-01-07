Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60538C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5C020678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkB1SbqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5C020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolxZ-0008OJ-5u
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iokt5-0006W5-Dr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iokt2-0006ZY-N6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:10:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iokt2-0006Xe-J5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578388250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05ZJvmkodkNJqznOdknG4TWMg6bMOufa1X9JWEiyO8M=;
 b=gkB1SbqSpK8ROShM350x510FoNyB4m4xTF1chdDi+cjluzMyo42+tuOBilfHVzfNah3aFh
 Oj9WMJRrEEs+OLfCtxR+wBY0TxWG0vQQ4PyqUs2KNqdyOs2gJGmFieo4o03cw7F/Q4n5ag
 ljgm/IU1IlVuz1HML2tKtOuEsfLhEqs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-bo55PVSoO52oQF99yPSAWw-1; Tue, 07 Jan 2020 04:10:49 -0500
Received: by mail-wm1-f70.google.com with SMTP id l11so2985410wmi.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 01:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wYCbv9HmbouaBLtGcG0ADhqwUeb+LbkXb/L4EUdli50=;
 b=jIJ47SV6/Pl9J7NFT5x+ab5KO2e0wxXZY/3vJ+/DgwwFCW8OF0dYids6Y2cG00uxYi
 HNCYdYqH8vUUP0gJgsS53ZiUJzFbreYwTVGKJzQtKSmt6A+na5kA755ntD9Vzoz12suL
 yOBk3JljlZwQAgMoCbedJRPd++fq6Tm4Og0n/DJwdIG2gTc5pZJldFagHiFFs0DgY7R5
 hMyAMR4CfNXwwjbi5JX2WCs56kN5nCSaoNgrH8KhLvgcGLmlv1yMqxizQttvQMRqJYHC
 ugOCUJ1gPLyqV1S+KFaH1eBmPJlPd99iCngAHdMIiZisl+SRw+B0biHPFHnBSBReC/Nh
 /Okw==
X-Gm-Message-State: APjAAAX13r/Gwmkz9/2S4SVc09GgnG+ZKRg3Z2zg3eX8yPidnqCV3iWR
 we2A+z+Zogiz3JBkDe6t6GnbFFNJ1XfN1BBT0Oqcg/VEbAHO/dN5Xe2aBjYPQ8wijVoPKi/Tg6x
 Yf/+ZuyxTUkIqQ14=
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr39759836wmo.13.1578388248026; 
 Tue, 07 Jan 2020 01:10:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKQmdJ7XTAUayE6CaHTUn2gA+F6G4WHLvP5KOe4hSC7pnhz1x2VQrSXHwTa582IB1PQB/ncg==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr39759818wmo.13.1578388247791; 
 Tue, 07 Jan 2020 01:10:47 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id w8sm27354799wmd.2.2020.01.07.01.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 01:10:47 -0800 (PST)
Subject: Re: [PATCH] xhci: recheck slot status
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200107083606.12393-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb17bf85-5976-8611-91cc-35d2499f2bef@redhat.com>
Date: Tue, 7 Jan 2020 10:10:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107083606.12393-1-kraxel@redhat.com>
Content-Language: en-US
X-MC-Unique: bo55PVSoO52oQF99yPSAWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 9:36 AM, Gerd Hoffmann wrote:
> Factor out slot status check into a helper function.  Add an additional
> check after completing transfers.  This is needed in case a guest
> queues multiple transfers in a row and a device unplug happens while
> qemu processes them.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1786413
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/usb/hcd-xhci.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 80988bb305a1..c198a2d150c9 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -1861,6 +1861,13 @@ static void xhci_kick_ep(XHCIState *xhci, unsigned=
 int slotid,
>       xhci_kick_epctx(epctx, streamid);
>   }
>  =20
> +static bool xhci_slot_ok(XHCIState *xhci, int slotid)
> +{
> +    return (xhci->slots[slotid - 1].uport &&
> +            xhci->slots[slotid - 1].uport->dev &&
> +            xhci->slots[slotid - 1].uport->dev->attached);
> +}
> +
>   static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid=
)
>   {
>       XHCIState *xhci =3D epctx->xhci;
> @@ -1878,9 +1885,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, u=
nsigned int streamid)
>  =20
>       /* If the device has been detached, but the guest has not noticed t=
his
>          yet the 2 above checks will succeed, but we must NOT continue */
> -    if (!xhci->slots[epctx->slotid - 1].uport ||
> -        !xhci->slots[epctx->slotid - 1].uport->dev ||
> -        !xhci->slots[epctx->slotid - 1].uport->dev->attached) {
> +    if (!xhci_slot_ok(xhci, epctx->slotid)) {
>           return;
>       }
>  =20
> @@ -1987,6 +1992,10 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, =
unsigned int streamid)
>           } else {
>               xhci_fire_transfer(xhci, xfer, epctx);
>           }
> +        if (!xhci_slot_ok(xhci, epctx->slotid)) {
> +            /* surprise removal -> stop processing */

I'd use "unexpected removal", but surprise is funnier :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +            break;
> +        }
>           if (xfer->complete) {
>               /* update ring dequeue ptr */
>               xhci_set_ep_state(xhci, epctx, stctx, epctx->state);
>=20


