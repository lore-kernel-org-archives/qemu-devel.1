Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C597C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5180E2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkqLhebR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5180E2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihDmJ-00026z-AA
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 09:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1ihDlg-0001c9-Er
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ihDld-0005PS-MW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:24:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25193
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ihDld-0005P0-An
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576592644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/XSnZ4YTd8wRl766wOWjHrrfaazJ6pZM5Uzzcop4YY=;
 b=EkqLhebRtTcreI4/ZcvEOPpom6RzXgJVGAnq/zhE0wOg/TiHAkWsDEg56BScnpYNhOz31i
 0pbl2FcKt5P6NEWePKiYn1RmgwN87wUMQ7ImgY85+XMHM9RO0n+i4cgh3HeN7NiW3XGlUK
 p0Uc0+7GLOs6NIqG96wEys+TcLGicEs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-ChyMcF62OhKJrcyvO1SB6w-1; Tue, 17 Dec 2019 09:24:01 -0500
Received: by mail-wm1-f72.google.com with SMTP id s25so616782wmj.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=naNXCfYeC76ZUsZ7zY584EysNoKQhLTleOShhxYR+1I=;
 b=lQjdxha5zTdR+YxdQBi1S2zfwNFDfkhMIEtF8u2Q9USbtBLCXf+kAC8vI8h8kiuv1i
 slR7FlINAgMQbDY7AwmqagvkTbRk5bzEls9gO6++kZ0pmplgefeFvpRVdkZENX0uXBs2
 EWiPLUrV23UfWNZuTEye+FdfjvHwA0lUk8AWZw0J2HyhhTPUIJJiHsk731rvSBz2JBsb
 /yoTlnfXET+6pZFJFzroKOJXqhhkhQ2MamkIWzThBFPyOR+7syTdPOm0HTC+IDGWMnkq
 ljrtZuTY/WewH0RO//MhiTxiCr7dkCXgpvX3tnWMysrhDycmJkDM8cCCvDBv2KPMNShk
 0HWQ==
X-Gm-Message-State: APjAAAWZ54AkafX40Aek96oNES6RRE3RlTmFk7iWxHAbve+F/uE24b5K
 uWMYjeWALd+qEh45f29xQlB2enAdMopJ4HiI+aLOAHxL1ec+T/cmzj97eMDfhq5Onx39Qsi0ViM
 N4LCqR/kLaxMQTTY=
X-Received: by 2002:a7b:c759:: with SMTP id w25mr6035532wmk.15.1576592639613; 
 Tue, 17 Dec 2019 06:23:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqweZJKaHSRVb+9ovWWOOM+jp2ibkE0PNwxBM6gxQYYIyqKwUiJ6OJ3BFjmTfNkYHjIKoNR3tg==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr6035507wmk.15.1576592639281; 
 Tue, 17 Dec 2019 06:23:59 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:1c42:ed63:2256:4add?
 ([2a01:e0a:466:71c0:1c42:ed63:2256:4add])
 by smtp.gmail.com with ESMTPSA id w8sm3228172wmm.0.2019.12.17.06.23.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2019 06:23:58 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Vote against removing the bluetooth subsystem from Quemu.
From: Christophe de Dinechin <dinechin@redhat.com>
X-Priority: 3 (Normal)
In-Reply-To: <0102016f14331e64-fc1b813a-187a-4ece-9c9e-8f78ea832fe9-000000@eu-west-1.amazonses.com>
Date: Tue, 17 Dec 2019 15:23:57 +0100
Message-Id: <DBA8AFBC-D515-4987-967E-C0FB541868D1@redhat.com>
References: <mail.3cd9c49a-989a-40c1-b627-b2197ff912ce@storage.wm.amazon.com>
 <mail.3cd9c49a-989a-40c1-b627-b2197ff912ce@storage.wm.amazon.com>
 <0102016f14331e64-fc1b813a-187a-4ece-9c9e-8f78ea832fe9-000000@eu-west-1.amazonses.com>
To: Andreas Scheucher <andreas.scheucher@otaya.cc>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: ChyMcF62OhKJrcyvO1SB6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 17 Dec 2019, at 15:11, Andreas Scheucher <andreas.scheucher@otaya.cc> =
wrote:
>=20
> Hello,
> =20
> I found following note in the Qemu documentation: This option and the who=
le bluetooth subsystem is considered as deprecated. If you still use it, pl=
ease send a mail to qemu-devel@nongnu.org where you describe your usecase.
> =20
> Here I am :)
> =20
> As GPU passthrough is becoming more and more common (to run Linux / Windo=
ws / Mac OS X simultaneously on the same host to prevent multiboot) on desk=
top systems, support for the use of the host Bluetooth device in Quemu VMs =
for sure will be a common use case: https://www.reddit.com/r/VFIO/
> =20
> For me personally I just want to set up a setup supporting Windows & Linu=
x to use the first strong nVidia GPU for occasional gaming on Windows and v=
ideo editing with DaVinci Resolve under CentOs.
> On the second AMD GPU I plan to install a Mac OS X VM, which for sure nee=
ds some Bluetooth support for a Magic Mouse 2 and maybe a Bluetooth Keyboar=
d.

For what it=E2=80=99s worth, I had mixed results getting standard GPUs to b=
e recognized by macOS as pass-through. The list of GPUs that macOS drivers =
acknowledge is smaller. At least that=E2=80=99s the case for NVIDIA cards.

Regarding the Bluetooth use case, why would you need the Magic Mouse to be =
exposed directly to the guest? Is that to get the extra features of the mou=
se, like gestures? Or as a way to have one keyboard dedicated to the VM? I=
=E2=80=99m asking because I=E2=80=99m using a Magic Trackpad connected to a=
 Mac Laptop and often interact with macOS VMs running on a distant machine =
over Screen Sharing, and I=E2=80=99ve not noticed any sensible loss in func=
tionality in doing so. Manu gestures just work. Of course, it=E2=80=99s pos=
sible that Apple Screen Sharing is doing something smart there, and that yo=
u would not get that benefit if your client is not itself running macOS. My=
 experience with VNC clients connecting to macOS VMs was nowhere as smooth.

> =20
> For sure Mac OS X in a VM is not the most common use case, but should wor=
k fine following some reports. And considering the prices for Apple hardwar=
e, a GPU solution with moderate expensive hardware seems to be a reasonable=
 solution for many use cases.
> =20
> Thanks for considering my use case and vote.
> =20
> Best regards,
> Andreas=20


