Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E192C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A74206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iC27+aA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A74206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsssM-0004cW-Aw
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 15:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jssrn-00048J-3p
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:02:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jssrl-0001ZK-CL
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594148572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KI8ePZl9TDbDjrxDfDqnNlC+04UP8bDvXEL9iQK5BS0=;
 b=iC27+aA9gZAM60NS9TMAVcixBOAGLkOLaKBnvjK3PPItabGdu7WmSxyd8oM8+MqBpyy+b8
 /XXEABqx+Rk0w5gu/etLCH++VNgcQ4cjmYgiQnIZ2t9dkOlM1cBQcovlka+lrxFiVrOK9F
 FR4h2TnU4o+imn1AmlMRqsHvo1llGS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-UBMfkjp5NNKkrI0n77hKaA-1; Tue, 07 Jul 2020 15:02:50 -0400
X-MC-Unique: UBMfkjp5NNKkrI0n77hKaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED476107ACCD;
 Tue,  7 Jul 2020 19:02:48 +0000 (UTC)
Received: from [10.3.115.46] (ovpn-115-46.phx2.redhat.com [10.3.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED170797F3;
 Tue,  7 Jul 2020 19:02:41 +0000 (UTC)
Subject: Re: [PATCH v12 1/8] error: New macro ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200707165037.1026246-1-armbru@redhat.com>
 <20200707165037.1026246-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <afd4b693-2aec-247b-c0a7-7d061ed5bdff@redhat.com>
Date: Tue, 7 Jul 2020 14:02:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707165037.1026246-2-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
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
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, groug@kaod.org,
 Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 11:50 AM, Markus Armbruster wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Introduce a new ERRP_AUTO_PROPAGATE macro, to be used at start of
> functions with an errp OUT parameter.
> 
> It has three goals:
> 
> 1. Fix issue with error_fatal and error_prepend/error_append_hint: user

the user

> can't see this additional information, because exit() happens in
> error_setg earlier than information is added. [Reported by Greg Kurz]
> 
> 2. Fix issue with error_abort and error_propagate: when we wrap
> error_abort by local_err+error_propagate, the resulting coredump will
> refer to error_propagate and not to the place where error happened.
> (the macro itself doesn't fix the issue, but it allows us to [3.] drop
> the local_err+error_propagate pattern, which will definitely fix the
> issue) [Reported by Kevin Wolf]
> 
> 3. Drop local_err+error_propagate pattern, which is used to workaround
> void functions with errp parameter, when caller wants to know resulting
> status. (Note: actually these functions could be merely updated to
> return int error code).
> 
> To achieve these goals, later patches will add invocations
> of this macro at the start of functions with either use
> error_prepend/error_append_hint (solving 1) or which use
> local_err+error_propagate to check errors, switching those
> functions to use *errp instead (solving 2 and 3).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Paul Durrant <paul@xen.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> [Comments merged properly with recent commit "error: Document Error
> API usage rules", and edited for clarity.  Put ERRP_AUTO_PROPAGATE()
> before its helpers, and touch up style.  Commit message tweaked.]
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/error.h | 160 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 141 insertions(+), 19 deletions(-)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 3fed49747d..c865a7d2f1 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h

> @@ -128,18 +122,26 @@
>    *         handle the error...
>    *     }
>    * when it doesn't, say a void function:
> + *     ERRP_AUTO_PROPAGATE();
> + *     foo(arg, errp);
> + *     if (*errp) {
> + *         handle the error...
> + *     }
> + * More on ERRP_AUTO_PROPAGATE() below.
> + *
> + * Code predating ERRP_AUTO_PROPAGATE() still exits, and looks like this:

exists

>    *     Error *err = NULL;
>    *     foo(arg, &err);
>    *     if (err) {
>    *         handle the error...
> - *         error_propagate(errp, err);
> + *         error_propagate(errp, err); // deprecated
>    *     }
> - * Do *not* "optimize" this to
> + * Avoid in new code.  Do *not* "optimize" it to
>    *     foo(arg, errp);
>    *     if (*errp) { // WRONG!
>    *         handle the error...
>    *     }
> - * because errp may be NULL!
> + * because errp may be NULL!  Guard with ERRP_AUTO_PROPAGATE().

maybe:

because errp may be NULL without the ERRP_AUTO_PROPAGATE() guard.

>    *
>    * But when all you do with the error is pass it on, please use
>    *     foo(arg, errp);
> @@ -158,6 +160,19 @@
>    *         handle the error...
>    *     }
>    *
> + * Pass an existing error to the caller:

> + * = Converting to ERRP_AUTO_PROPAGATE() =
> + *
> + * To convert a function to use ERRP_AUTO_PROPAGATE():
> + *
> + * 0. If the Error ** parameter is not named @errp, rename it to
> + *    @errp.
> + *
> + * 1. Add an ERRP_AUTO_PROPAGATE() invocation, by convention right at
> + *    the beginning of the function.  This makes @errp safe to use.
> + *
> + * 2. Replace &err by errp, and err by *errp.  Delete local variable
> + *    @err.
> + *
> + * 3. Delete error_propagate(errp, *errp), replace
> + *    error_propagate_prepend(errp, *errp, ...) by error_prepend(errp, ...),
> + *

Why a comma here?

> + * 4. Ensure @errp is valid at return: when you destroy *errp, set
> + *    errp = NULL.
> + *
> + * Example:
> + *
> + *     bool fn(..., Error **errp)
> + *     {
> + *         Error *err = NULL;
> + *
> + *         foo(arg, &err);
> + *         if (err) {
> + *             handle the error...
> + *             error_propagate(errp, err);
> + *             return false;
> + *         }
> + *         ...
> + *     }
> + *
> + * becomes
> + *
> + *     bool fn(..., Error **errp)
> + *     {
> + *         ERRP_AUTO_PROPAGATE();
> + *
> + *         foo(arg, errp);
> + *         if (*errp) {
> + *             handle the error...
> + *             return false;
> + *         }
> + *         ...
> + *     }

Do we want the example to show the use of error_free and *errp = NULL?

Otherwise, this is looking good to me.  It will need a tweak if we go 
with the shorter name ERRP_GUARD, but I like that idea.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


