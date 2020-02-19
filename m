Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7678C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA5121D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkPgqRxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA5121D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Kxd-0000SL-OU
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 03:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j4Kx0-0008SB-JM
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j4Kwz-0007ou-6h
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:43:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28137
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j4Kwz-0007lS-2v
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582101799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gDQnqyzfLM7EgCtTxtaE9d5cXdYp+pKkorE5erdIEsg=;
 b=BkPgqRxnDYxkqLvfNoChRgp3gRRnOBEO1jLZxqYjYKunwFjNsOZUz7az2oyDLbrLZsnh8C
 Arh5G7t+9BZrcu0L20GkRkur9u5cQBfUAiefYUFE5Yd1io4VyDyvhoosMJXjQG+QWCvqAo
 5gPdkcIVZ8+Z0wedC+C446Qa6AxV9Yk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-LxRHSP3lO3O99F-4z2sGAQ-1; Wed, 19 Feb 2020 03:43:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03A5318CA242;
 Wed, 19 Feb 2020 08:43:16 +0000 (UTC)
Received: from [10.36.116.151] (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A86428B570;
 Wed, 19 Feb 2020 08:43:03 +0000 (UTC)
Subject: Re: [PATCH v2 fixed 01/16] util: vfio-helpers: Factor out and fix
 processing of existing ram blocks
To: Peter Xu <peterx@redhat.com>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-2-david@redhat.com> <20200218220001.GE7090@xz-x1>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <88dcdda3-e9a9-ca46-3e53-ab5b8d2d0936@redhat.com>
Date: Wed, 19 Feb 2020 09:43:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218220001.GE7090@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: LxRHSP3lO3O99F-4z2sGAQ-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18.02.20 23:00, Peter Xu wrote:
> On Wed, Feb 12, 2020 at 02:42:39PM +0100, David Hildenbrand wrote:
>> Factor it out into common code when a new notifier is registered, just
>> as done with the memory region notifier. This allows us to have the
>> logic about how to process existing ram blocks at a central place (which
>> will be extended soon).
>>
>> Just like when adding a new ram block, we have to register the max_lengt=
h
>> for now. We don't have a way to get notified about resizes yet, and some
>> memory would not be mapped when growing the ram block.
>>
>> Note: Currently, ram blocks are only "fake resized". All memory
>> (max_length) is accessible.
>>
>> We can get rid of a bunch of functions in stubs/ram-block.c . Print the
>> warning from inside qemu_vfio_ram_block_added().

[...]

>>  #include "exec/ramlist.h"
>>  #include "exec/cpu-common.h"
>> =20
>> -void *qemu_ram_get_host_addr(RAMBlock *rb)
>> -{
>> -    return 0;
>> -}
>> -
>> -ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
>> -{
>> -    return 0;
>> -}
>> -
>> -ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
>> -{
>> -    return 0;
>> -}
>=20
> Maybe put into another patch?
>=20
> Actually I'm thinking whether it would worth to do...  They're still
> declared in include/exec/cpu-common.h, so logically who includes the
> header but linked against stubs can still call this function.  So
> keeping them there still make sense to me.

Why keep dead code around? If you look closely, the stubs really only
contain what's strictly necessary to make current code compile, not any
available ramblock related function.

I don't see a good reason for a separate patch either (after all, we're
removing the last users in this patch), but if more people agree, I can
move it to a separate patch.
[...]

>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>> index 813f7ec564..71e02e7f35 100644
>> --- a/util/vfio-helpers.c
>> +++ b/util/vfio-helpers.c
>> @@ -376,8 +376,13 @@ static void qemu_vfio_ram_block_added(RAMBlockNotif=
ier *n,
>>                                        void *host, size_t size)
>>  {
>>      QEMUVFIOState *s =3D container_of(n, QEMUVFIOState, ram_notifier);
>> +    int ret;
>> +
>>      trace_qemu_vfio_ram_block_added(s, host, size);
>> -    qemu_vfio_dma_map(s, host, size, false, NULL);
>> +    ret =3D qemu_vfio_dma_map(s, host, size, false, NULL);
>> +    if (ret) {
>> +        error_report("qemu_vfio_dma_map(%p, %zu) failed: %d", host, siz=
e, ret);
>> +    }
>=20
> Irrelevant change (another patch)?

This is the error that was printed in qemu_vfio_init_ramblock(). Not
moving it in this patch would mean we would stop printing the error.
[...]

>> -
>>  static void qemu_vfio_open_common(QEMUVFIOState *s)
>>  {
>>      qemu_mutex_init(&s->lock);
>>      s->ram_notifier.ram_block_added =3D qemu_vfio_ram_block_added;
>>      s->ram_notifier.ram_block_removed =3D qemu_vfio_ram_block_removed;
>> -    ram_block_notifier_add(&s->ram_notifier);
>>      s->low_water_mark =3D QEMU_VFIO_IOVA_MIN;
>>      s->high_water_mark =3D QEMU_VFIO_IOVA_MAX;
>> -    qemu_ram_foreach_block(qemu_vfio_init_ramblock, s);
>> +    ram_block_notifier_add(&s->ram_notifier);
>=20
> Pure question: this looks like a good improvement, however do you know
> why HAX and SEV do not need to init ramblock?

They register very early (e.g., at accel init time), before any ram
blocks are added.

Thanks for your review!

--=20
Thanks,

David / dhildenb


