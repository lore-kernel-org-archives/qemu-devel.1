Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2E1C3B19F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9562082F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5iOY6mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9562082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2e7j-0007ZS-7B
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 11:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j2e6c-00072H-2B
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j2e6Y-0002B7-PX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:46:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j2e6Y-0002Ah-KN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581698773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uR1QYL9EYKr06KpAp/sxn/0VZDj4OiTUR/IJPY9zq+M=;
 b=W5iOY6mu6OW0HbWeuefmaPJsaF+f0k8nNFwZOV1JZ+1Iqc6Kk07oGz1yH+4XgrwmCd7d8q
 EEQHbDkMN0e3w7xIt/eJcJyVLGy5pVnt5SUs/W8nbkvjr1i47CFGhSN4YTmoM9i/pIdrzu
 /xeABTE72iNAkuP9T5sLpDKne1t5dr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-X7ny7-1CMOqNIijx8NtU2Q-1; Fri, 14 Feb 2020 11:46:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC71C18C43C8;
 Fri, 14 Feb 2020 16:46:06 +0000 (UTC)
Received: from [10.36.118.137] (unknown [10.36.118.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7603F8AC4B;
 Fri, 14 Feb 2020 16:45:58 +0000 (UTC)
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
To: Peter Xu <peterx@redhat.com>
References: <20200213172016.196609-1-david@redhat.com>
 <20200213183221.GD1103216@xz-x1>
 <97821f63-bfdc-6342-bb8d-3d2b89c809fc@redhat.com>
 <20200213205636.GE1103216@xz-x1>
 <31872803-15d2-ca70-b750-c08e0fcbd25f@redhat.com>
 <20200214155623.GA1163818@xz-x1>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <e013b2f1-7153-323f-33d7-f6f3af985fe8@redhat.com>
Date: Fri, 14 Feb 2020 17:45:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214155623.GA1163818@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: X7ny7-1CMOqNIijx8NtU2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

>> a) In precopy during the second migration.
>> b) In postcopy during the first migration.
>=20
> After reading your reply - even the 1st migration of precopy?  Say,
> when source QEMU resets and found changed FW during the precopy?

I think the FW will only change during migration (depends on the other
QEMU version) - but yeah, might be possible - no expert.

>=20
>>
>>>
>>> And is this patch trying to fix/warn when there's a reboot during (3)
>>> so the new size is discovered at a wrong time?  Is my understanding
>>> correct?
>>
>> It's trying to bail out early instead of failing at other random points
>> (with an unclear outcome).
>=20
> Yeah, I am just uncertain on whether in some cases it could be a
> silent success (when used_length changed, however migration still
> completed without error reported) and now we're changing it to a VM
> crash... Could that happen?
>=20
>   - before the patch, when precopy triggers this,
>=20
>     - when it didn't encounter issue with the changed used_length, it
>       could get silently ignored.  Lucky enough & good case.
>=20
>     - when it triggered an error, precopy failed.  _However_, we can
>       simply restart... so still not so bad.
>=20
>   - after the patch, when precopy detects this, we abort
>     immediately...  Which is really not good...

Se the other sub-thread (see below), we're thinking about canceling
pre-copy, which could work just fine.

>=20
> If you see, that's the major thing I was worrying about...
>=20
> And since used_length is growing in most cases as you said (at least
> before virtio-mem comes? :), I'm suspecting that could be the major

hah! :) The think about virtio-mem is that it can actually decide to not
resize during migration (and I have that implemented right now) - acpi
code can't.

> case that there will be a silent success.

The thing is, it might not be a silent success but a very strange
error/crash. We have a data race here. But yeah, I agree that we should
at least precopy not crashing.

>>>> In the precopy case it would be easier to abort (although, not simple
>>>> AFAIKS), in the postcopy not so easy - because you're already partiall=
y
>>>> running on the migration target.
>>>
>>> Prior to this patch, would a precopy still survive with such an
>>> accident (asked because I _feel_ like migrating a ramblock with
>>> smaller used_length to the same ramblock with bigger used_length seems
>>> to be fine?)?  Or we can stop the precopy and restart.  After this
>>
>> I assume growing the region is the usual case (not shrinking). FW blobs
>> tend to get bigger.
>>
>> Migrating while growing a ram block on the source won't work. The source
>> would try to send a dirt page that's outside of the used_length on the
>> target, making e.g., ram_load_postcopy()/ram_load_precopy() fail with
>> "Illegal RAM offset...".
>=20
> Right.
>=20
>>
>> In the postcopy case, e.g., ram_dirty_bitmap_reload() will fail in case
>> there is a mismatch between ram block size on source/target.
>=20
> IMHO that's an extreme rare case when (one example I can think of):
>=20
>   - we start a postcopy after a precopy
>   - system reset, noticed a firmware update
>   - we got a network failure, postcopy interrupted
>   - we try to recover a postcopy
>=20
> So are you using postcopy recovery?  I will be surprised if so because
> then you'll be the first user I know that really used that besides QE. :)

One of my strengths is to read code and find flaws :P
Good to know that that should be "barely" affected for now :)

>> Another issue is if the used_length changes while in ram_save_setup(),
>> just between storing ram_bytes_total_common(true) and storing
>> block->used_length. A mismatch will screw up the migration stream.
>=20
> Yes this seems to be another issue then.  IIUC the ramblocks are
> protected by RCU, the migration code has always been with the read
> lock there so logically it should see a consistent view of system
> ramblocks in ram_save_setup().  IMHO the thing that was inconsistent
> is that RCU is not safe enough for changing used_length for a ramblock.

Yes.

>=20
>>
>> But these are just the immediately visible issues. I am more concerned
>> about used_length changing at random points in time, resulting in more
>> harm. (e.g., non-obvious load-store tearing when accessing the used leng=
th)
>>
>> Migration code is inherently racy when it comes to ram block resizes.
>> And that might become more dangerous once we want to size the migration
>> bitmaps smaller (used_length instead of max_length) or disallow access
>> to ram blocks beyond the used_length. Both are things I am working on :)
>=20
> Right. Now I start to wonder whether migration is the only special guy
> here.  I noticed at least we've got:
>=20
> struct RAMBlockNotifier {
>     void (*ram_block_added)(RAMBlockNotifier *n, void *host, size_t size)=
;
>     void (*ram_block_removed)(RAMBlockNotifier *n, void *host, size_t siz=
e);
>     QLIST_ENTRY(RAMBlockNotifier) next;
> };
>=20
> I suspect at least all these users could also break in some way if
> resize happens.

Hah! You should read

https://lore.kernel.org/qemu-devel/20200212134254.11073-1-david@redhat.com/

:)

VFIO is indeed broken on resizes - and fixed in that series (I assume
nobody migrates ...). HAX and SEV simply pin all memory and don't care
about any used_length changes. The callbacks were for now called with
max_length, which works but is not extensible.

See my suggestion in

https://lore.kernel.org/qemu-devel/bb33b209-2b15-4bbd-7fe9-3aa813e4c194@red=
hat.com/

which builds up on a ram resize notifier.

>=20
>>
>>> patch, it'll crash the source VM (&error_abort specified in
>>> memory_region_ram_resize()), which seems a bit more harsh?
>>
>> There seems to be no easy way to abort migration from outside the
>> migration thread. As Juan said, you actually don't want to fail
>> migration but instead soft-abort migration and continue running the
>> guest on the target on a reset. But that's not easy as well.
>>
>> One could think about extending ram block notifiers to notify migration
>> code (before) resizes, so that migration code can work around the
>> resize (how is TBD). Not easy as well :)
>=20
> True.  But if you see my worry still stands, on whether such a patch
> would make things worse by crashing it when it could still have a
> chance to survive.  Shall we loose the penalty of that even if we want
> to warn the user earlier?

Canceling migration in precopy case should be fine. Postcopy needs more
thought.

I certainly don't want to live with strange data races in migration code
because "it could work sometimes eventually".

Thanks for all the comments and thoughts!

--=20
Thanks,

David / dhildenb


