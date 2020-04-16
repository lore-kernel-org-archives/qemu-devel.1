Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594BC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 08:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2349D206B9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 08:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6J7eCco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2349D206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOzkZ-0004uI-8A
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 04:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jOzjj-0004HZ-NV
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 04:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jOzjh-0001zj-Aj
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 04:19:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36676
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jOzjh-0001z5-3j
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 04:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587025140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9iwgiWWSPD+b/Kff/+nNq3uhkyCcLTMOUJ4eAvogiWs=;
 b=a6J7eCcoTfEnAutXnU3sBbjKimbDwXXravVFef4CY0+11nUGJPLUr8kUa+GOs3jZKQPspL
 pmFFu07axN1xY+x4AL6AU3OFLXnrE0RE9t1DPZMLjwbo/1jIIHE9eTqBMrs0Hbk6S5V+N+
 jKE28xeiKFCNfCUnGGdi1TQlq//raFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-dqyZqILVNiy1daEGua17Dw-1; Thu, 16 Apr 2020 04:18:56 -0400
X-MC-Unique: dqyZqILVNiy1daEGua17Dw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FE8C1005510;
 Thu, 16 Apr 2020 08:18:55 +0000 (UTC)
Received: from [10.36.114.9] (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 023C060BF1;
 Thu, 16 Apr 2020 08:18:50 +0000 (UTC)
Subject: Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
To: Alexander Duyck <alexander.duyck@gmail.com>,
 David Hildenbrand <dhildenb@redhat.com>
References: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
 <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com>
 <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <f685fa75-6898-4fbe-c2a1-ba35424cb4a2@redhat.com>
Date: Thu, 16 Apr 2020 10:18:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Wang,
 Wei W" <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>
>> Postcopy is a very good point, bought!
>>
>> But (what you wrote above) it sounds like that this is really what we *h=
ave to* do, not an optimization. I=E2=80=98ll double check the spec tomorro=
w (hopefully it was documented). We should rephrase the comment then.
>=20
> Do you have a link to the spec that I could look at? I am not hopeful
> that this will be listed there since the poison side of QEMU was never
> implemented. The flag is only here because it was copied over in the
> kernel header.

Introducing a feature without

a) specification what it does
b) implementation (of both sides) showing what has to be done
c) any kind of documentation of what needs to be done

just horrible.

The latest-greatest spec lives in

https://github.com/oasis-tcs/virtio-spec.git

I can't spot any signs of free page hinting/page poisioning. :(

We should document our result of page poisoning, free page hinting, and
free page reporting there as well. I hope you'll have time for the latter.

-------------------------------------------------------------------------
Semantics of VIRTIO_BALLOON_F_PAGE_POISON
-------------------------------------------------------------------------

"The VIRTIO_BALLOON_F_PAGE_POISON feature bit is used to indicate if the
guest is using page poisoning. Guest writes to the poison_val config
field to tell host about the page poisoning value that is in use."
-> Very little information, no signs about what has to be done.

"Let the hypervisor know that we are expecting a specific value to be
written back in balloon pages."
-> Okay, that talks about "balloon pages", which would include right now
-- pages "inflated" and then "deflated" using free page hinting
-- pages "inflated" and then "deflated" using oridnary inflate/deflate
   queue
-- pages "inflated" using free page reporting and automatically
   "deflated" on access

So VIRTIO_BALLOON_F_PAGE_POISON really means "whenever the guest
deflates a page (either explicitly, or implicitly with free page
reporting), it is filled with "poison_val".

And I would add

"However, if the inflated page was not filled with "poison_val" when
inflating, it's not predictable if the original page or a page filled
with "poison_val" is returned."

Which would cover the "we did not discard the page in the hypervisor, so
the original page is still there".


We should also document what is expected to happen if "poison_val" is
suddenly changed by the guest at one point in time again. (e.g., not
supported, unexpected things can happen, etc.) Also, we might have to
document that a device reset resets the poison_val to 0. (not sure if
that's really necessary)

-------------------------------------------------------------------------
What we have to do in the guest/Linux:
-------------------------------------------------------------------------

A guest which relies on this (esp., free page reporting in Linux only,
right?), has to not use/advertise VIRTIO_BALLOON_F_REPORTING *in case
VIRTIO_BALLOON_F_PAGE_POISON is not provided* by the host. AFAIKS,
ordinary inflation/deflation and free page hinting does currently not
care, as we go via free_page(), so that is currently fine AFAIKs.

-------------------------------------------------------------------------
What we have to do in the hypervisor/QEMU:
-------------------------------------------------------------------------

With VIRTIO_BALLOON_F_PAGE_POISON, we could provide free page reporting
easily IFF "page_val"=3D=3D0. However, as you said, it will currently be
expensive in case of postcopy, as the guest still zeroes out all pages.
Document that properly.

With VIRTIO_BALLOON_F_PAGE_POISON, don't inflate any pages right now
(not discarding anything), OR fill the pages with poison_val when
deflating. I guess the latter would be better - even if current Linux
does not need it, it's what we are expected to do AFAIKS.

With VIRTIO_BALLOON_F_PAGE_POISON and page_val !=3D 0, discard all free
page reporting attempts. (=3D=3D what your patch #3 does). Document that
properly.


Makes sense? See below for guest migration thingies.

>=20
>> I could imagine that we also have to care about ordinary page inflation/=
deflation when handling page poisoning. (Iow, don=E2=80=98t inflate/deflate=
 if set for now).
>=20
> The problem is this was broken from the start for that. The issue is
> that the poison feature was wrapped up within the page hinting
> feature. So as a result enabling it for a VM that doesn't recognize
> the feature independently would likely leave the poison value
> uninitialized and flagging as though a value of 0 is used. In addition
> the original poison checking wasn't making sure that the page wasn't
> init_on_free which has the same effect as page poisoning but isn't
> page poisoning.

If the guest agrees to have VIRTIO_BALLOON_F_PAGE_POISON but does not
initialize poison_val, then it's a guest bug, I wouldn't worry about
that for now.

>=20
>>>
>>> The worst case scenario would be one in which the VM was suspended for
>>> migration while there were still pages in the balloon that needed to
>>> be drained. In such a case you would have them in an indeterminate
>>> state since the last page poisoning for them might have been ignored
>>> since they were marked as "free", so they are just going to be
>>> whatever value they were if they had been migrated at all.
>>>
>>>>>
>>>>>>
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>>     if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
>>>>>>>         s->free_page_report_cmd_id =3D
>>>>>>>                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>>>>>>
>>>>>> We should rename all "free_page_report" stuff we can to
>>>>>> "free_page_hint"/"free_page_hinting" to avoid confusion (e.g., on my
>>>>>> side :) ) before adding free page reporting .
>>>>>>
>>>>>> (looking at the virtio-balloon linux header, it's also confusing but
>>>>>> we're stuck with that - maybe we should add better comments)
>>>>>
>>>>> Are we stuck? Couldn't we just convert it to an anonymous union with
>>>>> free_page_hint_cmd_id and then use that where needed?
>>>>
>>>> Saw your patch already :)
>>>>
>>>>>
>>>>>>> @@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(Virt=
IOBalloon *s)
>>>>>>>     if (s->qemu_4_0_config_size) {
>>>>>>>         return sizeof(struct virtio_balloon_config);
>>>>>>>     }
>>>>>>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)=
) {
>>>>>>> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)=
 ||
>>>>>>> +        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HI=
NT)) {
>>>>>>>         return sizeof(struct virtio_balloon_config);
>>>>>>>     }
>>>>>>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HI=
NT)) {
>>>>>>> -        return offsetof(struct virtio_balloon_config, poison_val);
>>>>>>> -    }
>>>>>>
>>>>>> I am not sure this change is completely sane. Why is that necessary =
at all?
>>>>>
>>>>> The poison_val is stored at the end of the structure and is required
>>>>> in order to make free page hinting to work. What this change is doing
>>>>
>>>> Required to make it work? In the kernel,
>>>>
>>>> commit 2e991629bcf55a43681aec1ee096eeb03cf81709
>>>> Author: Wei Wang <wei.w.wang@intel.com>
>>>> Date:   Mon Aug 27 09:32:19 2018 +0800
>>>>
>>>>    virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
>>>>
>>>> was merged after
>>>>
>>>> commit 86a559787e6f5cf662c081363f64a20cad654195
>>>> Author: Wei Wang <wei.w.wang@intel.com>
>>>> Date:   Mon Aug 27 09:32:17 2018 +0800
>>>>
>>>>    virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>>>>
>>>> So I assume it's perfectly fine to not have it.
>>>>
>>>> I'd say it's the responsibility of the guest to *not* use
>>>> VIRTIO_BALLOON_F_FREE_PAGE_HINT in case it is using page poisoning
>>>> without VIRTIO_BALLOON_F_PAGE_POISON. Otherwise it will shoot itself
>>>> into the foot.
>>>
>>> Based on the timing I am guessing the page poisoning was in the same
>>> patch set as the free page hinting since there is only 2 seconds
>>> between when the two are merged. If I recall the page poisoning logic
>>> was added after the issue was pointed out that it needed to address
>>> it.
>>>
>>
>> Yeah, but any other OS implementing this, not caring about page poisonin=
g wouldn=E2=80=98t need it. Maybe there is something in the spec.
>>
>> Mental note: we=E2=80=98ll have to migrate the poison value if not alrea=
dy done (writing on my mobile).
>=20
> Right. We need to make sure any poison or init on free is migrated
> over to the destination before we can say we are going to skip the
> migration. If anything what I probably ought to look into would be if
> we could change the code so that if we have a hint the page is unused,
> poison is enabled, and the value is 0 we just ship over a 0 page
> instead of giving up on hinting entirely.
>=20

Yeah, we have to migrate poison_val from source to destination. Also, we
should worry about us losing the page poisoning feature when migrating
from source to destination.

Thinking about it, it might make sense to completely decouple page
poisoning here. Assign it a separate property (as you did), default
enable it, but disable it via QEMU compat machines.

Then, we won't lose the feature when migrating.

--=20
Thanks,

David / dhildenb


