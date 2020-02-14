Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F4C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086F62086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTuAd43h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086F62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2X6n-0000vM-89
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 04:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j2X6C-0000W7-Gj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j2X6A-0002oZ-Sv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:17:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57058
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j2X6A-0002nU-OM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581671841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PvUHtDeL9dQg9l6laqgRl7JrSu9KyqPAar6Nv0rMlNw=;
 b=iTuAd43h6qjorzveKH+AQCaMCU5/emdaa5dtciLJrVgrXuqJ2v1VCW/hNUQJCKTIU48r8v
 c0ldvB5OPEbXHjrxMoxloB7tZMgvoMzyHXlK4OAtSNKnKLkaTaK74i7UjwYEy1t2WlrXQz
 RU7yveNMFv5PtUm0uUpangW9bJoCCbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-6m6gl9BqPRWa-mqJDSgvKg-1; Fri, 14 Feb 2020 04:17:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AC8F800D48;
 Fri, 14 Feb 2020 09:17:18 +0000 (UTC)
Received: from [10.36.118.137] (unknown [10.36.118.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E85971001E91;
 Fri, 14 Feb 2020 09:17:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
To: Peter Xu <peterx@redhat.com>
References: <20200213172016.196609-1-david@redhat.com>
 <20200213183221.GD1103216@xz-x1>
 <97821f63-bfdc-6342-bb8d-3d2b89c809fc@redhat.com>
 <20200213205636.GE1103216@xz-x1>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <31872803-15d2-ca70-b750-c08e0fcbd25f@redhat.com>
Date: Fri, 14 Feb 2020 10:17:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213205636.GE1103216@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6m6gl9BqPRWa-mqJDSgvKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13.02.20 21:56, Peter Xu wrote:
> On Thu, Feb 13, 2020 at 08:42:23PM +0100, David Hildenbrand wrote:
>> On 13.02.20 19:32, Peter Xu wrote:
>>> On Thu, Feb 13, 2020 at 06:20:16PM +0100, David Hildenbrand wrote:
>>>> Resizing while migrating is dangerous and does not work as expected.
>>>> The whole migration code works on the usable_length of ram blocks and =
does
>>>> not expect this to change at random points in time.
>>>>
>>>> Precopy: The ram block size must not change on the source, after
>>>> ram_save_setup(), so as long as the guest is still running on the sour=
ce.
>>>>
>>>> Postcopy: The ram block size must not change on the target, after
>>>> synchronizing the RAM block list (ram_load_precopy()).
>>>>
>>>> AFAIKS, resizing can be trigger *after* (but not during) a reset in
>>>> ACPI code by the guest
>>>> - hw/arm/virt-acpi-build.c:acpi_ram_update()
>>>> - hw/i386/acpi-build.c:acpi_ram_update()
>>>
>>> What can be the pre-condition of triggering this after reset?  I'm
>>> thinking whether QEMU can be aware of this "resizing can happen"
>>> condition, then we could simply stop the migration from happening even
>>> before the resizing happens.  Thanks,
>>
>> I think the condition is not known before the guest actually tries to
>> read the relevant memory areas (which trigger the rebuilt+resize, and
>> AFAIK, the new size depends on fw config done by the guest after the
>> reset). So it's hard to "predict".
>=20
> I chimmed in without much context, sorry if I'm going to ask naive
> questions. :)

I think the problem is quite involved and not obvious, so there are no
naive questions :)

>=20
> What I was asking is about why the resizing can happen.  A quick read
> told me that it was majorly for easier extension of ROMs (firmware
> updates?).  With that, I'm imaging a common case for memory
> resizing...
>=20
>   (1) Source QEMU runs VM on old host, with old firmware
>=20
>   (2) Migrate source QEMU to destination new host, with new and bigger
>       firmware
>=20
>   (3) During the migration, the ROM size on the destination will still
>       be the old, referring to ram_load_precopy(), as long as no
>       system reset
>=20
>   (4) After migration finished, when the system reboots, memory
>       resizing happens with the new and bigger firmware loaded

AFAIK it could trigger

a) In precopy during the second migration.
b) In postcopy during the first migration.

>=20
> And is this patch trying to fix/warn when there's a reboot during (3)
> so the new size is discovered at a wrong time?  Is my understanding
> correct?

It's trying to bail out early instead of failing at other random points
(with an unclear outcome).

>>
>> In the precopy case it would be easier to abort (although, not simple
>> AFAIKS), in the postcopy not so easy - because you're already partially
>> running on the migration target.
>=20
> Prior to this patch, would a precopy still survive with such an
> accident (asked because I _feel_ like migrating a ramblock with
> smaller used_length to the same ramblock with bigger used_length seems
> to be fine?)?  Or we can stop the precopy and restart.  After this

I assume growing the region is the usual case (not shrinking). FW blobs
tend to get bigger.

Migrating while growing a ram block on the source won't work. The source
would try to send a dirt page that's outside of the used_length on the
target, making e.g., ram_load_postcopy()/ram_load_precopy() fail with
"Illegal RAM offset...".

In the postcopy case, e.g., ram_dirty_bitmap_reload() will fail in case
there is a mismatch between ram block size on source/target.

Another issue is if the used_length changes while in ram_save_setup(),
just between storing ram_bytes_total_common(true) and storing
block->used_length. A mismatch will screw up the migration stream.

But these are just the immediately visible issues. I am more concerned
about used_length changing at random points in time, resulting in more
harm. (e.g., non-obvious load-store tearing when accessing the used length)

Migration code is inherently racy when it comes to ram block resizes.
And that might become more dangerous once we want to size the migration
bitmaps smaller (used_length instead of max_length) or disallow access
to ram blocks beyond the used_length. Both are things I am working on :)

> patch, it'll crash the source VM (&error_abort specified in
> memory_region_ram_resize()), which seems a bit more harsh?

There seems to be no easy way to abort migration from outside the
migration thread. As Juan said, you actually don't want to fail
migration but instead soft-abort migration and continue running the
guest on the target on a reset. But that's not easy as well.

One could think about extending ram block notifiers to notify migration
code (before) resizes, so that migration code can work around the
resize (how is TBD). Not easy as well :)

But then, I am not sure
a) If we run into this issue in real life a lot.
b) If we actually need an elaborate solutions within QEMU to handle this
case. For now, it's sufficient to restart the VM on the migration
target. No data was lost. Not nice, but very simple.

Thanks!

--=20
Thanks,

David / dhildenb



