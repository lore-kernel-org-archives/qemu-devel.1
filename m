Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,YOU_INHERIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6F4C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E1220724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOuTj7Mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E1220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEshW-00053W-0q
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 06:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEsgT-0004Yy-EZ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEsgR-0001lV-3o
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:45:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEsgQ-0001ky-Ux
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584614750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W97N0/BhMj5VQnTpNBcqX2gvUKJva35QxWpCfIclmK0=;
 b=VOuTj7Mkc/SJW09h+6ht0Nc0F1LVieRjZElk/i9C1bID0wZABy3ilhLQUmz9gDBNSzD6Cg
 9+xdkND/uhQhMKIVf9vOAlUUeHwMbImaBBIG+3A98wMeUuZMr2wLULz09FoMiDxcQ83TII
 dllCnw3/+reS4SOsArMCQut97LNx7og=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-WDmxZiu1NFOvlcB7L8FNZA-1; Thu, 19 Mar 2020 06:45:38 -0400
X-MC-Unique: WDmxZiu1NFOvlcB7L8FNZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 892C1801A06;
 Thu, 19 Mar 2020 10:45:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4076B9128E;
 Thu, 19 Mar 2020 10:45:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C40351138404; Thu, 19 Mar 2020 11:45:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
 <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
 <875zf8gt2m.fsf@dusky.pond.sub.org>
 <7c6f9a91-76cf-242d-8166-0693ec14b24d@virtuozzo.com>
 <87blozex9v.fsf@dusky.pond.sub.org>
 <f9c8de73-38d8-a14c-632a-8e57d18e00c8@virtuozzo.com>
 <87o8swk8wc.fsf@dusky.pond.sub.org>
 <db2fa8a3-48cc-51aa-a3d5-eba88fb29f66@virtuozzo.com>
 <87wo7jqn8m.fsf@dusky.pond.sub.org>
 <c944511d-0a10-0840-258f-8e0bac19eb47@virtuozzo.com>
Date: Thu, 19 Mar 2020 11:45:28 +0100
In-Reply-To: <c944511d-0a10-0840-258f-8e0bac19eb47@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 17 Mar 2020 14:35:15 +0300")
Message-ID: <87wo7gd3nb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 17.03.2020 13:39, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> 16.03.2020 11:21, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>
>>>>> On 14.03.2020 00:54, Markus Armbruster wrote:
>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>>
>>>>>>> 13.03.2020 18:42, Markus Armbruster wrote:
>>>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>>>>
>>>>>>>>> 12.03.2020 19:36, Markus Armbruster wrote:
>>>>>>>>>> I may have a second look tomorrow with fresher eyes, but let's g=
et this
>>>>>>>>>> out now as is.
>>>>>>>>>>
>>>>>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>> [...]
>>>>>>>>>>> +@@
>>>>>>>>>>> +
>>>>>>>>>>> + fn(..., Error ** ____, ...)
>>>>>>>>>>> + {
>>>>>>>>>>> +     ...
>>>>>>>>>>> +     Error *local_err =3D NULL;
>>>>>>>>>>> +     ... when any
>>>>>>>>>>> +     Error *local_err2 =3D NULL;
>>>>>>>>>>> +     ... when any
>>>>>>>>>>> + }
>>>>>>
>>>>>> This flags functions that have more than one declaration along any
>>>>>> control flow path.  It doesn't flag this one:
>>>>>>
>>>>>>        void gnat(bool b, Error **errp)
>>>>>>        {
>>>>>>            if (b) {
>>>>>>                Error *local_err =3D NULL;
>>>>>>                foo(arg, &local_err);
>>>>>>                error_propagate(errp, local_err);
>>>>>>            } else {
>>>>>>                Error *local_err =3D NULL;
>>>>>>                bar(arg, &local_err);
>>>>>>                error_propagate(errp, local_err);
>>>>>>            }
>>>>>>        }
>>>>>>
>>>>>> The Coccinelle script does the right thing for this one regardless.
>>>>>>
>>>>>> I'd prefer to have such functions flagged, too.  But spending time o=
n
>>>>>> convincing Coccinelle to do it for me is not worthwhile; I can simpl=
y
>>>>>> search the diff produced by Coccinelle for deletions of declarations
>>>>>> that are not indented exactly four spaces.
>>>>>>
>>>>>> But if we keep this rule, we should adjust its comment
>>>>>>
>>>>>>        // Warn several Error * definitions.
>>>>>>
>>>>>> because it sure suggests it also catches functions like the one I ga=
ve
>>>>>> above.
>>>>>
>>>>> Hmm, yes.. We can write "Warn several Error * definitions in _one_
>>>>> control flow (it's not so trivial to match _any_ case with several
>>>>> definitions with coccinelle)" or something like this.
>>>>
>>>> Ha, "trivial" reminds me of a story.  The math professor, after having
>>>> spent a good chunk of his lecture developing a proof on the blackboad
>>>> turns to the audience to explain why this little part doesn't require
>>>> proof with the words familiar to any math student "and this is trivial=
."
>>>> Pause, puzzled look...  "Is it trivial?"  Pause, storms out of the
>>>> lecture hall.  A minute or three pass.  Professor comes back beaming,
>>>> "it is trivial!", and proceeds with the proof.
>>>>
>>>> My point is: it might be trivial with Coccinelle once you know how to =
do
>>>> it.  We don't.
>>>>
>>>> Suggest "(can't figure out how to match several definitions regardless
>>>> of control flow)".
>>>
>>> Wrong too, because I can:) for example, chaining two rules, catching th=
e
>>> positions of definition and check that they are different.. Or, some
>>> cheating with python script.. That's why I wrote "not trivial",
>>>
>>> So, most correct would be "(can't figure out how to simply match severa=
l definitions regardless
>>>> of control flow)".
>>
>> Works for me.
>>
>>> But again, coccinelle is for matching control flows, so its probably im=
possible to match such thing..
>> [...]
>>>>> OK, I almost OK with it, the only thing I doubt a bit is the followin=
g:
>>>>>
>>>>> We want to keep rule1.local_err inheritance to keep connection with
>>>>> local_err definition.
>>>>
>>>> Yes.
>>>>
>>>>> Interesting, when we have both rule1.fn and rule1.local_err inherited=
,
>>>>> do we inherit them in separate (i.e. all possible combinations of fn
>>>>> and local_err symbols from rule1) or do we inherit a pair, i.e. only
>>>>> fn/local_err pairs, found by rule1? If the latter is correct, that
>>>>> with your script we loss this pair inheritance, and go to all possibl=
e
>>>>> combinations of fn and local_err from rule1, possibly adding some wro=
ng
>>>>> conversion (OK, you've checked that no such cases in current code tre=
e).
>>>>
>>>> The chaining "identifier rule1.FOO" is by name.  It's reliable only as
>>>> long as there is exactly one instance of the name.
>>>>
>>>> We already discussed the case of the function name: if there are two
>>>> instances of foo(), and rule1 matches only one of them, then we
>>>> nevertheless apply the rules chained to rule1 to both.  Because that c=
an
>>>> be wrong, you came up with the ___ trick, which chains reliably.
>>>>
>>>> The same issue exists with the variable name: if there are two instanc=
es
>>>> of @local_err, and rule1 matches only one of them, then we nevertheles=
s
>>>> apply the rules chained to rule1 to both.  Can also be wrong.
>>>>
>>>> What are the conditions for "wrong"?
>>>>
>>>> Because the ___ chaining is reliable, we know rule1 matched the
>>>> function, i.e. it has a parameter Error **errp, and it has a automatic
>>>> variable Error *local_err =3D NULL.
>>>>
>>>> We're good as long as *all* identifiers @local_err in this function ar=
e
>>>> declared that way.  This seems quite likely.  It's not certain, though=
.
>>>>
>>>> Since nested declarations of Error ** variables are rare, we can rely =
on
>>>> review to ensure we transform these functions correctly.
>>>>
>>>>> So, dropping inheritance in check-rules makes sence, as it may match
>>>>> (and warn) more interesting cases.
>>>>>
>>>>> But for other rules, I'd prefere to be safer, and explictly inherit a=
ll
>>>>> actually inherited identifiers..
>>>>
>>>> I still can't see what chaining by function name in addition to the __=
_
>>>> chaining buys us.
>>>
>>> I'll check this thing soon. And resend today.
>
> Checked.
>
> Yes, it inherits pair of fn and local_err, and it definitely makes sense.=
 It more stable.
>
> Consider the following example:
>
> # cat a.c
> int f1(Error **errp)
> {
>     Error *err1 =3D NULL;
>     int err2 =3D 0;
>
>     error_propagate(errp, err1);
>
>     return err2;
> }
>
> int f2(Error **errp)
> {
>     Error *err2 =3D NULL;
>     int err1 =3D 0;
>
>     error_propagate(errp, err2);
>
>     return err1;
> }
>
>
> My script works correct and produces this change:
> --- a.c
> +++ /tmp/cocci-output-1753-10842a-a.c
> @@ -1,19 +1,15 @@
>  int f1(Error **errp)
>  {
> -    Error *err1 =3D NULL;
> +    ERRP_AUTO_PROPAGATE();
>      int err2 =3D 0;
>
> -    error_propagate(errp, err1);
> -
>      return err2;
>  }
>
>  int f2(Error **errp)
>  {
> -    Error *err2 =3D NULL;
> +    ERRP_AUTO_PROPAGATE();
>      int err1 =3D 0;
>
> -    error_propagate(errp, err2);
> -
>      return err1;
>  }
>
>
> But yours script is caught:
> --- a.c
> +++ /tmp/cocci-output-1814-b9b681-a.c
> @@ -1,19 +1,15 @@
>  int f1(Error **errp)
>  {
> -    Error *err1 =3D NULL;
> +    ERRP_AUTO_PROPAGATE();
>      int err2 =3D 0;
>
> -    error_propagate(errp, err1);
> -
> -    return err2;
> +    return *errp;
>  }
>
>  int f2(Error **errp)
>  {
> -    Error *err2 =3D NULL;
> +    ERRP_AUTO_PROPAGATE();
>      int err1 =3D 0;
>
> -    error_propagate(errp, err2);
> -
> -    return err1;
> +    return *errp;
>  }
>
>
> - see, it touches err1, which is unrelated to Error in f2. Hmm,
> interesting that it doesn't want to convert err1 declaration:)
>
> - this is because relation between local_err and fn is lost.

Let me try to think this through.

rule1 matches functions that propagate from a local variable @local_err
to parameter @errp.  It uses the ___ hack to reliably tag the function.
Later rules that should only apply to these functions can match ___.

These later rules each provide a part of the total error propagation
transformation.  They must transform exactly the @local_err and @errp
matched by rule1 in each function.

Your solution is to constrain the identifiers, i.e.

    identifier rule1.fn, rule1.local_err;

If rule1 matches only one function named foo(), and within that foo()
the local variable @local_err rule1 matches actually binds all
occurences of the identifier @local_err, the constraint is reliable.

Else, the constraint may still accept occurences of @local_err not bound
to the variable matched by rule1.

Example 1:

    int bar(Error **errp)
    {
        if (pred()) {
            Error *local_err =3D NULL;

            error_setg(&local_err, "zzzt");
            error_propagate(errp, local_err);
        } else {
            int local_err =3D 0;
            return local_err;
        }
        return 0;
    }

rule1 matches the first @local_err variable, and not the second one.  We
must transform occurences of the first one, and not occurences of the
second one.  We do transform all:

     int bar(Error **errp)
     {
    +    ERRP_AUTO_PROPAGATE();
         if (pred()) {
    -        Error *local_err =3D NULL;
    -
    -        error_setg(&local_err, "zzzt");
    -        error_propagate(errp, local_err);
    +        error_setg(errp, "zzzt");
         } else {
             int local_err =3D 0;
    -        return local_err;
    +        return *errp;
         }
         return 0;
     }

Example 2:

    int foo(Error **errp)
    {
        Error *local_err =3D NULL;

        error_setg(&local_err, "zzzt");
        error_propagate(errp, local_err);
        return 0;
    }

    int foo(Error **errp)
    {
        Error *err =3D NULL;
        int local_err =3D 0;

        error_setg(&local_err, "zzzt");
        error_propagate(errp, err);
        return local_err;
    }

rule1 matches @local_err in the first foo(), and @err in the second one.
We must transform @local_err in the first one(), and @err in the second
one.  We do transform both in both:

     int foo(Error **errp)
     {
    -    Error *local_err =3D NULL;
    +    ERRP_AUTO_PROPAGATE();

    -    error_setg(&local_err, "zzzt");
    -    error_propagate(errp, local_err);
    +    error_setg(errp, "zzzt");
         return 0;
     }

     int foo(Error **errp)
     {
    -    Error *err =3D NULL;
    +    ERRP_AUTO_PROPAGATE();
         int local_err =3D 0;

    -    error_setg(&local_err, "zzzt");
    -    error_propagate(errp, err);
    -    return local_err;
    +    error_setg(errp, "zzzt");
    +    return *errp;
     }

Constraining only the variable identifier like I proposed is even less
reliable, as you demonstrated: then the issue in example 2 exists even
for differently named functions.

For a reliable solution, we could use perhaps use the ___ hack again:
have rule1 rename @local_err it actually matches.  But to be honest, my
appetite for another round of wrestling with Coccinelle isn't what it
used to be.

I think we can do without as long as we're well aware of the script's
limitations, and we're confident we can detect problematic cases.

Detecting transformation of multiple functions with the same name should
be easy.

Detecting occurences of identifiers not bound by a certain variable
should be feasible: we find and review every transformed function that
doesn't declare the variable in its outermost scope.

Since "well aware" is going to erode with time, we may want to delete
the script when we're done converting.

> So, understanding that there no such cases in the whole tree, and even
> if your patch works faster on the whole tree, I still don't want to
> drop inheritance, because it's just a correct thing to do. Yes, we've
> added ____ helper. It helps to avoid some problems. Pair-inheritance
> helps to avoid another problems. I understand, that there still may
> other, not-covered problems, but better to be as safe as possible. And
> inheritance here is native and correct thing to do, even with our ____
> additional helper. What do you think?

I wouldn't call it correct.  It's still unreliable, but less so than
without the function name constraint.  That makes it less wrong.

100% reliable would be nice, but not at any cost.  Something we're
reasonably confident to get right should be good enough.

To be confident, we need to understand the script's limitations, and how
to compensate for them.  I figure we do now.  You too?

[...]


