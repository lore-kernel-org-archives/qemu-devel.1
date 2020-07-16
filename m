Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48145C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115E4206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115E4206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvyOz-0004Gc-Aa
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 03:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvyNx-0003Od-HN
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 03:32:54 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvyNq-0008Er-Fq
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 03:32:49 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01355; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0U2sTlwu_1594884751; 
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0U2sTlwu_1594884751) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Jul 2020 15:32:37 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [virtio-dev] [RFC for qemu v4 2/2] virtio_balloon: Add dcvq to
 deflate continuous pages
From: teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200716023910-mutt-send-email-mst@kernel.org>
Date: Thu, 16 Jul 2020 15:32:30 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F64B592-03CF-46F5-B761-78B4EBA5028E@linux.alibaba.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-6-git-send-email-teawater@gmail.com>
 <20200716023910-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=teawaterz@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 03:32:39
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: virtio-dev@lists.oasis-open.org, david@redhat.com, qemu-devel@nongnu.org,
 jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> 2020=E5=B9=B47=E6=9C=8816=E6=97=A5 14:39=EF=BC=8CMichael S. Tsirkin =
<mst@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 16, 2020 at 10:41:55AM +0800, Hui Zhu wrote:
>> This commit adds a vq dcvq to deflate continuous pages.
>> When VIRTIO_BALLOON_F_CONT_PAGES is set, try to get continuous pages
>> from icvq and use madvise MADV_WILLNEED with the pages.
>>=20
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>=20
> This is arguably something to benchmark. Does guest benefit
> from MADV_WILLNEED or loose performance?

MADV_WILLNEED will call madvise_willneed in the host kernel.
madvise_willneed will schedule all required I/O operations (swap in or =
vfs_fadvise POSIX_FADV_WILLNEED) of the address.

But the pages of the balloon are released by MADV_DONTNEED.
So I think MADV_WILLNEED will not affect the performance of the guest in =
the most of situations.

Best,
Hui

>=20
>> ---
>> hw/virtio/virtio-balloon.c         | 14 +++++++++-----
>> include/hw/virtio/virtio-balloon.h |  2 +-
>> 2 files changed, 10 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index d36a5c8..165adf7 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -138,7 +138,8 @@ static void balloon_inflate_page(VirtIOBalloon =
*balloon,
>> }
>>=20
>> static void balloon_deflate_page(VirtIOBalloon *balloon,
>> -                                 MemoryRegion *mr, hwaddr mr_offset)
>> +                                 MemoryRegion *mr, hwaddr mr_offset,
>> +                                 size_t size)
>> {
>>     void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
>>     ram_addr_t rb_offset;
>> @@ -153,10 +154,11 @@ static void balloon_deflate_page(VirtIOBalloon =
*balloon,
>>     rb_page_size =3D qemu_ram_pagesize(rb);
>>=20
>>     host_addr =3D (void *)((uintptr_t)addr & ~(rb_page_size - 1));
>> +    size &=3D ~(rb_page_size - 1);
>>=20
>>     /* When a page is deflated, we hint the whole host page it lives
>>      * on, since we can't do anything smaller */
>> -    ret =3D qemu_madvise(host_addr, rb_page_size, =
QEMU_MADV_WILLNEED);
>> +    ret =3D qemu_madvise(host_addr, size, QEMU_MADV_WILLNEED);
>>     if (ret !=3D 0) {
>>         warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
>>                     strerror(errno));
>> @@ -354,7 +356,7 @@ static void =
virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>             pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>>             offset +=3D 4;
>>=20
>> -            if (vq =3D=3D s->icvq) {
>> +            if (vq =3D=3D s->icvq || vq =3D=3D s->dcvq) {
>>                 uint32_t psize_ptr;
>>                 if (iov_to_buf(elem->out_sg, elem->out_num, offset, =
&psize_ptr, 4) !=3D 4) {
>>                     break;
>> @@ -383,8 +385,9 @@ static void =
virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>                     balloon_inflate_page(s, section.mr,
>>                                          =
section.offset_within_region,
>>                                          psize, &pbp);
>> -                } else if (vq =3D=3D s->dvq) {
>> -                    balloon_deflate_page(s, section.mr, =
section.offset_within_region);
>> +                } else if (vq =3D=3D s->dvq || vq =3D=3D s->dcvq) {
>> +                    balloon_deflate_page(s, section.mr, =
section.offset_within_region,
>> +                                         psize);
>>                 } else {
>>                     g_assert_not_reached();
>>                 }
>> @@ -838,6 +841,7 @@ static void =
virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>>=20
>>     if (virtio_has_feature(s->host_features, =
VIRTIO_BALLOON_F_CONT_PAGES)) {
>>         s->icvq =3D virtio_add_queue(vdev, 128, =
virtio_balloon_handle_output);
>> +        s->dcvq =3D virtio_add_queue(vdev, 128, =
virtio_balloon_handle_output);
>>     }
>>=20
>>     reset_stats(s);
>> diff --git a/include/hw/virtio/virtio-balloon.h =
b/include/hw/virtio/virtio-balloon.h
>> index 6a2514d..848a7fb 100644
>> --- a/include/hw/virtio/virtio-balloon.h
>> +++ b/include/hw/virtio/virtio-balloon.h
>> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
>>=20
>> typedef struct VirtIOBalloon {
>>     VirtIODevice parent_obj;
>> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
>> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq, *dcvq;
>>     uint32_t free_page_report_status;
>>     uint32_t num_pages;
>>     uint32_t actual;
>> --=20
>> 2.7.4
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


