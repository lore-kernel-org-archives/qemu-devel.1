Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C67C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDDC20836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJfpSx1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDDC20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Evd-0005YP-OX
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6Etp-0002ty-3k
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6Etn-0006w6-R5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:39:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6Etn-0006w2-Mz
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582555195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jMQBoPoaWNSt6FdYseFxhc0p+qR1q6ZAOXBg+SqvIV4=;
 b=UJfpSx1ddCuiKJwOjRVDcCVw9H6NtwMnEN/6N84b3qjes9ac5Zi3Kb+rOMMnjEywuXcXG2
 R7RDm5GHcX/wBv+hA+0pJTcOa87LX6T655iKgLVi59BC2wCds+X3lZzp69fqXCMnSk9Spn
 zPG25i91TSvT0E7eLEPpDBIG2FwpIQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-KxAEYSpePwmqOLECMO9X6w-1; Mon, 24 Feb 2020 09:39:53 -0500
X-MC-Unique: KxAEYSpePwmqOLECMO9X6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7365C800D53;
 Mon, 24 Feb 2020 14:39:52 +0000 (UTC)
Received: from [10.36.118.193] (unknown [10.36.118.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 539B319C7F;
 Mon, 24 Feb 2020 14:39:39 +0000 (UTC)
Subject: Re: [PATCH v2 fixed 08/16] util/mmap-alloc: Factor out calculation of
 pagesize to mmap_pagesize()
To: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.ibm.com>
References: <20200212134254.11073-1-david@redhat.com>
 <7252629e-6290-5709-ea3c-d215622975ed@redhat.com>
 <3378805.CNlBlhNnSm@kermit.br.ibm.com> <4591604.1lD6THJHVr@kermit.br.ibm.com>
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
Message-ID: <98368fff-825d-c081-b52b-4c12aa8ed63b@redhat.com>
Date: Mon, 24 Feb 2020 15:39:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4591604.1lD6THJHVr@kermit.br.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
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
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.02.20 15:25, Murilo Opsfelder Ara=FAjo wrote:
> On Monday, February 24, 2020 11:16:16 AM -03 Murilo Opsfelder Ara=FAjo wr=
ote:
>> On Monday, February 24, 2020 7:57:03 AM -03 David Hildenbrand wrote:
>>> On 24.02.20 11:50, David Hildenbrand wrote:
>>>> On 19.02.20 23:46, Peter Xu wrote:
>>>>> On Wed, Feb 12, 2020 at 02:42:46PM +0100, David Hildenbrand wrote:
>>>>>> Factor it out and add a comment.
>>>>>>
>>>>>> Reviewed-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
>>>>>> Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>>>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>>> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>>>>>> Cc: Greg Kurz <groug@kaod.org>
>>>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>>>>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>> ---
>>>>>>
>>>>>>  util/mmap-alloc.c | 21 ++++++++++++---------
>>>>>>  1 file changed, 12 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
>>>>>> index 27dcccd8ec..82f02a2cec 100644
>>>>>> --- a/util/mmap-alloc.c
>>>>>> +++ b/util/mmap-alloc.c
>>>>>> @@ -82,17 +82,27 @@ size_t qemu_mempath_getpagesize(const char
>>>>>> *mem_path)
>>>>>>
>>>>>>      return qemu_real_host_page_size;
>>>>>>
>>>>>>  }
>>>>>>
>>>>>> +static inline size_t mmap_pagesize(int fd)
>>>>>> +{
>>>>>> +#if defined(__powerpc64__) && defined(__linux__)
>>>>>> +    /* Mappings in the same segment must share the same page size *=
/
>>>>>> +    return qemu_fd_getpagesize(fd);
>>>>>> +#else
>>>>>> +    return qemu_real_host_page_size;
>>>>>> +#endif
>>>>>> +}
>>>>>
>>>>> Pure question: This will return 4K even for huge pages on x86, is thi=
s
>>>>> what we want?
>>>>
>>>> (was asking myself the same question) I *think* it's intended. It's
>>>> mainly only used to allocate one additional guard page. The callers of
>>>> qemu_ram_mmap() make sure that the size is properly aligned (e.g., to
>>>> huge pages).
>>>>
>>>> Of course, a 4k guard page is sufficient - unless we can't use that
>>>> (special case for ppc64 here).
>>>>
>>>> Thanks!
>>>
>>> We could rename the function to mmap_guard_pagesize(), thoughts?
>>
>> The existing qemu_fd_getpagesize() already returns qemu_real_host_page_s=
ize
>> for non-anonymous mappings (when fd =3D=3D -1).  I think this new
>> mmap_pagesize() could be dropped in favor of qemu_fd_getpagesize().
>=20
> s/non-//
>=20
> I mean "for anonymous mappings".
>=20
>>
>> A side effect of this change would be guard page using a bit more memory=
 for
>> non-anonymous mapping.  Could that be a problem?
>>
>> What do you think?

At least under Linux it won't be an issue I guess. The same is probably
true for other OSs as well - the memory is not even readable, so why
should it consume memory. So it will only consume space in the virtual
address space.

Anyone reading along wants to object?

--=20
Thanks,

David / dhildenb


