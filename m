Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A01AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31ABD20786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OV+zqlzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31ABD20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJ05-00019S-Bi
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jJIyz-0008Kv-RG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jJIyy-0000Oy-DT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:39:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jJIyy-0000NF-81
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585669155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Gmnq5pcGWB04g6GZAPeqqSTgNcroVYBW7kBwmSeKed4=;
 b=OV+zqlzlbFYUSlx8jfWnPMPJ+S6PjnWM9o/65hPtMXpDNx2Geis5luPFJYRyK3y1cDp4Xk
 R93Pg2WVkd1XG9XdUfcTs9zNeDmKVeezHUCk0Z+VIZ5ozAnvCuHfgAoHqUexKNbHPUvvu1
 B9UXu9Bbn1guQzG+EdkXj8shJYzvMfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-QgVHGAObN7CFXb4B1a9bvg-1; Tue, 31 Mar 2020 11:39:12 -0400
X-MC-Unique: QgVHGAObN7CFXb4B1a9bvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E07511005509;
 Tue, 31 Mar 2020 15:39:10 +0000 (UTC)
Received: from [10.36.114.0] (ovpn-114-0.ams2.redhat.com [10.36.114.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 996A060BFE;
 Tue, 31 Mar 2020 15:39:08 +0000 (UTC)
Subject: Re: [PATCH v1] s390x: Reject unaligned RAM sizes
To: Igor Mammedov <imammedo@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200327152930.66636-1-david@redhat.com>
 <64cefab8-f1e0-fbc7-27d3-4f28758c595a@de.ibm.com>
 <d8fb50c1-639a-826c-0dce-e2ddc26ae5e1@redhat.com>
 <24681aa0-9053-238f-89da-8ce08d34241d@de.ibm.com>
 <20200327174620.06b9c324@redhat.com>
 <4c5e56fd-a5e2-efe0-9a1a-99acb91aaf71@redhat.com>
 <20200327231303.30d76ddf@redhat.com>
 <9ba133fd-603e-a8e1-7a3c-2c05c8653c15@de.ibm.com>
 <20200331173358.2b195178@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <7961ef4f-9bbc-8ac5-f4ff-b4acbd896c99@redhat.com>
Date: Tue, 31 Mar 2020 17:39:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331173358.2b195178@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31.03.20 17:33, Igor Mammedov wrote:
> On Tue, 31 Mar 2020 13:17:38 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 27.03.20 23:13, Igor Mammedov wrote:
>>> On Fri, 27 Mar 2020 17:53:39 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> On 27.03.20 17:46, Igor Mammedov wrote:  
>>>>> On Fri, 27 Mar 2020 17:05:34 +0100
>>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>>     
>>>>>> On 27.03.20 17:01, David Hildenbrand wrote:    
>>>>>>> On 27.03.20 16:34, Christian Borntraeger wrote:      
>>>>>>>>
>>>>>>>>
>>>>>>>> On 27.03.20 16:29, David Hildenbrand wrote:      
>>>>>>>>> Historically, we fixed up the RAM size (rounded it down), to fit into
>>>>>>>>> storage increments. Since commit 3a12fc61af5c ("390x/s390-virtio-ccw: use
>>>>>>>>> memdev for RAM"), we no longer consider the fixed-up size when
>>>>>>>>> allcoating the RAM block - which will break migration.
>>>>>>>>>
>>>>>>>>> Let's simply drop that manual fixup code and let the user supply sane
>>>>>>>>> RAM sizes. This will bail out early when trying to migrate (and make
>>>>>>>>> an existing guest with e.g., 12345 MB non-migratable), but maybe we
>>>>>>>>> should have rejected such RAM sizes right from the beginning.
>>>>>>>>>
>>>>>>>>> As we no longer fixup maxram_size as well, make other users use ram_size
>>>>>>>>> instead. Keep using maxram_size when setting the maximum ram size in KVM,
>>>>>>>>> as that will come in handy in the future when supporting memory hotplug
>>>>>>>>> (in contrast, storage keys and storage attributes for hotplugged memory
>>>>>>>>>  will have to be migrated per RAM block in the future).
>>>>>>>>>
>>>>>>>>> This fixes (or rather rejects early):
>>>>>>>>>
>>>>>>>>> 1. Migrating older QEMU to upstream QEMU (e.g., with "-m 1235M"), as the
>>>>>>>>>    RAM block size changed.      
>>>>>>>>
>>>>>>>> Not sure I like this variant. Instead of breaking migration (that was 
>>>>>>>> accidentially done by Igors changes) we now reject migration from older
>>>>>>>> QEMUs to 5.0. This is not going to help those that still have such guests
>>>>>>>> running and want to migrate.       
>>>>>>>
>>>>>>> As Igor mentioned on another channel, you most probably can migrate an
>>>>>>> older guest by starting it on the target with a fixed-up size.
>>>>>>>
>>>>>>> E.g., migrate an old QEMU "-m 1235M" to a new QEMU "-m 1234M"      
>>>>>>
>>>>>> Yes, that should probably work.    
>>>>> I'm in process of testing it.  
>>>
>>> it works
>>>   
>>>>>     
>>>>>>> Not sure how many such weird-size VMs we actually do have in practice.      
>>>>>>
>>>>>> I am worried about some automated deployments where tooling has created
>>>>>> these sizes for dozens or hundreds of containers in VMS and so.    
>>>>
>>>> IIRC, e.g., Kata usually uses 2048MB. Not sure about others, but I'd be
>>>> surprised if it's not multiples of, say, 128MB.
>>>>  
>>>>> Yep, it's possible but then that tooling/configs should be fixed to work with
>>>>> new QEMU that validates user's input.
>>>>>     
>>>>
>>>> Yeah, and mention it in the cover letter, +eventually a "fixup" table
>>>> (e.g., old_size < X, has to be aligned to Y).
>>>>
>>>> One alternative is to have an early fixup hack in QEMU, that fixes up
>>>> the sizes as we did before (and eventually warns the user). Not sure if
>>>> we really want/need that.  
>>> That would require at least a callback at machine level, 
>>> also practice shows warnings are of no use.  
>>
>> I would strongly prefer to not break setups that used to work and do an early fixup
>> (a machine callback). I will have a look.
> 
> If it were breaking migration stream or guest ABI,
> I'd agree with you but it isn't.
> 
> So in this case, it's a bug that qemu wasn't checking
> size for alignment and making workaround to keep the bug
> around looks wrong to me.
> It is fixable on user side (one has to fix VM's config),
> so it should be fixed there and not in QEMU.
> And any automatic tooling that generates invalid size
> should be fixed as well. 
> (I think it's not QEMU's job to mask users errors and
> doing something that user not asked for)

Dave G mentioned, that e.g., via Cockpit it can be fairly easy to
produce weird RAM sizes (via a slider). So I guess this "issue" could be
more widespread than I initially thought.

I agree that it's a BUG that we didn't bail out but instead decided to
fix it up.

-- 
Thanks,

David / dhildenb


