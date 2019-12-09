Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B242AC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C48320726
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oi4ce94l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C48320726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieJ8Z-0006kw-Hf
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieJ7Q-0006Cw-TE
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieJ7N-0005OW-1S
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:30:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57288
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieJ7M-0005NE-Lr
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575898227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qSynBhZ1Z+OqDffuadKRgMI2oNnDdumZ0jlJkpxkenM=;
 b=Oi4ce94lHVdbL8eQwFCyyxWb4InYt/zZbNJW43RqRX1INYPLNxFSTgKFWp57mqpTUcPJJS
 OQfe7aW87xHs8arGjBuXijlgyisUf28YUATrbqgnJDvzXU007iRuEZz24N8Z8f1pFWpQlk
 g7ewItYKP0WC2nIY7jgWso84TletHj4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-ASx2sH3oOyuwSOE8Ad_Tdg-1; Mon, 09 Dec 2019 08:30:24 -0500
Received: by mail-wm1-f72.google.com with SMTP id b131so3838967wmd.9
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 05:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sarljVfnVAdSfZ9BXDhNeuZVocraqMAIlAnEvgZMNeI=;
 b=cWLXumw6McJ4K37jjxC49oG2UyMsNP9Wy2lza81ePoxoTvySUhuWOfNG6JgTXHvy/H
 CBpzDVmVc/HUjNPfJnqSZIWJg5GM6ZVJmVKGNrcLsMmXL/Ma+WGwLDBfQnDxzyStpYD9
 s5CQZySUNLc+1DW/LKJccUuztvswKM5Eug1WiWBz3pbfDFKz8UyhGaj0+rGNeey0fq4D
 AfPYGDOpvZSKEMcx69eUzZc6DmNmxt3as8gCFVmvMtlFNNSYWCf/AVD7KqnF91+QHZW5
 S9uEZF3cgGytd/NY1D/0CkJpYXiQgK+tcvve12/2BZba4tw66Bloz99k03Ef4cyqzGWq
 gekA==
X-Gm-Message-State: APjAAAXHa1Yd8wUwntdh5kbSa0AWEzfDdfxvzZ+jRUiyLHSLhY3F1AZy
 IFeNNX41BHzRG3BqHKFlr4WFl2f19Y90yMKlSc9vD8guJL3kErG0tPe9xsRriP2qgGGh2nMpIZA
 ipMmYnF4JjACMF+Y=
X-Received: by 2002:a1c:5451:: with SMTP id p17mr24095276wmi.57.1575898223038; 
 Mon, 09 Dec 2019 05:30:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKA2jVIDGIGQknejukoiwTeixgzdTX+SlLNbZ0tHiN0wo2Hn0PZRADtDKii0P1cEyzda12EQ==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr24095247wmi.57.1575898222735; 
 Mon, 09 Dec 2019 05:30:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id m187sm2742472wmm.16.2019.12.09.05.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 05:30:22 -0800 (PST)
Subject: Re: [PATCH v2 4/4] hw/display: Remove "rombar" hack from vga-pci and
 vmware_vga
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20191209125248.5849-1-thuth@redhat.com>
 <20191209125248.5849-5-thuth@redhat.com>
 <3ab730ea-658f-ff98-035d-f94ed7775f00@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bedf0734-7d00-9e82-56b6-509dff45a946@redhat.com>
Date: Mon, 9 Dec 2019 14:30:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3ab730ea-658f-ff98-035d-f94ed7775f00@redhat.com>
Content-Language: en-US
X-MC-Unique: ASx2sH3oOyuwSOE8Ad_Tdg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: libvir-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/19 14:12, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/9/19 1:52 PM, Thomas Huth wrote:
>> Now that the old pc-0.x machine types have been removed, we do not need
>> the old "rombar" hacks anymore.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 hw/display/vga-pci.c=C2=A0=C2=A0=C2=A0 | 5 -----
>> =C2=A0 hw/display/vga.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 +-=
--
>> =C2=A0 hw/display/vmware_vga.c | 5 -----
>> =C2=A0 3 files changed, 1 insertion(+), 13 deletions(-)
>>
>> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
>> index a27b88122d..cfe095713e 100644
>> --- a/hw/display/vga-pci.c
>> +++ b/hw/display/vga-pci.c
>> @@ -264,11 +264,6 @@ static void pci_std_vga_realize(PCIDevice *dev,
>> Error **errp)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_regist=
er_bar(&d->dev, 2,
>> PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 if (!dev->rom_bar) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* compatibility with pc-0.1=
3 and older */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vga_init_vbe(s, OBJECT(dev),=
 pci_address_space(dev));
>> -=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void pci_std_vga_init(Object *obj)
>> diff --git a/hw/display/vga.c b/hw/display/vga.c
>> index 82ebe53610..636586a476 100644
>> --- a/hw/display/vga.c
>> +++ b/hw/display/vga.c
>> @@ -2304,9 +2304,7 @@ void vga_init(VGACommonState *s, Object *obj,
>> MemoryRegion *address_space,
>> =C2=A0 =C2=A0 void vga_init_vbe(VGACommonState *s, Object *obj, MemoryRe=
gion
>> *system_memory)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 /* With pc-0.12 and below we map both the PCI BAR an=
d the fixed
>> VBE region,
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * so use an alias to avoid double-mapping the =
same region.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 /* Use an alias to avoid double-mapping the same reg=
ion */
>=20
> If I understand the comment correctly, we can now revert commit
> 8294a64d7f9 and and remove the alias, isn't it?

Yes, even inline vga_init_vbe and remove vbe_mapped.

----------------- 8< ----------------
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] vga: cleanup mapping of VRAM for non-PCI VGA

vga_init_vbe is now used only from ISA VGA cards.  Since the alias is
not needed anymore, remove it (effectively reverting commit 8294a64d7f,
"vga: fix vram double-mapping with -vga std and -M pc-0.12", 2012-05-29)
and the new unused vbe_mapped field of VGACommonState.  The function now
consists of a single memory_region_add_subregion call, so we can inline
it and avoid incorrect usage from PCI cards.

Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index e9c43e5530..06f93c4ef5 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -106,6 +106,9 @@ int isa_vga_mm_init(hwaddr vram_base,
=20
     s->vga.con =3D graphic_console_init(NULL, 0, s->vga.hw_ops, s);
=20
-    vga_init_vbe(&s->vga, NULL, address_space);
+    memory_region_add_subregion(system_memory,
+                                VBE_DISPI_LFB_PHYSICAL_ADDRESS,
+                                &s->vram);
+
     return 0;
 }
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 873e5e9706..5b0b567835 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -76,7 +76,9 @@ static void vga_isa_realizefn(DeviceState *dev, Error **e=
rrp)
     memory_region_set_coalescing(vga_io_memory);
     s->con =3D graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
=20
-    vga_init_vbe(s, OBJECT(dev), isa_address_space(isadev));
+    memory_region_add_subregion(system_memory,
+                                VBE_DISPI_LFB_PHYSICAL_ADDRESS,
+                                &s->vram);
     /* ROM BIOS */
     rom_add_vga(VGABIOS_FILENAME);
 }
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 636586a476..061fd9ab8f 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2301,15 +2301,3 @@ void vga_init(VGACommonState *s, Object *obj, Memory=
Region *address_space,
         portio_list_add(&s->vbe_port_list, address_space_io, 0x1ce);
     }
 }
-
-void vga_init_vbe(VGACommonState *s, Object *obj, MemoryRegion *system_mem=
ory)
-{
-    /* Use an alias to avoid double-mapping the same region */
-    memory_region_init_alias(&s->vram_vbe, obj, "vram.vbe",
-                             &s->vram, 0, memory_region_size(&s->vram));
-    /* XXX: use optimized standard vga accesses */
-    memory_region_add_subregion(system_memory,
-                                VBE_DISPI_LFB_PHYSICAL_ADDRESS,
-                                &s->vram_vbe);
-    s->vbe_mapped =3D 1;
-}
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 55c418eab5..3081be445d 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -106,7 +106,6 @@ typedef struct VGACommonState {
     uint32_t vbe_start_addr;
     uint32_t vbe_line_offset;
     uint32_t vbe_bank_mask;
-    int vbe_mapped;
     /* display refresh support */
     QemuConsole *con;
     uint32_t font_offsets[2];
@@ -178,7 +177,6 @@ void vga_invalidate_scanlines(VGACommonState *s, int y1=
, int y2);
=20
 int vga_ioport_invalid(VGACommonState *s, uint32_t addr);
=20
-void vga_init_vbe(VGACommonState *s, Object *obj, MemoryRegion *address_sp=
ace);
 uint32_t vbe_ioport_read_data(void *opaque, uint32_t addr);
 void vbe_ioport_write_index(void *opaque, uint32_t addr, uint32_t val);
 void vbe_ioport_write_data(void *opaque, uint32_t addr, uint32_t val);


