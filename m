Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3611CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD08620B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKcdUYkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD08620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqpA-00022b-LI
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMqo2-0000w5-EE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMqo0-0004AB-12
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:50:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44854
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMqnz-00049z-TC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571737819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OG0e0ewbVh3R67znSxCkpfCRmBTG37BqsGa4y73s7Q=;
 b=VKcdUYkVzGpiROsZ05ToO7HJ2d/V+gQARDYgl6ZUwRlCLUqNvDs2TcQYtWK8YZleLeEeVV
 ERE8zNgcgRizkW0+t9YvHz0WDpm0xRMVXLWgMq1dlpqkQmSBSnOHZUNErrKQ/g3wA5WpdB
 3ssgZqZYnVYOy0yRLEve4uoboa1OGwE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-o4S1ONKWPRK3FmhMbQzpNQ-1; Tue, 22 Oct 2019 05:50:18 -0400
Received: by mail-wr1-f69.google.com with SMTP id s9so8848066wrw.23
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OXaDuDwJoJFcycjxDm4ESqfcq0lFUdhQ3kfiUoncFB8=;
 b=JwmEpUmeoXsKfP26voKYz4YX+s2hNIVpF6SpEas0fghS+BLBQIFFTLxaYJquLLci55
 qfeLzxD7VBMTofriRi99kJ8tiyjRGEBZFSTCSM5ImK6wzWPAx4HbMAoThaZzF2Czzjnn
 T6OqAsl96+uf1RaRzNt7zIVYvU/Z8INUAbm1/aPmB3Gdc4T0XrLkzsWc2uiIxMG7p86E
 8SONY9XFHIp/cKXA8XIFkT2Q0qL+R2+DkH54tdQ6mBkAzDg4bIAPYmiG7N4MNknfUVS6
 WGlfYfED3GrVhhdlzRhmIO1JJdrbOmbe3IEw0Fd/qua5hlEf3SqgMWqfOGdS8o16uu6p
 RSIg==
X-Gm-Message-State: APjAAAXiRDur8Wy6lUx3G29tM3gaIEZljTraRHTxebVkpnP9hb4QYdR7
 6gTYoadryOnDtClxVjUZM4srJ6gczX9beZzKDCy9O1A8+LeLZTW9rHb3VU4dGNI7Yw/6mD+gSuD
 hpvblhGw/8+5QPdQ=
X-Received: by 2002:a1c:a4c6:: with SMTP id n189mr2166116wme.111.1571737816397; 
 Tue, 22 Oct 2019 02:50:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxdu5nT6JJabvxA1tKUWTK0xQErTGN7iO/aEnsrkTaIyjXiSn9+y6fnmPlVcgn4A0HfS34rIw==
X-Received: by 2002:a1c:a4c6:: with SMTP id n189mr2166095wme.111.1571737816192; 
 Tue, 22 Oct 2019 02:50:16 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id p17sm14207927wrn.4.2019.10.22.02.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 02:50:15 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] ps2: accept 'Set Key Make and Break' commands
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191022055415.18122-1-svens@stackframe.org>
 <20191022055415.18122-4-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <666cd652-ffb3-8615-1cf0-1310967a9e56@redhat.com>
Date: Tue, 22 Oct 2019 11:50:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022055415.18122-4-svens@stackframe.org>
Content-Language: en-US
X-MC-Unique: o4S1ONKWPRK3FmhMbQzpNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 7:54 AM, Sven Schnelle wrote:
> HP-UX sends both the 'Set key make and break (0xfc) and
> 'Set all key typematic make and break' (0xfa). QEMU response
> with 'Resend' as it doesn't handle these commands. HP-UX than
> reports an PS/2 max retransmission exceeded error. Add these
> commands and just reply with ACK.
>=20
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   hw/input/ps2.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 67f92f6112..6c2c7066a6 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -49,6 +49,8 @@
>   #define KBD_CMD_RESET_DISABLE=090xF5=09/* reset and disable scanning */
>   #define KBD_CMD_RESET_ENABLE   =090xF6    /* reset and enable scanning =
*/
>   #define KBD_CMD_RESET=09=090xFF=09/* Reset */
> +#define KBD_CMD_SET_MAKE_BREAK  0xFC    /* Set Make and Break mode */
> +#define KBD_CMD_SET_TYPEMATIC   0xFA    /* Set Typematic Make and Break =
mode */
>  =20
>   /* Keyboard Replies */
>   #define KBD_REPLY_POR=09=090xAA=09/* Power on reset */
> @@ -592,6 +594,10 @@ void ps2_write_keyboard(void *opaque, int val)
>                   KBD_REPLY_ACK,
>                   KBD_REPLY_POR);
>               break;
> +        case KBD_CMD_SET_TYPEMATIC:
> +        case KBD_CMD_SET_MAKE_BREAK:

Shouldn't we reset the write state machine too? I'm not sure.

                s->common.write_cmd =3D -1;

> +            ps2_queue(&s->common, KBD_REPLY_ACK);
> +            break;
>           default:
>               ps2_queue(&s->common, KBD_REPLY_RESEND);
>               break;
>=20


