Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3543C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 08:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4D020781
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 08:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAWIVHJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4D020781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXKz-00079y-RI
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 04:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRXKL-0006fk-Th
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRXKJ-0002mW-5q
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:35:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRXKH-0002hX-Ot
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587630914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gsf7NtVFGnL04iiTAZfL70I+FCCLkN1785auI9asKqY=;
 b=WAWIVHJE6ymdNPSZuJEOW+FYB+V0+ShTxqLCqDLA9WEfKoSypJOl/nHtpqTo5dfQ2tkeV6
 PpOaQvW8rWsqLht1mTA7fFZQ5Kq7Le7YZ1IGvNLlIQQfzwrGj9sN2M6H0xu782bMTBlSaA
 LyYoytq1hpJxED5DUmRqxG8QXdTiF+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-faYyxFhYOYelT_WKd2Ur6g-1; Thu, 23 Apr 2020 04:35:11 -0400
X-MC-Unique: faYyxFhYOYelT_WKd2Ur6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0521A107ACC9;
 Thu, 23 Apr 2020 08:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3291F4508;
 Thu, 23 Apr 2020 08:35:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A065511358BC; Thu, 23 Apr 2020 10:35:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 14/14] qga: Fix qmp_guest_suspend_{disk,
 ram}() error handling
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-15-armbru@redhat.com>
 <ccf97c71-744d-1d0a-f961-bb3d71c1c64a@redhat.com>
 <87zhb3v9c4.fsf@dusky.pond.sub.org>
 <0cabb08f-b53a-ac6b-bd14-1aed2b88e848@redhat.com>
Date: Thu, 23 Apr 2020 10:35:05 +0200
In-Reply-To: <0cabb08f-b53a-ac6b-bd14-1aed2b88e848@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 22 Apr 2020 18:07:04
 +0200")
Message-ID: <87a732txae.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
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

> On 4/22/20 5:17 PM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>>> On 4/22/20 3:07 PM, Markus Armbruster wrote:
>>>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>>>> pointer to a variable containing NULL.  Passing an argument of the
>>>> latter kind twice without clearing it in between is wrong: if the
>>>> first call sets an error, it no longer points to NULL for the second
>>>>
>>>> qmp_guest_suspend_disk() and qmp_guest_suspend_ram() pass @local_err
>>>> first to check_suspend_mode(), then to acquire_privilege(), then to
>>>> execute_async().  Continuing after errors here can only end in tears.
>>>> For instance, we risk tripping error_setv()'s assertion.
>>>>
>>>> Fixes: aa59637ea1c6a4c83430933f9c44c43e6c3f1b69
>>>> Fixes: f54603b6aa765514b2519e74114a2f417759d727
>>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>    qga/commands-win32.c | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>>>> index 9717a8d52d..5ba56327dd 100644
>>>> --- a/qga/commands-win32.c
>>>> +++ b/qga/commands-win32.c
>>>> @@ -1322,9 +1322,16 @@ void qmp_guest_suspend_disk(Error **errp)
>>>>          *mode =3D GUEST_SUSPEND_MODE_DISK;
>>>>        check_suspend_mode(*mode, &local_err);
>>>> +    if (local_err) {
>>>> +        goto out;
>>>> +    }
>>>>        acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
>>>> +    if (local_err) {
>>>> +        goto out;
>>>> +    }
>>>>        execute_async(do_suspend, mode, &local_err);
>>>>    +out:
>>>>        if (local_err) {
>>>
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg695647.html is
>>> slightly different by removing the if() check.
>>
>> It frees @mode unconditionally (marked --> below) I believe that's
>> wrong.  execute_async() runs do_suspend() in a new thread, and passes it
>> @mode.  do_suspend() frees it.
>
> Oops I missed that, good catch!
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

I wasn't aware of (or totally forgot about) your patch, or else I'd have
fixed it instead of redoing it.  My apologies!


