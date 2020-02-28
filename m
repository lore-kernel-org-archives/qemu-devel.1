Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2ACC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C175420684
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOnGRHDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C175420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jwj-0006MD-Vy
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 13:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7jvv-0005aI-So
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7jvt-00048i-BI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:00:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59065
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7jvt-000483-67
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582912816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YZWXiQLKCnvA+mE/uF1xUy5rCkp9YR6wzlA0q+6F+uo=;
 b=dOnGRHDdaTo21TrOvQM+AGkd7BbvUoRvop0aTp44YGhQnQFvE/6lMK/ILdN3JbEvOJqrBA
 mierave1KfbBtdqyk/Sgx3LpnMve51j3a5fBMuw2/+pgpq67/ZpkX5Pyi/bQfuY1Y0ygBe
 kj8nT3LczRNwJN3WAZe2fRCzchf2LXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-Agjh-tYmNayfnwAE6mKhaw-1; Fri, 28 Feb 2020 13:00:14 -0500
X-MC-Unique: Agjh-tYmNayfnwAE6mKhaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86462800D5C;
 Fri, 28 Feb 2020 18:00:12 +0000 (UTC)
Received: from [10.36.117.192] (ovpn-117-192.ams2.redhat.com [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1B881CB;
 Fri, 28 Feb 2020 17:59:57 +0000 (UTC)
Subject: Re: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
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
 <8f10dd72-9a19-b910-489c-eacc6a772046@redhat.com>
 <04adb50079bc45888f514721edb3cfa3@huawei.com>
 <69ab2339-f4c3-dbd6-1be7-5d6eef28d027@redhat.com>
 <b78f892f-c917-a3a8-4c6b-8d03af02782d@redhat.com>
 <8f27608fd02147bfb11bdfca38316f4c@huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <01aa6f4a-cfa7-6a35-8a7a-5189b66e2c9e@redhat.com>
Date: Fri, 28 Feb 2020 18:59:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8f27608fd02147bfb11bdfca38316f4c@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On 28.02.20 17:49, Shameerali Kolothum Thodi wrote:
>=20
>=20
>> -----Original Message-----
>> From: David Hildenbrand [mailto:david@redhat.com]
>> Sent: 13 February 2020 17:09
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> Igor Mammedov <imammedo@redhat.com>
>> Cc: peter.maydell@linaro.org; xiaoguangrong.eric@gmail.com;
>> mst@redhat.com; shannon.zhaosl@gmail.com; qemu-devel@nongnu.org;
>> xuwei (O) <xuwei5@huawei.com>; Linuxarm <linuxarm@huawei.com>;
>> eric.auger@redhat.com; qemu-arm@nongnu.org; lersek@redhat.com;
>> dgilbert@redhat.com; Juan Jose Quintela Carreira <quintela@redhat.com>
>> Subject: Re: [PATCH v2 1/7] exec: Fix for qemu_ram_resize() callback
>=20
> [...]
>=20
>>>> Thanks for that. I had a go with the below patch and it indeed fixes t=
he issue
>>>> of callback not being called on resize. But the migration fails with t=
he below
>>>> error,
>>>>
>>>> For x86
>>>> ---------
>>>> qemu-system-x86_64: Unknown combination of migration flags: 0x14
>>>> qemu-system-x86_64: error while loading state for instance 0x0 of devi=
ce
>> 'ram'
>>>> qemu-system-x86_64: load of migration failed: Invalid argument
>>>>
>>>> For arm64
>>>> --------------
>>>> qemu-system-aarch64: Received an unexpected compressed page
>>>> qemu-system-aarch64: error while loading state for instance 0x0 of dev=
ice
>> 'ram'
>>>> qemu-system-aarch64: load of migration failed: Invalid argument
>>>>
>>>> I haven=E2=80=99t debugged this further but looks like there is a corr=
uption
>> happening.
>>>> Please let me know if you have any clue.
>>>
>>> The issue is
>>>
>>> qemu_put_be64(f, ram_bytes_total_common(true) |
>> RAM_SAVE_FLAG_MEM_SIZE)
>>>
>>> The total ram size we store must be page aligned, otherwise it will be
>>> detected as flags. Hm ... maybe we can round it up ...
>>>
>>
>> I'm afraid we can't otherwise we will run into issues in
>> ram_load_precopy(). Hm ...
>=20
> Sorry, took a while to get back on this. Yes, round up indeed breaks in
> ram_load_precopy() . I had the below on top of your patch and that=20
> seems to do the job (sanity tested on arm/virt).
>=20
> Please take a look and let me know if you see any issues with this approa=
ch.
>=20
> Thanks,
> Shameer
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 2acc4b85ca..7447f0cefa 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1782,7 +1782,7 @@ static uint64_t ram_bytes_total_migration(void)
>      RCU_READ_LOCK_GUARD();
> =20
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> -        total +=3D ramblock_ram_bytes_migration(block);
> +        total +=3D block->used_length;
>      }
>      return total;
>  }
> @@ -3479,7 +3479,7 @@ static int ram_load_precopy(QEMUFile *f)
>                      ret =3D -EINVAL;
>                  }
> =20
> -                total_ram_bytes -=3D length;
> +                total_ram_bytes -=3D block->used_length;
>              }
>              break;
>=20
>=20
>=20

What you mean is the following:


commit 702f4325086c3a8d6083787f8bc8503f7523bac8 (HEAD -> master)
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Feb 12 19:16:34 2020 +0100

    tmp
   =20
    Signed-off-by: David Hildenbrand <david@redhat.com>

diff --git a/exec.c b/exec.c
index 67e520d18e..cec643b914 100644
--- a/exec.c
+++ b/exec.c
@@ -2125,11 +2125,21 @@ static int memory_try_enable_merging(void *addr, si=
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
@@ -2153,9 +2163,9 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsi=
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
index d2208b5534..249d3edede 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3412,7 +3412,15 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         RAMBLOCK_FOREACH_MIGRATABLE(block) {
             qemu_put_byte(f, strlen(block->idstr));
             qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idst=
r));
-            qemu_put_be64(f, block->used_length);
+            /*
+             * When resizing on the target, we need the unaligned size,
+             * otherwise we lose the unaligned sise during migration.
+             *
+             * Note: The sum of all ram blocks will differ to
+             * ram_bytes_total_common(true) stored above.
+             */
+            qemu_put_be64(f, ramblock_ram_bytes_migration(block));
+
             if (migrate_postcopy_ram() && block->page_size !=3D
                                           qemu_host_page_size) {
                 qemu_put_be64(f, block->page_size);
@@ -4429,7 +4437,7 @@ static int ram_load_precopy(QEMUFile *f)
                     ret =3D -EINVAL;
                 }
=20
-                total_ram_bytes -=3D length;
+                total_ram_bytes -=3D block->used_length;
             }
             break;
=20

Please note that this will *for sure* break migration between QEMU versions=
.
So I don't think this will work.


We should instead think about

1. Migrating the actual size of the 3 memory regions separately and setting=
 them via
memory_region_ram_resize() when loading the vmstate. This will trigger anot=
her FW cfg
fixup and should be fine (with the same qemu_ram_resize() above).

2. Introduce a new RAM_SAVE_FLAG_MEM_SIZE_2, that e.g., stores the number o=
f ramblocks,
not the total amount of memory of the ram blocks. But it's hacky, because w=
e migrate
something for RAM blocks, that is not a RAM block concept (sub-block sizes)=
.

I think you should look into 1. Shouldn't be too hard I think.

--=20
Thanks,

David / dhildenb


