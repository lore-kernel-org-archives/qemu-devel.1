Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896D0C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4032054F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlEUQTWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4032054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWg9-0005sz-EI
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jYWc4-00011E-Ah
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:14:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49315
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jYWc0-0005iE-Nc
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589296467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bWaVTsypD67oceyRuHYiNedQLxJqRmHYWm1W8E9uGDE=;
 b=hlEUQTWX2WXg7jr6PnA3/7dkL+y0DRmYH6zB8Aj0RaBRrPbwr3tf38+s4LziadwP+iDy2i
 FczLfuou4VDBsM/oogDHVnTPaQfpXj5NiTz99dT20UL8vK6BEK23/QcEUm9/odjpKJ6DGh
 jFxni0chlXj72TL5v0jzIVw1hf3IVUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-B9lf5wljM2azMMxUWuBzYQ-1; Tue, 12 May 2020 11:14:17 -0400
X-MC-Unique: B9lf5wljM2azMMxUWuBzYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 928E4835B41;
 Tue, 12 May 2020 15:14:16 +0000 (UTC)
Received: from [10.36.113.205] (ovpn-113-205.ams2.redhat.com [10.36.113.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD8236E6EB;
 Tue, 12 May 2020 15:14:08 +0000 (UTC)
Subject: Re: Assertion failure through vring_split_desc_read
From: Laurent Vivier <lvivier@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200511035124.v2ff4f5gyfh6xlgc@mozz.bu.edu>
 <b67bd42d-b832-20ff-411e-dd3f4a40da1a@redhat.com>
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
 D+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <008dc437-4719-0271-7647-b04f1253049c@redhat.com>
Date: Tue, 12 May 2020 17:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b67bd42d-b832-20ff-411e-dd3f4a40da1a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lvivier@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/2020 15:49, Laurent Vivier wrote:
> On 11/05/2020 05:51, Alexander Bulekov wrote:
>> Hello,
>> While fuzzing, I found an input that triggers an assertion failure
>> through virtio-rng -> vring_split_desc_read. Maybe this is related to:
>> Message-ID: <20200511033001.dzvtbdhl3oz5pgiy@mozz.bu.edu> 
>> Assertion failure through virtio_lduw_phys_cached
>>
>> #8 0x7fe6a9acf091 in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/assert.c:101:3
>> #9 0x564cbe7d96fd in address_space_read_cached include/exec/memory.h:2423:5
>> #10 0x564cbe7e79c5 in vring_split_desc_read hw/virtio/virtio.c:236:5
>> #11 0x564cbe7e84ce in virtqueue_split_read_next_desc hw/virtio/virtio.c:929:5
>> #12 0x564cbe78f86b in virtqueue_split_get_avail_bytes hw/virtio/virtio.c:1009:18
>> #13 0x564cbe78ab22 in virtqueue_get_avail_bytes hw/virtio/virtio.c:1208:9
>> #14 0x564cc08aade1 in get_request_size hw/virtio/virtio-rng.c:40:5
>> #15 0x564cc08aa20b in virtio_rng_process hw/virtio/virtio-rng.c:115:12
>> #16 0x564cc08a8c48 in virtio_rng_set_status hw/virtio/virtio-rng.c:172:5
>> #17 0x564cbe7a50be in virtio_set_status hw/virtio/virtio.c:1876:9
>> #18 0x564cc08d1b8f in virtio_pci_common_write hw/virtio/virtio-pci.c:1245:9
>>
>> I can reproduce it in a qemu 5.0 build using these qtest commands:
>> https://paste.debian.net/plain/1146089
>> (not including them here, as some are quite long)
>>
>> wget https://paste.debian.net/plain/1146089 -O qtest-trace; ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc-q35-5.0  -device virtio-rng-pci,addr=04.0 -display none -nodefaults -nographic -qtest stdio < qtest-trace
> 
> Nice work.
> 
> If I use directly "curl https://paste.debian.net/plain/1146089 |
> qemu-system-i386 ..." I have only a warning:
> 
>     qemu-system-i386: Guest moved used index from 0 to 496
> 
> I've added some traces.
> 
> The assert is triggered because addr (0xffff0) >= cache->len (0x11d0).
> 
> addr is 2nd argument of:
> 
>     address_space_read_cached(cache, i * sizeof(VRingDesc),
>                               desc, sizeof(VRingDesc));
> 
> and "i" appears to be "65535".
> 
> In virtqueue_split_read_next_desc(), the value is checked not to be
> greater than max.
> 
> But max is 268345360...
> 
> "max" is provided by virtqueue_split_get_avail_bytes(), it's originally
> vq->vring.num (255), but in the case of VRING_DESC_F_INDIRECT max is
> updated to "desc.len / sizeof(VRingDesc)". desc.len is 4293525760.
> 
> It is set from max to cache->len by address_space_cache_init() but this
> value seems to be truncated in the next iteration of the loop (where we
> have the assert()).
> 
> I'm investigating why we have that.

The problem is in virtqueue_split_get_avail_bytes().

On start, max is set to vq->vring.num (255), then in the
virtqueue_get_head() loop we read an indirect descriptor and max is set
to desc.len / sizeof(VRingDesc) (268345360). cache->len is
indirect_desc_cache.len, initialized from desc_len. So it is fine.

But after that desc is consumed by virtqueue_split_read_next_desc() and
then indirect_desc_cache is destroyed by address_space_cache_destroy(),
but max is not reset and used to check the next access with a new desc
that has a different size.

I think max should be reset when the cache is destroyed or set at the
begining of the loop.

Something like:

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b6c8ef5bc025..f6d90a99e5e4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1001,7 +1001,6 @@ static void
virtqueue_split_get_avail_bytes(VirtQueue *vq,
     idx = vq->last_avail_idx;
     total_bufs = in_total = out_total = 0;

-    max = vq->vring.num;
     caches = vring_get_region_caches(vq);
     if (!caches) {
         goto err;
@@ -1013,6 +1012,7 @@ static void
virtqueue_split_get_avail_bytes(VirtQueue *vq,
         VRingDesc desc;
         unsigned int i;

+        max = vq->vring.num;
         num_bufs = total_bufs;

         if (!virtqueue_get_head(vq, idx++, &i)) {

Thanks,
Laurent


