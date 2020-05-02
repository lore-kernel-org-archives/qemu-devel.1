Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763DCC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 08:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42150208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 08:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cz1+AfFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42150208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUnhI-00041P-FP
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 04:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jUngF-0002tE-5i
 for qemu-devel@nongnu.org; Sat, 02 May 2020 04:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jUngE-0001vR-IG
 for qemu-devel@nongnu.org; Sat, 02 May 2020 04:39:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jUngE-0001uw-1S
 for qemu-devel@nongnu.org; Sat, 02 May 2020 04:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588408765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zVUkRzyT4eMaB5Usiby70sKpM6qDBG2I7+RzyDlMTKk=;
 b=cz1+AfFfE+acXQMlenIqnujhcrTPFJOU/DsVlc7RgKagq4Z+xjfwuPnaUKgsjudPnPvVkU
 WODnt94B4XngiBJgfJ+ndksaPXfq1hobvaubiPmVaYPanOK0sT2LGdiMTlP2Hfa3R/QIA+
 khRlR0D8cDqF+ZibBEY1LEo2+0ileGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-OAdBvsWUPWuXdHRR4BxVWQ-1; Sat, 02 May 2020 04:39:18 -0400
X-MC-Unique: OAdBvsWUPWuXdHRR4BxVWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4276B872FE0;
 Sat,  2 May 2020 08:39:17 +0000 (UTC)
Received: from [10.36.112.72] (ovpn-112-72.ams2.redhat.com [10.36.112.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07BBE600F5;
 Sat,  2 May 2020 08:39:14 +0000 (UTC)
Subject: Re: [PATCH 08/17] s390x/cpumodel: Fix UI to CPU features
 pcc-cmac-{aes,eaes}-256
To: Markus Armbruster <armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-9-armbru@redhat.com>
 <7ed42e2f-e437-3d06-e46b-5416e4d2a6d3@redhat.com>
 <874kt0bzq8.fsf@dusky.pond.sub.org>
 <83638290-f00e-7d50-225b-efee0179ff9c@redhat.com>
 <87368i6eed.fsf@dusky.pond.sub.org>
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
Message-ID: <68f9c124-aeea-4369-52bf-3f4c7f579a64@redhat.com>
Date: Sat, 2 May 2020 10:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87368i6eed.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 04:39:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: berrange@redhat.com, ehabkost@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.05.20 08:26, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
>=20
>> On 30.04.20 20:22, Markus Armbruster wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 28.04.20 18:34, Markus Armbruster wrote:
>>>>> Both s390_features[S390_FEAT_PCC_CMAC_AES_256].name and
>>>>> s390_features[S390_FEAT_PCC_CMAC_EAES_256].name is
>>>>> "pcc-cmac-eaes-256".  The former is obviously a pasto.
>>>>>
>>>>> Impact:
>>>>>
>>>>> * s390_feat_bitmap_to_ascii() misidentifies S390_FEAT_PCC_CMAC_AES_25=
6
>>>>>   as "pcc-cmac-eaes-256".  Affects QMP commands query-cpu-definitions=
,
>>>>>   query-cpu-model-expansion, query-cpu-model-baseline,
>>>>>   query-cpu-model-comparison, and the error message when
>>>>>   s390_realize_cpu_model() fails in check_compatibility().
>>>>>
>>>>> * s390_realize_cpu_model() misidentifies it in check_consistency()
>>>>>   warnings.
>>>>>
>>>>> * s390_cpu_list() likewise.  Affects -cpu help.
>>>>>
>>>>> * s390_cpu_model_register_props() creates CPU property
>>>>>   "pcc-cmac-eaes-256" twice.  The second one fails, but the error is
>>>>>   ignored (a later commit will change that).  Results in a single
>>>>>   property "pcc-cmac-eaes-256" with the description for
>>>>>   S390_FEAT_PCC_CMAC_AES_256, and no property for
>>>>>   S390_FEAT_PCC_CMAC_EAES_256.  CPU properties are visible in CLI -cp=
u
>>>>>   and -device, QMP & HMP device_add, QMP device-list-properties, and
>>>>>   QOM introspection.
>>>>>
>>>>> Fix by deleting the wayward 'e'.
>>>>
>>>> Very nice catch - thanks!
>>>
>>> :)
>>>
>>>> While this sounds very bad, it's luckily not that bad in practice
>>>> (currently).
>>>>
>>>> The feature (or rather, both features) is part of the feature group
>>>> "msa4". As long as we have all sub-features part of that group (which =
is
>>>> usually the case), we will always indicate "msa4" to the user, instead
>>>> of all the separate sub-features. So, expansion, baseline, comparison
>>>> will usually only work with "msa4".
>>>>
>>>> (in addition, current KVM is not capable of actually masking off these
>>>> sub-features, so it will still, always see the feature, even if not
>>>> explicitly specified via "-cpu X,pcc-cmac-aes-256=3Don)
>>>
>>> Would you like to propose an commit message improvements?
>>
>> Maybe something like
>>
>> "Both affected features are part of the feature group msa4. In current
>> setups, we will always see the msa4 feature instead of the separate
>> contained sub-features (because all sub-features are around). Therefore,
>> both features are currently never passed from/to the user explicitly
>> (e.g., via cpu model expansion, comparison, baseline and '-cpu' setup)."
>>
>> Thanks!
>=20
> I think I can guess how this could work for reporting features (I
> haven't checked my guess against the code), which is what the
> query-cpu-model-* do: suppress individual features when their group is
> complete.

Yes. Expand the group to single features on user input, expand the
single features to the group on user output (if all features are enabled).

>=20
> But "'-cpu' setup" doesn't seem to be about reporting features.  Am I
> confused?
>=20

Let me clarify. Any user input would be broken if the two sub-features
would be specified explicitly, instead of the whole "msa4" group. This
applies to any user input, also the user input for query-cpu-model-.

In the usual cases, libvirt will expand a cpu model (e.g., "host",
"z15") and start QEMU with that (-cpu ...). We will only have the
complete msa4 group here in practice.

Yes, if some user would pick and chose such features manually, it would
be broken - it's just not the common on s390x with the huge amount of
features. But that's why I thing stable backports still make sense.

> While testing, I noticed that
>=20
>     $ s390x-softmmu/qemu-system-s390x
>=20
> flashes a window at me, then terminates successfully, without printing
> anything.  With -S, it behaves like other targets.  Bug?
>=20

Think this is expected.

t480s: ~  $ qemu-system-s390x --nographic
LOADPARM=3D[        ]
Could not find a suitable boot device (none specified)

The s390-ccw bios will come up, detect that there is nothing to boot and
quit. The bios can only print to the sclp console, not to a graphical
output.

What the others do (e.g., ppc64, x86_64) is boot the bios/firmware and
then halt there.

--=20
Thanks,

David / dhildenb


