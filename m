Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939D3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF74206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rh4Q0r7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF74206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsuSP-0001cI-Iz
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 16:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsuRQ-0000yB-Q9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:43:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsuRN-00087a-VJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594154625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OSUiNs2fk9vf5Yf2XiF6PjTmNHMFGvknvlUiA71OCsM=;
 b=Rh4Q0r7ejKxC1OIDP6ULDAfjSkXNmN3fQ2YU5x7iQ05ICGt8SAY3yIsE/Ebk+tX4TFsKv/
 E7C7BDg6lHy7cFl545iv3Y51okaHcDK0koONqztuQz7LCEqhmXYeXQ+5zl2sgq+YRihLmy
 7EzThPEx3lpk0tV9Gw/dZ9xrk5DQ2Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-RP6EYJbuNYOpi3320bjyLw-1; Tue, 07 Jul 2020 16:43:41 -0400
X-MC-Unique: RP6EYJbuNYOpi3320bjyLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 368F1108BD15;
 Tue,  7 Jul 2020 20:43:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAC8110013C2;
 Tue,  7 Jul 2020 20:43:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FE451132FD2; Tue,  7 Jul 2020 22:43:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v12 1/8] error: New macro ERRP_AUTO_PROPAGATE()
References: <20200707165037.1026246-1-armbru@redhat.com>
 <20200707165037.1026246-2-armbru@redhat.com>
 <3bea211a-4522-f713-2edc-261730702114@virtuozzo.com>
Date: Tue, 07 Jul 2020 22:43:29 +0200
In-Reply-To: <3bea211a-4522-f713-2edc-261730702114@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 7 Jul 2020 23:08:19 +0300")
Message-ID: <87a70b5a4u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, groug@kaod.org,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 07.07.2020 19:50, Markus Armbruster wrote:
>> From: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
>>
>> Introduce a new ERRP_AUTO_PROPAGATE macro, to be used at start of
>> functions with an errp OUT parameter.
>>
>> It has three goals:
>>
>> 1. Fix issue with error_fatal and error_prepend/error_append_hint: user
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
>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
>> Reviewed-by: Paul Durrant<paul@xen.org>
>> Reviewed-by: Greg Kurz<groug@kaod.org>
>> Reviewed-by: Eric Blake<eblake@redhat.com>
>> [Comments merged properly with recent commit "error: Document Error
>> API usage rules", and edited for clarity.  Put ERRP_AUTO_PROPAGATE()
>> before its helpers, and touch up style.  Commit message tweaked.]
>> Signed-off-by: Markus Armbruster<armbru@redhat.com>
>
> Ok, I see you have mostly rewritten the big comment

Guilty as charged...  I was happy with the contents you provided (and
grateful for it), but our parallel work caused some redundancy.  I went
beyond a minimal merge to get a something that reads as one coherent
text.

> and not only in this patch, so, I go and read the whole comment on top of these series.
>
> =================================
>
>    * Pass an existing error to the caller with the message modified:
>    *     error_propagate_prepend(errp, err,
>    *                             "Could not frobnicate '%s': ", name);
>    * This is more concise than
>    *     error_propagate(errp, err); // don't do this
>    *     error_prepend(errp, "Could not frobnicate '%s': ", name);
>    * and works even when @errp is &error_fatal.
>
> - the latter doesn't consider ERRP_AUTO_PROPAGATE: as we know, that ERRP_AUTO_PROPAGATE should be used when we use error_prepend, the latter should look like
>
>
> ERRP_AUTO_PROPAGATE();
> ...
> error_propagate(errp, err); // don't do this
> error_prepend(errp, "Could not frobnicate '%s': ", name);
>
> - and it works even when @errp is &error_fatal, so the error_propagate_prepend now is just a shortcut, not the only correct way.

I can duplicate the advice from the paragraph preceding it, like this:

     * This is rarely needed.  When @err is a local variable, use of
     * ERRP_GUARD() commonly results in more readable code.
     * Where it is needed, it is more concise than
     *     error_propagate(errp, err); // don't do this
     *     error_prepend(errp, "Could not frobnicate '%s': ", name);
     * and works even when @errp is &error_fatal.

> Still, the text is formally correct as is, and may be improved later.
>
> =================================
>
>    * 2. Replace &err by errp, and err by *errp.  Delete local variable
>    *    @err.
>
> - hmm a bit not obvious,, It can be local_err.

Yes, but I trust the reader can make that mental jump.

> It can be (in some rare cases) still needed to handle the error locally, not passing to the caller..

I didn't think of this.

What about

     * To convert a function to use ERRP_GUARD(), assuming the local
     * variable it propagates to @errp is called @err:
     [...]
     * 2. Replace &err by errp, and err by *errp.  Delete local variable
     *    @err if it s now unused.

Nope, still no good, if we replace like that, @err *will* be unused, and
the locally handled error will leak to the caller.

No time left for wordsmithing; let's improve on top.

> may be just something like "Assume local Error *err variable is used to get errors from called functions and than propagated to caller's errp" before paragraph [2.] will help.
>
>
>    *
>    * 3. Delete error_propagate(errp, *errp), replace
>    *    error_propagate_prepend(errp, *errp, ...) by error_prepend(errp, ...),
>    *
>    * 4. Ensure @errp is valid at return: when you destroy *errp, set
>    *    errp = NULL.
>
> =================================
>
>
> May be good to add note about ERRP_AUTO_PROPAGATE() into comment above error_append_hint (and error_(v)prepend)).

Good point.

> =================================
>
>   /*
>    * Make @errp parameter easier to use regardless of argument value
>
> may be s/argument/its/
>
>    *
>    * This macro is for use right at the beginning of a function that
>    * takes an Error **errp parameter to pass errors to its caller.  The
>    * parameter must be named @errp.
>    *
>    * It must be used when the function dereferences @errp or passes
>    * @errp to error_prepend(), error_vprepend(), or error_append_hint().
>    * It is safe to use even when it's not needed, but please avoid
>    * cluttering the source with useless code.
>    *
>    * If @errp is NULL or &error_fatal, rewrite it to point to a local
>    * Error variable, which will be automatically propagated to the
>    * original @errp on function exit.
>    *
>    * Note: &error_abort is not rewritten, because that would move the
>    * abort from the place where the error is created to the place where
>    * it's propagated.
>    */
>
> =================================
>
>
> All these are minor, the documentation is good as is, thank you!

Thanks for your review, and your patience!


