Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30816C35DF8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAF221744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amtJrVDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAF221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Uue-00067j-3x
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6Utu-0005ZM-5B
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6Uts-0005Jg-KO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:45:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6Uts-0005JJ-GC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582616703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HSekG9h1VZuv19UhOpAI18iTecv4xc0A8MpA2VDeT0w=;
 b=amtJrVDpy1tfyWeuVAnHUwrkvrlsUYm/gcbDdH7tEhslLtEE3Iv1ztUiQjajS+o9E6KcXv
 /G3qDoOLtwBYYZxDp32BhSTzog2PD04XoNS0v8fzIZyD1OtbDS7zzRdhlf56AwJbs160aE
 SeB7IaNxDHwJNt//xMKDmcALB8tu4cM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-U6Kxl1fsOrys2WZaRd89CQ-1; Tue, 25 Feb 2020 02:45:02 -0500
X-MC-Unique: U6Kxl1fsOrys2WZaRd89CQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BDB6107ACCC;
 Tue, 25 Feb 2020 07:45:01 +0000 (UTC)
Received: from [10.36.117.12] (ovpn-117-12.ams2.redhat.com [10.36.117.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBA31390;
 Tue, 25 Feb 2020 07:44:56 +0000 (UTC)
Subject: Re: [PATCH v2 13/13] migration/ram: Tolerate partially changed
 mappings in postcopy code
To: Peter Xu <peterx@redhat.com>
References: <20200221164204.105570-1-david@redhat.com>
 <20200221164204.105570-14-david@redhat.com> <20200224224949.GE113102@xz-x1>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <531232dc-33f9-2c37-41a6-ef3899abd11a@redhat.com>
Date: Tue, 25 Feb 2020 08:44:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224224949.GE113102@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.02.20 23:49, Peter Xu wrote:
> On Fri, Feb 21, 2020 at 05:42:04PM +0100, David Hildenbrand wrote:
>> When we partially change mappings (esp., mmap over parts of an existing
>> mmap like qemu_ram_remap() does) where we have a userfaultfd handler
>> registered, the handler will implicitly be unregistered from the parts t=
hat
>> changed.
>>
>> Trying to place pages onto mappings where there is no longer a handler
>> registered will fail. Let's make sure that any waiter is woken up - we
>> have to do that manually.
>>
>> Let's also document how UFFDIO_UNREGISTER will handle this scenario.
>>
>> This is mainly a preparation for RAM blocks with resizable allcoations,
>> where the mapping of the invalid RAM range will change. The source will
>> keep sending pages that are outside of the new (shrunk) RAM size. We hav=
e
>> to treat these pages like they would have been migrated, but can
>> essentially simply drop the content (ignore the placement error).
>>
>> Keep printing a warning on EINVAL, to avoid hiding other (programming)
>> issues. ENOENT is unique.
>>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  migration/postcopy-ram.c | 37 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index c68caf4e42..f023830b9a 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -506,6 +506,12 @@ static int cleanup_range(RAMBlock *rb, void *opaque=
)
>>      range_struct.start =3D (uintptr_t)host_addr;
>>      range_struct.len =3D length;
>> =20
>> +    /*
>> +     * In case the mapping was partially changed since we enabled userf=
ault
>> +     * (e.g., via qemu_ram_remap()), the userfaultfd handler was alread=
y removed
>> +     * for the mappings that changed. Unregistering will, however, stil=
l work
>> +     * and ignore mappings without a registered handler.
>> +     */
>=20
> Ideally we should still only unregister what we have registered.
> After all we do have this information because we know what we
> registered, we know what has unmapped (in your new resize() hook, when
> postcopy_state=3D=3DRUNNING).

Not in the case of qemu_ram_remap(). And whatever you propose will
require synchronization (see my other mail) and more complicated
handling than this. uffd allows you to handle races with mmap changes in
a very elegant way (e.g., -ENOENT, or unregisterignoring changed mappings).

>=20
> An extreme example is when we register with pages in range [A, B),
> then shrink it to [A, C), then we mapped something else within [C, B)
> (note, with virtio-mem logically B can be very big and C can be very
> small, it means [B, C) can cover quite some address space). Then if:
>=20
>   - [C, B) memory type is not compatible with uffd, or

That will never happen in the near future. Without resizable allocations:
- All memory is either anonymous or from a single fd

In addition, right now, only anonymous memory can be used for resizable
RAM. However, with resizable allocations we could have:
- All used_length memory is either anonymous or from a single fd
- All remaining memory is either anonymous or from a single fd

Everything else does not make any sense IMHO and I don't think this is
relevant long term. You cannot arbitrarily map things into the
used_length part of a RAMBlock. That would contradict to its page_size
and its fd. E.g., you would break qemu_ram_remap().

>=20
>   - [C, B) could be registered with uffd again due to some other
>     reason (so far QEMU should not have such a reason)

Any code that wants to make use of uffd properly has to synchronize
against postcopy code either way IMHO. It just doesn't work otherwise.

E.g., once I would use it to protect unplugged memory in virtio-mem
(something I am looking into right now and teaching QEMU not to touch
all RAMBlock memory is complicated :) ), virtio-mem would unregister any
uffd handler when notified that postcopy will start, and re-register
after postcopy finished.

[...]


>> =20
>> +static int qemu_ufd_wake_ioctl(int userfault_fd, void *host_addr,
>> +                               uint64_t pagesize)
>> +{
>> +    struct uffdio_range range =3D {
>> +        .start =3D (uint64_t)(uintptr_t)host_addr,
>> +        .len =3D pagesize,
>> +    };
>> +
>> +    return ioctl(userfault_fd, UFFDIO_WAKE, &range);
>> +}
>> +
>>  static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
>>                                 void *from_addr, uint64_t pagesize, RAMB=
lock *rb)
>>  {
>> @@ -1198,6 +1215,26 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, =
void *host_addr,
>>          zero_struct.mode =3D 0;
>>          ret =3D ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
>>      }
>> +
>> +    /*
>> +     * When the mapping gets partially changed (e.g., qemu_ram_remap())=
 before
>> +     * we try to place a page, the userfaultfd handler will be removed =
for the
>> +     * changed mappings and placing pages will fail. We can safely igno=
re this,
>> +     * because mappings that changed on the destination don't need data=
 from the
>> +     * source (e.g., qemu_ram_remap()). Wake up any waiter waiting for =
that page
>> +     * (unlikely but possible). Waking up waiters is always possible, e=
ven
>> +     * without a registered userfaultfd handler.
>> +     *
>> +     * Old kernels report EINVAL, new kernels report ENOENT in case the=
re is
>> +     * no longer a userfaultfd handler for a mapping.
>> +     */
>> +    if (ret && (errno =3D=3D ENOENT || errno =3D=3D EINVAL)) {
>> +        if (errno =3D=3D EINVAL) {
>> +            warn_report("%s: Failed to place page %p. Waking up any wai=
ters.",
>> +                         __func__, host_addr);
>> +        }
>> +        ret =3D qemu_ufd_wake_ioctl(userfault_fd, host_addr, pagesize);
>=20
> ... if with above information (takes notes on where we registered
> uffd), I think we don't need to capture error, but we can simply skip
> those outliers.

I think we could skip them in general. Nobody should be touching that
memory. But debugging e.g., a SEGFAULT is easier than debugging some
sleeping thread IMHO.

--=20
Thanks,

David / dhildenb


