Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FD0C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 06:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943B720684
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 06:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aySKvm2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943B720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAT4o-0005fR-Kb
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 01:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jAT4D-0005Aq-Ks
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 01:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jAT4B-0003Ug-OD
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 01:36:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jAT4B-0003TS-Fd
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 01:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583562966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7/Gfnp5HmkwQxm3Mmu+GVBvVrNv3rxKXo817DU4/vA=;
 b=aySKvm2YCku9eG2vGyF/I/rrS0v+SUzL6uVaT200keJQaMzSymgvU8YBVL8kZ/ESv4GjAk
 ncjuItffD4rs0UNxqnAW0OhXar/BDJvGu+p9g83w8duV3FPrRgJR27mXa5xvxpH69exfPB
 3DLTBlXpmjIk+niXcyBmoKaLx0gg4W8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-BNdI0yypM4ma_4LmIZ1OIA-1; Sat, 07 Mar 2020 01:36:03 -0500
X-MC-Unique: BNdI0yypM4ma_4LmIZ1OIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12E1A800D50;
 Sat,  7 Mar 2020 06:36:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE03060C63;
 Sat,  7 Mar 2020 06:36:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4553311386A6; Sat,  7 Mar 2020 07:36:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 06/10] iotests: limit line length to 79 chars
References: <20200304213818.15341-1-jsnow@redhat.com>
 <20200304213818.15341-7-jsnow@redhat.com>
 <a23da70f-a46f-acc8-18b4-c1b2e5cea60c@redhat.com>
 <c57333a3-baf3-cc00-7f99-6fce2de91a7f@redhat.com>
 <20200305115548.GA5363@linux.fritz.box>
 <d9500e3c-48d4-8ab2-51c7-9a914dd8ec49@redhat.com>
 <20200306101425.GC7240@linux.fritz.box>
Date: Sat, 07 Mar 2020 07:36:00 +0100
In-Reply-To: <20200306101425.GC7240@linux.fritz.box> (Kevin Wolf's message of
 "Fri, 6 Mar 2020 11:14:25 +0100")
Message-ID: <8736akzn73.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, armbru@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 05.03.2020 um 19:25 hat John Snow geschrieben:
[...]
>> So in summary:
>>=20
>> - Avoid nested hanging indents from format operators
>> - Use a line break before the % format operator.
>> - OPTIONALLY(?), use a hanging indent for the entire format string to
>> reduce nesting depth.
>
> Yes, though I don't think of it as a special case for format strings. So
> I would phrase it like this:
>
> - Don't use hanging indent for any nested parentheses unless the outer
>   parentheses use hanging indents, too.
> - Use a line break before binary operators.
> - OPTIONALLY, use a hanging indent for the top level(s) to reduce
>   nesting depth.
>
> The first one is the only rule that involves some interpretation of
> PEP-8, the rest seems to be its unambiguous recommendation.
>
> Anyway, so I would apply the exact same rules to the following (imagine
> even longer expressions, especially the last example doesn't make sense
> with the short numbers):
>
> * bad:
>     really_long_function_name(-1234567890 + 987654321 * (
>         1337 / 42))

Definitely bad.

> * ok:
>     really_long_function_name(-1234567890 + 987654321
>                               * (1337 / 42))
>
> * ok:
>     really_long_function_name(
>         -1234567890 + 987654321
>         * (1337 / 42))

Yup.

> * ok:
>     really_long_function_name(
>         -1234567890 + 987654321 * (
>             1337 / 42))

Okay, although when you need this, chances are there's just too much
going on in that argument list.

>> e.g., either this form:
>> (using a line break before the binary operator and nesting to the
>> argument level)
>>=20
>> write('hello %s'
>>       % (world,))
>>=20
>>=20
>> or optionally this form if it buys you a little more room:
>> (using a hanging indent of 4 spaces and nesting arguments at that level)
>>=20
>> write(
>>     'hello %s'
>>     % ('world',))
>>=20
>>=20
>> but not ever this form:
>> (Using a hanging indent of 4 spaces from the opening paren of the format
>> operand)
>>=20
>> write('hello %s' % (
>>     'world',))
>>=20
>>=20
>>=20
>> yea/nea?
>>=20
>> (Kevin, Philippe, Markus, Max)
>
> Looks good to me.

Me too.


