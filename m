Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FE3C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D7620714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRd26heL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D7620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1weA-0003Db-52
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 13:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1wdR-0002eU-SC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1wdP-0006HA-2B
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:21:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1wdO-0006FW-MV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581531673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G5EEGDoYvH+v8ukGpNndzjDKvYVuBu5Iusu2Lrc5j2E=;
 b=BRd26heLiUOggFmxeA/cLEVSWx0qERKi9uKBCAd4hJksmBR2r1QenEUx2gMveP6o47znS7
 Hm03pNY8lz+pTW4nrDQLrwb1UcNDT9o86u8yBCh/njBxW7g/Mpq6O7qS+o54NgESx29c71
 nQJd31N3OAkYYimuhcs/WDZrMwhd/2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-X1i3wboWNaqnbhD1TH2UmA-1; Wed, 12 Feb 2020 13:21:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5FDD107ACC9;
 Wed, 12 Feb 2020 18:21:07 +0000 (UTC)
Received: from [10.36.117.92] (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D063619C6A;
 Wed, 12 Feb 2020 18:20:58 +0000 (UTC)
Subject: Re: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
 <20200117174522.22044-2-shameerali.kolothum.thodi@huawei.com>
 <20200204162320.67e5d353@redhat.com>
 <74eaaa45-0d20-9a21-fbf8-6d29deb248eb@redhat.com>
 <4ce41554-8b8e-dbb5-5fe9-43af09950f23@redhat.com>
 <8e0b2c762e914c64bebfab5fc7441661@huawei.com>
 <133f274e-e942-7008-93d2-8edb1bc4d7ae@redhat.com>
 <52fff289cca14874ad493fc25806fe3d@huawei.com>
 <f041380c-afcb-f8d8-89db-8f48c7b46767@redhat.com>
 <e97fa28c653044b8bab66aeca2374682@huawei.com>
 <0ff4d2c1-ebd3-1d2f-07e8-a4f13be07ceb@redhat.com>
 <6bf255ecb88446f1b08ee4ab21a85f02@huawei.com>
 <69848dd3-fac4-ec6b-78a8-a052124f4fc3@redhat.com>
 <49b54eea65cd49ae832cd6ec21eae64a@huawei.com>
 <b4ccf1d9-4514-6b63-5ef9-1d337f539267@redhat.com>
 <fad66252aa8f4b46816f21b5315b6358@huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <8f10dd72-9a19-b910-489c-eacc6a772046@redhat.com>
Date: Wed, 12 Feb 2020 19:20:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fad66252aa8f4b46816f21b5315b6358@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: X1i3wboWNaqnbhD1TH2UmA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>,
 Juan Jose Quintela Carreira <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "lersek@redhat.com" <lersek@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12.02.20 18:07, Shameerali Kolothum Thodi wrote:
>=20
>=20
>> -----Original Message-----
>> From: David Hildenbrand [mailto:david@redhat.com]
>> Sent: 10 February 2020 09:54
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> Igor Mammedov <imammedo@redhat.com>
>> Cc: peter.maydell@linaro.org; xiaoguangrong.eric@gmail.com;
>> mst@redhat.com; shannon.zhaosl@gmail.com; qemu-devel@nongnu.org;
>> xuwei (O) <xuwei5@huawei.com>; Linuxarm <linuxarm@huawei.com>;
>> eric.auger@redhat.com; qemu-arm@nongnu.org; lersek@redhat.com
>> Subject: Re: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
>>
>> On 10.02.20 10:50, Shameerali Kolothum Thodi wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: David Hildenbrand [mailto:david@redhat.com]
>>>> Sent: 10 February 2020 09:29
>>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>>>> Igor Mammedov <imammedo@redhat.com>
>>>> Cc: peter.maydell@linaro.org; xiaoguangrong.eric@gmail.com;
>>>> mst@redhat.com; shannon.zhaosl@gmail.com; qemu-devel@nongnu.org;
>>>> xuwei (O) <xuwei5@huawei.com>; Linuxarm <linuxarm@huawei.com>;
>>>> eric.auger@redhat.com; qemu-arm@nongnu.org; lersek@redhat.com
>>>> Subject: Re: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
>>>>
>>>>>> Can you look the original value up somehow and us the resize callbac=
k
>>>>>> only as a notification that something changed? (that value would hav=
e to
>>>>>> be stored somewhere and migrated I assume - maybe that's already
>> being
>>>>>> done)
>>>>>
>>>>> Ok. I will take a look at that. But can we instead pass the
>> block->used_length
>>>> to
>>>>> fw_cfg_add_file_callback(). That way we don=E2=80=99t have to change =
the
>>>> qemu_ram_resize()
>>>>> as well. I think Igor has suggested this before[1] and I had a go at =
it before
>>>> coming up
>>>>> with the "req_length" proposal here.
>>>>
>>>> You mean, passing the old size as well? I don't see how that will solv=
e
>>>> the issue, but yeah, nothing speaks against simply sending the old and
>>>> the new size.
>>>
>>> Nope. I actually meant using the block->used_length to store in the
>>> s->files->f[index].size.
>>>
>>> virt_acpi_setup()
>>>   acpi_add_rom_blob()
>>>     rom_add_blob()
>>>       rom_set_mr()  --> used_length  =3D page aligned blob size
>>>         fw_cfg_add_file_callback()  --> uses actual blob size.
>>>
>>>
>>> Right now what we do is use the actual blob size to store in FWCfgEntry=
.
>>> Instead pass the RAMBlock used_length to fw_cfg_add_file_callback().
>>> Of course by this, the firmware will see an aligned size, but that is f=
ine I think.
>>> But at the same time this means the qemu_ram_resize() can stay as it is
>>> because it will invoke the callback when the size changes beyond the al=
igned
>>> page size. And also during migration, there won't be any inconsistency =
as
>> everyone
>>> works on aligned page size.
>>>
>>> Does that make sense? Or I am again missing something here?
>>
>> Oh, you mean simply rounding up to full pages in the fw entries? If we
>> can drop the "sub-page" restriction, that would be awesome!
>>
>> Need to double check if that could be an issue for fw/migration/whatever=
.
>=20
> Hmm..it breaks x86 + seabios boot. The issue is seabios expects RSDP in F=
SEG
> memory. With the above proposed change, RSDP will be aligned to PAGE_SIZE=
 and
> seabios mem allocation for RSDP fails at,
>=20
> https://github.com/coreboot/seabios/blob/master/src/fw/romfile_loader.c#L=
85
>=20
> To get pass the above, I changed "alloc_fseg" flag to false in build_rsdp=
(), but
> seabios seems to make the assumption that RSDP has to be placed in FSEG m=
emory
> here,
> https://github.com/coreboot/seabios/blob/master/src/fw/biostables.c#L126
>=20
> So doesn=E2=80=99t look like there is an easy fix for this without changi=
ng the seabios code.
>=20
> Between, OVMF works fine with the aligned size on x86.
>=20
> One thing we can do is treat the RSDP case separately or only use the ali=
gned
> page size for "etc/acpi/tables" as below,
>=20
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index d1b78f60cd..f07f6a7a35 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -60,6 +60,7 @@
>  #include "hw/boards.h"
>  #include "qemu/cutils.h"
>  #include "sysemu/runstate.h"
> +#include "hw/acpi/aml-build.h"
> =20
>  #include <zlib.h>
> =20
> @@ -1056,6 +1057,7 @@ MemoryRegion *rom_add_blob(const char *name, const =
void *blob, size_t len,
>      if (fw_file_name && fw_cfg) {
>          char devpath[100];
>          void *data;
> +        size_t size =3D rom->datasize;
> =20
>          if (read_only) {
>              snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
> @@ -1066,13 +1068,21 @@ MemoryRegion *rom_add_blob(const char *name, cons=
t void *blob, size_t len,
>          if (mc->rom_file_has_mr) {
>              data =3D rom_set_mr(rom, OBJECT(fw_cfg), devpath, read_only)=
;
>              mr =3D rom->mr;
> +           /*
> +            * Use the RAMblk used_length for acpi tables as this avoids =
any
> +            * inconsistency with table size changes during hot add and d=
uring
> +            * migration.
> +            */
> +           if (strcmp(fw_file_name, ACPI_BUILD_TABLE_FILE) =3D=3D 0) {
> +                size =3D memory_region_get_used_length(mr);
> +           }
>          } else {
>              data =3D rom->data;
>          }
> =20
>          fw_cfg_add_file_callback(fw_cfg, fw_file_name,
>                                   fw_callback, NULL, callback_opaque,
> -                                 data, rom->datasize, read_only);
> +                                 data, size, read_only);
>      }
>      return mr;
>  }
>=20
>=20
> Thoughts?

I don't think introducing memory_region_get_used_length() is a
good idea. I also dislike, that the ram block size can differ
to the memory region size. I wasn't aware of that condition, sorry!

Making the memory region always store an aligned size might break other use=
 cases.

Summarizing the issue:
1. Memory regions contain ram blocks with a different size, if the size is
   not properly aligned. While memory regions can have an unaligned size,
   ram blocks can't. This is true when creating resizable memory region wit=
h
   an unaligned size.
2. When resizing a ram block/memory region, the size of the memory region
   is set to the aligned size. The callback is called with the aligned size=
.
   The unaligned piece is lost.
3. When migrating, we migrate the aligned size.


What about something like this: (untested)


From d84c21bc67e15acdac2f6265cd1576d8dd920211 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 12 Feb 2020 19:16:34 +0100
Subject: [PATCH v1] tmp

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c          | 14 ++++++++++++--
 migration/ram.c | 44 ++++++++++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/exec.c b/exec.c
index 05cfe868ab..d41a1e11b5 100644
--- a/exec.c
+++ b/exec.c
@@ -2130,11 +2130,21 @@ static int memory_try_enable_merging(void *addr, si=
ze_t len)
  */
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 {
+    const ram_addr_t unaligned_size =3D newsize;
+
     assert(block);
=20
     newsize =3D HOST_PAGE_ALIGN(newsize);
=20
     if (block->used_length =3D=3D newsize) {
+        /*
+         * We don't have to resize the ram block (which only knows aligned
+         * sizes), however, we have to notify if the unaligned size change=
d.
+         */
+        if (block->resized && unaligned_size !=3D memory_region_size(block=
->mr)) {
+            block->resized(block->idstr, unaligned_size, block->host);
+            memory_region_set_size(block->mr, unaligned_size);
+        }
         return 0;
     }
=20
@@ -2158,9 +2168,9 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsi=
ze, Error **errp)
     block->used_length =3D newsize;
     cpu_physical_memory_set_dirty_range(block->offset, block->used_length,
                                         DIRTY_CLIENTS_ALL);
-    memory_region_set_size(block->mr, newsize);
+    memory_region_set_size(block->mr, unaligned_size);
     if (block->resized) {
-        block->resized(block->idstr, newsize, block->host);
+        block->resized(block->idstr, unaligned_size, block->host);
     }
     return 0;
 }
diff --git a/migration/ram.c b/migration/ram.c
index ed23ed1c7c..2acc4b85ca 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1761,28 +1761,43 @@ void acct_update_position(QEMUFile *f, size_t size,=
 bool zero)
     }
 }
=20
-static uint64_t ram_bytes_total_common(bool count_ignored)
+static uint64_t ramblock_ram_bytes_migration(RAMBlock *block)
+{
+    /*
+     * When resizing on the target, we need the unaligned size,
+     * otherwise, we lose the unaligned size during migration.
+     */
+    if (block->mr && (block->flags & RAM_RESIZEABLE)) {
+        return memory_region_size(block->mr);
+    } else {
+        return block->used_length;
+    }
+}
+
+static uint64_t ram_bytes_total_migration(void)
 {
     RAMBlock *block;
     uint64_t total =3D 0;
=20
     RCU_READ_LOCK_GUARD();
=20
-    if (count_ignored) {
-        RAMBLOCK_FOREACH_MIGRATABLE(block) {
-            total +=3D block->used_length;
-        }
-    } else {
-        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-            total +=3D block->used_length;
-        }
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        total +=3D ramblock_ram_bytes_migration(block);
     }
     return total;
 }
=20
 uint64_t ram_bytes_total(void)
 {
-    return ram_bytes_total_common(false);
+    RAMBlock *block;
+    uint64_t total =3D 0;
+
+    RCU_READ_LOCK_GUARD();
+
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+        total +=3D block->used_length;
+    }
+    return total;
 }
=20
 static void xbzrle_load_setup(void)
@@ -2432,12 +2447,17 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
)
     (*rsp)->f =3D f;
=20
     WITH_RCU_READ_LOCK_GUARD() {
-        qemu_put_be64(f, ram_bytes_total_common(true) | RAM_SAVE_FLAG_MEM_=
SIZE);
+        qemu_put_be64(f, ram_bytes_total_migration() | RAM_SAVE_FLAG_MEM_S=
IZE);
=20
         RAMBLOCK_FOREACH_MIGRATABLE(block) {
             qemu_put_byte(f, strlen(block->idstr));
             qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idst=
r));
-            qemu_put_be64(f, block->used_length);
+            /*
+             * When resizing on the target, we need the unaligned size,
+             * otherwise we lose the unaligned sise during migration.
+             */
+            qemu_put_be64(f, ramblock_ram_bytes_migration(block));
+
             if (migrate_postcopy_ram() && block->page_size !=3D
                                           qemu_host_page_size) {
                 qemu_put_be64(f, block->page_size);
--=20
2.24.1


--=20
Thanks,

David / dhildenb


