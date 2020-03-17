Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	YOU_INHERIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC7CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0656E20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNwtkO0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0656E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9hE-0007jL-6M
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jE9dI-0002a5-EM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jE9dG-0007AW-Ic
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:39:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jE9dG-000767-CU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584441573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7/q2r8eHhu1Tof18xlulApDVDHs4u/ktWqfFPWtBs4=;
 b=hNwtkO0ehnJ6CtDr6HGnPqXtQTARhxcS9xj1lV/tJ7A2m9NCH28dTHXvUoeBPeneiWYCsn
 HclbqHB2lWr5ArNtEAeIJwssPlFAHqPFhZ2NUV+U5qqm05pPR9zh91q4d1B0hpkVaKGkUy
 PEXmkMSjkOrCPHkP/q2kRKzwXayB7bY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-zcAcngZvNz2rTbBFGklYBg-1; Tue, 17 Mar 2020 06:39:30 -0400
X-MC-Unique: zcAcngZvNz2rTbBFGklYBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8261D18B9F19;
 Tue, 17 Mar 2020 10:39:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C70AB5C1BB;
 Tue, 17 Mar 2020 10:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B7831138404; Tue, 17 Mar 2020 11:39:21 +0100 (CET)
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
Date: Tue, 17 Mar 2020 11:39:21 +0100
In-Reply-To: <db2fa8a3-48cc-51aa-a3d5-eba88fb29f66@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 17 Mar 2020 12:29:13 +0300")
Message-ID: <87wo7jqn8m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 16.03.2020 11:21, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> On 14.03.2020 00:54, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>
>>>>> 13.03.2020 18:42, Markus Armbruster wrote:
>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>>
>>>>>>> 12.03.2020 19:36, Markus Armbruster wrote:
>>>>>>>> I may have a second look tomorrow with fresher eyes, but let's get=
 this
>>>>>>>> out now as is.
>>>>>>>>
>>>>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
[...]
>>>>>>>>> +@@
>>>>>>>>> +
>>>>>>>>> + fn(..., Error ** ____, ...)
>>>>>>>>> + {
>>>>>>>>> +     ...
>>>>>>>>> +     Error *local_err =3D NULL;
>>>>>>>>> +     ... when any
>>>>>>>>> +     Error *local_err2 =3D NULL;
>>>>>>>>> +     ... when any
>>>>>>>>> + }
>>>>
>>>> This flags functions that have more than one declaration along any
>>>> control flow path.  It doesn't flag this one:
>>>>
>>>>       void gnat(bool b, Error **errp)
>>>>       {
>>>>           if (b) {
>>>>               Error *local_err =3D NULL;
>>>>               foo(arg, &local_err);
>>>>               error_propagate(errp, local_err);
>>>>           } else {
>>>>               Error *local_err =3D NULL;
>>>>               bar(arg, &local_err);
>>>>               error_propagate(errp, local_err);
>>>>           }
>>>>       }
>>>>
>>>> The Coccinelle script does the right thing for this one regardless.
>>>>
>>>> I'd prefer to have such functions flagged, too.  But spending time on
>>>> convincing Coccinelle to do it for me is not worthwhile; I can simply
>>>> search the diff produced by Coccinelle for deletions of declarations
>>>> that are not indented exactly four spaces.
>>>>
>>>> But if we keep this rule, we should adjust its comment
>>>>
>>>>       // Warn several Error * definitions.
>>>>
>>>> because it sure suggests it also catches functions like the one I gave
>>>> above.
>>>
>>> Hmm, yes.. We can write "Warn several Error * definitions in _one_
>>> control flow (it's not so trivial to match _any_ case with several
>>> definitions with coccinelle)" or something like this.
>>
>> Ha, "trivial" reminds me of a story.  The math professor, after having
>> spent a good chunk of his lecture developing a proof on the blackboad
>> turns to the audience to explain why this little part doesn't require
>> proof with the words familiar to any math student "and this is trivial."
>> Pause, puzzled look...  "Is it trivial?"  Pause, storms out of the
>> lecture hall.  A minute or three pass.  Professor comes back beaming,
>> "it is trivial!", and proceeds with the proof.
>>
>> My point is: it might be trivial with Coccinelle once you know how to do
>> it.  We don't.
>>
>> Suggest "(can't figure out how to match several definitions regardless
>> of control flow)".
>
> Wrong too, because I can:) for example, chaining two rules, catching the
> positions of definition and check that they are different.. Or, some
> cheating with python script.. That's why I wrote "not trivial",
>
> So, most correct would be "(can't figure out how to simply match several =
definitions regardless
>> of control flow)".

Works for me.

> But again, coccinelle is for matching control flows, so its probably impo=
ssible to match such thing..
[...]
>>> OK, I almost OK with it, the only thing I doubt a bit is the following:
>>>
>>> We want to keep rule1.local_err inheritance to keep connection with
>>> local_err definition.
>>
>> Yes.
>>
>>> Interesting, when we have both rule1.fn and rule1.local_err inherited,
>>> do we inherit them in separate (i.e. all possible combinations of fn
>>> and local_err symbols from rule1) or do we inherit a pair, i.e. only
>>> fn/local_err pairs, found by rule1? If the latter is correct, that
>>> with your script we loss this pair inheritance, and go to all possible
>>> combinations of fn and local_err from rule1, possibly adding some wrong
>>> conversion (OK, you've checked that no such cases in current code tree)=
.
>>
>> The chaining "identifier rule1.FOO" is by name.  It's reliable only as
>> long as there is exactly one instance of the name.
>>
>> We already discussed the case of the function name: if there are two
>> instances of foo(), and rule1 matches only one of them, then we
>> nevertheless apply the rules chained to rule1 to both.  Because that can
>> be wrong, you came up with the ___ trick, which chains reliably.
>>
>> The same issue exists with the variable name: if there are two instances
>> of @local_err, and rule1 matches only one of them, then we nevertheless
>> apply the rules chained to rule1 to both.  Can also be wrong.
>>
>> What are the conditions for "wrong"?
>>
>> Because the ___ chaining is reliable, we know rule1 matched the
>> function, i.e. it has a parameter Error **errp, and it has a automatic
>> variable Error *local_err =3D NULL.
>>
>> We're good as long as *all* identifiers @local_err in this function are
>> declared that way.  This seems quite likely.  It's not certain, though.
>>
>> Since nested declarations of Error ** variables are rare, we can rely on
>> review to ensure we transform these functions correctly.
>>
>>> So, dropping inheritance in check-rules makes sence, as it may match
>>> (and warn) more interesting cases.
>>>
>>> But for other rules, I'd prefere to be safer, and explictly inherit all
>>> actually inherited identifiers..
>>
>> I still can't see what chaining by function name in addition to the ___
>> chaining buys us.
>
> I'll check this thing soon. And resend today.
>
>>
>>>                                   Still, I feel, we'll never be
>>> absolutely safe with coccinelle :)
>>
>> Right, although this particular problem is not really Coccinelle's
>> fault.  Blindly treating all instances of a certain identifier in a
>> certain area the same regardless of how they are bound to declarations
>> is fundamentally unreliable, regardless of your actual tooling.
>>
>
> Yes, still interesting, can coccinelle do more smart inheritance to match
> exactly same object... I think, I need to CC coccinelle mailing list
> to the next version

I'love to get taught how to chain reliably.


