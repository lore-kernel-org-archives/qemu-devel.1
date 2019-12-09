Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8C1C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0441420726
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkERccJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0441420726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieJ9B-0007cz-5n
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ieJ80-0006bK-LX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ieJ7z-00067J-JS
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:31:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35933
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ieJ7z-00066W-FS
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575898266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2mP/JwN5RGaAgTaL9ZFt7JzyWQYvwmGj6MDVEQbbFk=;
 b=hkERccJ6jTO2gAqnu0tduUVLFBNxbpVTlI2iP6tHznUmu2js2L2ectPjTacJV1rk3xyEqi
 XRI5dGsHdJCYOwE3ds6drBSwkTtuKTqEZqSeil0wnLxtA9egzsb1zMQRzSpPmFbhG6lH9Y
 rA/Tp7Rhy1HVuVP7hB/Y1XZpUEKflvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-IpWuuR6GMFegtdT1YoPgYg-1; Mon, 09 Dec 2019 08:31:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B63ADB25
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 13:31:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4430608FB;
 Mon,  9 Dec 2019 13:30:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EC70F16E08; Mon,  9 Dec 2019 14:30:54 +0100 (CET)
Date: Mon, 9 Dec 2019 14:30:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 4/4] hw/display: Remove "rombar" hack from vga-pci and
 vmware_vga
Message-ID: <20191209133054.zxrwzjutefxxf7ar@sirius.home.kraxel.org>
References: <20191209125248.5849-1-thuth@redhat.com>
 <20191209125248.5849-5-thuth@redhat.com>
 <3ab730ea-658f-ff98-035d-f94ed7775f00@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3ab730ea-658f-ff98-035d-f94ed7775f00@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: IpWuuR6GMFegtdT1YoPgYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 09, 2019 at 02:12:35PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 12/9/19 1:52 PM, Thomas Huth wrote:
> > Now that the old pc-0.x machine types have been removed, we do not need
> > the old "rombar" hacks anymore.
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   hw/display/vga-pci.c    | 5 -----
> >   hw/display/vga.c        | 4 +---
> >   hw/display/vmware_vga.c | 5 -----
> >   3 files changed, 1 insertion(+), 13 deletions(-)
> >=20
> > diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> > index a27b88122d..cfe095713e 100644
> > --- a/hw/display/vga-pci.c
> > +++ b/hw/display/vga-pci.c
> > @@ -264,11 +264,6 @@ static void pci_std_vga_realize(PCIDevice *dev, Er=
ror **errp)
> >           pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &=
d->mmio);
> >       }
> > -
> > -    if (!dev->rom_bar) {
> > -        /* compatibility with pc-0.13 and older */
> > -        vga_init_vbe(s, OBJECT(dev), pci_address_space(dev));
> > -    }
> >   }
> >   static void pci_std_vga_init(Object *obj)
> > diff --git a/hw/display/vga.c b/hw/display/vga.c
> > index 82ebe53610..636586a476 100644
> > --- a/hw/display/vga.c
> > +++ b/hw/display/vga.c
> > @@ -2304,9 +2304,7 @@ void vga_init(VGACommonState *s, Object *obj, Mem=
oryRegion *address_space,
> >   void vga_init_vbe(VGACommonState *s, Object *obj, MemoryRegion *syste=
m_memory)
> >   {
> > -    /* With pc-0.12 and below we map both the PCI BAR and the fixed VB=
E region,
> > -     * so use an alias to avoid double-mapping the same region.
> > -     */
> > +    /* Use an alias to avoid double-mapping the same region */
>=20
> If I understand the comment correctly, we can now revert commit 8294a64d7=
f9
> and and remove the alias, isn't it?

Hmm, yes, I think so given that only isa-vga calls vga_init_vbe().

cheers,
  Gerd


