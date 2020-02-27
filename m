Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1272DC35677
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58DF24699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMVDLx2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58DF24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KKO-00057l-0q
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7KJk-0004OG-5R
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7KJi-0005g5-HW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:39:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35992
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7KJi-0005fi-DC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582814349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3ayXL9ZizCG5OVZWqVyg9eizx9Fth+K29G56z+uN98=;
 b=iMVDLx2RHV87uJajWq16h6tL0IsdZL9H/8El4HsOOynEigck+pAipzEAkkbIHwdedghp9g
 9TecGPUy9fhta2Wn26/cV65RfcRBdXW6cCgdfOCBMJKG4tNt5HAmMdqiFngAJUAdTSNQ9f
 701vrEYHsNZe1ASJN6Wnq8twNeJ+mCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-yISgprG1MjS9oG4D5JyFeg-1; Thu, 27 Feb 2020 09:39:07 -0500
X-MC-Unique: yISgprG1MjS9oG4D5JyFeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93A111902EA4;
 Thu, 27 Feb 2020 14:39:06 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BECEC9296C;
 Thu, 27 Feb 2020 14:39:05 +0000 (UTC)
Subject: Re: [PATCH v1 1/8] qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-2-dplotnikov@virtuozzo.com>
 <501fde69-f116-a3b9-0356-05708f0b78b7@redhat.com>
 <78aa28c9-49a4-ac0a-51c5-e3587f46603d@virtuozzo.com>
 <e93ca287-07c0-c6f9-c490-31954bcde274@redhat.com>
 <e166d252-37ae-7b56-8ff4-d8524e055eed@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5fc1dceb-5448-e08d-5e80-bc6285bf7de6@redhat.com>
Date: Thu, 27 Feb 2020 08:39:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e166d252-37ae-7b56-8ff4-d8524e055eed@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 8:30 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> But what is the benefit? We have already documented padding in the=20
>>> spec, and discussed it so much time... What is the problem with=20
>>> padding? And why to add 8 bytes for every new feature which needs=20
>>> only one byte?
>>
>> Okay, so requiring an 8-byte field is not necessary.=A0 But still, at=20
>> least mentioning padding bytes (that may be assigned meanings later)=20
>> is consistent with the rest of the document (for example, we have=20
>> padding bits documented for the compatible/incompatible/autoclear=20
>> feature bits), and reminds implementers to keep size rounded to a=20
>> multiple of 8.
>>
>=20
> Yes, we can add something about it.. But I'm not sure we need, and I=20
> can't imaging correct short wording.
>=20
>=20
> We have section about padding:
>=20
> "
> =3D=3D=3D Header padding =3D=3D=3D
>=20
> @header_length must be a multiple of 8, which means that if the end of=20
> the last
> additional field is not aligned, some padding is needed. This padding=20
> must be
> zeroed, so that if some existing (or future) additional field will fall=
=20
> into
> the padding, it will be interpreted accordingly to point [3.] of the=20
> previous
> paragraph, i.e.=A0 in the same manner as when this field is not present.
> "
>=20
>=20
> So, if we want to add something about 104-111, it should be added to=20
> this section, not to previous "=3D=3D=3D Additional fields (version 3 and=
=20
> higher) =3D=3D=3D".
>=20
> And, if we want, to add something, we should consider both cases when=20
> compression type field exists and when not... What to write?
>=20
> "105 - 111: These bytes are padding, if header length > 104. May be=20
> turned into new additional fields in future."
>=20
> Sounds a bit strange... Keeping in mind that different versions of qemu=
=20
> may consider the same bytes as additional field or as padding, and it is=
=20
> correct.

Looking at the header extension, it can probably be as simple as:

105 - m: Zero padding to round up the header size to the next
          multiple of 8.

I guess I'll propose a patch to make my idea concrete.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


