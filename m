Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC42C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 04:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B23E20671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 04:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LICtr5Ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B23E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZRyM-0000fy-Mp
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 00:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZRxn-000078-8A
 for qemu-devel@nongnu.org; Fri, 15 May 2020 00:28:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZRxm-0003Wi-0O
 for qemu-devel@nongnu.org; Fri, 15 May 2020 00:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589516924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AqpKq14fo3BXdA3kQMDNjyp39E1R8VaYEptt65UdptA=;
 b=LICtr5Akoj4taNXfi7C4kTruJ1RfYeMjCF8JJrFS9jevO5Tjbe+5PqwZbatdtsap1sMn9L
 0zAsdcIt8El7TYDIrbInPRsxepWveXCOf2j1BmCnu+HJHFraF9Z5/MYUJbcohw3VbQGYwn
 1eYpI3iKv2Cv6hrgMbGytz3CLSgs9DI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-4Q_oNsJYM3ev5wN_Tbe0fg-1; Fri, 15 May 2020 00:28:41 -0400
X-MC-Unique: 4Q_oNsJYM3ev5wN_Tbe0fg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE8E71005510;
 Fri, 15 May 2020 04:28:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73844620AF;
 Fri, 15 May 2020 04:28:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0261611358BC; Fri, 15 May 2020 06:28:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Questionable aspects of QEMU Error's design
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <87blo7heag.fsf@dusky.pond.sub.org>
 <87blndey9c.fsf@dusky.pond.sub.org>
 <3b9d53fd-bdd0-c15b-292c-c4952fa24dfd@virtuozzo.com>
 <923ceeeb-1fc8-489e-a32d-4cebfa6eadae@virtuozzo.com>
Date: Fri, 15 May 2020 06:28:37 +0200
In-Reply-To: <923ceeeb-1fc8-489e-a32d-4cebfa6eadae@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 14 May 2020 10:59:47 +0300")
Message-ID: <87y2ptstxm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 28.04.2020 08:20, Vladimir Sementsov-Ogievskiy wrote:
>> 27.04.2020 18:36, Markus Armbruster wrote:
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> Markus Armbruster <armbru@redhat.com> writes:
>>>>
>>>>> QEMU's Error was patterned after GLib's GError.=C2=A0 Differences inc=
lude:
>>>> [...]
>>>>> * Return value conventions
>>>>>
>>>>> =C2=A0=C2=A0 Common: non-void functions return a distinct error value=
 on failure
>>>>> =C2=A0=C2=A0 when such a value can be defined.=C2=A0 Patterns:
>>>>>
>>>>> =C2=A0=C2=A0 - Functions returning non-null pointers on success retur=
n null pointer
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 on failure.
>>>>>
>>>>> =C2=A0=C2=A0 - Functions returning non-negative integers on success r=
eturn a
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 negative error code on failure.
>>>>>
>>>>> =C2=A0=C2=A0 Different: GLib discourages void functions, because thes=
e lead to
>>>>> =C2=A0=C2=A0 awkward error checking code.=C2=A0 We have tons of them,=
 and tons of
>>>>> =C2=A0=C2=A0 awkward error checking code:
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 frobnicate(arg, &err);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... recover ...
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp=
, err);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0 instead of
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (!frobnicate(arg, errp))
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... recover ...
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0 Can also lead to pointless creation of Error objects.
>>>>>
>>>>> =C2=A0=C2=A0 I consider this a design mistake.=C2=A0 Can we still fix=
 it?=C2=A0 We have more
>>>>> =C2=A0=C2=A0 than 2000 void functions taking an Error ** parameter...
>>>>>
>>>>> =C2=A0=C2=A0 Transforming code that receives and checks for errors wi=
th Coccinelle
>>>>> =C2=A0=C2=A0 shouldn't be hard.=C2=A0 Transforming code that returns =
errors seems more
>>>>> =C2=A0=C2=A0 difficult.=C2=A0 We need to transform explicit and impli=
cit return to
>>>>> =C2=A0=C2=A0 either return true or return false, depending on what we=
 did to the
>>>>> =C2=A0=C2=A0 @errp parameter on the way to the return.=C2=A0 Hmm.
>>>> [...]
>>>>
>>>> To figure out what functions with an Error ** parameter return, I used
>>>> Coccinelle to find such function definitions and print the return type=
s.
>>>> Summary of results:
>>>>
>>>> =C2=A0=C2=A0=C2=A0 2155 void
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 873 signed integer
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 494 pointer
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 153 bool
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 33 unsigned integer
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6 enum
>>>> =C2=A0=C2=A0=C2=A0 ---------------------
>>>> =C2=A0=C2=A0=C2=A0 3714 total
>>>>
>>>> I then used Coccinelle to find checked calls of void functions (passin=
g
>>>> &error_fatal or &error_abort is not considered "checking" here).=C2=A0=
 These
>>>> calls become simpler if we make the functions return a useful value.=
=C2=A0 I
>>>> found a bit under 600 direct calls, and some 50 indirect calls.
>>>>
>>>> Most frequent direct calls:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 127 object_property_set_bool
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 27 qemu_opts_absorb_qdict
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16 visit_type_str
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14 visit_type_int
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10 visit_type_uint32
>>>>
>>>> Let's have a closer look at object_property_set() & friends.=C2=A0 Out=
 of
>>>> almost 1000 calls, some 150 are checked.=C2=A0 While I'm sure many of =
the
>>>> unchecked calls can't actually fail, I am concerned some unchecked cal=
ls
>>>> can.
>>>>
>>>> If we adopt the convention to return a value that indicates success /
>>>> failure, we should consider converting object.h to it sooner rather th=
an
>>>> later.
>>>>
>>>> Please understand these are rough numbers from quick & dirty scripts.
>>>
>>> FYI, I'm working on converting QemuOpts, QAPI visitors and QOM.=C2=A0 I=
 keep
>>> running into bugs.=C2=A0 So far:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [PATCH v2 for-5.1 0/9] qemu-option: Fix corner=
 cases and clean up
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [PATCH for-5.1 0/5] qobject: Minor spring clea=
ning
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [PATCH v2 00/14] Miscellaneous error handling =
fixes
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [PATCH 0/4] Subject: [PATCH 0/4] smbus: SPD fi=
xes
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [PATCH 0/3] fuzz: Probably there is a better w=
ay to do this
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [PATCH v2 00/15] qapi: Spring cleaning
>>> =C2=A0=C2=A0=C2=A0=C2=A0 [PATCH 00/11] More miscellaneous error handlin=
g fixes
>>>
>>> I got another one coming for QOM and qdev before I can post the
>>> conversion.
>>>
>>> Vladimir, since the conversion will mess with error_propagate(), I'd
>>> like to get it in before your auto-propagation work.
>>>
>>
>> OK, just let me know when to regenerate the series, it's not hard.
>>
>
> Hi! Is all that merged? Should I resend now?

I ran into many bugs and fell into a few rabbit holes.  I'm busy
finishing and flushing the patches.


