Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED62C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D5D2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBJjyXKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D5D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9skA-0008DQ-GS
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ybendito@redhat.com>) id 1j9lPN-0002ln-3e
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ybendito@redhat.com>) id 1j9lPK-0007Nj-32
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:59:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ybendito@redhat.com>) id 1j9lPJ-0007NJ-Qs
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 02:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583395141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qb6FTWgQD+FOy1k2v5iiDJYeEaNjQcXT2cn1KEIDOOE=;
 b=KBJjyXKCmZGmVeVLexR/8A9gZG3liYnGNLrtRGnoAnuskJEcS1flzqPz7Aiaj6ECabSZfx
 23Pjrz9ahsGs23oEx0EFFwX4co13T/XyB5lPqbSYagyRccHrQGKwwOOkk0EK3LGRufzKlv
 KFIA9DK3qwb/eCqDuPTVMI0OaZC8p+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-_Fa4mPHsMvKiW-nKkyAYaQ-1; Thu, 05 Mar 2020 02:57:19 -0500
X-MC-Unique: _Fa4mPHsMvKiW-nKkyAYaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B18C13E5
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 07:57:18 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4217B39A
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 07:57:18 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com
 (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0848A18034E9;
 Thu,  5 Mar 2020 07:57:18 +0000 (UTC)
Date: Thu, 5 Mar 2020 02:57:17 -0500 (EST)
From: Yuri Benditovich <ybendito@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1472901155.11933269.1583395037984.JavaMail.zimbra@redhat.com>
In-Reply-To: <bb1f9cbb-7f98-e955-c55d-abc36e788902@redhat.com>
References: <20200213090627.2181-1-kraxel@redhat.com>
 <20200213090627.2181-2-kraxel@redhat.com>
 <bb1f9cbb-7f98-e955-c55d-abc36e788902@redhat.com>
Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5
MIME-Version: 1.0
X-Originating-IP: [10.35.206.16, 10.4.195.1]
Thread-Topic: introduce hardware revision 5
Thread-Index: 4G3/K+xE/zdJm21xdFY38sqkTKx/tA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; 
 boundary="----=_Part_11933268_1972522042.1583395037983"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_Part_11933268_1972522042.1583395037983
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Laszlo Ersek" <lersek@redhat.com>
> To: "Gerd Hoffmann" <kraxel@redhat.com>
> Cc: qemu-devel@nongnu.org, "Eduardo Habkost" <ehabkost@redhat.com>, "Yuri
> Benditovich" <ybendito@redhat.com>, "Yan Vugenfirer" <yvugenfi@redhat.com>
> Sent: Thursday, March 5, 2020 1:28:23 AM
> Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5

> Hi Gerd,

> On 02/13/20 10:06, Gerd Hoffmann wrote:
> > The only difference to hardware revision 4 is that the device doesn't
> > switch to VGA mode in case someone happens to touch a VGA register,
> > which should make things more robust in configurations with multiple
> > vga devices.
> >
> > Swtiching back to VGA mode happens on reset, either full machine
> > reset or qxl device reset (QXL_IO_RESET ioport command).
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Message-id: 20200206074358.4274-1-kraxel@redhat.com
> > ---
> > hw/display/qxl.h | 2 +-
> > hw/core/machine.c | 2 ++
> > hw/display/qxl.c | 7 ++++++-
> > 3 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> > index 80eb0d267269..707631a1f573 100644
> > --- a/hw/display/qxl.h
> > +++ b/hw/display/qxl.h
> > @@ -144,7 +144,7 @@ typedef struct PCIQXLDevice {
> > } \
> > } while (0)
> >
> > -#define QXL_DEFAULT_REVISION QXL_REVISION_STABLE_V12
> > +#define QXL_DEFAULT_REVISION (QXL_REVISION_STABLE_V12 + 1)
> >
> > /* qxl.c */
> > void *qxl_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL phys, int group_id);
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index d8e30e4895d8..84812a1d1cc1 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -34,6 +34,8 @@ GlobalProperty hw_compat_4_2[] = {
> > { "vhost-blk-device", "seg_max_adjust", "off"},
> > { "usb-host", "suppress-remote-wake", "off" },
> > { "usb-redir", "suppress-remote-wake", "off" },
> > + { "qxl", "revision", "4" },
> > + { "qxl-vga", "revision", "4" },
> > };
> > const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
> >
> > diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> > index c33b1915a52c..64884da70857 100644
> > --- a/hw/display/qxl.c
> > +++ b/hw/display/qxl.c
> > @@ -1309,7 +1309,8 @@ static void qxl_vga_ioport_write(void *opaque,
> > uint32_t addr, uint32_t val)
> > PCIQXLDevice *qxl = container_of(vga, PCIQXLDevice, vga);
> >
> > trace_qxl_io_write_vga(qxl->id, qxl_mode_to_string(qxl->mode), addr, val);
> > - if (qxl->mode != QXL_MODE_VGA) {
> > + if (qxl->mode != QXL_MODE_VGA &&
> > + qxl->revision <= QXL_REVISION_STABLE_V12) {
> > qxl_destroy_primary(qxl, QXL_SYNC);
> > qxl_soft_reset(qxl);
> > }
> > @@ -2121,6 +2122,10 @@ static void qxl_realize_common(PCIQXLDevice *qxl,
> > Error **errp)
> > pci_device_rev = QXL_REVISION_STABLE_V12;
> > io_size = pow2ceil(QXL_IO_RANGE_SIZE);
> > break;
> > + case 5: /* qxl-5 */
> > + pci_device_rev = QXL_REVISION_STABLE_V12 + 1;
> > + io_size = pow2ceil(QXL_IO_RANGE_SIZE);
> > + break;
> > default:
> > error_setg(errp, "Invalid revision %d for qxl device (max %d)",
> > qxl->revision, QXL_DEFAULT_REVISION);
> >

> this patch -- commit ed71c09ffd6f -- disables ACPI S3 in the Windows 10
> guest for me, using OVMF and QXL.

> The "Sleep" menu entry disappears from the power button icon/menu at the
> login screen, and "psshutdown -d -t 3" (from the pstools package) also
> stops working (it reports that the computer does not support S3).

> At the parent commit (e18e5501d8ac), S3 suspend/resume works.

> Here's the bisection log:

> > git bisect start
> > # good: [928173659d6e5dc368284f73f90ea1d129e1f57d] Merge remote-tracking
> > branch 'remotes/pmaydell/tags/pull-target-arm-20200130' into staging
> > git bisect good 928173659d6e5dc368284f73f90ea1d129e1f57d
> > # good: [93c86fff53a267f657e79ec07dcd04b63882e330] Merge remote-tracking
> > branch 'remotes/pmaydell/tags/pull-target-arm-20200207' into staging
> > git bisect good 93c86fff53a267f657e79ec07dcd04b63882e330
> > # bad: [db736e0437aa6fd7c1b7e4599c17f9619ab6b837] Merge remote-tracking
> > branch 'remotes/bonzini/tags/for-upstream' into staging
> > git bisect bad db736e0437aa6fd7c1b7e4599c17f9619ab6b837
> > # bad: [8ee06e4ccb0f447caf9dc884b98986c155915e5c] ppc/mac_oldworld: use
> > memdev for RAM
> > git bisect bad 8ee06e4ccb0f447caf9dc884b98986c155915e5c
> > # good: [dc7a88d0810ad272bdcd2e0869359af78fdd9114] target/arm: Implement
> > ARMv8.1-VMID16 extension
> > git bisect good dc7a88d0810ad272bdcd2e0869359af78fdd9114
> > # bad: [652c5bbd7e7d3cb3d27a2e0590118dc79fb6f4d8] Merge remote-tracking
> > branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging
> > git bisect bad 652c5bbd7e7d3cb3d27a2e0590118dc79fb6f4d8
> > # bad: [e050e426782ec4ae6bf84e5ec75ca502187f69cb] qapi: Use explicit
> > bulleted lists
> > git bisect bad e050e426782ec4ae6bf84e5ec75ca502187f69cb
> > # good: [5d6542bea780ad443c4f7f1496e64706101f525c] Merge remote-tracking
> > branch 'remotes/rth/tags/pull-tcg-20200212' into staging
> > git bisect good 5d6542bea780ad443c4f7f1496e64706101f525c
> > # bad: [72ec8bf362b24ebbd45452c298a3b14fb617eebb] qga/qapi-schema.json: Fix
> > missing '-' in GuestDiskBusType doc comment
> > git bisect bad 72ec8bf362b24ebbd45452c298a3b14fb617eebb
> > # bad: [2eb054c237d0b5427f62499f3c31e90cf87821d7] configure: Allow user to
> > specify sphinx-build binary
> > git bisect bad 2eb054c237d0b5427f62499f3c31e90cf87821d7
> > # bad: [517c84cef759a453cfb8f51498aebc909a5f3b39] Merge remote-tracking
> > branch 'remotes/kraxel/tags/vga-20200213-pull-request' into staging
> > git bisect bad 517c84cef759a453cfb8f51498aebc909a5f3b39
> > # bad: [ed71c09ffd6fbd01c2a487d47291ae57b08671ea] qxl: introduce hardware
> > revision 5
> > git bisect bad ed71c09ffd6fbd01c2a487d47291ae57b08671ea
> > # first bad commit: [ed71c09ffd6fbd01c2a487d47291ae57b08671ea] qxl:
> > introduce hardware revision 5

> OVMF is built at current edk2 master: e63d54db9526.

> In the Windows 10 guest, the installed driver has the following
> properties (per Device Manager):

> - driver date: 7/28/2015
> - driver version: 22.33.46.473
This is not what I would expect from any qxl driver for Win10 
What is the name of display adapter? 
The driver provider is 'Red Hat'? 
Does your guest run with secure boot? 
I do not see such an effect with 'Sleep' with latest qemu master + OVMF + qxl + Win10, the sleep button does not disappear. 

> I tried upgrading the QXL driver in the Windows 10 guest, using the
> latest package at
> <https://fedorapeople.org/groups/virt/virtio-win/repo/latest/?C=M;O=D>,
> namely "virtio-win-0.1.173-7.noarch.rpm". But Device Manager said that
> the currently installed driver was already the best / most recent for
> the device.For now I'll force the revision back to 4 using <qemu:arg>
> elements in
> my domain XML. (I'd like to use pc-q35-5.0.)

> <qemu:arg value='-global'/>
> <qemu:arg value='qxl-vga.revision=4'/>

> Thanks
> Laszlo

------=_Part_11933268_1972522042.1583395037983
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: courier new,courier,monaco,monospace=
,sans-serif; font-size: 12pt; color: #000000"><div><br></div><div><br></div=
><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><b>From: </b>"Laszlo Ersek" &lt;lersek@redhat.com&gt;<br><b>To: </b>"Gerd=
 Hoffmann" &lt;kraxel@redhat.com&gt;<br><b>Cc: </b>qemu-devel@nongnu.org, "=
Eduardo Habkost" &lt;ehabkost@redhat.com&gt;, "Yuri Benditovich" &lt;ybendi=
to@redhat.com&gt;, "Yan Vugenfirer" &lt;yvugenfi@redhat.com&gt;<br><b>Sent:=
 </b>Thursday, March 5, 2020 1:28:23 AM<br><b>Subject: </b>Re: [PULL 1/1] q=
xl: introduce hardware revision 5<br><div><br></div>Hi Gerd,<br><div><br></=
div>On 02/13/20 10:06, Gerd Hoffmann wrote:<br>&gt; The only difference to =
hardware revision 4 is that the device doesn't<br>&gt; switch to VGA mode i=
n case someone happens to touch a VGA register,<br>&gt; which should make t=
hings more robust in configurations with multiple<br>&gt; vga devices.<br>&=
gt;<br>&gt; Swtiching back to VGA mode happens on reset, either full machin=
e<br>&gt; reset or qxl device reset (QXL_IO_RESET ioport command).<br>&gt;<=
br>&gt; Signed-off-by: Gerd Hoffmann &lt;kraxel@redhat.com&gt;<br>&gt; Revi=
ewed-by: Maxim Levitsky &lt;mlevitsk@redhat.com&gt;<br>&gt; Message-id: 202=
00206074358.4274-1-kraxel@redhat.com<br>&gt; ---<br>&gt; &nbsp;hw/display/q=
xl.h &nbsp;| 2 +-<br>&gt; &nbsp;hw/core/machine.c | 2 ++<br>&gt; &nbsp;hw/d=
isplay/qxl.c &nbsp;| 7 ++++++-<br>&gt; &nbsp;3 files changed, 9 insertions(=
+), 2 deletions(-)<br>&gt;<br>&gt; diff --git a/hw/display/qxl.h b/hw/displ=
ay/qxl.h<br>&gt; index 80eb0d267269..707631a1f573 100644<br>&gt; --- a/hw/d=
isplay/qxl.h<br>&gt; +++ b/hw/display/qxl.h<br>&gt; @@ -144,7 +144,7 @@ typ=
edef struct PCIQXLDevice {<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \<br>&gt; &n=
bsp; &nbsp; &nbsp;} while (0)<br>&gt;<br>&gt; -#define QXL_DEFAULT_REVISION=
 QXL_REVISION_STABLE_V12<br>&gt; +#define QXL_DEFAULT_REVISION (QXL_REVISIO=
N_STABLE_V12 + 1)<br>&gt;<br>&gt; &nbsp;/* qxl.c */<br>&gt; &nbsp;void *qxl=
_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL phys, int group_id);<br>&gt; diff=
 --git a/hw/core/machine.c b/hw/core/machine.c<br>&gt; index d8e30e4895d8..=
84812a1d1cc1 100644<br>&gt; --- a/hw/core/machine.c<br>&gt; +++ b/hw/core/m=
achine.c<br>&gt; @@ -34,6 +34,8 @@ GlobalProperty hw_compat_4_2[] =3D {<br>=
&gt; &nbsp; &nbsp; &nbsp;{ "vhost-blk-device", "seg_max_adjust", "off"},<br=
>&gt; &nbsp; &nbsp; &nbsp;{ "usb-host", "suppress-remote-wake", "off" },<br=
>&gt; &nbsp; &nbsp; &nbsp;{ "usb-redir", "suppress-remote-wake", "off" },<b=
r>&gt; + &nbsp; &nbsp;{ "qxl", "revision", "4" },<br>&gt; + &nbsp; &nbsp;{ =
"qxl-vga", "revision", "4" },<br>&gt; &nbsp;};<br>&gt; &nbsp;const size_t h=
w_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);<br>&gt;<br>&gt; diff --gi=
t a/hw/display/qxl.c b/hw/display/qxl.c<br>&gt; index c33b1915a52c..64884da=
70857 100644<br>&gt; --- a/hw/display/qxl.c<br>&gt; +++ b/hw/display/qxl.c<=
br>&gt; @@ -1309,7 +1309,8 @@ static void qxl_vga_ioport_write(void *opaque=
, uint32_t addr, uint32_t val)<br>&gt; &nbsp; &nbsp; &nbsp;PCIQXLDevice *qx=
l =3D container_of(vga, PCIQXLDevice, vga);<br>&gt;<br>&gt; &nbsp; &nbsp; &=
nbsp;trace_qxl_io_write_vga(qxl-&gt;id, qxl_mode_to_string(qxl-&gt;mode), a=
ddr, val);<br>&gt; - &nbsp; &nbsp;if (qxl-&gt;mode !=3D QXL_MODE_VGA) {<br>=
&gt; + &nbsp; &nbsp;if (qxl-&gt;mode !=3D QXL_MODE_VGA &amp;&amp;<br>&gt; +=
 &nbsp; &nbsp; &nbsp; &nbsp;qxl-&gt;revision &lt;=3D QXL_REVISION_STABLE_V1=
2) {<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;qxl_destroy_primary(qxl, QXL=
_SYNC);<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;qxl_soft_reset(qxl);<br>&=
gt; &nbsp; &nbsp; &nbsp;}<br>&gt; @@ -2121,6 +2122,10 @@ static void qxl_re=
alize_common(PCIQXLDevice *qxl, Error **errp)<br>&gt; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;pci_device_rev =3D QXL_REVISION_STABLE_V12;<br>&gt; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;io_size =3D pow2ceil(QXL_IO_RANGE_SIZE);<br>&gt; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>&gt; + &nbsp; &nbsp;case 5: /* qx=
l-5 */<br>&gt; + &nbsp; &nbsp; &nbsp; &nbsp;pci_device_rev =3D QXL_REVISION=
_STABLE_V12 + 1;<br>&gt; + &nbsp; &nbsp; &nbsp; &nbsp;io_size =3D pow2ceil(=
QXL_IO_RANGE_SIZE);<br>&gt; + &nbsp; &nbsp; &nbsp; &nbsp;break;<br>&gt; &nb=
sp; &nbsp; &nbsp;default:<br>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;error_s=
etg(errp, "Invalid revision %d for qxl device (max %d)",<br>&gt; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; qxl-&gt;revisio=
n, QXL_DEFAULT_REVISION);<br>&gt;<br><div><br></div>this patch -- commit ed=
71c09ffd6f -- disables ACPI S3 in the Windows 10<br>guest for me, using OVM=
F and QXL.<br><div><br></div>The "Sleep" menu entry disappears from the pow=
er button icon/menu at the<br>login screen, and "psshutdown -d -t 3" (from =
the pstools package) also<br>stops working (it reports that the computer do=
es not support S3).<br><div><br></div>At the parent commit (e18e5501d8ac), =
S3 suspend/resume works.<br><div><br></div>Here's the bisection log:<br><di=
v><br></div>&gt; git bisect start<br>&gt; # good: [928173659d6e5dc368284f73=
f90ea1d129e1f57d] Merge remote-tracking branch 'remotes/pmaydell/tags/pull-=
target-arm-20200130' into staging<br>&gt; git bisect good 928173659d6e5dc36=
8284f73f90ea1d129e1f57d<br>&gt; # good: [93c86fff53a267f657e79ec07dcd04b638=
82e330] Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm=
-20200207' into staging<br>&gt; git bisect good 93c86fff53a267f657e79ec07dc=
d04b63882e330<br>&gt; # bad: [db736e0437aa6fd7c1b7e4599c17f9619ab6b837] Mer=
ge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging<=
br>&gt; git bisect bad db736e0437aa6fd7c1b7e4599c17f9619ab6b837<br>&gt; # b=
ad: [8ee06e4ccb0f447caf9dc884b98986c155915e5c] ppc/mac_oldworld: use memdev=
 for RAM<br>&gt; git bisect bad 8ee06e4ccb0f447caf9dc884b98986c155915e5c<br=
>&gt; # good: [dc7a88d0810ad272bdcd2e0869359af78fdd9114] target/arm: Implem=
ent ARMv8.1-VMID16 extension<br>&gt; git bisect good dc7a88d0810ad272bdcd2e=
0869359af78fdd9114<br>&gt; # bad: [652c5bbd7e7d3cb3d27a2e0590118dc79fb6f4d8=
] Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pul=
l-request' into staging<br>&gt; git bisect bad 652c5bbd7e7d3cb3d27a2e059011=
8dc79fb6f4d8<br>&gt; # bad: [e050e426782ec4ae6bf84e5ec75ca502187f69cb] qapi=
: Use explicit bulleted lists<br>&gt; git bisect bad e050e426782ec4ae6bf84e=
5ec75ca502187f69cb<br>&gt; # good: [5d6542bea780ad443c4f7f1496e64706101f525=
c] Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200212' into s=
taging<br>&gt; git bisect good 5d6542bea780ad443c4f7f1496e64706101f525c<br>=
&gt; # bad: [72ec8bf362b24ebbd45452c298a3b14fb617eebb] qga/qapi-schema.json=
: Fix missing '-' in GuestDiskBusType doc comment<br>&gt; git bisect bad 72=
ec8bf362b24ebbd45452c298a3b14fb617eebb<br>&gt; # bad: [2eb054c237d0b5427f62=
499f3c31e90cf87821d7] configure: Allow user to specify sphinx-build binary<=
br>&gt; git bisect bad 2eb054c237d0b5427f62499f3c31e90cf87821d7<br>&gt; # b=
ad: [517c84cef759a453cfb8f51498aebc909a5f3b39] Merge remote-tracking branch=
 'remotes/kraxel/tags/vga-20200213-pull-request' into staging<br>&gt; git b=
isect bad 517c84cef759a453cfb8f51498aebc909a5f3b39<br>&gt; # bad: [ed71c09f=
fd6fbd01c2a487d47291ae57b08671ea] qxl: introduce hardware revision 5<br>&gt=
; git bisect bad ed71c09ffd6fbd01c2a487d47291ae57b08671ea<br>&gt; # first b=
ad commit: [ed71c09ffd6fbd01c2a487d47291ae57b08671ea] qxl: introduce hardwa=
re revision 5<br><div><br></div>OVMF is built at current edk2 master: e63d5=
4db9526.<br><div><br></div>In the Windows 10 guest, the installed driver ha=
s the following<br>properties (per Device Manager):<br><div><br></div>- dri=
ver date: 7/28/2015<br>- driver version: 22.33.46.473</blockquote><div>This=
 is not what I would expect from any qxl driver for Win10<br></div><div>Wha=
t is the name of display adapter?<br></div><div>The driver provider is 'Red=
 Hat'? <br></div><div>Does your guest run with secure boot?<br></div><div>I=
 do not see such an effect with 'Sleep' with latest qemu master + OVMF + qx=
l + Win10, the sleep button does not disappear.<br></div><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><br><div><br></div>I tried upgrad=
ing the QXL driver in the Windows 10 guest, using the<br>latest package at<=
br>&lt;https://fedorapeople.org/groups/virt/virtio-win/repo/latest/?C=3DM;O=
=3DD&gt;,<br>namely "virtio-win-0.1.173-7.noarch.rpm". But Device Manager s=
aid that<br>the currently installed driver was already the best / most rece=
nt for<br>the device.For now I'll force the revision back to 4 using &lt;qe=
mu:arg&gt; elements in<br>my domain XML. (I'd like to use pc-q35-5.0.)<br><=
div><br></div>&nbsp;&nbsp; &nbsp;&lt;qemu:arg value=3D'-global'/&gt;<br>&nb=
sp;&nbsp; &nbsp;&lt;qemu:arg value=3D'qxl-vga.revision=3D4'/&gt;<br><div><b=
r></div>Thanks<br>Laszlo<br></blockquote><div><br></div></div></body></html=
>
------=_Part_11933268_1972522042.1583395037983--


