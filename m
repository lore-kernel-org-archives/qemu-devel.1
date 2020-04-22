Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEFEC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33A52074B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1jcdr2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33A52074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHAG-0008U0-JN
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRH8I-0006xW-U1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRH8F-0000HV-VU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:17:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRH8F-0008WH-DC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587568655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDFCNRLQxsXIIGfrjQP2Jg6helCme51xRqQkweZUIWE=;
 b=a1jcdr2n+2MNYDW9BKwALe/8RetTS1DrqDqj5kce7YG35kFhRRugbc5ilwUWDP7ZdmCzNp
 yr5PUZUkFHHrT8ihqKQy49gnHrshorWDmlwj2P8j1P0OOEnGsWfMz9q04NUGNlC7DPQppJ
 gSDSeMndqEyG4dqEqzXZz1GApDob1UQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-kbNosfqSM2K53_JicVkMnA-1; Wed, 22 Apr 2020 11:17:19 -0400
X-MC-Unique: kbNosfqSM2K53_JicVkMnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CA41DB5A;
 Wed, 22 Apr 2020 15:17:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07F9C173FF;
 Wed, 22 Apr 2020 15:17:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BA2D11358BC; Wed, 22 Apr 2020 17:17:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 14/14] qga: Fix qmp_guest_suspend_{disk,
 ram}() error handling
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-15-armbru@redhat.com>
 <ccf97c71-744d-1d0a-f961-bb3d71c1c64a@redhat.com>
Date: Wed, 22 Apr 2020 17:17:15 +0200
In-Reply-To: <ccf97c71-744d-1d0a-f961-bb3d71c1c64a@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 22 Apr 2020 15:41:02
 +0200")
Message-ID: <87zhb3v9c4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/22/20 3:07 PM, Markus Armbruster wrote:
>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>> pointer to a variable containing NULL.  Passing an argument of the
>> latter kind twice without clearing it in between is wrong: if the
>> first call sets an error, it no longer points to NULL for the second
>>
>> qmp_guest_suspend_disk() and qmp_guest_suspend_ram() pass @local_err
>> first to check_suspend_mode(), then to acquire_privilege(), then to
>> execute_async().  Continuing after errors here can only end in tears.
>> For instance, we risk tripping error_setv()'s assertion.
>>
>> Fixes: aa59637ea1c6a4c83430933f9c44c43e6c3f1b69
>> Fixes: f54603b6aa765514b2519e74114a2f417759d727
>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qga/commands-win32.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index 9717a8d52d..5ba56327dd 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -1322,9 +1322,16 @@ void qmp_guest_suspend_disk(Error **errp)
>>         *mode =3D GUEST_SUSPEND_MODE_DISK;
>>       check_suspend_mode(*mode, &local_err);
>> +    if (local_err) {
>> +        goto out;
>> +    }
>>       acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
>> +    if (local_err) {
>> +        goto out;
>> +    }
>>       execute_async(do_suspend, mode, &local_err);
>>   +out:
>>       if (local_err) {
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg695647.html is
> slightly different by removing the if() check.

It frees @mode unconditionally (marked --> below) I believe that's
wrong.  execute_async() runs do_suspend() in a new thread, and passes it
@mode.  do_suspend() frees it.

>>           error_propagate(errp, local_err);
>>           g_free(mode);
>> @@ -1338,9 +1345,16 @@ void qmp_guest_suspend_ram(Error **errp)
>>         *mode =3D GUEST_SUSPEND_MODE_RAM;
>>       check_suspend_mode(*mode, &local_err);
>> +    if (local_err) {
>> +        goto out;
>> +    }
>>       acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
>> +    if (local_err) {
>> +        goto out;
>> +    }
>>       execute_async(do_suspend, mode, &local_err);
>>   +out:
>>       if (local_err) {
>>           error_propagate(errp, local_err);
>>           g_free(mode);
>>

   diff --git a/qga/commands-win32.c b/qga/commands-win32.c
   index b49920e201..8b66098056 100644
   --- a/qga/commands-win32.c
   +++ b/qga/commands-win32.c
   @@ -1341,13 +1341,18 @@ void qmp_guest_suspend_disk(Error **errp)

        *mode =3D GUEST_SUSPEND_MODE_DISK;
        check_suspend_mode(*mode, &local_err);
   +    if (local_err) {
   +        goto out;
   +    }
        acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
   +    if (local_err) {
   +        goto out;
   +    }
        execute_async(do_suspend, mode, &local_err);

   -    if (local_err) {
   -        error_propagate(errp, local_err);
   -        g_free(mode);
   -    }
   +out:
   +    error_propagate(errp, local_err);
-->+    g_free(mode);
    }

    void qmp_guest_suspend_ram(Error **errp)


