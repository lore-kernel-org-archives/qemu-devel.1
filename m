Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631B62073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul1YhgIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631B62073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9slT-0002G7-EW
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ybendito@redhat.com>) id 1j9mcS-0006i6-Ev
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ybendito@redhat.com>) id 1j9mcQ-0005vv-Ni
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:16:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ybendito@redhat.com>) id 1j9mcQ-0005va-Fh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583399797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=waNN1k+caFLJ1goptcYR3N9iOonwTVIJ0Q6vJkjqu/s=;
 b=Ul1YhgIcKXvFWzCBItgGFESh9WOvhqakbRPcLP9LVTVZG3ZdW9pPPaG+oupuWPbjTkryqz
 B0gnk+9shst6vh/yBAu3aHaZncv3TbmU2/44zG8jUYkW8TL8KIMNg1R9RFSHKMJfcXgRUF
 XB4aywYNxta9fJUIrStnCZXyKRQhIOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-nCrMc8amP-SB-IH45AHX7Q-1; Thu, 05 Mar 2020 04:16:35 -0500
X-MC-Unique: nCrMc8amP-SB-IH45AHX7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39F14800D55
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 09:16:34 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31C9073884
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 09:16:34 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com
 (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id E7DD318034E9;
 Thu,  5 Mar 2020 09:16:33 +0000 (UTC)
Date: Thu, 5 Mar 2020 04:16:33 -0500 (EST)
From: Yuri Benditovich <ybendito@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <665005970.11944591.1583399793900.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200305080836.cggs6z3s5g5thuzw@sirius.home.kraxel.org>
References: <20200213090627.2181-1-kraxel@redhat.com>
 <20200213090627.2181-2-kraxel@redhat.com>
 <bb1f9cbb-7f98-e955-c55d-abc36e788902@redhat.com>
 <20200305080836.cggs6z3s5g5thuzw@sirius.home.kraxel.org>
Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5
MIME-Version: 1.0
X-Originating-IP: [10.35.206.16, 10.4.195.12]
Thread-Topic: introduce hardware revision 5
Thread-Index: MmT4tIY1G4haZrM6OAJ/T4tJBN2tjQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; 
 boundary="----=_Part_11944590_768467404.1583399793899"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-Mailman-Approved-At: Thu, 05 Mar 2020 10:48:03 -0500
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
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_Part_11944590_768467404.1583399793899
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Gerd Hoffmann" <kraxel@redhat.com>
> To: "Laszlo Ersek" <lersek@redhat.com>
> Cc: qemu-devel@nongnu.org, "Eduardo Habkost" <ehabkost@redhat.com>, "Yuri
> Benditovich" <ybendito@redhat.com>, "Yan Vugenfirer" <yvugenfi@redhat.com>
> Sent: Thursday, March 5, 2020 10:08:36 AM
> Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5

> Hi,

> > > + case 5: /* qxl-5 */
> > > + pci_device_rev = QXL_REVISION_STABLE_V12 + 1;
> > > + io_size = pow2ceil(QXL_IO_RANGE_SIZE);
> > > + break;

> > this patch -- commit ed71c09ffd6f -- disables ACPI S3 in the Windows 10
> > guest for me, using OVMF and QXL.
> >
> > The "Sleep" menu entry disappears from the power button icon/menu at the
> > login screen, and "psshutdown -d -t 3" (from the pstools package) also
> > stops working (it reports that the computer does not support S3).

> Any chance the qxl windows guest driver checks "revision == 4"
> instead of "revision >= 4"?
Not with qxl-wddm-dod drivers I'm releasing. 
But driver attributes that Laszlo provided are not related to any driver I'm aware of. 

> cheers,
> Gerd

------=_Part_11944590_768467404.1583399793899
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: courier new,courier,monaco,monospace=
,sans-serif; font-size: 12pt; color: #000000"><div><br></div><div><br></div=
><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><b>From: </b>"Gerd Hoffmann" &lt;kraxel@redhat.com&gt;<br><b>To: </b>"Las=
zlo Ersek" &lt;lersek@redhat.com&gt;<br><b>Cc: </b>qemu-devel@nongnu.org, "=
Eduardo Habkost" &lt;ehabkost@redhat.com&gt;, "Yuri Benditovich" &lt;ybendi=
to@redhat.com&gt;, "Yan Vugenfirer" &lt;yvugenfi@redhat.com&gt;<br><b>Sent:=
 </b>Thursday, March 5, 2020 10:08:36 AM<br><b>Subject: </b>Re: [PULL 1/1] =
qxl: introduce hardware revision 5<br><div><br></div>&nbsp;&nbsp;Hi,<br><di=
v><br></div>&gt; &gt; + &nbsp; &nbsp;case 5: /* qxl-5 */<br>&gt; &gt; + &nb=
sp; &nbsp; &nbsp; &nbsp;pci_device_rev =3D QXL_REVISION_STABLE_V12 + 1;<br>=
&gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp;io_size =3D pow2ceil(QXL_IO_RANGE_SI=
ZE);<br>&gt; &gt; + &nbsp; &nbsp; &nbsp; &nbsp;break;<br><div><br></div>&gt=
; this patch -- commit ed71c09ffd6f -- disables ACPI S3 in the Windows 10<b=
r>&gt; guest for me, using OVMF and QXL.<br>&gt; <br>&gt; The "Sleep" menu =
entry disappears from the power button icon/menu at the<br>&gt; login scree=
n, and "psshutdown -d -t 3" (from the pstools package) also<br>&gt; stops w=
orking (it reports that the computer does not support S3).<br><div><br></di=
v>Any chance the qxl windows guest driver checks "revision =3D=3D 4"<br>ins=
tead of "revision &gt;=3D 4"?</blockquote><div>Not with qxl-wddm-dod driver=
s I'm releasing.<br></div><div>But driver attributes that Laszlo provided a=
re not related to any driver I'm aware of.<br></div><blockquote style=3D"bo=
rder-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fon=
t-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetic=
a,Arial,sans-serif;font-size:12pt;"><br><div><br></div>cheers,<br>&nbsp;&nb=
sp;Gerd<br><div><br></div></blockquote><div><br></div></div></body></html>
------=_Part_11944590_768467404.1583399793899--


