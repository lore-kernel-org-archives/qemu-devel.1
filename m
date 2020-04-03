Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC5C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DD12073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SF2HyarG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DD12073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKH5Q-0003GT-FN
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 03:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jKH3x-0002Iw-Up
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jKH3w-0006Fs-6H
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:48:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jKH3w-0006FU-2R
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585900103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=To1AEK2euXKxnsCevNGhPO22NE0Udm6yMkoQCCaOxB0=;
 b=SF2HyarGRKzHV2MgAl4m0QA6qUiaenPAdoDH1wLsziRhEH0KThjGbF4YVU0luqxMmVm7mD
 284AdrdnavGaUPerSE82REbJnCI16JHSZA0sVZ93QVCz6+xGlhTRjg9iV2oCPzuuovj85F
 OBB3yJpKq9JvhTZ4rfaQJS9a/arD3tM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-6FEpMo18MSGR53-yryKGgQ-1; Fri, 03 Apr 2020 03:48:20 -0400
X-MC-Unique: 6FEpMo18MSGR53-yryKGgQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B23F8017CE;
 Fri,  3 Apr 2020 07:48:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9B651147CE;
 Fri,  3 Apr 2020 07:48:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 67F9011385E2; Fri,  3 Apr 2020 09:48:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Questionable aspects of QEMU Error's design
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org>
 <44b5ff2c-6dce-e516-a9cc-9d80354c5a72@virtuozzo.com>
 <CAFEAcA_cmOkR4YsDmP7mDdKzs0jTu3WDO=d1uvMxHguvZjGW_g@mail.gmail.com>
 <877dyy9shs.fsf@dusky.pond.sub.org>
 <045198b9-29d8-231c-d35c-440723308003@virtuozzo.com>
 <878sjegc5a.fsf@dusky.pond.sub.org>
 <cf346d30-c233-50a1-b1fa-f5be20bfd891@virtuozzo.com>
Date: Fri, 03 Apr 2020 09:48:17 +0200
In-Reply-To: <cf346d30-c233-50a1-b1fa-f5be20bfd891@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 2 Apr 2020 20:17:26 +0300")
Message-ID: <87imihrovy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-?= =?utf-8?Q?Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 02.04.2020 18:06, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> 02.04.2020 11:55, Markus Armbruster wrote:
>>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>>
>>>>> On Thu, 2 Apr 2020 at 07:11, Vladimir Sementsov-Ogievskiy
>>>>> <vsementsov@virtuozzo.com> wrote:
>>>>>> Somehow, in general, especially with long function names and long pa=
rameter lists I prefer
>>>>>>
>>>>>> ret =3D func(..);
>>>>>> if (ret < 0) {
>>>>>>        return ret;
>>>>>> }
>>>>>
>>>>> Personally I prefer the other approach -- this one has an extra line
>>>>> in the source and
>>>>> needs an extra local variable.
>>>>
>>>> Me too, except when func(...) is so long that
>>>>
>>>>       if (func(...) < 0) {
>>>>
>>>> becomes illegible like
>>>>
>>>>       if (func(... yadda, yadda,
>>>>                yadda, ...) < 0) {
>>>>
>>>> Then an extra variable can improve things.
>>>>
>>>>>> Are you sure that adding a lot of boolean functions is a good idea? =
I somehow feel better with more usual int functions with -errno on failure.
>>>>>>
>>>>>> Bool is a good return value for functions which are boolean by natur=
e: checks, is something correspond to some criteria. But for reporting an e=
rror I'd prefer -errno.
>>>>>
>>>>> When would we want to return an errno? I thought the whole point of t=
he
>>>>> Error* was that that was where information about the error was return=
ed.
>>>>> If all your callsites are just going to do "if (ret < 0) { ... } then=
 having
>>>>> the functions pick an errno value to return is just extra work.
>>>>
>>>> 0/-1 vs. true/false is a matter of convention.  Lacking convention, it=
's
>>>> a matter of taste. >
>>>> 0/-1 vs. 0/-errno depends on the function and its callers.  When -errn=
o
>>>> enables callers to distinguish failures in a sane and simple way, use
>>>> it.  When -errno feels "natural", I'd say feel free to use it even whe=
n
>>>> all existing callers only check < 0.
>>>>
>>>> When you return non-null/null or true/false on success/error, neglecti=
ng
>>>> to document that in a function contract can perhaps be tolerated; you'=
re
>>>> using the return type the common, obvious way.  But when you return 0/=
-1
>>>> or 0/-errno, please spell it out.  I've seen too many "Operation not
>>>> permitted" that were actually -1 mistaken for -EPERM.  Also too many
>>>> functions that return -1 for some failures and -errno for others.
>>>>
>>>
>>> I just want to add one note:
>>>
>>> OK, you like the pattern
>>>
>>>    if (func()) {
>>>        <handle error>
>>>    }
>>>
>>> , I can live with it.
>>>
>>> I believe, we have a lot of such patterns already in code.
>>>
>>> Now, we are going to add a lot of functions, returning true on success =
and false on failure, so add a lot of patterns
>>>
>>>    if (!func()) {
>>>        <handle error>
>>>    }
>>
>> We already have this pattern all over the place with functions returning
>> non-null pointers on success, null pointer on failure.
>
> Functions returning pointer are simpler to distinguish by name.
>
> Hmm, strange. But this pattern lose the pointer.. You mean
>
> ptr =3D func();
> if (!ptr) {
>   <handle error>
> }

Yes, when you actually need the pointer.  Common, but not universal.

> this is much more understandable. Usually ptr variable name and function =
name - all will help to understand that it's all about pointer.
>
>
>>
>>> ---
>>>
>>> After it, looking at something like
>>>
>>>    if (!func()) {} / if (func()) {}
>>>
>>> I'll have to always jump to function definition, to check is it int or =
bool function, to understand what exactly is meant and is there a mistake i=
n the code..
>>> So, I'm afraid that such conversion will not help reviewing/understandi=
ng the code. I'd prefer to avoid using two opposite conventions in on proje=
ct.
>>
>> C sucks :)
>>
>> Conventions help mitigate.  Here's one: when fun() returns
>> non-negative/negative on success/error, always use
>>
>>      fun(...) < 0
>
> This reduces chances that it fit in one line..

Yes, that's a drawback.

> But yes, if all use this convention, it makes it obvious what happening.
>
>>
>> or
>>
>>      fun(...) >=3D 0
>>
>> to check.  I dislike the latter.
>>
>> When returns 0/negative, always use
>>
>>      fun(...) < 0
>>
>> Avoid
>>
>>      fun(...) >=3D 0
>>
>> because that suggests it could return a positive value, which is wrong.
>>
>> Avoid
>>
>>      fun(...)
>>
>> because that requires the reader to know the return type.
>
> Exactly the problem I mention. To follow your suggestion, we'll have to u=
pdate
> the whole code base.. However, why not.

Only if we value the consistency more than the update labor and churn.

>>
>> When its returns non-null/null or true/false on success/failure, always
>> use
>>
>>      !fun(...)
>>
>> Avoid
>>
>>      fun(...)
>>
>> because that requires the reader to know the return type.
>>
>> Note that we have a usable check for failure in all cases.  Goes well
>> with the habit to handle errors like this whenever practical
>>
>>      if (failed) {
>>          handle failure
>>          bail out
>>      }
>>      handle success
>>
>
> OK. If convert everything to your suggestion it looks good.
>
> The only possible problem is boolean functions, which just check somethin=
g, not returning the error..
>
> With a function like is_x_in_set(x, set), it's native to write
>
> if (is_x_in_set(x, set)) {
>
>    ...
>
> }
>
> which is a bit in conflict with your suggestion. Still, such functions sh=
ould be simply distinguished by name.

The conventions I described only apply to error checking.  I certainly
don't mean to discourage things like

    while (*p && qemu_isspace(*p)) {
        p++;
    }

Also, they're *conventions*, not law.  The purpose of conventions is to
help us write clearer code.  Don't make code less clear just to conform
to a convention.  Use your judgement.

>>> I can also imagine combining different function types (int/bool) in if =
conditions o_O, what will save us from it?
>>
>> Can you give an example?
>
> I just meant something like if (f1() || !f2()) { < error > }, nothing spe=
cial.

Perfectly consistent error checking style, idiomatic C, pick one.

>>> And don't forget about bool functions, which just check something, and =
false is not an error, but just negative answer on some question.
>>
>> For what it's worth, GLib specifically advises against such function
>> contracts:
>>
>>      By convention, if you return a boolean value indicating success the=
n
>>      TRUE means success and FALSE means failure.  Avoid creating
>>      functions which have a boolean return value and a GError parameter,
>>      but where the boolean does something other than signal whether the
>>      GError is set.  Among other problems, it requires C callers to
>>      allocate a temporary error.  Instead, provide a "gboolean *" out
>>      parameter.  There are functions in GLib itself such as
>>      g_key_file_has_key() that are deprecated because of this.
>>
>
> Sounds good. But we are speaking about all functions, not only with errp =
parameter.. Or not?

The conventions I described apply to error checking, regardless of Error
object use.  For instance, they'd apply to error-checking
remove("some-file").


