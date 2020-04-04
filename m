Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C61C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 11:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398D7206C3
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 11:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7UXEcua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398D7206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKgXI-0003SH-7s
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 07:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jKgWV-0002rI-4G
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 06:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jKgWT-00078I-34
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 06:59:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jKgWS-00077W-Su
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 06:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585997971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XxBVjsGz7aZHo7XaZUUImpN4YNnqVmFw4Lz7sDBYcKo=;
 b=N7UXEcua5KwMGOwp+qgZr6LPWUBz2jQ8VCkPQ3B1XgEoAmOTzY8F4/j7t8ZdPbvYHopRuz
 +eono68XVNhqIwDV3jB8kkLLjJUFCAe1Ed9ZL78EXuzoyPtAiMXpi9hmBej6gkt+KFoZEn
 5dQEaOQE/qqs+ZY2KAbtg/56TkcPd7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-4cCJFAR-PmGqbmZayrQdUQ-1; Sat, 04 Apr 2020 06:59:30 -0400
X-MC-Unique: 4cCJFAR-PmGqbmZayrQdUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 271711005509;
 Sat,  4 Apr 2020 10:59:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-152.ams2.redhat.com
 [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 986DA5DA76;
 Sat,  4 Apr 2020 10:59:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 17A171138610; Sat,  4 Apr 2020 12:59:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Questionable aspects of QEMU Error's design
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <87blo7heag.fsf@dusky.pond.sub.org>
Date: Sat, 04 Apr 2020 12:59:27 +0200
In-Reply-To: <87blo7heag.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Sat, 04 Apr 2020 09:59:35 +0200")
Message-ID: <87sghjfre8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
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

Paolo, Daniel, Eduardo,

Please pick one for QOM:

* Do nothing.  Looks like

     object_property_set_bool(..., &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }

* Return true on success, false on error.  Looks like

     if (!object_property_set_bool(..., errp)) {
         return;
     }

* Return 0 on success, -1 on error.  Looks like

     if (object_property_set_bool(..., errp) < 0) {
         return;
     }

  This is slightly more likely to require line wrapping than the
  previous one.


