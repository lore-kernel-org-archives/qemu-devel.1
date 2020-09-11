Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1544EC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E3921D79
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfLIGAz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E3921D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGku2-0001I3-Om
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kGktD-00008Y-Mp
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kGktB-0006Fj-Lu
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599837780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AFaxGIN8TsWlj9N9k0EUhnitA/ikjRd8nhxZeJsdt1E=;
 b=JfLIGAz5E5e4ecdOyhAEFQubO0oDKTbjoF9QF+KdXCuC2F5pkXXAOuUObrbt++fgyr2m44
 IwVlUWggIplcUW2Ra4ITFr/yWQ9WkEB61juCjU+GkG4PYGmvEZgUG/GTth79VD2iJerwrb
 hVezj5Fk1YxurbniZUs1Oeik5S6a0e0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-yFPPBFH7MkSPptjhnyG38A-1; Fri, 11 Sep 2020 11:22:56 -0400
X-MC-Unique: yFPPBFH7MkSPptjhnyG38A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 575BF10BBEDB;
 Fri, 11 Sep 2020 15:22:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC68C60C04;
 Fri, 11 Sep 2020 15:22:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 12E28113865F; Fri, 11 Sep 2020 17:22:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 11/14] block/qcow2-bitmap: return startus from
 qcow2_store_persistent_dirty_bitmaps
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-12-vsementsov@virtuozzo.com>
 <20200911113838.482b062e@bahia.lan>
 <2d8099d0-c04c-8b91-fd1e-f988cbba14ce@virtuozzo.com>
 <20200911132152.01855289@bahia.lan>
 <12a7ab93-6545-a221-e9ff-4328c781fbb3@virtuozzo.com>
Date: Fri, 11 Sep 2020 17:22:41 +0200
In-Reply-To: <12a7ab93-6545-a221-e9ff-4328c781fbb3@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 11 Sep 2020 14:39:27 +0300")
Message-ID: <87r1r8cp8e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, berto@igalia.com, pavel.dovgaluk@ispras.ru,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com,
 armbru@redhat.com, Greg Kurz <groug@kaod.org>, stefanha@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 11.09.2020 14:21, Greg Kurz wrote:
>> On Fri, 11 Sep 2020 13:18:32 +0300
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>=20
>>> 11.09.2020 12:38, Greg Kurz wrote:
>>>> s/startus/status
>>>>
>>>> On Wed,  9 Sep 2020 21:59:27 +0300
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>>>
>>>>> It's better to return status together with setting errp. It makes
>>>>> possible to avoid error propagation.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>>>> ---
>>>>>    block/qcow2.h        |  2 +-
>>>>>    block/qcow2-bitmap.c | 13 ++++++-------
>>>>>    2 files changed, 7 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>>>> index e7e662533b..49824be5c6 100644
>>>>> --- a/block/qcow2.h
>>>>> +++ b/block/qcow2.h
>>>>> @@ -972,7 +972,7 @@ bool qcow2_get_bitmap_info_list(BlockDriverState =
*bs,
>>>>>                                    Qcow2BitmapInfoList **info_list, E=
rror **errp);
>>>>>    int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
>>>>>    int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **err=
p);
>>>>> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>>                                              bool release_stored, Err=
or **errp);
>>>>>    int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
>>>>>    bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>>>> index f58923fce3..5eeff1cb1c 100644
>>>>> --- a/block/qcow2-bitmap.c
>>>>> +++ b/block/qcow2-bitmap.c
>>>>> @@ -1524,9 +1524,10 @@ out:
>>>>>     * readonly to begin with, and whether we opened directly or reope=
ned to that
>>>>>     * state shouldn't matter for the state we get afterward.
>>>>>     */
>>>>> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
>>>>>                                              bool release_stored, Err=
or **errp)
>>>>>    {
>>>>> +    ERRP_GUARD();
>>>>
>>>> Maybe worth mentioning in the changelog that this ERRP_GUARD() fixes
>>>> an error_prepend(errp, ...) not visible in the patch context.
>>>
>>> Ah yes. Actually this is occasional thing I didn't want to include into=
 this patch
>>> (and int this part I). So we can just drop it and leave for part II or =
part III,
>>> or add a note into commit message

Either works for me.

>>>>
>>>> Anyway,
>>>>
>>>> Reviewed-by: Greg Kurz <groug@kaod.org>
>>>
>>> Thanks a lot for reviewing :)
>>>
>> Don't mention it :)
>>=20
>>> Hmm.. With this series I understand the following:
>>>
>>> 1. It's no sense in simple applying scripts/coccinelle/errp-guard.cocci=
 to the whole code-base, because:
>>>
>>>     - it produces a lot of "if (*errp)" in places where it is really si=
mple to avoid error propagation at all, like in this series
>>>     - reviewing is the hardest part of the process
>>>
>>> So, if we have to review these changes anyway, it's better to invest a =
bit more time into patch creation, and make code correspond to our modern e=
rror API recommendations.

Yes, going the extra mile is better.

I recommend it for code that is actively maintained.  Making the code
simpler and thus easier to maintain is an investment that'll pay off.

We may have code where it won't pay off.  Do you think a blind
application of errp-guard.cocci might be better than nothing there?

>>> 2. So, the process turns into following steps:
>>>
>>>     - apply scripts/coccinelle/errp-guard.cocci
>>>     - look through patches and do obvious refactorings (like this serie=
s)
>>>     - keep ERRP_GUARD where necessary (appending info to error, or wher=
e refactoring of function return status is too invasive and not simple)
>>>
>> I've started to follow this process for the spapr code and, indeed,
>> I
>> can come up with better changes by refactoring some code manually.
>> Some of these changes are not that obvious that they could be made
>> by someone who doesn't know the code, so I tend to agree with your
>> arguments in 1.
>> This is also the reason I didn't review patches 10, 13 and 14
>> because
>> they looked like I should understand the corresponding code a bit more.
>>=20
>>> 3. Obviously, that's too much for me :) Of course, I will invest some t=
ime into making the series like this one, and reviewing them, but I can't d=
o it for weeks and months. (My original =D1=81unning plan to simply push ~1=
00 generated commits with my s-o-b and become the greatest contributor fail=
ed:)

LOL

A lesser craftsman than you would've peddled the generated commits
anyway.  Props!

>> Ha ha :D ... as a consolation prize, maybe we can reach a fair
>> number
>> of r-b by reviewing each other's _simple_ cleanups ;-)
>>=20
>>> The good thing is that now, with ERRP_GUARD finally merged, we can prod=
uce parallel series like this, and they will be processed in parallel by di=
fferent maintainers (and Markus will have to merge series for subsystems wi=
th unavailable maintainers).

If people care enough about [2] to submit patches, I'll feel obliged to
help merging them.

>> This sounds nice. My only concern would be to end up fixing code
>> nobody
>> uses or cares for, so I guess it would be better that active maintainers
>> or supporters give impetus on that.

A bit of weeding on the side is always appreciated, but please don't
feel obliged to sink lots of time into code you don't care about.

>>> So, everybody is welcome to the process [2]. Probably we want to make a=
 separate announcement in a list with short recommendations and instruction=
s? But who read announcements..
>
>> I don't :) but the very massive series that were posted on the topic
>> the last few months look like an announcement to me, at least for
>> active maintainers and supporters.
>
> Aha, I know. Better than announcement is improving checkpatch.

Yes, automated feedback works best.

Relentless pressure from reviewers can also work in the long, long run.
But it's tiresome.

Of course, checkpatch.pl checks only new or changed code.  Any ideas on
how to make people aware of the opportunity to simplify their existing
code?  Obvious: posting more patches simplifying existing code we care
about.  Any other smart ideas?


