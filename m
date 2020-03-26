Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85CBC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DB020714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqzYyu+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DB020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMpC-0003vZ-Rc
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jHMoR-0003Rt-FN
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jHMoP-00053I-Vv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:20:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33103)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jHMoP-00052k-Ro
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585207221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOAcI39jsJ9fz88dD3GQ792JSJ0IUL9eFspJufQfAfU=;
 b=LqzYyu+VaBwGJmBy1bqa8PEVQVC6cOi3eECGguxZwpECakQjl3Qbd4itiiB8gXYjSiyw2n
 6f5lHieTR8OHPdZbiZzrJhCwk6zTQAVT+2JoS2zu1OgT881V8Z4YbVVfY1+sQegZKSNK15
 AewwOT6L2W3W15UtM+xaK/eIeW16puM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-CK3oBd3yOkKHe0P6mJCLPw-1; Thu, 26 Mar 2020 03:20:19 -0400
X-MC-Unique: CK3oBd3yOkKHe0P6mJCLPw-1
Received: by mail-wr1-f69.google.com with SMTP id b11so2566840wru.21
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 00:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=1Z6I3vnt1926wjCwMm7CmJgIas5ga85UWxGXYl1i0Do=;
 b=TrpR8h7NoH5va4qUb3U6oJg4KJSCsdPv77LuSxL2eENsxgGnHsGyamTjzemV1wmHfp
 rWHDAc8bLvkgX/c6SvCKum502JzOPkl6cunb65zCS1r1AKI9ujsOY9UCfNi0wGJW0/1F
 6PiAob+zQ01MqupsC34zaxeKTsS7I2jnxpBIhbdFxdP8mcTbs9B0VmnLdWDKtEDlQ1va
 G1Zm3DvVMDbP/PywF0/Xh1ik/e4O0UL/EZAaCItnOYjGl0NdxI0gaVwctIpJrNPpk4nk
 htztVJhrSnPgmiznpeQ86HT6Y4pgCjrowFePNZl+lRMudbGVL27ddt2olEoYTzqnldNs
 I2JA==
X-Gm-Message-State: ANhLgQ03iTjOq750JgJftBUq3fRxxfa+mJNRzeOpmQGM0wq/n4MKPsFb
 +yQw1pmhCQNFDvKV/L2RbtgLhYe7B235oSolD2kJ8EzVJ6KlXGhEhc/8M4xV/me3YEFPIo0CWNz
 ds411DgQwVGbz2xI=
X-Received: by 2002:a1c:b60b:: with SMTP id g11mr1660494wmf.175.1585207217921; 
 Thu, 26 Mar 2020 00:20:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt4FCH3TsK9IEjiVhgPUlD/dXXsAFI8yS8H3JzHiIqKxv2+AZofgjkk3677JHt+44wbwPfbQg==
X-Received: by 2002:a1c:b60b:: with SMTP id g11mr1660461wmf.175.1585207217610; 
 Thu, 26 Mar 2020 00:20:17 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C669F.dip0.t-ipconnect.de. [91.12.102.159])
 by smtp.gmail.com with ESMTPSA id r15sm2326259wra.19.2020.03.26.00.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 00:20:17 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH for QEMU v2] virtio-balloon: Add option cont-pages to set
 VIRTIO_BALLOON_VQ_INFLATE_CONT
Date: Thu, 26 Mar 2020 08:20:12 +0100
Message-Id: <B47DD070-AB50-4A43-BE7E-D4F17921891F@redhat.com>
References: <575FA585-343A-4246-830B-C1CB3153B7E0@linux.alibaba.com>
In-Reply-To: <575FA585-343A-4246-830B-C1CB3153B7E0@linux.alibaba.com>
To: teawater <teawaterz@linux.alibaba.com>
X-Mailer: iPhone Mail (17D50)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: pagupta@redhat.com, aquini@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 mojha@codeaurora.org, david@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 namit@vmware.com, Andrew Morton <akpm@linux-foundation.org>,
 Jason Wang <jasowang@redhat.com>, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 26.03.2020 um 08:06 schrieb teawater <teawaterz@linux.alibaba.com>:
>=20
> =EF=BB=BFPing.
>=20

On paid leave this week. Will try to have a look next week, but it could ta=
ke a bit longer.

Cheers

> Thanks,
> Hui
>=20
>> 2020=E5=B9=B43=E6=9C=8823=E6=97=A5 00:04=EF=BC=8CHui Zhu <teawater@gmail=
.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> If the guest kernel has many fragmentation pages, use virtio_balloon
>> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
>> the balloon pages.
>> Set option cont-pages to on will open flags VIRTIO_BALLOON_VQ_INFLATE_CO=
NT
>> and set continuous pages order to THP order.
>> Then It will get continuous pages PFN from VQ icvq use use madvise
>> MADV_DONTNEED release the THP page.
>> This will handle the THP split issue.
>>=20
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>> ---
>> hw/virtio/virtio-balloon.c                      | 32 +++++++++++++++++++=
++----
>> include/hw/virtio/virtio-balloon.h              |  4 +++-
>> include/standard-headers/linux/virtio_balloon.h |  4 ++++
>> 3 files changed, 35 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index a4729f7..88bdaca 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -34,6 +34,7 @@
>> #include "hw/virtio/virtio-access.h"
>>=20
>> #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
>> +#define CONT_PAGES_ORDER   9
>>=20
>> typedef struct PartiallyBalloonedPage {
>>    ram_addr_t base_gpa;
>> @@ -65,7 +66,8 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloo=
nedPage *pbp,
>>=20
>> static void balloon_inflate_page(VirtIOBalloon *balloon,
>>                                 MemoryRegion *mr, hwaddr mr_offset,
>> -                                 PartiallyBalloonedPage *pbp)
>> +                                 PartiallyBalloonedPage *pbp,=20
>> +                                 bool is_cont_pages)
>> {
>>    void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
>>    ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
>> @@ -76,6 +78,13 @@ static void balloon_inflate_page(VirtIOBalloon *ballo=
on,
>>    /* XXX is there a better way to get to the RAMBlock than via a
>>     * host address? */
>>    rb =3D qemu_ram_block_from_host(addr, false, &rb_offset);
>> +
>> +    if (is_cont_pages) {
>> +        ram_block_discard_range(rb, rb_offset,
>> +                                BALLOON_PAGE_SIZE << CONT_PAGES_ORDER);
>> +        return;
>> +    }
>> +
>>    rb_page_size =3D qemu_ram_pagesize(rb);
>>=20
>>    if (rb_page_size =3D=3D BALLOON_PAGE_SIZE) {
>> @@ -361,9 +370,10 @@ static void virtio_balloon_handle_output(VirtIODevi=
ce *vdev, VirtQueue *vq)
>>            trace_virtio_balloon_handle_output(memory_region_name(section=
.mr),
>>                                               pa);
>>            if (!qemu_balloon_is_inhibited()) {
>> -                if (vq =3D=3D s->ivq) {
>> +                if (vq =3D=3D s->ivq || vq =3D=3D s->icvq) {
>>                    balloon_inflate_page(s, section.mr,
>> -                                         section.offset_within_region, =
&pbp);
>> +                                         section.offset_within_region, =
&pbp,
>> +                                         vq =3D=3D s->icvq);
>>                } else if (vq =3D=3D s->dvq) {
>>                    balloon_deflate_page(s, section.mr, section.offset_wi=
thin_region);
>>                } else {
>> @@ -618,9 +628,12 @@ static size_t virtio_balloon_config_size(VirtIOBall=
oon *s)
>>    if (s->qemu_4_0_config_size) {
>>        return sizeof(struct virtio_balloon_config);
>>    }
>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
>> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGE=
S)) {
>>        return sizeof(struct virtio_balloon_config);
>>    }
>> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
>> +        return offsetof(struct virtio_balloon_config, pages_order);
>> +    }
>>    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>        return offsetof(struct virtio_balloon_config, poison_val);
>>    }
>> @@ -646,6 +659,10 @@ static void virtio_balloon_get_config(VirtIODevice =
*vdev, uint8_t *config_data)
>>                       cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
>>    }
>>=20
>> +    if (virtio_has_feature(dev->host_features, VIRTIO_BALLOON_F_CONT_PA=
GES)) {
>> +        config.pages_order =3D cpu_to_le32(CONT_PAGES_ORDER);
>> +    }
>> +
>>    trace_virtio_balloon_get_config(config.num_pages, config.actual);
>>    memcpy(config_data, &config, virtio_balloon_config_size(dev));
>> }
>> @@ -816,6 +833,11 @@ static void virtio_balloon_device_realize(DeviceSta=
te *dev, Error **errp)
>>            virtio_error(vdev, "iothread is missing");
>>        }
>>    }
>> +
>> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGE=
S)) {
>> +        s->icvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_o=
utput);
>> +    }
>> +
>>    reset_stats(s);
>> }
>>=20
>> @@ -916,6 +938,8 @@ static Property virtio_balloon_properties[] =3D {
>>                    VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>>    DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>>                    VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
>> +    DEFINE_PROP_BIT("cont-pages", VirtIOBalloon, host_features,
>> +                    VIRTIO_BALLOON_F_CONT_PAGES, false),
>>    /* QEMU 4.0 accidentally changed the config size even when free-page-=
hint
>>     * is disabled, resulting in QEMU 3.1 migration incompatibility.  Thi=
s
>>     * property retains this quirk for QEMU 4.1 machine types.
>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virt=
io-balloon.h
>> index d1c968d..61d2419 100644
>> --- a/include/hw/virtio/virtio-balloon.h
>> +++ b/include/hw/virtio/virtio-balloon.h
>> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
>>=20
>> typedef struct VirtIOBalloon {
>>    VirtIODevice parent_obj;
>> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
>> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
>>    uint32_t free_page_report_status;
>>    uint32_t num_pages;
>>    uint32_t actual;
>> @@ -70,6 +70,8 @@ typedef struct VirtIOBalloon {
>>    uint32_t host_features;
>>=20
>>    bool qemu_4_0_config_size;
>> +
>> +    uint32_t pages_order;
>> } VirtIOBalloon;
>>=20
>> #endif
>> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/s=
tandard-headers/linux/virtio_balloon.h
>> index 9375ca2..ee18be7 100644
>> --- a/include/standard-headers/linux/virtio_balloon.h
>> +++ b/include/standard-headers/linux/virtio_balloon.h
>> @@ -36,6 +36,8 @@
>> #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM    2 /* Deflate balloon on OOM *=
/
>> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT    3 /* VQ to report free pages =
*/
>> #define VIRTIO_BALLOON_F_PAGE_POISON    4 /* Guest is using page poisoni=
ng */
>> +#define VIRTIO_BALLOON_F_CONT_PAGES    5 /* VQ to report continuous pag=
es */
>> +
>>=20
>> /* Size of a PFN in the balloon interface. */
>> #define VIRTIO_BALLOON_PFN_SHIFT 12
>> @@ -51,6 +53,8 @@ struct virtio_balloon_config {
>>    uint32_t free_page_report_cmd_id;
>>    /* Stores PAGE_POISON if page poisoning is in use */
>>    uint32_t poison_val;
>> +    /* Pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
>> +    uint32_t pages_order;
>> };
>>=20
>> #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
>> --=20
>> 2.7.4
>>=20
>=20


