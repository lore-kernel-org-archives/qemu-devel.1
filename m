Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URG_BIZ,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE0C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595F02086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9sOvR44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595F02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fh5-00019z-J4
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j2fgI-0008RG-8W
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j2fgG-0002D2-Ap
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:27:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30327
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j2fgG-0002Co-6R
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581704831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RJ1n3F05vlnmMhtJnFA1aDzyeUTrxe55Hsz4ENFGnp4=;
 b=K9sOvR44tXxoIkwBhMMlc2JLvpYzFkM2drCvnq4Y0LiVa7AbuqevxTPPblJBiGuW1I3+sT
 LiOPmHfbRi1XWVnnJVuz8b/wtfBijyFGR7zRXRz5NT0tcRFzJEQkJfw5SRhjPHTDCHWRSC
 EsCKQGPIuGmE8TlQpCWYNlrL/KAQiYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-BG523zJ7NQ68HLa_fFrlFw-1; Fri, 14 Feb 2020 13:27:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C28F8800D5C;
 Fri, 14 Feb 2020 18:27:08 +0000 (UTC)
Received: from [10.36.118.137] (unknown [10.36.118.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94571790D1;
 Fri, 14 Feb 2020 18:27:00 +0000 (UTC)
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
To: Peter Xu <peterx@redhat.com>
References: <20200213172016.196609-1-david@redhat.com>
 <20200214102514.GB3283@work-vm>
 <30a66b1d-184e-a684-d0d2-c3921366b478@redhat.com>
 <20200214104230.GC3283@work-vm>
 <cd295e35-72ca-e335-35be-f38bb9026e48@redhat.com>
 <20200214110226.GD3283@work-vm>
 <9a15fd0e-77d1-b3a0-4824-665f85f79c71@redhat.com>
 <bb33b209-2b15-4bbd-7fe9-3aa813e4c194@redhat.com>
 <20200214172933.GC1163818@xz-x1>
 <9597c9a9-05d2-d99d-e153-8ffc112910bc@redhat.com>
 <20200214181146.GE1163818@xz-x1>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <ab0c4b8f-c18b-cf02-282a-eb968bb6677e@redhat.com>
Date: Fri, 14 Feb 2020 19:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214181146.GE1163818@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: BG523zJ7NQ68HLa_fFrlFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14.02.20 19:11, Peter Xu wrote:
> On Fri, Feb 14, 2020 at 06:32:35PM +0100, David Hildenbrand wrote:
>> On 14.02.20 18:29, Peter Xu wrote:
>>> On Fri, Feb 14, 2020 at 01:02:46PM +0100, David Hildenbrand wrote:
>>>> From c0049ac2e95d6756037db918852c507fb88297d9 Mon Sep 17 00:00:00 2001
>>>> From: David Hildenbrand <david@redhat.com>
>>>> Date: Fri, 14 Feb 2020 13:01:03 +0100
>>>> Subject: [PATCH v1] tmp
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  migration/migration.c |  9 +++++++--
>>>>  migration/migration.h |  1 +
>>>>  migration/ram.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 50 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 3a21a4686c..0e7efe2920 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -175,13 +175,18 @@ void migration_object_init(void)
>>>>      }
>>>>  }
>>>> =20
>>>> +void migration_cancel(void)
>>>> +{
>>>> +    migrate_fd_cancel(current_migration);
>>>> +}
>>>> +
>>>>  void migration_shutdown(void)
>>>>  {
>>>>      /*
>>>>       * Cancel the current migration - that will (eventually)
>>>>       * stop the migration using this structure
>>>>       */
>>>> -    migrate_fd_cancel(current_migration);
>>>> +    migration_cancel();
>>>>      object_unref(OBJECT(current_migration));
>>>>  }
>>>> =20
>>>> @@ -2019,7 +2024,7 @@ void qmp_migrate(const char *uri, bool has_blk, =
bool blk,
>>>> =20
>>>>  void qmp_migrate_cancel(Error **errp)
>>>>  {
>>>> -    migrate_fd_cancel(migrate_get_current());
>>>> +    migration_cancel();
>>>>  }
>>>> =20
>>>>  void qmp_migrate_continue(MigrationStatus state, Error **errp)
>>>> diff --git a/migration/migration.h b/migration/migration.h
>>>> index 8473ddfc88..79fd74afa5 100644
>>>> --- a/migration/migration.h
>>>> +++ b/migration/migration.h
>>>> @@ -343,5 +343,6 @@ int foreach_not_ignored_block(RAMBlockIterFunc fun=
c, void *opaque);
>>>>  void migration_make_urgent_request(void);
>>>>  void migration_consume_urgent_request(void);
>>>>  bool migration_rate_limit(void);
>>>> +void migration_cancel(void);
>>>> =20
>>>>  #endif
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index ed23ed1c7c..f86f32b453 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -52,6 +52,7 @@
>>>>  #include "migration/colo.h"
>>>>  #include "block.h"
>>>>  #include "sysemu/sysemu.h"
>>>> +#include "sysemu/runstate.h"
>>>>  #include "savevm.h"
>>>>  #include "qemu/iov.h"
>>>>  #include "multifd.h"
>>>> @@ -3710,8 +3711,49 @@ static SaveVMHandlers savevm_ram_handlers =3D {
>>>>      .resume_prepare =3D ram_resume_prepare,
>>>>  };
>>>> =20
>>>> +static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host=
,
>>>> +                                      size_t old_size, size_t new_siz=
e)
>>>> +{
>>>> +    /*
>>>> +     * We don't care about resizes triggered on incoming migration (w=
hen
>>>> +     * syncing ram blocks), or of course, when no migration is going =
on.
>>>> +     */
>>>> +    if (migration_is_idle() || !runstate_is_running()) {
>>>> +        return;
>>>> +    }
>>>
>>> I feel like migration_is_idle() check is enough.  Firstly, I feel like
>>> we allow migration even with VM stopped.  At the meantime, if VM is
>>> not running, I see no reason that this resizing will happen after all? =
:)
>>
>> Migration code resizes ram blocks when synchronizing the ram state. See
>> qemu_ram_resize() in ram_load_precopy()
>>
>> That happens on incoming migration while the vm is stopped.
>=20
> Ah so your comment is for that which I misread.  I'm surprised even
> the incoming migration will set MigrationState and migration_is_idle()

I was already surprised by that :) And states are not well document
(IOW, not documented)

> will return false for it, since we've got MigrationIncomingState after
> all.  But yeh that seems to be correct.
>=20
> Then it seems fine.  It's just a bit unclear even with the comment.
> Another alternative is we only register this resize() hook when
> migration starts, and unregister it when stopped.  Then we can even
> drop the migration_is_idle().

Yeah, I prefer the current code because its simpler (and I don't have to
worry about races when registering/unregistering notifiers, because
locking in combination with migration is still a big puzzle to me)

I'll try to make the comment clearer, thanks!

>=20
>>
>>>
>>>> +
>>>> +    if (!postcopy_is_running()) {
>>>> +        Error *err =3D NULL;
>>>> +
>>>> +        /*
>>>> +         * Precopy code cannot deal with the size of ram blocks chang=
ing at
>>>> +         * random points in time. We're still running on the source, =
abort
>>>> +         * the migration and continue running here. Make sure to wait=
 until
>>>> +         * migration was canceled.
>>>> +         */
>>>> +        error_setg(&err, "RAM resized during precopy.");
>>>> +        migrate_set_error(migrate_get_current(), err);
>>>> +        error_free(err);
>>>> +        migration_cancel();
>>>> +    } else {
>>>> +        /*
>>>> +         * Postcopy code cannot deal with the size of ram blocks chan=
ging at
>>>> +         * random points in time. We're running on the target. Fail h=
ard.
>>>> +         *
>>>> +         * TODO: How to handle this in a better way?
>>>> +         */
>>>> +        error_report("RAM resized during postcopy.");
>>>> +        exit(-1);
>>>
>>> Now I'm rethinking the postcopy case....
>>>
>>> ram_dirty_bitmap_reload() should only happen during the postcopy
>>> recovery, and when that happens the VM should be stopped on both
>>> sides.  Which means, ram resizing should not trigger there...
>>
>> But that guest got the chance to run for a bit and eventually reboot
>> AFAIK. Also, there are other data races possible when used_length
>> suddenly changes, this is just the most obvious one where things will;
>> get screwed up.
>=20
> Right, the major one could be in ram_load_postcopy() where we call
> host_from_ram_block_offset().  However if FW extension is the major
> use case then it seems to still work (still better than crashing,
> isn't it? :).

"Let's close our eyes and hope it will never happen" ? :) No, I don't
like that. This screams for a better solution long term, and until then
a proper fencing IMHO. We're making here wild guesses about data races
and why they might not be that bad in certain cases (did I mention
load/store tearing? used_length is not an atomic value ...).

--=20
Thanks,

David / dhildenb


