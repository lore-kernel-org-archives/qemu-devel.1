Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EC8C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FEB206F8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPk68vPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FEB206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHn7G-0007t2-Vn
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jHn6e-0007DV-MF
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jHn6c-0006fE-3f
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:24:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jHn6c-0006bM-04
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585308293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1YESa4ia4jr2x5Nt+u7QABacIQQCwS7PRuut+Zkwg14=;
 b=BPk68vPLqDqpkh2TCaD/Sqr4F6dFilPxrqbBo3V4n9iQZHE53m04XR8yfGy7uMOoTv7dgy
 dugiA6TKWFilS30pXJm5lUzi5kkoGS5WCGzCS95bbUj/TXArO2sIY+n+tJkr0QGl8XvFxC
 7qdWiz3sPA8xHRpgC1GPCy4Gd4/7Pn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-JWH4kiPvOaif0Jo2nCzOsw-1; Fri, 27 Mar 2020 07:24:51 -0400
X-MC-Unique: JWH4kiPvOaif0Jo2nCzOsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A03F800D48;
 Fri, 27 Mar 2020 11:24:50 +0000 (UTC)
Received: from [10.36.112.108] (ovpn-112-108.ams2.redhat.com [10.36.112.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F05495C1D6;
 Fri, 27 Mar 2020 11:24:41 +0000 (UTC)
Subject: Re: [PATCH v4 15/15] exec: Ram blocks with resizeable anonymous
 allocations under POSIX
To: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.ibm.com>
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-16-david@redhat.com>
 <17423492.TemvMP7ggL@kermit.br.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <1ecbcba0-99bc-00f0-0cd1-5b83b54caa75@redhat.com>
Date: Fri, 27 Mar 2020 12:24:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <17423492.TemvMP7ggL@kermit.br.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.03.20 16:34, Murilo Opsfelder Ara=FAjo wrote:
> On Thursday, March 5, 2020 11:29:45 AM -03 David Hildenbrand wrote:
>> We can now make use of resizeable anonymous allocations to implement
>> actually resizeable ram blocks. Resizeable anonymous allocations are
>> not implemented under WIN32 yet and are not available when using
>> alternative allocators. Fall back to the existing handling.
>>
>> We also have to fallback to the existing handling in case any ram block
>> notifier does not support resizing (esp., AMD SEV, HAX) yet. Remember
>> in RAM_RESIZEABLE_ALLOC if we are using resizeable anonymous allocations=
.
>>
>> Try to grow early, as that can easily fail if out of memory. Shrink late
>> and ignore errors (nothing will actually break). Warn only.
>>
>> The benefit of actually resizeable ram blocks is that e.g., under Linux,
>> only the actual size will be reserved (even if
>> "/proc/sys/vm/overcommit_memory" is set to "never"). Additional memory w=
ill
>> be reserved when trying to resize, which allows to have ram blocks that
>> start small but can theoretically grow very large.
>>
>> Note1: We are not able to create resizeable ram blocks with pre-allocate=
d
>>        memory yet, so prealloc is not affected.
>> Note2: mlock should work as it used to as os_mlock() does a
>>        mlockall(MCL_CURRENT | MCL_FUTURE), which includes future
>>        mappings.
>> Note3: Nobody should access memory beyond used_length. Memory notifiers
>>        already properly take care of this, only ram block notifiers
>>        violate this constraint and, therefore, have to be special-cased.
>>        Especially, any ram block notifier that might dynamically
>>        register at runtime (e.g., vfio) has to support resizes. Add an
>>        assert for that. Both, HAX and SEV register early, so they are
>>        fine.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: Stefan Weil <sw@weilnetz.de>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  exec.c                    | 65 ++++++++++++++++++++++++++++++++++++---
>>  hw/core/numa.c            |  7 +++++
>>  include/exec/cpu-common.h |  2 ++
>>  include/exec/memory.h     |  8 +++++
>>  4 files changed, 77 insertions(+), 5 deletions(-)
>>
>> diff --git a/exec.c b/exec.c
>> index 9c3cc79193..6c6b6e12d2 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -2001,6 +2001,16 @@ void qemu_ram_unset_migratable(RAMBlock *rb)
>>      rb->flags &=3D ~RAM_MIGRATABLE;
>>  }
>>
>> +bool qemu_ram_is_resizeable(RAMBlock *rb)
>> +{
>> +    return rb->flags & RAM_RESIZEABLE;
>> +}
>> +
>> +bool qemu_ram_is_resizeable_alloc(RAMBlock *rb)
>> +{
>> +    return rb->flags & RAM_RESIZEABLE_ALLOC;
>> +}
>> +
>>  /* Called with iothread lock held.  */
>>  void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceSt=
ate
>> *dev) {
>> @@ -2094,6 +2104,7 @@ static void qemu_ram_apply_settings(void *host, si=
ze_t
>> length) */
>>  int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>>  {
>> +    const bool shared =3D block->flags & RAM_SHARED;
>=20
> Do you think a new function, for example, qemu_ram_is_shared() would be
> welcome to check for RAM_SHARED flag as well?  Similar to what is done
> in qemu_ram_is_resizeable() and qemu_ram_is_resizeable_alloc().

We have that one already, and I'll just reuse it :)

Thanks!

>=20
> Apart from that,
>=20
> Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>=20

--=20
Thanks,

David / dhildenb


