Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5DEC3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B8D2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS+P8xD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B8D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54329 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytKI-0004hY-9t
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iytJ9-0003hA-Pb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iytJ6-0001bw-UZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:11:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iytJ6-0001XJ-P7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580803899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LllqucTQ/NAU09BgDkoJV47sdQqB6ernnxHGtqs6MDs=;
 b=NS+P8xD7C0aOjZcbMKtpoQ49+R/biypiORrsWGS4tHMnaAegyjJ5YxqVtZulVe/LqoZuap
 X8nEfYLl+mtcd2LU7EiKib4jeZBmX6fjG9WM443hGhLKbiwAlhxvZPI4tges7frBDGudU4
 t/mXUIwreJ7tA8yhcos6EazDJ5her3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-wxEpZjlCNjiiAtEOj6mz0A-1; Tue, 04 Feb 2020 03:11:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BD3B8C45A3;
 Tue,  4 Feb 2020 08:11:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 493B71001920;
 Tue,  4 Feb 2020 08:11:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B66D511386A7; Tue,  4 Feb 2020 09:11:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: Does Libvirt's json parser support single quoted string in qmp
 json string?
References: <ADDDD4B8-45AD-4D79-9332-06F2A50B26CE@sina.com>
 <9bac386b-5a90-3c10-b63b-d45a2e8c2d58@redhat.com>
 <20200203101352.GB1922177@redhat.com>
 <1f285f58-7a8f-0656-4f0a-8acfe56bad43@redhat.com>
Date: Tue, 04 Feb 2020 09:11:27 +0100
In-Reply-To: <1f285f58-7a8f-0656-4f0a-8acfe56bad43@redhat.com> (Eric Blake's
 message of "Mon, 3 Feb 2020 10:27:40 -0600")
Message-ID: <87eevabwls.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: wxEpZjlCNjiiAtEOj6mz0A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: libvirt-users@redhat.com, Peter Luo <d8514@sina.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> [adding Markus]
>
> On 2/3/20 4:13 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Jan 31, 2020 at 06:44:42AM -0600, Eric Blake wrote:
>>> On 1/31/20 4:38 AM, Peter Luo wrote:
>>>
>>>> error: internal error: cannot parse json {"execute": "block-commit", "=
arguments": { "device": "drive-virtio-disk2", "job-id": "job100", "base":'j=
son:{"encrypt.key-secret":"vol-38973xjl.secret","driver":"qcow2","file":{"d=
river":"file","filename":"/pitrix/data/container/vol-38973xjl.img"}}', "top=
": "/pitrix/data/container/vol-38973xjl_ss-2tw7v0mm.img"}}: lexical error: =
invalid char in json text.
>>>>
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , "job-id": "=
job100", "base":'json:{"encrypt.key-secret":"vo
>>>>
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (right here) ------^
>>>>
>>>
>>> qemu's QMP language has an extension where it accepts 'string' in addit=
ion
>>> to the JSON "string".  But it uses a hand-rolled parser, so it can do
>>> whatever it wants.
>>
>> Can we deprecate & remove this extension in QEMU ?

I think deprecating the extension makes sense only if we can actually
kill it.

We could try to make the extension opt-in, and have only the intermal
users opt in.  Can't say offhand whether that's practical.

> We could start a deprecation clock, if desired, but I don't know how
> many external users would be impacted (at least qemu's testsuite
> heavily relies on the extension of single quotes).

Looks like this:

    rsp =3D qdict_from_jsonf_nofail("{ 'error': { 'class': %s, 'desc': %s }=
 }",
                                  QapiErrorClass_str(error_get_class(err)),
                                  error_get_pretty(err));

Without the extension, we'd suffer from a mild case of leaning toothpick
syndrome:

    rsp =3D qdict_from_jsonf_nofail("{ \"error\": { \"class\": %s, \"desc\"=
: %s } }",
                                  QapiErrorClass_str(error_get_class(err)),
                                  error_get_pretty(err));

I intentionally picked an example outside tests/ :)

> Are there any third-party libraries that parse JSON5?
> https://json5.org/ documents that one of the nice features of JSON5 is
> that single quotes work out of the box.  Right now, even though qemu
> does NOT parse the same thing as pure JSON (which is
> https://datatracker.ietf.org/doc/rfc8259/), it does appear to parse a
> subset of JSON5, where the additional features of JSON5 (such as
> allowing a trailing comma, escaped newlines within strings, allowing
> bareword key:"value" syntax, a larger set of accepted numeric values,
> allowing comments) don't seem that onerous.

JSON5 is rather niche, I'm afraid.

>> If we're going to call QMP protocol JSON, then IMHO QEMU should follow
>> the JSON spec as closely as possible, without extensions.
>
> As it is, qemu explicitly does NOT parse all valid JSON - it rejects
> non-ASCII bytes (whether as UTF-8 or as \u escape sequences) in
> strings. So the fact that it already extensions in some places and
> limitations in others is a burden for clients to be aware of.

Not true; I think you're confusing the QAPI schema parser
scripts/qapi/parser.py with the JSON parser qobject/json-*.[ch].

Quoting json-lexer.c:

 * Extensions over RFC 8259:
 * - Extra escape sequence in strings:
 *   0x27 (apostrophe) is recognized after escape, too
 * - Single-quoted strings:
 *   Like double-quoted strings, except they're delimited by %x27
 *   (apostrophe) instead of %x22 (quotation mark), and can't contain
 *   unescaped apostrophe, but can contain unescaped quotation mark.
 * - Interpolation, if enabled:
 *   The lexer accepts %[A-Za-z0-9]*, and leaves rejecting invalid
 *   ones to the parser.

Makes use of RFC 8259 section 9. Parsers: "A JSON parser MAY accept
non-JSON forms or extensions."

The QAPI schema parser indeed restricts strings to printable ASCII.  The
QAPI schema language is so bastardized, I'm not sure how much RFC 8259
still matters, but if you think it does, then consider section
9. Parsers: "An implementation may set limits on the length and
character contents of strings."

>> On the flip side, if we're going to support extensions like single quoti=
ng,
>> then we should make it clear to applications that this is not really JSO=
N
>> and that they need to provide an impl that is 100% matching QEMU's diale=
ct.
>> This effectively means they need just import a copy of QEMU's code.

To the best of my knowledge, the JSON parser interprets any valid strict
JSON input in accordance to RFC 8259.  In other words, you don't notice
the extensions unless you use them, or rely on invalid strict JSON to be
rejected.

Peter Luo's input uses one of QEMU's JSON parser's extensions like this:

    "base":'json:{...}'

This is not valid strict JSON.  Libvirt's JSON parser doesn't accept it.

The problem is not presence of extensions in QEMU, it's the use of these
extensions in input for libvirt.  Removing the extensions from QEMU will
not affect the error.  Removing their use from the input will.


