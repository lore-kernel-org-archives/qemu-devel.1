Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A47C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5162072A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ss2zOZhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5162072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9vtC-0002iK-TU
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ybendito@redhat.com>) id 1j9vsO-00029K-HN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ybendito@redhat.com>) id 1j9vsM-0004oA-0B
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:09:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40056
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ybendito@redhat.com>) id 1j9vsK-0004lu-MP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583435379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrDSOPKXDKc4kD+vMMy1a3fDbsEbXsCuutYL0JhTYgA=;
 b=Ss2zOZhRzqy7+YjmnuyM7iXyWtaAR9gJ0ikieyL/0JdVQzO3UdCxxGKogVHGGQ0R4WAHmV
 lpIlhCwouO9c//GsDri6SA/LfJJruxHrODRCv9SQcXskyv34dE5xPwM7rd8XBueXluY5GR
 ais4mEYAIs5QyjiSYRtXPKdO4kKKV9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-S1uLPEI7PLSvldVtucpGXw-1; Thu, 05 Mar 2020 14:09:35 -0500
X-MC-Unique: S1uLPEI7PLSvldVtucpGXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B610DB23
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 19:09:34 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F036101D491
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 19:09:34 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com
 (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id F07611803C32;
 Thu,  5 Mar 2020 19:09:33 +0000 (UTC)
Date: Thu, 5 Mar 2020 14:09:33 -0500 (EST)
From: Yuri Benditovich <ybendito@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1043730203.12069417.1583435373924.JavaMail.zimbra@redhat.com>
In-Reply-To: <e69ea9ab-9fc1-ca12-c7ab-50e094c1c782@redhat.com>
References: <20200213090627.2181-1-kraxel@redhat.com>
 <20200213090627.2181-2-kraxel@redhat.com>
 <bb1f9cbb-7f98-e955-c55d-abc36e788902@redhat.com>
 <1472901155.11933269.1583395037984.JavaMail.zimbra@redhat.com>
 <e69ea9ab-9fc1-ca12-c7ab-50e094c1c782@redhat.com>
Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5
MIME-Version: 1.0
X-Originating-IP: [10.35.206.16, 10.4.195.25]
Thread-Topic: introduce hardware revision 5
Thread-Index: INi8ytQc/pJaZn8jN+5pZMzQhvIQ5A==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; 
 boundary="----=_Part_12069416_487772286.1583435373924"
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
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_Part_12069416_487772286.1583435373924
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Laszlo Ersek" <lersek@redhat.com>
> To: "Yuri Benditovich" <ybendito@redhat.com>
> Cc: "Gerd Hoffmann" <kraxel@redhat.com>, qemu-devel@nongnu.org, "Eduardo
> Habkost" <ehabkost@redhat.com>, "Yan Vugenfirer" <yvugenfi@redhat.com>
> Sent: Thursday, March 5, 2020 5:01:24 PM
> Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5

> On 03/05/20 08:57, Yuri Benditovich wrote:
> > ----- Original Message -----
> >
> >> From: "Laszlo Ersek" <lersek@redhat.com>
> >> To: "Gerd Hoffmann" <kraxel@redhat.com>
> >> Cc: qemu-devel@nongnu.org, "Eduardo Habkost" <ehabkost@redhat.com>,
> >> "Yuri Benditovich" <ybendito@redhat.com>, "Yan Vugenfirer"
> >> <yvugenfi@redhat.com>
> >> Sent: Thursday, March 5, 2020 1:28:23 AM
> >> Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5
> >
> >> this patch -- commit ed71c09ffd6f -- disables ACPI S3 in the Windows
> >> 10 guest for me, using OVMF and QXL.
> >
> >> The "Sleep" menu entry disappears from the power button icon/menu at
> >> the login screen, and "psshutdown -d -t 3" (from the pstools package)
> >> also stops working (it reports that the computer does not support
> >> S3).
> >
> >> At the parent commit (e18e5501d8ac), S3 suspend/resume works.
> >

> [...]

> >> OVMF is built at current edk2 master: e63d54db9526.
> >
> >> In the Windows 10 guest, the installed driver has the following
> >> properties (per Device Manager):
> >
> >> - driver date: 7/28/2015
> >> - driver version: 22.33.46.473

> > This is not what I would expect from any qxl driver for Win10
> > What is the name of display adapter?

> "Red Hat QXL controller"

> > The driver provider is 'Red Hat'?

> In the "Red Hat QXL controller Properties" dialog:

> - on the General tab, Manufacturer is "Red Hat, Inc."

> - on the Driver tab, both the "Driver Provider" and the "Digital Signer"
> fields are "Red Hat, Inc."

> This driver comes from "qxlwddm-0.1-12" (buildID=449635), in Brew.

> In retrospect it looks like this driver was meant for Windows 8 only,
> but it happened to install under, and work OK for, Windows 10 too.

> > Does your guest run with secure boot?

> Yes, it does. (Double-checked it with "confirm-SecureBootUEFI" in
> PowerShell.)

> > I do not see such an effect with 'Sleep' with latest qemu master +
> > OVMF + qxl + Win10, the sleep button does not disappear.

> I'm happy to try other driver versions. Hopefully Windows 10 will
> actually see them as upgrading the currently installed driver. (Or
> should I uninstall first?)
This is the latest release 
https://www.spice-space.org/download/windows/qxl-wddm-dod/qxl-wddm-dod-0.19/ 

> Thanks!
> Laszlo

------=_Part_12069416_487772286.1583435373924
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: courier new,courier,monaco,monospace=
,sans-serif; font-size: 12pt; color: #000000"><div><br></div><div><br></div=
><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
" data-mce-style=3D"border-left: 2px solid #1010FF; margin-left: 5px; paddi=
ng-left: 5px; color: #000; font-weight: normal; font-style: normal; text-de=
coration: none; font-family: Helvetica,Arial,sans-serif; font-size: 12pt;">=
<b>From: </b>"Laszlo Ersek" &lt;lersek@redhat.com&gt;<br><b>To: </b>"Yuri B=
enditovich" &lt;ybendito@redhat.com&gt;<br><b>Cc: </b>"Gerd Hoffmann" &lt;k=
raxel@redhat.com&gt;, qemu-devel@nongnu.org, "Eduardo Habkost" &lt;ehabkost=
@redhat.com&gt;, "Yan Vugenfirer" &lt;yvugenfi@redhat.com&gt;<br><b>Sent: <=
/b>Thursday, March 5, 2020 5:01:24 PM<br><b>Subject: </b>Re: [PULL 1/1] qxl=
: introduce hardware revision 5<br><div><br></div>On 03/05/20 08:57, Yuri B=
enditovich wrote:<br>&gt; ----- Original Message -----<br>&gt;<br>&gt;&gt; =
From: "Laszlo Ersek" &lt;lersek@redhat.com&gt;<br>&gt;&gt; To: "Gerd Hoffma=
nn" &lt;kraxel@redhat.com&gt;<br>&gt;&gt; Cc: qemu-devel@nongnu.org, "Eduar=
do Habkost" &lt;ehabkost@redhat.com&gt;,<br>&gt;&gt; "Yuri Benditovich" &lt=
;ybendito@redhat.com&gt;, "Yan Vugenfirer"<br>&gt;&gt; &lt;yvugenfi@redhat.=
com&gt;<br>&gt;&gt; Sent: Thursday, March 5, 2020 1:28:23 AM<br>&gt;&gt; Su=
bject: Re: [PULL 1/1] qxl: introduce hardware revision 5<br>&gt;<br>&gt;&gt=
; this patch -- commit ed71c09ffd6f -- disables ACPI S3 in the Windows<br>&=
gt;&gt; 10 guest for me, using OVMF and QXL.<br>&gt;<br>&gt;&gt; The "Sleep=
" menu entry disappears from the power button icon/menu at<br>&gt;&gt; the =
login screen, and "psshutdown -d -t 3" (from the pstools package)<br>&gt;&g=
t; also stops working (it reports that the computer does not support<br>&gt=
;&gt; S3).<br>&gt;<br>&gt;&gt; At the parent commit (e18e5501d8ac), S3 susp=
end/resume works.<br>&gt;<br><div><br></div>[...]<br><div><br></div>&gt;&gt=
; OVMF is built at current edk2 master: e63d54db9526.<br>&gt;<br>&gt;&gt; I=
n the Windows 10 guest, the installed driver has the following<br>&gt;&gt; =
properties (per Device Manager):<br>&gt;<br>&gt;&gt; - driver date: 7/28/20=
15<br>&gt;&gt; - driver version: 22.33.46.473<br><div><br></div>&gt; This i=
s not what I would expect from any qxl driver for Win10<br>&gt; What is the=
 name of display adapter?<br><div><br></div>"Red Hat QXL controller"<br><di=
v><br></div>&gt; The driver provider is 'Red Hat'?<br><div><br></div>In the=
 "Red Hat QXL controller Properties" dialog:<br><div><br></div>- on the Gen=
eral tab, Manufacturer is "Red Hat, Inc."<br><div><br></div>- on the Driver=
 tab, both the "Driver Provider" and the "Digital Signer"<br>&nbsp;&nbsp;fi=
elds are "Red Hat, Inc."<br><div><br></div>This driver comes from "qxlwddm-=
0.1-12" (buildID=3D449635), in Brew.<br><div><br></div>In retrospect it loo=
ks like this driver was meant for Windows 8 only,<br>but it happened to ins=
tall under, and work OK for, Windows 10 too.<br><div><br></div>&gt; Does yo=
ur guest run with secure boot?<br><div><br></div>Yes, it does. (Double-chec=
ked it with "confirm-SecureBootUEFI" in<br>PowerShell.)<br><div><br></div>&=
gt; I do not see such an effect with 'Sleep' with latest qemu master +<br>&=
gt; OVMF + qxl + Win10, the sleep button does not disappear.<br><div><br></=
div>I'm happy to try other driver versions. Hopefully Windows 10 will<br>ac=
tually see them as upgrading the currently installed driver. (Or<br>should =
I uninstall first?)</blockquote><div>This is the latest release<br></div><d=
iv>https://www.spice-space.org/download/windows/qxl-wddm-dod/qxl-wddm-dod-0=
.19/</div><div><br></div><blockquote style=3D"border-left:2px solid #1010FF=
;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt;" data-mce-style=3D"border-left: 2px solid #1010FF; margin-left: 5px=
; padding-left: 5px; color: #000; font-weight: normal; font-style: normal; =
text-decoration: none; font-family: Helvetica,Arial,sans-serif; font-size: =
12pt;"><br><div><br></div>Thanks!<br>Laszlo<br></blockquote><div><br></div>=
</div></body></html>
------=_Part_12069416_487772286.1583435373924--


