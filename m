Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE54C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D8B2082F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rr5VzKjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D8B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2YqY-0007aN-7W
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 06:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j2Ypn-0006lO-Vy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j2Ypm-0001Qt-AX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:08:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j2Ypm-0001QH-5T
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581678513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L4Yp4odyPWQLxJ4lzkB4U6tuV93qX+S04F22LaAN4E8=;
 b=Rr5VzKjjkH4+1DcCwER0UsIUwVqH7eDQbouIvIvzdFYKGnswXFSCw6C9HDM7e+lx/uvYhf
 AWSQzYurlwlbcCzr40DloLgN2veCVRkf6sAsftdFzkvSkPLGAg0GoU8EmmJhk7/frNijCN
 WXFWX+1D/zoE6VV88HAf8pXUWRE/pgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-RdW_91dPNKmkL6t6rdbGLw-1; Fri, 14 Feb 2020 06:08:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C835E100550E;
 Fri, 14 Feb 2020 11:08:28 +0000 (UTC)
Received: from [10.36.118.137] (unknown [10.36.118.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96D778AC3E;
 Fri, 14 Feb 2020 11:08:23 +0000 (UTC)
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200213172016.196609-1-david@redhat.com>
 <20200214102514.GB3283@work-vm>
 <30a66b1d-184e-a684-d0d2-c3921366b478@redhat.com>
 <20200214104230.GC3283@work-vm>
 <cd295e35-72ca-e335-35be-f38bb9026e48@redhat.com>
 <20200214110226.GD3283@work-vm>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <9a15fd0e-77d1-b3a0-4824-665f85f79c71@redhat.com>
Date: Fri, 14 Feb 2020 12:08:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214110226.GD3283@work-vm>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: RdW_91dPNKmkL6t6rdbGLw-1
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
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14.02.20 12:02, Dr. David Alan Gilbert wrote:
> * David Hildenbrand (david@redhat.com) wrote:
>> On 14.02.20 11:42, Dr. David Alan Gilbert wrote:
>>> * David Hildenbrand (david@redhat.com) wrote:
>>>> On 14.02.20 11:25, Dr. David Alan Gilbert wrote:
>>>>> * David Hildenbrand (david@redhat.com) wrote:
>>>>>> Resizing while migrating is dangerous and does not work as expected.
>>>>>> The whole migration code works on the usable_length of ram blocks an=
d does
>>>>>> not expect this to change at random points in time.
>>>>>>
>>>>>> Precopy: The ram block size must not change on the source, after
>>>>>> ram_save_setup(), so as long as the guest is still running on the so=
urce.
>>>>>>
>>>>>> Postcopy: The ram block size must not change on the target, after
>>>>>> synchronizing the RAM block list (ram_load_precopy()).
>>>>>>
>>>>>> AFAIKS, resizing can be trigger *after* (but not during) a reset in
>>>>>> ACPI code by the guest
>>>>>> - hw/arm/virt-acpi-build.c:acpi_ram_update()
>>>>>> - hw/i386/acpi-build.c:acpi_ram_update()
>>>>>>
>>>>>> I see no easy way to work around this. Fail hard instead of failing
>>>>>> somewhere in migration code due to strange other reasons. AFAIKs, th=
e
>>>>>> rebuilts will be triggered during reboot, so this should not affect
>>>>>> running guests, but only guests that reboot at a very bad time and
>>>>>> actually require size changes.
>>>>>>
>>>>>> Let's further limit the impact by checking if an actual resize of th=
e
>>>>>> RAM (in number of pages) is required.
>>>>>>
>>>>>> Don't perform the checks in qemu_ram_resize(), as that's called duri=
ng
>>>>>> migration when syncing the used_length. Update documentation.
>>>>>
>>>>> Interesting; we need to do something about this - but banning resets
>>>>> during migration is a bit harsh; and aborting the source VM is really
>>>>> nasty - for a precopy especially we shouldn't kill the source VM,
>>>>> we should just abort the migration.
>>>>
>>>> Any alternative, easy solutions to handle this? I do wonder how often
>>>> this will actually trigger in real life.
>>>
>>> Well it's not that hard to abort a migration (I'm not sure we've got a
>>> convenient wrapper to do it - but it shouldn't be hard to add).
>>>
>>
>> We do have qmp_migrate_cancel(). I hope that can be called under BQL.
>=20
> Well it's a monitor command so I think so; although it's not really
> designed for an error - it's a user action.  Doing a
> migrate_set_error(..) followed by a qemu_file_shutdown is probably a
> good bet.

I'll base on "[PATCH v2 fixed 00/16] Ram blocks with resizable anonymous
allocations under POSIX", where I extend the ram block notifier with a
resize notification.

migrate/ram.c can register the notifier and react accordingly. E.g., for
precopy, abort migration. Not sure about postcopy (below).

>=20
>> Can that be called in both, precopy and postcopy case? I assume in the
>> precopy, it's easy.
>=20
> The problem is during postcopy you're toast when that happens because
> you can't restart; however, can this happen once we're actually in
> postcopy?  It's a little different - if it happens before the transition
> to postcopy then it's the same as precopy; if it happens afterwards..
> well it's going to happen ont he destination side and that's quite
> different.

If it happens after, we are in trouble at least with received bitmaps.
Not sure about other issues (it's a lot of code :) ). Especially
shrinking while trying to place pages will be bad and fail. It's code
that assumes used_length won't change.

ramblock_recv_bitmap_send() on the target and ram_dirty_bitmap_reload()
on the source. ram_dirty_bitmap_reload() will bail out if the sizes
don't match.

--=20
Thanks,

David / dhildenb


