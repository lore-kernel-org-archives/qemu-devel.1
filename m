Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD3C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DAA2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 07:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+6gXLrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DAA2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isLjd-0002EW-3U
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 02:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isLim-0001oI-Jc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isLij-0001J9-OM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:07:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47227
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isLij-0001Hc-Kd
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 02:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579244824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4iYzFw7t9cA3DSXB2XGkOFcp2KLbEZ8/q1vcBN/FjQM=;
 b=O+6gXLrd3Cvnt7ftK8Bm3tSYIF6tpt18orOe+2LRSFZHb6jomKWZ4NIsg5XLKCQYUIVRbl
 xs4auwtR7zCW+vuMgX0cDXkd5+2J4NS4YSQnQbaYBQy88+jRjtbdb9YJydELQDo1henTe1
 m7sYsjB+mWMnIfSj5l0MF58YJYQnGFg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-dDTmoR7uPPOkn96kUqPCJg-1; Fri, 17 Jan 2020 02:07:02 -0500
Received: by mail-wr1-f71.google.com with SMTP id i9so10183320wru.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 23:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AGIRKq7k5rEa8CPRLQ882k3C/r5o+CdhJ8fTP16L/GI=;
 b=JT73BVtNphaApiGuzCWPmXRUXHJ9VgVVwSraOjFavT0/r3F/98Ez23narG+pYRJFnJ
 FRSXubzn/8Lb02a3sKeWF/6PoKifqUOohXV8vwL7XGM0EPfrRURdPA+TlJWiDoZFp18+
 EujrgG9kHyG00fdLye2ILLKdx5xtFO+9NmX84lPCwl11SeqF9ZH+5zis4JkHngXbxsV3
 dKzI1v7azSfzhDwKd5/TwSFo9tH+k1bdFY7z8vuXrLVpeVKfyB7+DiZJmsvqMRaDF40u
 WsrNSHhCJCHBFiFNXPbAv7EjDo7JUZvN5PA7a8Vp+NWZWsHPXksKTMXIpCee3B0vwj5u
 mbWg==
X-Gm-Message-State: APjAAAXrlD/IiMy+foOLC8b6hX0EbjUGVyie09jE6XnwwMjoAGN816iT
 82DCBtkjBFfSo91WbqxIdNUc7RxR84kkeZXqBPFkP+69SMBOfBQY38//VOXahuBfNEU4rKyDcp1
 Iea4UVejYMoNIB8k=
X-Received: by 2002:adf:ee45:: with SMTP id w5mr1463496wro.352.1579244821761; 
 Thu, 16 Jan 2020 23:07:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxx4b0DPkwMHOS2zx8kRNBBX65eB2GsxLT3CGKCU60PSfU/ypI7uLep5ibWizJi9qIuiETyjw==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr1463475wro.352.1579244821482; 
 Thu, 16 Jan 2020 23:07:01 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 4sm7731929wmg.22.2020.01.16.23.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 23:07:00 -0800 (PST)
Subject: Re: [PATCH] uas: fix super speed bMaxPacketSize0
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200117062710.25102-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8d6a5f0f-1367-a870-6f51-23291ac3cdb8@redhat.com>
Date: Fri, 17 Jan 2020 08:06:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117062710.25102-1-kraxel@redhat.com>
Content-Language: en-US
X-MC-Unique: dDTmoR7uPPOkn96kUqPCJg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Ben Lunt <fys@fysnet.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 7:27 AM, Gerd Hoffmann wrote:
> For usb2 bMaxPacketSize0 is "n", for usb3 it is "1 << n",
> so it must be 9 not 64 ...

Maybe add in description:

 From "Universal Serial Bus 3.1 Specification":

   If the device is operating at Gen X speed, the bMaxPacketSize0
   field shall be set to 09H indicating a 512-byte maximum packet.
   An Enhanced SuperSpeed device shall not support any other maximum
   packet sizes for the default control pipe (endpoint 0) control
   endpoint.

We now announce a 512-byte maximum packet.

Fixes: 89a453d4a5c

> Reported-by: fys@fysnet.net

https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_S=
igned-off-by:_line

"Please use your real name to sign a patch (not an alias or acronym)."

OK this is not about the author name but reporter name.

Gerd, I think you we use 'Reported-by: Benjamin David Lunt=20
<fys@fysnet.net>' instead, which was previously used in commit=20
9da82227caa7 (except if Ben refuses obviously).

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/usb/dev-uas.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
> index 6d6d1073b907..1bc4dd4fafb8 100644
> --- a/hw/usb/dev-uas.c
> +++ b/hw/usb/dev-uas.c
> @@ -303,7 +303,7 @@ static const USBDescDevice desc_device_high =3D {
>  =20
>   static const USBDescDevice desc_device_super =3D {
>       .bcdUSB                        =3D 0x0300,
> -    .bMaxPacketSize0               =3D 64,
> +    .bMaxPacketSize0               =3D 9,
>       .bNumConfigurations            =3D 1,
>       .confs =3D (USBDescConfig[]) {
>           {
>=20


