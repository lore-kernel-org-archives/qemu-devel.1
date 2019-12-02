Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A7EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80619215E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxCWt5is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80619215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibhB2-0002O2-K1
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 03:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1ibhAB-0001YT-H2
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1ibhA8-0000DW-4n
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:34:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23427
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1ibhA7-0000Cj-OE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575275670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bKxobMFRPTtoBOEkQIUWmCVhYal3HDWGlkCgvYaoHLE=;
 b=YxCWt5is4Vpan6qeDz1tZw59LccBbIEI1CeOLwIzSk3gwMbNnAgLkJdUkKsdoi4rnijNZg
 ysTs9D+/ZO26WJRAnQLZtpiqlxtyGBo9u2iu/5kV8qP1OUbjleBzcAZj3Lx9Ii9bYJ4kvL
 uwCqiNga8hOu+qhS92wMX/jzV2HNmJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-8NTIDi4hNyiU0DYjnki3Qw-1; Mon, 02 Dec 2019 03:34:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D898018A8C82;
 Mon,  2 Dec 2019 08:34:25 +0000 (UTC)
Received: from [10.36.117.49] (ovpn-117-49.ams2.redhat.com [10.36.117.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82FAF60BF7;
 Mon,  2 Dec 2019 08:34:24 +0000 (UTC)
Subject: Re: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error
 handling bugs
To: Markus Armbruster <armbru@redhat.com>
References: <20191130194240.10517-18-armbru@redhat.com>
 <9C97FEE6-D390-4CEB-9B00-50AE00AEA4D2@redhat.com>
 <CAL1e-=jst9hGBXy0zm-975QDvW0F0xBNJAypqM4KooWEUvJfjQ@mail.gmail.com>
 <d9eb5b70-8396-7537-aac5-24c4d872d553@redhat.com>
 <87sgm3nww5.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <631941d9-0e30-330b-e50e-4c9d99824e73@redhat.com>
Date: Mon, 2 Dec 2019 09:34:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87sgm3nww5.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8NTIDi4hNyiU0DYjnki3Qw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <dhildenb@redhat.com>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[...]

> First search hit.  Here's my second one:
>=20
>     Q: What are latent bugs?
>=20
>     A: These bugs do not cause problems today. However, they are lurking
>     just waiting to reveal themselves later.  The Ariane 5 rocket
>     failure was caused by a float->int conversion error that lay dormant
>     when previous rockets were slower; but the faster Ariane 5 triggered
>     the problem.  The Millennium bug is another example of a latent bug
>     that came to light when circumstances changed.  Latent bugs are much
>     harder to test using conventional testing techniques, and finding
>     them requires someone with foresight to ask.
>=20
> http://www.geekinterview.com/question_details/36689

Google search "latent software BUG"

Hit 1: What I posted


Hit 2:
https://www.quora.com/What-are-some-examples-for-a-latent-defect-in-softwar=
e-testing

"The problems will not cause the damage currently, but wait to reveal
themselves at a later time. ... E.g. February has 28 days. ... These
defects do not cause damage to the system immediately but wait for a
particular event sometime to cause damage and show their presence."

"Mostly, these types of bugs are unexpected outcome of any corner/edge
case scenarios which was executed with some specific set of test data."


Hit 3: https://sqa.stackexchange.com/questions/9170/what-is-a-latent-bug

"Latent bugs are bugs which exist, but have not yet been discovered.

They are bugs waiting to be found."

"In Software Quality Assurance:

Latent defects are the those which arises in the field, and unknown
until they reported by the field staff."


Hit 4:
https://sqa.stackexchange.com/questions/13980/what-is-the-difference-betwee=
n-gold-bug-and-latent-bug

"A latent bug is a bug which is present in the system from previous
iterations or release (in your scenario Sprint 1). They are either low
priority bugs, which either went undetected or were not reported."


Same at least for Hit 5, 6, 7 (then I got tired ;) )

https://blog.qatestlab.com/2011/10/21/latent-and-masked-software-bugs-what-=
is-the-difference/
https://www.testing-whiz.com/blog/3-types-of-unusual-software-defects-you-s=
hould-not-miss
https://www.360logica.com/blog/latent-defect-hide-n-seek-defect-software-te=
sting/

Which contain perfect examples and descriptions for latent bugs :)

e.g.,

"Let=E2=80=99s imagine that an application is able to print a document eith=
er by
laser printer or by dot matrix printer. To reach this, the application
first searches for the laser printer. In this case if it finds a laser
printer (used by default) it uses this one and prints. In case if it
does not find a laser printer, the application searches for dot matrix
printer. And if the application finds a dot matrix printer, it  gives an
error message. This unleashes a latent defect. Therefore this
application will never search for the dot matrix printer. And the
application never got tested for the dot matrix printer. That means the
accurate conditions were never met for the dot matrix printer. This is
what we call a latent software bug."

[...]

>=20
>>> In that light, this change is not a clean up. It is a fix of a latent
>>> bugs, and Markus' aproach to treat it as a bug fix looks right to me. I
>>> would just add a word "latent" or similar, which would even more
>>> distance the patch from "cleanup" meaning.
>>
>> I agree iff there is some way to trigger it. Otherwise, to me it is a
>> cleanup.If it's a BUG, it deserves proper Fixes tags and some
>> description how it can be triggered.
>=20
> Yes, a bug that can bite deserves a reproducer and a formal Fixes: tag.

A "BUG that cannot be triggered" is an oxymoron. :)

The code might be "error prone", it might "violate API guidelines", it
might "not obey coding practices". If it can't be triggered, it's - by
definition - not a (latent) BUG.

>=20
> The thing we're discussing (however we may want to call it) does not
> have a reproducer, and I think we're in agreement that it doesn't need a
> Fixes: tag.
>=20
> However, my patch is not cleaning up something that's dirty, it's fixing
> something that's unequivocally wrong: a violation of a stated interface
> contract.

In general, I don't care about these minor details, but if somebody
literally tells the world for all eternity in a handful of patch
descriptions "David messed up the code by introducing a (latent) BUG
(that cannot be triggered)" I get suspicious. Something nicer (IMHO)
would be "Commit X introduced error prone code, let's rework that to
make it more stable in the future and obey the "error API" guidelines. I
hope you see the difference ;)

>=20
> Your point that the commit message should not confuse people looking for
> real bugs is well taken.  I think "latent bug" is clear enough, and also
> concise.  I'm of course open to better phrasings.
>=20
>    s390x: Fix currently harmless query-cpu-model-FOO error API violations
>=20
> feels no clearer to me than
>=20
>    s390x: Fix latent query-cpu-model-FOO error handling bugs
>=20
> It's also too long.
>=20
> I tried.  Your turn :)


s390x: Fix query-cpu-model-FOO error API violations

s390x: Make query-cpu-model-FOO error handling less error prone

s390x: Cleanup error handling in query-cpu-model-FOO

s390x: Rework error handling in query-cpu-model-FOO

...

but, enough time spent on this, feel free to continue with this however
you want.

--=20
Thanks,

David / dhildenb


