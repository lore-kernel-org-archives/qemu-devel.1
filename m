Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C9DC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9963E20644
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tid2rm+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9963E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOIdF-0002WB-Nw
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 06:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOIcX-0001pC-Ez
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOIcW-0001C0-B4
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:16:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39552
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOIcW-0001Bo-7T
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586859403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQm+PuEEDfDhtjQ7pcJrViSysq8W7W9ZDHzW2uWZOPg=;
 b=Tid2rm+YYT7b679bzrgjBSRfyXQIHNvcPpjeQiZCXZS+Pn/xed9sfLnAwmBxk4OFaZaIYs
 XNrXXYyN5gZqF0eEygAMibJkFQO4OumlHoU9xjPOWXPRmn7gyZ6KWhaoOr6CzAxpL3Skgf
 vtdaQTSWKG03uQUMAcQyjqH1fxZ1zOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-Gda0uWbTNXisq4ruLY58AQ-1; Tue, 14 Apr 2020 06:16:42 -0400
X-MC-Unique: Gda0uWbTNXisq4ruLY58AQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F1A618C35A3;
 Tue, 14 Apr 2020 10:16:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DE721036B21;
 Tue, 14 Apr 2020 10:16:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A42B11385C8; Tue, 14 Apr 2020 12:16:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-5.1 5/8] qemu-option: Fix has_help_option()'s sloppy
 parsing
References: <20200409153041.17576-1-armbru@redhat.com>
 <20200409153041.17576-6-armbru@redhat.com>
 <4e7c8e64-b5fe-4b8c-70d4-f6b2ea527e6a@redhat.com>
Date: Tue, 14 Apr 2020 12:16:39 +0200
In-Reply-To: <4e7c8e64-b5fe-4b8c-70d4-f6b2ea527e6a@redhat.com> (Eric Blake's
 message of "Thu, 9 Apr 2020 13:10:24 -0500")
Message-ID: <87o8ruv0c8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/9/20 10:30 AM, Markus Armbruster wrote:
>> has_help_option() uses its own parser.  It's inconsistent with
>> qemu_opts_parse(), as demonstrated by test-qemu-opts case
>> /qemu-opts/has_help_option.  Fix by reusing the common parser.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/test-qemu-opts.c |  2 +-
>>   util/qemu-option.c     | 39 +++++++++++++++++++--------------------
>>   2 files changed, 20 insertions(+), 21 deletions(-)
>>
>> diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
>> index 27c24bb1a2..58a4ea2408 100644
>> --- a/tests/test-qemu-opts.c
>> +++ b/tests/test-qemu-opts.c
>> @@ -744,7 +744,7 @@ static void test_has_help_option(void)
>>           { "a,help", true, true, true },
>>           { "a=3D0,help,b", true, true, true },
>>           { "help,b=3D1", true, true, false },
>> -        { "a,b,,help", false /* BUG */, true, true },
>> +        { "a,b,,help", true, true, true },
>
> Okay, this revisits my question from 1/8.
>
> I guess the argument is that since 'b,help' is NOT a valid option name
> (only as an option value), that we are instead parsing three separate
> options 'b', '', and 'help', and whether or not the empty option is
> valid, the face that 'help' is valid is what makes this return true?

Parsing is oblivious of which option names are valid.  It's actually
oblivious of the entire QemuOpts definition.

Desugaring may depend on the QemuOpts definition, however.

"a,b,,help" gets parsed as four option parameters:

    "a",    which gets desugared to either "a=3Don" or "firstname=3Da"
    "b",    which gets desugared to "b=3Don"
    "" ,    which gets desugared to "=3Don"
    "help", which gets desugared to "help=3Don"

A user of the parse that supports help should clue on the last one,
throw away the parse, and provide help.

The first desugaring is one that depends on the QemuOpts definition.

>> +++ b/util/qemu-option.c
>> @@ -165,26 +165,6 @@ void parse_option_size(const char *name, const char=
 *value,
>>       *ret =3D size;
>>   }
>>   -bool has_help_option(const char *param)
>> -{
>> -    const char *p =3D param;
>> -    bool result =3D false;
>> -
>> -    while (*p && !result) {
>> -        char *value;
>> -
>> -        p =3D get_opt_value(p, &value);
>> -        if (*p) {
>> -            p++;
>> -        }
>> -
>> -        result =3D is_help_option(value);
>
> Old code: both 'help' and '?' are accepted.
>
>> +bool has_help_option(const char *params)
>> +{
>> +    const char *p;
>> +    char *name, *value;
>> +    bool ret;
>> +
>> +    for (p =3D params; *p;) {
>> +        p =3D get_opt_name_value(p, NULL, &name, &value);
>> +        ret =3D !strcmp(name, "help");
>
> New code: only 'help' is accepted.  Is the loss of '?' intentional?

No.  Will fix, thanks!


