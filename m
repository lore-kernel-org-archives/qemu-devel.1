Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B35C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32A92084D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qxc1/WTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32A92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaRXK-0001Pb-R2
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 16:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaQRN-0006WU-SD
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaQQC-0000hM-9O
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:29:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaQQB-0000Sb-CM
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574972982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmVjT4woYxZbkHElSChMYDacSehKi1TecYyA7GhSlHY=;
 b=Qxc1/WTNkmqxT2XAZWx6oDbyLXNq/fDvVwK1mJ3BxhbAC7jhep8xmuC8PXHi315TbC4ksK
 s68UDb37LpuYIMzbyhjcqI2w0wtCrjzGI23Zqp7EY++mDxDbXYtDLh/lnRUOLD61rbKOL5
 sPlfguL2hPDGqnPkiyjABstSEvWljhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-pnN-o-muPbem27n2GnJ10g-1; Thu, 28 Nov 2019 15:29:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE3471800D52;
 Thu, 28 Nov 2019 20:29:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52A6C600C8;
 Thu, 28 Nov 2019 20:29:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D5A481138606; Thu, 28 Nov 2019 21:29:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] error: rename errp to errp_in where it is IN-argument
References: <20191127183704.14825-1-vsementsov@virtuozzo.com>
 <878so05bca.fsf@dusky.pond.sub.org>
 <f901e0db-61df-898f-ce18-096bfeadf525@virtuozzo.com>
Date: Thu, 28 Nov 2019 21:29:35 +0100
In-Reply-To: <f901e0db-61df-898f-ce18-096bfeadf525@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 28 Nov 2019 14:54:36 +0000")
Message-ID: <87mucf218w.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: pnN-o-muPbem27n2GnJ10g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 28.11.2019 17:23, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>=20
>>> Error **errp is almost always OUT-argument: it's assumed to be NULL, or
>>> pointer to NULL-initialized pointer, or pointer to error_abort or
>>> error_fatal, for callee to report error.
>>>
>>> But very few functions instead get Error **errp as IN-argument:
>>> it's assumed to be set (or, maybe, NULL), and callee should clean it,
>>> or add some information.
>>>
>>> In such cases, rename errp to errp_in.
>>=20
>> Missing: why is the rename useful?
>
> The main reason is to prepare for coccinelle part.

It's not a prerequisite for applying the patches Coccinelle produces,
only a prerequisite for running Coccinelle.

>> It's useful if it helps readers recognize unusual Error ** parameters,
>> and recognizing unusual Error ** parameters is actually a problem.  I'm
>> not sure it is, but my familiarity with the Error interface may blind
>> me.
>>=20
>> How many functions have unusual Error **parameters?  How are they used?
>> Any calls that could easily be mistaken as the usual case?  See [*]
>> below.
>>=20
>> You effectively propose a naming convention.  error.h should spell it
>> out.  Let me try:
>>=20
>>      Any Error ** parameter meant for passing an error to the caller mus=
t
>>      be named @errp.  No other Error ** parameter may be named @errp.
>
> Good
>
>>=20
>> Observe:
>>=20
>> * I refrain from stipulating how other Error ** parameters are to be
>>    named.  You use @errp_in, because the ones you rename are actually
>>    "IN-arguments".  However, different uses are conceivable, where
>>    @errp_in would be misleading.
>>=20
>> * If I understand your ERRP_AUTO_PROPAGATE() idea correctly, many
>>    functions that take an Error ** to pass an error to the caller will
>>    also use ERRP_AUTO_PROPAGATE, but not all.  Thus, presence of
>>    ERRP_AUTO_PROPAGATE() won't be a reliable indicator of "the Error **
>>    parameter is for passing an error to the caller".
>>=20
>> * I can't see machinery to help us catch violations of the convention.
>>=20
>>> This patch updates only error API functions. There still a few
>>> functions with errp-in semantics, they will be updated in further
>>> commits.
>>=20
>> Splitting the series into individual patches was a bad idea :)
>>=20
>> First, it really needs review as a whole.  I'll do that, but now I have
>> to hunt down the parts.  Found so far:
>>=20
>>      [PATCH v6] error: rename errp to errp_in where it is IN-argument
>>      [PATCH v6] hmp: drop Error pointer indirection in hmp_handle_error
>>      [PATCH v6] vnc: drop Error pointer indirection in vnc_client_io_err=
or
>>      [PATCH v6] qdev-monitor: well form error hint helpers
>>      [PATCH v6] nbd: well form nbd_iter_channel_error errp handler
>>      [PATCH v6] ppc: well form kvmppc_hint_smt_possible error hint helpe=
r
>>      [PATCH v6] 9pfs: well form error hint helpers
>>      [PATCH v6] hw/core/qdev: cleanup Error ** variables
>>      [PATCH v6] block/snapshot: rename Error ** parameter to more common=
 errp
>>      [PATCH v6] hw/i386/amd_iommu: rename Error ** parameter to more com=
mon errp
>>      [PATCH v6] qga: rename Error ** parameter to more common errp
>>      [PATCH v6] monitor/qmp-cmds: rename Error ** parameter to more comm=
on errp
>>      [PATCH v6] hw/s390x: rename Error ** parameter to more common errp
>>      [PATCH v6] hw/sd: drop extra whitespace in sdhci_sysbus_realize() h=
eader
>>      [PATCH v6] hw/tpm: rename Error ** parameter to more common errp
>>      [PATCH v6] hw/usb: rename Error ** parameter to more common errp
>>      [PATCH v6] include/qom/object.h: rename Error ** parameter to more =
common errp
>>      [PATCH v6] backends/cryptodev: drop local_err from cryptodev_backen=
d_complete()
>>      [PATCH v6] hw/vfio/ap: drop local_err from vfio_ap_realize
>
> .. 19 patches.. should be 21.
>
> It's really simple for me to resend them all in one v7 series. Should I?

Might add to the confusion.  Got a branch I can pull?

>>=20
>> [*] The information I asked for above is buried in these patches.  I'll
>> try to dig it up as I go reviewing them.
>>=20
>> Second, it risks some of these "further patches" overtake this one, and
>> then its commit message will be misleading.  Moreover, the other commits
>> will lack context.
>>=20
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>
>>> v6: fix s/errp/errp_in/ in comments corresponding to changed functions
>>>      [Eric]
>>>      add Eric's r-b
>>>
>>>   include/qapi/error.h | 16 ++++++++--------
>>>   util/error.c         | 30 +++++++++++++++---------------
>>>   2 files changed, 23 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>> index 3f95141a01..df518644fc 100644
>>> --- a/include/qapi/error.h
>>> +++ b/include/qapi/error.h
>>> @@ -230,16 +230,16 @@ void error_propagate_prepend(Error **dst_errp, Er=
ror *local_err,
>>>                                const char *fmt, ...);
>>>  =20
>>>   /*
>>> - * Prepend some text to @errp's human-readable error message.
>>> + * Prepend some text to @errp_in's human-readable error message.
>>>    * The text is made by formatting @fmt, @ap like vprintf().
>>>    */
>>> -void error_vprepend(Error **errp, const char *fmt, va_list ap);
>>> +void error_vprepend(Error **errp_in, const char *fmt, va_list ap);
>>>  =20
>>>   /*
>>> - * Prepend some text to @errp's human-readable error message.
>>> + * Prepend some text to @errp_in's human-readable error message.
>>>    * The text is made by formatting @fmt, ... like printf().
>>>    */
>>> -void error_prepend(Error **errp, const char *fmt, ...)
>>> +void error_prepend(Error **errp_in, const char *fmt, ...)
>>>       GCC_FMT_ATTR(2, 3);
>>>  =20
>>>   /*
>>> @@ -250,13 +250,13 @@ void error_prepend(Error **errp, const char *fmt,=
 ...)
>>>    * Intended use is adding helpful hints on the human user interface,
>>>    * e.g. a list of valid values.  It's not for clarifying a confusing
>>>    * error message.
>>> - * @errp may be NULL, but not &error_fatal or &error_abort.
>>> + * @errp_in may be NULL, but not &error_fatal or &error_abort.
>>=20
>> That's because the function modifies the error object.
>>=20
>> Hmm, so do error_prepend() and error_vprepend().  I figure we better
>> update their contract accordingly, and copy the "not &error_fatal or
>> &error_abort" assertion.  Not in this patch.  Maybe not even in this
>> series.
>>=20
>>>    * Trivially the case if you call it only after error_setg() or
>>>    * error_propagate().
>>>    * May be called multiple times.  The resulting hint should end with =
a
>>>    * newline.
>>>    */
>>> -void error_append_hint(Error **errp, const char *fmt, ...)
>>> +void error_append_hint(Error **errp_in, const char *fmt, ...)
>>>       GCC_FMT_ATTR(2, 3);
>>>  =20
>>>   /*
>>> @@ -281,9 +281,9 @@ Error *error_copy(const Error *err);
>>>   void error_free(Error *err);
>>>  =20
>>>   /*
>>> - * Convenience function to assert that *@errp is set, then silently fr=
ee it.
>>> + * Convenience function to assert that *@errp_in is set, then silently=
 free it.
>> Long line.  Suggest:
>>=20
>>      * Assert that *@errp_in is set, then silently free it.
>>      * This is a convenience function for use in tests.
>>=20
>>>    */
>>> -void error_free_or_abort(Error **errp);
>>> +void error_free_or_abort(Error **errp_in);
>>>  =20
>>>   /*
>>>    * Convenience function to warn_report() and free @err.
>>> diff --git a/util/error.c b/util/error.c
>>> index d4532ce318..275586faa8 100644
>>> --- a/util/error.c
>>> +++ b/util/error.c
>>> @@ -121,41 +121,41 @@ void error_setg_file_open_internal(Error **errp,
>>>                                 "Could not open '%s'", filename);
>>>   }
>>>  =20
>>> -void error_vprepend(Error **errp, const char *fmt, va_list ap)
>>> +void error_vprepend(Error **errp_in, const char *fmt, va_list ap)
>>>   {
>>>       GString *newmsg;
>>>  =20
>>> -    if (!errp) {
>>> +    if (!errp_in) {
>>>           return;
>>>  =20
>>>       newmsg =3D g_string_new(NULL);
>>>       g_string_vprintf(newmsg, fmt, ap);
>>> -    g_string_append(newmsg, (*errp)->msg);
>>> -    g_free((*errp)->msg);
>>> -    (*errp)->msg =3D g_string_free(newmsg, 0);
>>> +    g_string_append(newmsg, (*errp_in)->msg);
>>> +    g_free((*errp_in)->msg);
>>> +    (*errp_in)->msg =3D g_string_free(newmsg, 0);
>>>   }
>>>  =20
>>> -void error_prepend(Error **errp, const char *fmt, ...)
>>> +void error_prepend(Error **errp_in, const char *fmt, ...)
>>>   {
>>>       va_list ap;
>>>  =20
>>>       va_start(ap, fmt);
>>> -    error_vprepend(errp, fmt, ap);
>>> +    error_vprepend(errp_in, fmt, ap);
>>>       va_end(ap);
>>>   }
>>>  =20
>>> -void error_append_hint(Error **errp, const char *fmt, ...)
>>> +void error_append_hint(Error **errp_in, const char *fmt, ...)
>>>   {
>>>       va_list ap;
>>>       int saved_errno =3D errno;
>>>       Error *err;
>>>  =20
>>> -    if (!errp) {
>>> +    if (!errp_in) {
>>>           return;
>>>       }
>>> -    err =3D *errp;
>>> -    assert(err && errp !=3D &error_abort && errp !=3D &error_fatal);
>>> +    err =3D *errp_in;
>>> +    assert(err && errp_in !=3D &error_abort && errp_in !=3D &error_fat=
al);
>>>  =20
>>>       if (!err->hint) {
>>>           err->hint =3D g_string_new(NULL);
>>> @@ -271,11 +271,11 @@ void error_free(Error *err)
>>>       }
>>>   }
>>>  =20
>>> -void error_free_or_abort(Error **errp)
>>> +void error_free_or_abort(Error **errp_in)
>>>   {
>>> -    assert(errp && *errp);
>>> -    error_free(*errp);
>>> -    *errp =3D NULL;
>>> +    assert(errp_in && *errp_in);
>>> +    error_free(*errp_in);
>>> +    *errp_in =3D NULL;

This one is actually in/out.

To make the compiler check errp_in is truly an in-argument, we can
declare it as Error *const *errp_in.

But we can save ourselves the trouble of renaming it; the const should
suffice to tell both human readers and Coccinelle that this is not your
common out-argument.  I think I like this better than relying on a
naming convention.  What about you?

>>>   }
>>>  =20
>>>   void error_propagate(Error **dst_errp, Error *local_err)
>>=20


