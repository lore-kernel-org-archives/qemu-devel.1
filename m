Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB9AC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97BC20706
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLqAyIOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97BC20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEiy-0006Ms-6y
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1idEPQ-0002Yj-Mk
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1idEPO-00030I-1c
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58197
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1idEPM-0002xm-Fu
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575641794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e4KUBt//Qx6p9myQs5/gQLalN0+kFiIzXywrLQ7EWN0=;
 b=JLqAyIOvxATieDUs/vrSFovxqH4zNOuHDN7fAje8BFEAQ15cS59d7JhFr2NTzhWPVSkd1X
 U8QzzVeCRvQhMOtw8jMYDCFIZiuk4GVG3YjQCNv6O5lPqisBO/hpSdLolAd/F1v4I12Fgu
 QkmLY3e8qzH1bT6j/pGLKPgIKaLwhc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-rlQ6sT1HN1KjPsWXWeRhVA-1; Fri, 06 Dec 2019 02:15:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C0A8800D5A;
 Fri,  6 Dec 2019 07:15:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84D6E60C80;
 Fri,  6 Dec 2019 07:15:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 169741138606; Fri,  6 Dec 2019 08:15:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v3] qga: fence guest-set-time if hwclock not available
References: <20191205115350.18713-1-cohuck@redhat.com>
 <5aaa7f3a-e3d1-0057-5fe2-07dea4864bc7@redhat.com>
 <a0636a36-60e6-9d18-4643-cea6a1e5e294@redhat.com>
Date: Fri, 06 Dec 2019 08:15:40 +0100
In-Reply-To: <a0636a36-60e6-9d18-4643-cea6a1e5e294@redhat.com> (Laszlo Ersek's
 message of "Thu, 5 Dec 2019 16:24:41 +0100")
Message-ID: <87h82dorfn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: rlQ6sT1HN1KjPsWXWeRhVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laszlo Ersek <lersek@redhat.com> writes:

> On 12/05/19 14:05, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Cornelia,
>>
>> On 12/5/19 12:53 PM, Cornelia Huck wrote:
>>> The Posix implementation of guest-set-time invokes hwclock to
>>> set/retrieve the time to/from the hardware clock. If hwclock
>>> is not available, the user is currently informed that "hwclock
>>> failed to set hardware clock to system time", which is quite
>>> misleading. This may happen e.g. on s390x, which has a different
>>> timekeeping concept anyway.
>>>
>>> Let's check for the availability of the hwclock command and
>>> return QERR_UNSUPPORTED for guest-set-time if it is not available.
>>>
>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>
>>> v2->v3:
>>>    - added 'static' keyword to hwclock_path
>>>
>>> Not sure what tree this is going through; if there's no better place,
>>> I can also take this through the s390 tree.
>>
>> s390 or trivial trees seems appropriate.
>>
>>>
>>> ---
>>>   qga/commands-posix.c | 13 ++++++++++++-
>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>>> index 1c1a165daed8..0be301a4ea77 100644
>>> --- a/qga/commands-posix.c
>>> +++ b/qga/commands-posix.c
>>> @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t
>>> time_ns, Error **errp)
>>>       pid_t pid;
>>>       Error *local_err =3D NULL;
>>>       struct timeval tv;
>>> +    static const char hwclock_path[] =3D "/sbin/hwclock";
>>> +    static int hwclock_available =3D -1;
>>> +
>>> +    if (hwclock_available < 0) {
>>> +        hwclock_available =3D (access(hwclock_path, X_OK) =3D=3D 0);
>>> +    }
>>> +
>>> +    if (!hwclock_available) {
>>> +        error_setg(errp, QERR_UNSUPPORTED);
>>
>> In include/qapi/qmp/qerror.h we have:
>>
>> /*
>>  * These macros will go away, please don't use in new code, and do not
>>  * add new ones!
>>  */
>
> Obviously, the last word on this belongs to Markus (CC'd) -- he added
> that comment. I'd just like to point out *when* that comment was added:
> approx. four and half years ago. (See commit 4629ed1e9896.)

Yes, with a big push to finally kill qerror_report().  I was too
exhausted to finish the job and kill all the remaining QERR_, too.

I'm dead serious on the "do not add new ones" part.

On the "don't use in new code" part, I'm quite willing to tolerate
reasonable exceptions, e.g. to maintain consistency with old code.

This one looks like a reasonable exception to me.

> I've always associated QERR_UNSUPPORTED with QMP interfaces rejecting
> invocation due to lack of support. I don't think one more instance of
> QERR_UNSUPPORTED will matter much, when we'll "finally" :) convert or
> eliminate the other 35! (Yes, I've counted.)
>
> In case it's unacceptable to add one more QERR_UNSUPPORTED: what is the
> official solution that replaces it?
>
> I assume it was explained in the series that included commit
> 4629ed1e9896, but I can't easily tell. (And, there is no "QERR_" match
> in docs/.)

See "exhausted" above.

> Hmmm, more history digging... In the 4629ed1e9896..v4.2.0-rc4 set of
> commits, the following commits introduced new instances of
> QERR_UNSUPPORTED:
>
> - e09484efbc9d ("qmp: add QMP interface "query-cpu-model-expansion"", 201=
6-09-06)
> - 0031e0d68339 ("qmp: add QMP interface "query-cpu-model-comparison"", 20=
16-09-06)
> - b18b6043341d ("qmp: add QMP interface "query-cpu-model-baseline"", 2016=
-09-06)
> - 1007a37e2082 ("smbios: filter based on CONFIG_SMBIOS rather than TARGET=
", 2017-01-16)
> - 9f57061c3555 ("acpi: filter based on CONFIG_ACPI_X86 rather than TARGET=
", 2017-01-16)
> - 39164c136cba ("qmp/hmp: add query-vm-generation-id and 'info vm-generat=
ion-id' commands", 2017-03-02)
> - 161a56a9065f ("qga: Add 'guest-get-users' command", 2017-04-26)
> - 53c58e64d0a2 ("qga: Add `guest-get-timezone` command", 2017-04-27)
> - e674605f9821 ("qemu-ga: check if utmpx.h is available on the system", 2=
017-07-17)
>
> I don't claim that all of those additions have stuck with us, to
> v4.2.0-rc4. Yet, in general, practice doesn't seem to have followed the
> intended deprecation.
>
>>
>> Maybe we can replace it by "this feature is not supported on this
>> architecture"? (or without 'on this architecture').
>
> I think if we replace QERR_UNSUPPORTED with anything, it should be
> "similarly standardized". (Lack of support for a given QMP interface is
> pretty common, I think.)

Here's my the general idea on getting rid of qerror.h.  The QERR_ macros
effectively factor out common error message format strings.  DRY is a
legitimate concern.  However, I dislike (1) passing anything but string
literals as format to printf()-style function, and (2) tempting people
to reuse existing error messages where a new error message would be more
helpful.

Note that the error_setg() is *also* common.  So take DRY to the next
level: factor out the common error_setg(errp, "literal error format
string", ...) along with whatever error handling is also common in a
helper function, and call that.

However, do that only where the errors are truly common.  Where they're
just similar, duplicate the error message, and maybe specialize it for
specific error situations.

>>> +        return;
>>> +    }
>>>         /* If user has passed a time, validate and set it. */
>>>       if (has_time) {
>>> @@ -195,7 +206,7 @@ void qmp_guest_set_time(bool has_time, int64_t
>>> time_ns, Error **errp)
>>>             /* Use '/sbin/hwclock -w' to set RTC from the system time,
>>>            * or '/sbin/hwclock -s' to set the system time from RTC. */
>>> -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
>>> +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
>>>                  NULL, environ);
>>>           _exit(EXIT_FAILURE);
>>>       } else if (pid < 0) {
>>>
>>


