Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB2AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B3420714
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOmR1joZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B3420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT12z-000758-7x
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 07:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT11e-0006b2-Go
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT11c-0004ay-9T
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602759740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t6T6YSQWfGM5InAHRhgWMevIrBcK6O5M/IW3PHz+8DE=;
 b=fOmR1joZAsl6RhCx25wPgN2jls4MQh3e9Dk84PhWU9L0KgxsTpSDC24DSPktOe6okL1OCl
 so8IgRak9xnQITv1fQK/VwKhTOEZA72xP1VhlYaHOOTcydg3rirYEuh9EoPLz1U7dM7pC5
 nO3Pn6X9M6jToyv1bc2h7dDcmYq9Wp0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-jJ3ownylP1yeR_6-KqcywA-1; Thu, 15 Oct 2020 07:02:17 -0400
X-MC-Unique: jJ3ownylP1yeR_6-KqcywA-1
Received: by mail-oo1-f72.google.com with SMTP id a11so1125975oot.13
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 04:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t6T6YSQWfGM5InAHRhgWMevIrBcK6O5M/IW3PHz+8DE=;
 b=TN6eHeKjXl7t1EPL8CZ557imVchfcEWyhB9+tI3zxy7XilRtNsczvVcq6V2G4cHmCc
 geMk2/IMJxfEgy8X1t8WPULNPTe8oyFnwj3pEa3SOSVM3oNEBN2O0PDFjFRrjONy9vpH
 Pkt6x2mCB8//2F0KwLwZ5XdY74f5njrSqrAB2Rux5qjHHx0wWTYkobVPbL/o5UzD2J/3
 Lv9ygHzd/21Az0JA3X30eBILDyELYACDKd0UQ8q2Hs3EwoD+iFkCnBJa3tHk0vVfcGIT
 d05TbJCFKu06WhBAONvY54l8LtHnifFLQh9NAemgGu4G9RFHsLvvTAseiT5czjb/P81H
 u+Fw==
X-Gm-Message-State: AOAM533FejYOvo9V3HoNobkrGu7aELC4xU3nJqg+orfYmkMV6rRcm1CX
 0oWk3LIlCmwWfMSP1H0gg8z+f9k1H/QEEhO+LPq8s1MvYomWYXtiLkpSJu3LPejVlLM4Gu3C92Z
 8aT4Eopz/TtpmZkvhKdlvXPpkQCRX1Qs=
X-Received: by 2002:a9d:3e4:: with SMTP id f91mr2412143otf.244.1602759735926; 
 Thu, 15 Oct 2020 04:02:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwExiBBPccnZxZKDq3Hodl9gAqrFWct9uhdWdB6phvZ40pkA3jR5FIN0GPiTB5hMtQfoFdy2/Rbx9kkq1ps0Ms=
X-Received: by 2002:a9d:3e4:: with SMTP id f91mr2412116otf.244.1602759735680; 
 Thu, 15 Oct 2020 04:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201015075957.268823-1-mcascell@redhat.com>
In-Reply-To: <20201015075957.268823-1-mcascell@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 15 Oct 2020 13:02:04 +0200
Message-ID: <CAP+75-VWtNi=Hv+-=5gbZbFmK3871c3obNO4w_ihGBnDoUZ2dQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/usb/hcd-dwc2: fix divide-by-zero in
 dwc2_handle_packet()
To: Mauro Matteo Cascella <mcascell@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: gaoning.pgn@antgroup.com, Paul Zimmerman <pauldzim@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Xingwei Lin <linyi.lxw@antfin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 10:03 AM Mauro Matteo Cascella
<mcascell@redhat.com> wrote:
>
> Check the value of mps to avoid potential divide-by-zero later in the function.
> Since HCCHAR_MPS is guest controllable, this prevents a malicious/buggy guest
> from crashing the QEMU process on the host.
>
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> Reviewed-by: Paul Zimmerman <pauldzim@gmail.com>
> Reported-by: Gaoning Pan <gaoning.pgn@antgroup.com>
> Reported-by: Xingwei Lin <linyi.lxw@antfin.com>

Maybe also the implicit
Tested-by: Paul Zimmerman <pauldzim@gmail.com>
from:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg04254.html

> ---
> Moved check earlier in the function and added "Reviewed-by" line.
>
>  hw/usb/hcd-dwc2.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> index 97688d21bf..9856c4540c 100644
> --- a/hw/usb/hcd-dwc2.c
> +++ b/hw/usb/hcd-dwc2.c
> @@ -245,6 +245,12 @@ static void dwc2_handle_packet(DWC2State *s, uint32_t devadr, USBDevice *dev,
>      trace_usb_dwc2_handle_packet(chan, dev, &p->packet, epnum, types[eptype],
>                                   dirs[epdir], mps, len, pcnt);
>
> +    if (mps == 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: Bad HCCHAR_MPS set to zero\n", __func__);
> +        return;
> +    }
> +
>      if (eptype == USB_ENDPOINT_XFER_CONTROL && pid == TSIZ_SC_MC_PID_SETUP) {
>          pid = USB_TOKEN_SETUP;
>      } else {
> --
> 2.26.2
>
>


