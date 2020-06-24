Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F83C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 21:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEA92072E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 21:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vy/3QzUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEA92072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joCeg-0003a1-HZ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 17:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1joCbV-0007NG-Tc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 17:06:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1joCbT-0006ZY-Pe
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 17:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593032803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cLW0rVq1kuXxGdxUqa7h+1cSlRXiORN2/6DQqTN5Q/Q=;
 b=Vy/3QzUgsd7vHh6PX1hGzWDspsl/fwiKlFBOfox8Jyzl7lGvPT+lqVNwEyvDF4srA/bB20
 NN/PgJSTolps6MZ3EUEr8poxcUuP9zAmJxkrL1d2aE2se6yYx5szV7gF1S/pd4g8e39FAA
 YWmW2MYB1Q0MWcOUCok6/cyf46Jvsm8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-DrtekutgOdSWlTI00McDJw-1; Wed, 24 Jun 2020 17:06:40 -0400
X-MC-Unique: DrtekutgOdSWlTI00McDJw-1
Received: by mail-wr1-f72.google.com with SMTP id b14so4193897wrp.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 14:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=X2u4IeGXiagkzz+Cp92yV4q6XBaXoem1UIfq86zhmkU=;
 b=VlbwFl8WW88591sPKnno8eYgeFtj1U9lG51XWDNsG2tNfRBca4FPcWUnQePOx+IVQ2
 0/CsOkQrD43MWz+zaCxL6ku5yoFsPEvbZVYQ8FzkMlbowu+54Ok3O4ETikymSlwcf3cE
 IHJWFP+lSxldNz0MePswPklHJHtXj5cC1ccpgE6A2tKFUXFPmRu13EX5vHItBG6/lTwK
 jp4vZM1g09FA2H+1J0+w1s6QA8e8hVplkARHJTFnzIAgrJVAwpFTbhGcMf9YhkbnFyim
 2KA7HpkhEzrbm7gN5NjJVAweDcP2LT26ML6pKkLE6IyPV5uZcc3t5+Ivr4kRIxFMbDyf
 Fvig==
X-Gm-Message-State: AOAM530nWtF9816nl3bC5YeJljkxYxuSwoHG+K2Nj1gJ+4UegJneMo+x
 wysDiG4L/Oh+/rTVrva55iiesrcCVEkF7wiUxANnwFRBVqkrV/l7m4bucqKTm32+8m73NVWqYCU
 h69PIaIcRTiFV3fc=
X-Received: by 2002:a1c:308:: with SMTP id 8mr30089590wmd.125.1593032798923;
 Wed, 24 Jun 2020 14:06:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOXmL91dNMm2Y4EPqjv1mzq5V8+NXlvTMnk9N//1FTdlt84HAd2ziSa7/4g+yN4uLtyou7nw==
X-Received: by 2002:a1c:308:: with SMTP id 8mr30089566wmd.125.1593032798651;
 Wed, 24 Jun 2020 14:06:38 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6093.dip0.t-ipconnect.de. [91.12.96.147])
 by smtp.gmail.com with ESMTPSA id
 x1sm3134332wrp.10.2020.06.24.14.06.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 14:06:37 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Date: Wed, 24 Jun 2020 23:06:36 +0200
Message-Id: <9749A408-91E3-4535-8815-AAE3740AD754@redhat.com>
References: <20200624163604-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200624163604-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (17F80)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 24.06.2020 um 22:36 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFOn Wed, Jun 24, 2020 at 06:01:02PM +0200, David Hildenbrand wrot=
e:
>>> On 24.06.20 17:37, Michael S. Tsirkin wrote:
>>> On Wed, Jun 24, 2020 at 05:28:59PM +0200, David Hildenbrand wrote:
>>>>> So at the high level the idea was simple, we just clear the dirty bit
>>>>> when page is hinted, unless we sent a new command since. Implementati=
on
>>>>> was reviewed by migration maintainers. If there's a consensus the cod=
e
>>>>> is written so badly we can't maintain it, maybe we should remove it.
>>>>> Which parts are unmaintainable in your eyes - migration or virtio one=
s?
>>>>=20
>>>> QEMU implementation without a propert virtio specification. I hope tha=
t
>>>> we can *at least* finally document the expected behavior. Alex gave it=
 a
>>>> shot, and I was hoping that Wei could jump in to clarify, help move th=
is
>>>> forward ... after all he implemented (+designed?) the feature and the
>>>> virtio interface.
>>>>=20
>>>>> Or maybe it's the general thing that interface was never specced
>>>>> properly.
>>>>=20
>>>> Yes, a spec would be definitely a good starter ...
>>>>=20
>>>> [...]
>>>>=20
>>>>>>=20
>>>>>> 1. If migration fails during RAM precopy, the guest will never recei=
ve a
>>>>>> DONE notification. Probably easy to fix.
>>>>>>=20
>>>>>> 2. Unclear semantics. Alex tried to document what the actual semanti=
cs
>>>>>> of hinted pages are.
>>>>>=20
>>>>> I'll reply to that now.
>>>>>=20
>>>>>> Assume the following in the guest to a previously
>>>>>> hinted page
>>>>>>=20
>>>>>> /* page was hinted and is reused now */
>>>>>> if (page[x] !=3D Y)
>>>>>>    page[x] =3D=3D Y;
>>>>>> /* migration ends, we now run on the destination */
>>>>>> BUG_ON(page[x] !=3D Y);
>>>>>> /* BUG, because the content chan
>>>>>=20
>>>>> The assumption hinting makes is that data in page is writtent to befo=
re it's used.
>>>>>=20
>>>>>=20
>>>>>> A guest can observe that. And that could be a random driver that jus=
t
>>>>>> allocated a page.
>>>>>>=20
>>>>>> (I *assume* in Linux we might catch that using kasan, but I am not 1=
00%
>>>>>> sure, also, the actual semantics to document are unclear - e.g., for
>>>>>> other guests)
>>>>>=20
>>>>> I think it's basically simple: hinting means it's ok to
>>>>> fill page with trash unless it has been modified since the command
>>>>> ID supplied.
>>>>=20
>>>> Yeah, I quite dislike the semantics, especially, as they are different
>>>> to well-know semantics as e.g., represent in MADV_FREE. Getting change=
d
>>>> content when reading is really weird. But it seemed to be easier to
>>>> implement (low hanging fruit) and nobody complained back then. Well, n=
ow
>>>> we are stuck with it.
>>>>=20
>>>> [..]
>>>=20
>>> The difference with MADV_FREE is
>>> - asynchronous (using cmd id to synchronize)
>>> - zero not guaranteed
>>>=20
>>> right?
>>=20
>> *looking into man page*, yes, when reading you either get the old
>> content or zero.
>>=20
>> (I remember that a re-read also makes the content stable, but looks like
>> you really have to write to a page)
>>=20
>> We should most probably do what Alex suggested and initialize pages (at
>> least write a single byte) when leaking them from the shrinker in the
>> guest while hinting is active, such that the content is stable for
>> anybody to allocate and reuse a page.
>=20
> Drivers ignore old content from slab though, so I don't really see
> the point.
>=20

That=E2=80=98s what we=E2=80=98re hoping for and what we would expect. Mayb=
e we should just life with that assumption and hope for the best ...

>> --=20
>> Thanks,
>>=20
>> David / dhildenb
>=20


