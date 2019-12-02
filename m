Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69BAC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 05:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFAA20659
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 05:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPlORvzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFAA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibdrN-0005Dz-HI
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 00:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ibdqS-0004NN-Qv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ibdqP-0007aj-NY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:01:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37787
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ibdqP-0007aR-Ce
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 00:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575262916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRYaAy650yiSRqFk5USZXKnuS8A+Yj/qPpOFf6yDWoY=;
 b=MPlORvzwMiSpZIJ6NQUfQ/jojxIcutEoFko7nVJlDZ7O+ugohAfW24m150AL6isncBCLPu
 WYRdXlq+gr+dKWvTAiOVSI/5HBDJToeZVH3Wpd22ZHd0DSETFAa6NNG95cmqhcfePL1Nzy
 P+3f19vEQhW8oYVH0HmHr3NFAtvT8Ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-qeuefDKbNlKrZx6jm882nA-1; Mon, 02 Dec 2019 00:01:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 665F91852E20;
 Mon,  2 Dec 2019 05:01:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 055715C883;
 Mon,  2 Dec 2019 05:01:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8BE591138606; Mon,  2 Dec 2019 06:01:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error
 handling bugs
References: <20191130194240.10517-18-armbru@redhat.com>
 <9C97FEE6-D390-4CEB-9B00-50AE00AEA4D2@redhat.com>
 <CAL1e-=jst9hGBXy0zm-975QDvW0F0xBNJAypqM4KooWEUvJfjQ@mail.gmail.com>
 <d9eb5b70-8396-7537-aac5-24c4d872d553@redhat.com>
Date: Mon, 02 Dec 2019 06:01:46 +0100
In-Reply-To: <d9eb5b70-8396-7537-aac5-24c4d872d553@redhat.com> (David
 Hildenbrand's message of "Sun, 1 Dec 2019 15:09:04 +0100")
Message-ID: <87sgm3nww5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qeuefDKbNlKrZx6jm882nA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <dhildenb@redhat.com>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> On 01.12.19 14:46, Aleksandar Markovic wrote:
>>=20
>>=20
>> On Saturday, November 30, 2019, David Hildenbrand <dhildenb@redhat.com
>> <mailto:dhildenb@redhat.com>> wrote:
>>=20
>>=20
>>=20
>>     > Am 30.11.2019 um 20:42 schrieb Markus Armbruster
>>     <armbru@redhat.com <mailto:armbru@redhat.com>>:
>>     >
>>     > =EF=BB=BFcpu_model_from_info() is a helper for
>>     qmp_query_cpu_model_expansion(),
>>     > qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().=
=C2=A0 It
>>     > crashes when the visitor or the QOM setter fails, and its @errp
>>     > argument is null.=C2=A0 Messed up in commit 137974cea3 's390x/cpum=
odel:
>>     > implement QMP interface "query-cpu-model-expansion"'.
>>     >
>>     > Its three callers have the same bug.=C2=A0 Messed up in commit 4e8=
2ef0502
>>     > 's390x/cpumodel: implement QMP interface "query-cpu-model-comparis=
on"'
>>     > and commit f1a47d08ef 's390x/cpumodel: implement QMP interface
>>     > "query-cpu-model-baseline"'.
>>     >
>>     > The bugs can't bite as no caller actually passes null.=C2=A0 Fix t=
hem
>>     > anyway.
>>=20
>>     https://en.m.wikipedia.org/wiki/Software_bug
>>     <https://en.m.wikipedia.org/wiki/Software_bug>
>>=20
>>     =C2=A0 =E2=80=9E A software bug is an error, flaw or fault in a comp=
uter program
>>     or system that causes it to produce an incorrect or unexpected
>>     result, or to behave in unintended ways. =E2=80=9E
>>=20
>>     Please make it clear in the descriptions that these are cleanups and
>>     not bugfixes. It might be very confusing for people looking out for
>>     real bugs.
>>=20
>>=20
>>=20
>> Disclaimer: I am not entirely familiar with the code in question, so
>> take my opinion with reasonablereservation.
>>=20
>> It looks that we here deal with latent bugs. As you probably know from
>> experience, a latent bugs, when they are activated with some ostensibly
>> unrelated code change, can be much more difficult to diagnose and fix
>> than regular bugs.
>
> "https://economictimes.indiatimes.com/definition/latent-bug
>
> "Definition: An uncovered or unidentified bug which exists in the system
> over a period of time is known as the Latent Bug. The bug may persist in
> the system in one or more versions of the software."
>
> AFAIK, a latent BUG can be triggered, it simply was never triggered.

First search hit.  Here's my second one:

    Q: What are latent bugs?

    A: These bugs do not cause problems today. However, they are lurking
    just waiting to reveal themselves later.  The Ariane 5 rocket
    failure was caused by a float->int conversion error that lay dormant
    when previous rockets were slower; but the faster Ariane 5 triggered
    the problem.  The Millennium bug is another example of a latent bug
    that came to light when circumstances changed.  Latent bugs are much
    harder to test using conventional testing techniques, and finding
    them requires someone with foresight to ask.

http://www.geekinterview.com/question_details/36689

My point is: common usage of the term is not as clear-cut as your quote
makes it seem.

> Do you think the following code is buggy?
>
> static int get_val(int *ptr)
> {
> =09return *ptr;
> }
>
> int main()
> {
> =09int a =3D 0;
>
> =09return get_val(&a);
> }
>
> I claim, no, although we could access a NULL pointer if ever reworked.
> There is no invalid system state possible.

get_val() is silent on how it wants to be used.  error.h is anything
but: it spells out how it wantes to be used in quite some detail.  In
particular:

 * Receive an error and pass it on to the caller:
 *     Error *err =3D NULL;
 *     foo(arg, &err);
 *     if (err) {
 *         handle the error...
 *         error_propagate(errp, err);
 *     }
 * where Error **errp is a parameter, by convention the last one.
 *
 * Do *not* "optimize" this to
 *     foo(arg, errp);
 *     if (*errp) { // WRONG!
 *         handle the error...
 *     }
 * because errp may be NULL!

My patch fixes this exact misuse of the interface.

>> In that light, this change is not a clean up. It is a fix of a latent
>> bugs, and Markus' aproach to treat it as a bug fix looks right to me. I
>> would just add a word "latent" or similar, which would even more
>> distance the patch from "cleanup" meaning.
>
> I agree iff there is some way to trigger it. Otherwise, to me it is a
> cleanup.If it's a BUG, it deserves proper Fixes tags and some
> description how it can be triggered.

Yes, a bug that can bite deserves a reproducer and a formal Fixes: tag.

The thing we're discussing (however we may want to call it) does not
have a reproducer, and I think we're in agreement that it doesn't need a
Fixes: tag.

However, my patch is not cleaning up something that's dirty, it's fixing
something that's unequivocally wrong: a violation of a stated interface
contract.

The violation happens to have no ill effects at this time due to the way
the violating code is being used.

I call that a "latent bug".  git-log has quite a few occurences of
"latent bug", by Richard Henderson, Daniel Berrang=C3=A9, Paolo, ...

Your point that the commit message should not confuse people looking for
real bugs is well taken.  I think "latent bug" is clear enough, and also
concise.  I'm of course open to better phrasings.

   s390x: Fix currently harmless query-cpu-model-FOO error API violations

feels no clearer to me than

   s390x: Fix latent query-cpu-model-FOO error handling bugs

It's also too long.

I tried.  Your turn :)


