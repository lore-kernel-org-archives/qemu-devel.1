Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8A3C35642
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B6320722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sx+lf2Uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B6320722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j53zz-0004e5-Tp
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 03:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j53zP-0004Cm-As
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j53zN-00026Y-7I
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:48:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44161
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j53zM-000254-MY
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582274927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T8urZ3eCHTvd3P6xdmVzv7PhFCKWdxAqc+XDRDbdeYg=;
 b=Sx+lf2UvVEM48OwPyHlAGQh2ejt1pM7I32EI15sWgiBjs3lWWFmiggp2cr4zGb9uCIat9y
 L1hGFfUbqfS65I37JVDK2K/x/PFuog+AJ0mbmiI4Htsds7Q2fXsvdHiOAyEt+DEHIcieik
 1YNwkOBc1JGK7nwb+xAo0TJ0HhWU5BQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-vM6xop_DMLC4xEjh1hKSfA-1; Fri, 21 Feb 2020 03:48:44 -0500
X-MC-Unique: vM6xop_DMLC4xEjh1hKSfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1799D184B121;
 Fri, 21 Feb 2020 08:48:43 +0000 (UTC)
Received: from [10.36.117.197] (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E10A26FAA;
 Fri, 21 Feb 2020 08:48:38 +0000 (UTC)
Subject: Re: [PATCH v1 13/13] migrate/ram: Tolerate partially changed mappings
 in postcopy code
To: Peter Xu <peterx@redhat.com>
References: <20200219161725.115218-1-david@redhat.com>
 <20200219161725.115218-14-david@redhat.com>
 <9887ef65-12b1-37d5-cbf3-fda0b7d7fda7@redhat.com>
 <20200220210712.GA18283@xz-x1>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <76b62d2a-6045-221f-936d-2abf901e5f41@redhat.com>
Date: Fri, 21 Feb 2020 09:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220210712.GA18283@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.02.20 22:07, Peter Xu wrote:
> On Thu, Feb 20, 2020 at 12:24:42PM +0100, David Hildenbrand wrote:
>> On 19.02.20 17:17, David Hildenbrand wrote:
>>> When we partially change mappings (e.g., mmap over parts of an existing
>>> mmap) where we have a userfaultfd handler registered, the handler will
>>> implicitly be unregistered from the parts that changed. This is e.g., t=
he
>>> case when doing a qemu_ram_remap(), but is also a preparation for RAM
>>> blocks with resizable allocations and we're shrinking RAM blocks.
>>>
>>> When the mapping is changed and the handler is removed, any waiters are
>>> woken up. Trying to place pages will fail. We can simply ignore erors
>>> due to that when placing pages - as the mapping changed on the migratio=
n
>>> destination, also the content is stale. E.g., after shrinking a RAM
>>> block, nobody should be using that memory. After doing a
>>> qemu_ram_remap(), the old memory is expected to have vanished.
>>>
>>> Let's tolerate such errors (but still warn for now) when placing pages.
>>> Also, add a comment why unregistering will continue to work even though
>>> the mapping might have changed.
>>>
>>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>> Cc: Juan Quintela <quintela@redhat.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  migration/postcopy-ram.c | 43 ++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 37 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>>> index c68caf4e42..df9d27c004 100644
>>> --- a/migration/postcopy-ram.c
>>> +++ b/migration/postcopy-ram.c
>>> @@ -506,6 +506,13 @@ static int cleanup_range(RAMBlock *rb, void *opaqu=
e)
>>>      range_struct.start =3D (uintptr_t)host_addr;
>>>      range_struct.len =3D length;
>>> =20
>>> +    /*
>>> +     * In case the mapping was partially changed since we enabled user=
fault
>>> +     * (esp. when whrinking RAM blocks and we have resizable allocatio=
ns, or
>>> +     * via qemu_ram_remap()), the userfaultfd handler was already remo=
ved for
>>> +     * the mappings that changed. Unregistering will, however, still w=
ork and
>>> +     * ignore mappings without a registered handler.
>>> +     */
>>>      if (ioctl(mis->userfault_fd, UFFDIO_UNREGISTER, &range_struct)) {
>>>          error_report("%s: userfault unregister %s", __func__, strerror=
(errno));
>>> =20
>>> @@ -1239,10 +1246,28 @@ int postcopy_place_page(MigrationIncomingState =
*mis, void *host, void *from,
>>>       */
>>>      if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize, r=
b)) {
>>>          int e =3D errno;
>>> -        error_report("%s: %s copy host: %p from: %p (size: %zd)",
>>> -                     __func__, strerror(e), host, from, pagesize);
>>> =20
>>> -        return -e;
>>> +        /*
>>> +         * When the mapping gets partially changed before we try to pl=
ace a page
>>> +         * (esp. when whrinking RAM blocks and we have resizable alloc=
ations, or
>>> +         * via qemu_ram_remap()), the userfaultfd handler will be remo=
ved and
>>> +         * placing pages will fail. In that case, any waiter was alrea=
dy woken
>>> +         * up when the mapping was changed. We can safely ignore this,=
 as
>>> +         * mappings that change once we're running on the destination =
imply
>>> +         * that memory of these mappings vanishes. Let's still print a=
 warning
>>> +         * for now.
>>> +         *
>>
>> After talking to Andrea, on mapping changes, no waiter will be woken up
>> automatically. We have to do an UFFDIO_WAKE, which even works when there
>> is no longer a handler registered for that reason. Interesting stuff :)
>=20
> Yes actually it makes sense. :)
>=20
> Though I do think it should hardly happen, otherwise even if it's
> waked up it'll still try to access that GPA and KVM will be confused
> on that and exit because no memslot was setup for that.  Then I think
> it's a fatal VM error.  In other words, I feel like the resizing
> should be blocked somehow by that stall vcpu too (e.g., even if we
> want to reboot a Linux guest, it'll sync between vcpus, and same to
> bootstraping).

I am actually not concerned about KVM. More about some QEMU thread that
accesses bad RAM block state. With resizable allocations that thread
would get a segfault - here it could happen that it simply waits
forever. I guess a segfault would be better to debug than some thread
being stuck waiting for a uffd.

I do agree that this might be very rare (IOW, a BUG in the code :) ).
And we might skip the wakeup for now. But we should set the page
received in the bitmap, even if placement failed due to changed mappings.

Resizes are properly synchronized with KVM suing memory listeners. E.g.,
with resizable allocations, we will only shrink the RAM block *after*
the kvm slots where modified. (resizing kvm slots while VCPUs are in KVM
is a different problem to solve on my side :) )

>=20
> Btw, I feel like we cannot always depend on the fact that userfaultfd
> will dissapear itself if the VMA is unmapped, because even it's true
> it'll only be true for shrinking of memories.  How about extending
> memory in the future?  So IIUC if we want to really fix this, we

As far as I understood, growing works as designed.

1. Destination VM started and initialized.
2. Precopy data is loaded
- RAM block sizes will be synchronized to the source.
3. Guest starts running
- Any RAM block resize will differ to the source.

userfaultfd handlers will be registered just before 3. Growing in 3
means that we are bigger than the RAM block on the source. There is
nothing to migrate -> no usefaultfd handler (it would even be bad to
register one).

> probably need to take care of uffd register and unregister of changed
> memory regions, which AFAIUI can be done inside your newly introduced
> resize hook...

We have to be careful, because once we resize while the guest is
running, any resizes race with precopy code. Having that said, it should
not be necessary as far as I understand.
>=20
> We probably need to take care of other things that might be related to
> ramblock resizing too in the same notifier.  One I can think of is to
> realloc the ramblock.receivedmap otherwise we could have some bit
> cleared forever for shrinking memories (which logically when migration
> finishes that bitmap should be all set).

Realloc is not needed (as long as we keep allocating for max_length),
but eventually simply setting all bits of pages that are now outside of
used_length as received (which can be done atomically AFAIK, which is nice)=
.

Having that said, I am currently trying to test the postcopy stuff with
virtio-mem and resizable allocations. So stay tuned :)

Thanks a lot for your valuable feedback!

--=20
Thanks,

David / dhildenb


