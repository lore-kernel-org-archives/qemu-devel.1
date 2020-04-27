Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E26C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B5520656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qf+Zl6zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B5520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51871 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5q5-0002xj-Om
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jT5oV-0000zO-1b
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jT5oT-0007dD-OB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:36:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jT5oT-0007c3-4s
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588001811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihZD/jqVN/p9dTPL/nOV9Z5F8BiTzerDtIyvU5zRP3o=;
 b=Qf+Zl6zgqsrP1BoSMN9uklWFrdBoUL1N3XpYffi6CH/kTKRi0n0CrMQJjsnep5dkhTYdtQ
 3Cy6+IzJV42dW/cIIpySQE+DUWjg91NJG/ViKVatgDBDn8eF/SgZE9BdqaxCcapcCWkREQ
 9k598lGMtSp9LV94V4IsT1X5uQX0NaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-glOh4eyFNWmA0z7TE3JB6g-1; Mon, 27 Apr 2020 11:36:50 -0400
X-MC-Unique: glOh4eyFNWmA0z7TE3JB6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1668E800685;
 Mon, 27 Apr 2020 15:36:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A49D35D9DA;
 Mon, 27 Apr 2020 15:36:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2273611358BC; Mon, 27 Apr 2020 17:36:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: Questionable aspects of QEMU Error's design
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <87blo7heag.fsf@dusky.pond.sub.org>
Date: Mon, 27 Apr 2020 17:36:47 +0200
In-Reply-To: <87blo7heag.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Sat, 04 Apr 2020 09:59:35 +0200")
Message-ID: <87blndey9c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:33:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> QEMU's Error was patterned after GLib's GError.  Differences include:
> [...]
>> * Return value conventions
>>
>>   Common: non-void functions return a distinct error value on failure
>>   when such a value can be defined.  Patterns:
>>
>>   - Functions returning non-null pointers on success return null pointer
>>     on failure.
>>
>>   - Functions returning non-negative integers on success return a
>>     negative error code on failure.
>>
>>   Different: GLib discourages void functions, because these lead to
>>   awkward error checking code.  We have tons of them, and tons of
>>   awkward error checking code:
>>
>>     Error *err =3D NULL;
>>     frobnicate(arg, &err);
>>     if (err) {
>>         ... recover ...
>>         error_propagate(errp, err);
>>     }
>>
>>   instead of
>>
>>     if (!frobnicate(arg, errp))
>>         ... recover ...
>>     }
>>
>>   Can also lead to pointless creation of Error objects.
>>
>>   I consider this a design mistake.  Can we still fix it?  We have more
>>   than 2000 void functions taking an Error ** parameter...
>>
>>   Transforming code that receives and checks for errors with Coccinelle
>>   shouldn't be hard.  Transforming code that returns errors seems more
>>   difficult.  We need to transform explicit and implicit return to
>>   either return true or return false, depending on what we did to the
>>   @errp parameter on the way to the return.  Hmm.
> [...]
>
> To figure out what functions with an Error ** parameter return, I used
> Coccinelle to find such function definitions and print the return types.
> Summary of results:
>
>    2155 void
>     873 signed integer
>     494 pointer
>     153 bool
>      33 unsigned integer
>       6 enum
>    ---------------------
>    3714 total
>
> I then used Coccinelle to find checked calls of void functions (passing
> &error_fatal or &error_abort is not considered "checking" here).  These
> calls become simpler if we make the functions return a useful value.  I
> found a bit under 600 direct calls, and some 50 indirect calls.
>
> Most frequent direct calls:
>
>     127 object_property_set_bool
>      27 qemu_opts_absorb_qdict
>      16 visit_type_str
>      14 visit_type_int
>      10 visit_type_uint32
>
> Let's have a closer look at object_property_set() & friends.  Out of
> almost 1000 calls, some 150 are checked.  While I'm sure many of the
> unchecked calls can't actually fail, I am concerned some unchecked calls
> can.
>
> If we adopt the convention to return a value that indicates success /
> failure, we should consider converting object.h to it sooner rather than
> later.
>
> Please understand these are rough numbers from quick & dirty scripts.

FYI, I'm working on converting QemuOpts, QAPI visitors and QOM.  I keep
running into bugs.  So far:

    [PATCH v2 for-5.1 0/9] qemu-option: Fix corner cases and clean up
    [PATCH for-5.1 0/5] qobject: Minor spring cleaning
    [PATCH v2 00/14] Miscellaneous error handling fixes
    [PATCH 0/4] Subject: [PATCH 0/4] smbus: SPD fixes
    [PATCH 0/3] fuzz: Probably there is a better way to do this
    [PATCH v2 00/15] qapi: Spring cleaning
    [PATCH 00/11] More miscellaneous error handling fixes

I got another one coming for QOM and qdev before I can post the
conversion.

Vladimir, since the conversion will mess with error_propagate(), I'd
like to get it in before your auto-propagation work.


