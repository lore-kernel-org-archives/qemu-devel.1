Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092BBC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F7F2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F7F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHuD5-0003rw-2m
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 14:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHuAe-0002dE-OZ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHuAb-0002ak-6C
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:25:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iHuAN-0002Sy-4j; Tue, 08 Oct 2019 14:24:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00E77806A7C;
 Tue,  8 Oct 2019 18:24:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF291001B32;
 Tue,  8 Oct 2019 18:24:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3DE31138648; Tue,  8 Oct 2019 20:24:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 04/31] error: auto propagated local_err
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-5-vsementsov@virtuozzo.com>
 <87k19fgr7i.fsf@dusky.pond.sub.org>
 <20191008181921.288e69e4@bahia.lan>
Date: Tue, 08 Oct 2019 20:24:31 +0200
In-Reply-To: <20191008181921.288e69e4@bahia.lan> (Greg Kurz's message of "Tue, 
 8 Oct 2019 18:19:21 +0200")
Message-ID: <87y2xvccyo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 08 Oct 2019 18:24:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, pburton@wavecomp.com, peter.maydell@linaro.org,
 codyprime@gmail.com, jasowang@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 kraxel@redhat.com, sundeep.lkml@gmail.com, qemu-block@nongnu.org,
 quintela@redhat.com, arikalo@wavecomp.com, mst@redhat.com,
 mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 joel@jms.id.au, marcandre.lureau@redhat.com, rth@twiddle.net,
 farman@linux.ibm.com, ehabkost@redhat.com, sw@weilnetz.de, dgilbert@redhat.com,
 yuval.shaia@oracle.com, alex.williamson@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, clg@kaod.org,
 stefanha@redhat.com, david@redhat.com, jsnow@redhat.com,
 david@gibson.dropbear.id.au, kwolf@redhat.com, integration@gluster.org,
 berrange@redhat.com, andrew@aj.id.au, cohuck@redhat.com, qemu-s390x@nongnu.org,
 mreitz@redhat.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> On Tue, 08 Oct 2019 18:03:13 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>> 
>> > Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
>> > functions with errp OUT parameter.
>> >
>> > It has three goals:
>> >
>> > 1. Fix issue with error_fatal & error_prepend/error_append_hint: user
>> > can't see this additional information, because exit() happens in
>> > error_setg earlier than information is added. [Reported by Greg Kurz]
>> >
>> > 2. Fix issue with error_abort & error_propagate: when we wrap
>> > error_abort by local_err+error_propagate, resulting coredump will
>> > refer to error_propagate and not to the place where error happened.
>> > (the macro itself doesn't fix the issue, but it allows to [3.] drop all
>> > local_err+error_propagate pattern, which will definitely fix the issue)
>> > [Reported by Kevin Wolf]
>> >
>> > 3. Drop local_err+error_propagate pattern, which is used to workaround
>> > void functions with errp parameter, when caller wants to know resulting
>> > status. (Note: actually these functions could be merely updated to
>> > return int error code).
>> 
>> Starting with stating your goals is an excellent idea.  But I'd love to
>> next read a high-level description of how your patch achieves or enables
>> achieving these goals.
>> 
>> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> > ---
>> [...]
>> > diff --git a/include/qapi/error.h b/include/qapi/error.h
>> > index 9376f59c35..02f967ac1d 100644
>> > --- a/include/qapi/error.h
>> > +++ b/include/qapi/error.h
>> > @@ -322,6 +322,43 @@ void error_set_internal(Error **errp,
>> >                          ErrorClass err_class, const char *fmt, ...)
>> >      GCC_FMT_ATTR(6, 7);
>> >  
>> > +typedef struct ErrorPropagator {
>> > +    Error *local_err;
>> > +    Error **errp;
>> > +} ErrorPropagator;
>> > +
>> > +static inline void error_propagator_cleanup(ErrorPropagator *prop)
>> > +{
>> > +    error_propagate(prop->errp, prop->local_err);
>> > +}
>> > +
>> > +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
>> > +
>> > +/*
>> > + * ERRP_AUTO_PROPAGATE
>> > + *
>> > + * This macro is created to be the first line of a function with Error **errp
>> > + * OUT parameter. It's needed only in cases where we want to use error_prepend,
>> > + * error_append_hint or dereference *errp. It's still safe (but useless) in
>> > + * other cases.
>> > + *
>> > + * If errp is NULL or points to error_fatal, it is rewritten to point to a
>> > + * local Error object, which will be automatically propagated to the original
>> > + * errp on function exit (see error_propagator_cleanup).
>> > + *
>> > + * After invocation of this macro it is always safe to dereference errp
>> > + * (as it's not NULL anymore) and to append hints (by error_append_hint)
>> > + * (as, if it was error_fatal, we swapped it with a local_error to be
>> > + * propagated on cleanup).
>> 
>> Well, appending hints was always safe, it just didn't work with
>> &error_fatal.  Don't worry about that now, I'll probably want to polish
>> this contract comment a bit anyway, but later.
>> 
>
> FWIW I've already posted this:
>
> Author: Greg Kurz <groug@kaod.org>
> Date:   Mon Oct 7 15:45:46 2019 +0200
>
>     error: Update error_append_hint()'s documenation
>     
>     error_setg() and error_propagate(), as well as their variants, cause
>     QEMU to terminate when called with &error_fatal or &error_abort. This
>     prevents to add hints since error_append_hint() isn't even called in
>     this case.
>     
>     It means that error_append_hint() should only be used with a local
>     error object, and then propagate this local error to the caller.
>     
>     Document this in <qapi/error.h> .
>     
>     Signed-off-by: Greg Kurz <groug@kaod.org>
>
> Message-id: <156871563702.196432.5964411202152101367.stgit@bahia.lan>
> https://patchwork.ozlabs.org/patch/1163278/

I marked your series containing this patch for review.  I decided to
review this one first.  I clearly need look at yours as well before I
can advise on how to proceed.

[...]

