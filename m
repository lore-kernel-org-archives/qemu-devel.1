Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27837C2D0BF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA4A206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsAb1Zrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA4A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictDV-00035Q-3E
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1icszt-0004My-EH
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1icszr-0008Td-7t
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:24:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1icszr-0008Hy-1r
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575559488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=28vuIR0QCWs/l5fQ6tEiLiU+bpxf4rV9hu+K2FhhRz0=;
 b=LsAb1Zrnf0OmVO8mN96i5DCwkRdg1O7cFOljQ4xsrZ9xej5ZYj7MHACeDIG+sDUWm5jYl1
 tKzZWjh0rL7jrc+KXfkUM07y8cnh32S+7MwJgNSc6QD2ndwR+w1ZdS6vBl3ypxAFoMwP3X
 /z9zfsrt3xQb1LQQ/PkztAaW5cccqdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ddsrxuWFMfOgy1dXEaes6w-1; Thu, 05 Dec 2019 10:24:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5797A107ACCA;
 Thu,  5 Dec 2019 15:24:46 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-62.ams2.redhat.com
 [10.36.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 272C75D6A5;
 Thu,  5 Dec 2019 15:24:41 +0000 (UTC)
Subject: Re: [PATCH v3] qga: fence guest-set-time if hwclock not available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20191205115350.18713-1-cohuck@redhat.com>
 <5aaa7f3a-e3d1-0057-5fe2-07dea4864bc7@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a0636a36-60e6-9d18-4643-cea6a1e5e294@redhat.com>
Date: Thu, 5 Dec 2019 16:24:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5aaa7f3a-e3d1-0057-5fe2-07dea4864bc7@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ddsrxuWFMfOgy1dXEaes6w-1
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
Cc: "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/19 14:05, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Cornelia,
>
> On 12/5/19 12:53 PM, Cornelia Huck wrote:
>> The Posix implementation of guest-set-time invokes hwclock to
>> set/retrieve the time to/from the hardware clock. If hwclock
>> is not available, the user is currently informed that "hwclock
>> failed to set hardware clock to system time", which is quite
>> misleading. This may happen e.g. on s390x, which has a different
>> timekeeping concept anyway.
>>
>> Let's check for the availability of the hwclock command and
>> return QERR_UNSUPPORTED for guest-set-time if it is not available.
>>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>
>> v2->v3:
>>    - added 'static' keyword to hwclock_path
>>
>> Not sure what tree this is going through; if there's no better place,
>> I can also take this through the s390 tree.
>
> s390 or trivial trees seems appropriate.
>
>>
>> ---
>>   qga/commands-posix.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 1c1a165daed8..0be301a4ea77 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t
>> time_ns, Error **errp)
>>       pid_t pid;
>>       Error *local_err =3D NULL;
>>       struct timeval tv;
>> +    static const char hwclock_path[] =3D "/sbin/hwclock";
>> +    static int hwclock_available =3D -1;
>> +
>> +    if (hwclock_available < 0) {
>> +        hwclock_available =3D (access(hwclock_path, X_OK) =3D=3D 0);
>> +    }
>> +
>> +    if (!hwclock_available) {
>> +        error_setg(errp, QERR_UNSUPPORTED);
>
> In include/qapi/qmp/qerror.h we have:
>
> /*
>  * These macros will go away, please don't use in new code, and do not
>  * add new ones!
>  */

Obviously, the last word on this belongs to Markus (CC'd) -- he added
that comment. I'd just like to point out *when* that comment was added:
approx. four and half years ago. (See commit 4629ed1e9896.)

I've always associated QERR_UNSUPPORTED with QMP interfaces rejecting
invocation due to lack of support. I don't think one more instance of
QERR_UNSUPPORTED will matter much, when we'll "finally" :) convert or
eliminate the other 35! (Yes, I've counted.)

In case it's unacceptable to add one more QERR_UNSUPPORTED: what is the
official solution that replaces it?

I assume it was explained in the series that included commit
4629ed1e9896, but I can't easily tell. (And, there is no "QERR_" match
in docs/.)

Hmmm, more history digging... In the 4629ed1e9896..v4.2.0-rc4 set of
commits, the following commits introduced new instances of
QERR_UNSUPPORTED:

- e09484efbc9d ("qmp: add QMP interface "query-cpu-model-expansion"", 2016-=
09-06)
- 0031e0d68339 ("qmp: add QMP interface "query-cpu-model-comparison"", 2016=
-09-06)
- b18b6043341d ("qmp: add QMP interface "query-cpu-model-baseline"", 2016-0=
9-06)
- 1007a37e2082 ("smbios: filter based on CONFIG_SMBIOS rather than TARGET",=
 2017-01-16)
- 9f57061c3555 ("acpi: filter based on CONFIG_ACPI_X86 rather than TARGET",=
 2017-01-16)
- 39164c136cba ("qmp/hmp: add query-vm-generation-id and 'info vm-generatio=
n-id' commands", 2017-03-02)
- 161a56a9065f ("qga: Add 'guest-get-users' command", 2017-04-26)
- 53c58e64d0a2 ("qga: Add `guest-get-timezone` command", 2017-04-27)
- e674605f9821 ("qemu-ga: check if utmpx.h is available on the system", 201=
7-07-17)

I don't claim that all of those additions have stuck with us, to
v4.2.0-rc4. Yet, in general, practice doesn't seem to have followed the
intended deprecation.

>
> Maybe we can replace it by "this feature is not supported on this
> architecture"? (or without 'on this architecture').

I think if we replace QERR_UNSUPPORTED with anything, it should be
"similarly standardized". (Lack of support for a given QMP interface is
pretty common, I think.)

Thanks,
Laszlo

>
>> +        return;
>> +    }
>>         /* If user has passed a time, validate and set it. */
>>       if (has_time) {
>> @@ -195,7 +206,7 @@ void qmp_guest_set_time(bool has_time, int64_t
>> time_ns, Error **errp)
>>             /* Use '/sbin/hwclock -w' to set RTC from the system time,
>>            * or '/sbin/hwclock -s' to set the system time from RTC. */
>> -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
>> +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
>>                  NULL, environ);
>>           _exit(EXIT_FAILURE);
>>       } else if (pid < 0) {
>>
>


