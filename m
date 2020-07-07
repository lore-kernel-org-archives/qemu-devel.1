Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E22C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1749720771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8DK4y4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1749720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jstnF-0003WY-5R
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 16:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jstmc-0002xI-Hf
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:01:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55190
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jstma-000215-O7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594152095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ANH7oWwKRrDk54ynkXpx8px3Vbl0w8cuK3dMy77nJTc=;
 b=T8DK4y4x6YcASypOBQbxNOZwM8E0AWWNJsqEjsgWJAxsyPMM+8JA0dIGrxyUOraKj6k5AY
 kJ+oSJSJO8gvUyHRw3GS48rj5aeaLebgCSviPzGD1yBmFsG3c4sXD7P7MYRTNSvvM36XxM
 hYDz83oVjp9QbboE2jWwVkSye56+xT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-PFsI-5sUPva7wvO5__2oNg-1; Tue, 07 Jul 2020 16:01:32 -0400
X-MC-Unique: PFsI-5sUPva7wvO5__2oNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 717C318FE860;
 Tue,  7 Jul 2020 20:01:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F079E1A835;
 Tue,  7 Jul 2020 20:01:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BAA71132FD2; Tue,  7 Jul 2020 22:01:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v12 1/8] error: New macro ERRP_AUTO_PROPAGATE()
References: <20200707165037.1026246-1-armbru@redhat.com>
 <20200707165037.1026246-2-armbru@redhat.com>
 <afd4b693-2aec-247b-c0a7-7d061ed5bdff@redhat.com>
Date: Tue, 07 Jul 2020 22:01:21 +0200
In-Reply-To: <afd4b693-2aec-247b-c0a7-7d061ed5bdff@redhat.com> (Eric Blake's
 message of "Tue, 7 Jul 2020 14:02:41 -0500")
Message-ID: <87h7uj6qni.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, groug@kaod.org,
 Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 7/7/20 11:50 AM, Markus Armbruster wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Introduce a new ERRP_AUTO_PROPAGATE macro, to be used at start of
>> functions with an errp OUT parameter.
>>
>> It has three goals:
>>
>> 1. Fix issue with error_fatal and error_prepend/error_append_hint: user
>
> the user

Yes.

>> can't see this additional information, because exit() happens in
>> error_setg earlier than information is added. [Reported by Greg Kurz]
>>
>> 2. Fix issue with error_abort and error_propagate: when we wrap
>> error_abort by local_err+error_propagate, the resulting coredump will
>> refer to error_propagate and not to the place where error happened.
>> (the macro itself doesn't fix the issue, but it allows us to [3.] drop
>> the local_err+error_propagate pattern, which will definitely fix the
>> issue) [Reported by Kevin Wolf]
>>
>> 3. Drop local_err+error_propagate pattern, which is used to workaround
>> void functions with errp parameter, when caller wants to know resulting
>> status. (Note: actually these functions could be merely updated to
>> return int error code).
>>
>> To achieve these goals, later patches will add invocations
>> of this macro at the start of functions with either use
>> error_prepend/error_append_hint (solving 1) or which use
>> local_err+error_propagate to check errors, switching those
>> functions to use *errp instead (solving 2 and 3).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Paul Durrant <paul@xen.org>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> [Comments merged properly with recent commit "error: Document Error
>> API usage rules", and edited for clarity.  Put ERRP_AUTO_PROPAGATE()
>> before its helpers, and touch up style.  Commit message tweaked.]
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qapi/error.h | 160 ++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 141 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index 3fed49747d..c865a7d2f1 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>
>> @@ -128,18 +122,26 @@
>>    *         handle the error...
>>    *     }
>>    * when it doesn't, say a void function:
>> + *     ERRP_AUTO_PROPAGATE();
>> + *     foo(arg, errp);
>> + *     if (*errp) {
>> + *         handle the error...
>> + *     }
>> + * More on ERRP_AUTO_PROPAGATE() below.
>> + *
>> + * Code predating ERRP_AUTO_PROPAGATE() still exits, and looks like this:
>
> exists

Fixing...

>>    *     Error *err = NULL;
>>    *     foo(arg, &err);
>>    *     if (err) {
>>    *         handle the error...
>> - *         error_propagate(errp, err);
>> + *         error_propagate(errp, err); // deprecated
>>    *     }
>> - * Do *not* "optimize" this to
>> + * Avoid in new code.  Do *not* "optimize" it to
>>    *     foo(arg, errp);
>>    *     if (*errp) { // WRONG!
>>    *         handle the error...
>>    *     }
>> - * because errp may be NULL!
>> + * because errp may be NULL!  Guard with ERRP_AUTO_PROPAGATE().
>
> maybe:
>
> because errp may be NULL without the ERRP_AUTO_PROPAGATE() guard.

Sold.

>>    *
>>    * But when all you do with the error is pass it on, please use
>>    *     foo(arg, errp);
>> @@ -158,6 +160,19 @@
>>    *         handle the error...
>>    *     }
>>    *
>> + * Pass an existing error to the caller:
>
>> + * = Converting to ERRP_AUTO_PROPAGATE() =
>> + *
>> + * To convert a function to use ERRP_AUTO_PROPAGATE():
>> + *
>> + * 0. If the Error ** parameter is not named @errp, rename it to
>> + *    @errp.
>> + *
>> + * 1. Add an ERRP_AUTO_PROPAGATE() invocation, by convention right at
>> + *    the beginning of the function.  This makes @errp safe to use.
>> + *
>> + * 2. Replace &err by errp, and err by *errp.  Delete local variable
>> + *    @err.
>> + *
>> + * 3. Delete error_propagate(errp, *errp), replace
>> + *    error_propagate_prepend(errp, *errp, ...) by error_prepend(errp, ...),
>> + *
>
> Why a comma here?

Editing accident.

>> + * 4. Ensure @errp is valid at return: when you destroy *errp, set
>> + *    errp = NULL.
>> + *
>> + * Example:
>> + *
>> + *     bool fn(..., Error **errp)
>> + *     {
>> + *         Error *err = NULL;
>> + *
>> + *         foo(arg, &err);
>> + *         if (err) {
>> + *             handle the error...
>> + *             error_propagate(errp, err);
>> + *             return false;
>> + *         }
>> + *         ...
>> + *     }
>> + *
>> + * becomes
>> + *
>> + *     bool fn(..., Error **errp)
>> + *     {
>> + *         ERRP_AUTO_PROPAGATE();
>> + *
>> + *         foo(arg, errp);
>> + *         if (*errp) {
>> + *             handle the error...
>> + *             return false;
>> + *         }
>> + *         ...
>> + *     }
>
> Do we want the example to show the use of error_free and *errp = NULL?

Yes, but we're running out of time, so let's do it in the series that
introduces the usage to the code.

> Otherwise, this is looking good to me.  It will need a tweak if we go
> with the shorter name ERRP_GUARD, but I like that idea.

Tweaking away...

Thanks!


