Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB371C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DB02051A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAKAPme0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DB02051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jaP-0007FA-Sx
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j7jXJ-0001ZD-FJ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j7jXH-00024f-Sd
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:34:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j7jXH-000232-Nh
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 12:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582911290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nR1tpYWfgsUb4c6rPE1uaukrxA/CypxAWsKjqplQw4U=;
 b=LAKAPme0tHcoOa6XVWxl/iWG1J+17DsLC8ur8fW1KJl/LIiL3U7grNoUe+4/CNk2Gjh3KE
 RsfGnuduASGLaraWLjO4XKts8ueBvoJCZWZHwZH8tZjcNdXjAO0pbZsU9iguWXZ5pNdIOT
 LC+OoKcZWjGB1p8DpEcQakhSkgTLbIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-m63Yrc88MSaazgQBuhr_cA-1; Fri, 28 Feb 2020 12:34:43 -0500
X-MC-Unique: m63Yrc88MSaazgQBuhr_cA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFB0F100550E
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:34:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44AE590A16;
 Fri, 28 Feb 2020 17:34:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E867B11386A6; Fri, 28 Feb 2020 18:34:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] qapi/machine: Place the 'Notes' tag after the 'Since'
 tag
References: <20200227134019.6218-1-philmd@redhat.com>
 <87tv3cozfw.fsf@dusky.pond.sub.org>
 <c27cdab5-23a9-78f4-994a-49aaf96eb487@redhat.com>
 <49248832-6ce3-a545-0ee3-8bd3ce664725@redhat.com>
 <87tv3bmc8c.fsf@dusky.pond.sub.org>
 <d124e9bc-1db6-52a4-843f-7f3fe73fbe5d@redhat.com>
Date: Fri, 28 Feb 2020 18:34:40 +0100
In-Reply-To: <d124e9bc-1db6-52a4-843f-7f3fe73fbe5d@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 28 Feb 2020 11:17:21
 +0100")
Message-ID: <87y2smhaz3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/28/20 7:56 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>> On 2/27/20 3:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 2/27/20 3:52 PM, Markus Armbruster wrote:
>>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>>>
>>>>>> This fixes when adding a 'Since' tag:
>>>>>>
>>>>>>  =C2=A0=C2=A0 In file included from qapi/qapi-schema.json:105:
>>>>>>  =C2=A0=C2=A0 qapi/machine.json:25:1: '@arch:' can't follow 'Notes' =
section
>>>>>
>>>>> I'm confused.=C2=A0 This error is detected in scripts/qapi/parser.py,=
 and it
>>>>> is fatal.=C2=A0 Is the build broken for you?=C2=A0 It isn't for me.=
=C2=A0 Moreover,
>>>>> where is @arch?=C2=A0 I can't see it anywhere close to the two spots =
the
>>>>> patch patches.
>>>>
>>>> I get the error after trying to fix what Eric commented here:
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg682344.html
>>>
>>> Using:
>>> ---
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index 6c11e3cf3a..40a36d6276 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -20,13 +20,15 @@
>>>   #        prefix to produce the corresponding QEMU executable name. Th=
is
>>>   #        is true even for "qemu-system-x86_64".
>>>   #
>>> +# @rx: since 5.0
>>> +#
>>>   # Since: 3.0
>>>   ##
>>>   { 'enum' : 'SysEmuTarget',
>>>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32=
',
>>>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>>> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>>> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>>>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>>>                'x86_64', 'xtensa', 'xtensaeb' ] }
>>> ---
>>>
>>> or
>>>
>>> ---
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index 6c11e3cf3a..4b59e87b6f 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -21,12 +21,14 @@
>>>   #        is true even for "qemu-system-x86_64".
>>>   #
>>>   # Since: 3.0
>>> +#
>>> +# @rx: since 5.0
>>>   ##
>>>   { 'enum' : 'SysEmuTarget',
>>>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32=
',
>>>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>>> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>>> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>>>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>>>                'x86_64', 'xtensa', 'xtensaeb' ] }
>>> ---
>>>
>>> I get:
>>>
>>>    GEN     qapi-gen
>>>    GEN     rx-softmmu/config-devices.mak
>>> In file included from qapi/qapi-schema.json:105:
>>> qapi/machine.json:23:1: '@rx:' can't follow 'Notes' section
>>> make: *** [Makefile:645: qapi-gen-timestamp] Error 1
>>>
>>> This works however:
>>>
>>> ---
>>>   ##
>>>   # @SysEmuTarget:
>>>   #
>>>   # The comprehensive enumeration of QEMU system emulation ("softmmu")
>>>   # targets. Run "./configure --help" in the project root directory, an=
d
>>>   # look for the *-softmmu targets near the "--target-list" option. The
>>>   # individual target constants are not documented here, for the time
>>>   # being.
>>>   #
>>> +# @rx: since 5.0
>>> +#
>>>   # Notes: The resulting QMP strings can be appended to the "qemu-syste=
m-"
>>>   #        prefix to produce the corresponding QEMU executable name. Th=
is
>>>   #        is true even for "qemu-system-x86_64".
>>>   #
>>>   # Since: 3.0
>>>   ##
>>>   { 'enum' : 'SysEmuTarget',
>>>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32=
',
>>>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>>> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>>> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>>>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>>>                'x86_64', 'xtensa', 'xtensaeb' ] }
>>> ---
>>
>> This one adds it to the correct spot.
>
> OK I'll use that then.
>
>>
>> qapi-code-gen.txt:
>>
>>      Definition documentation starts with a line naming the definition,
>>      followed by an optional overview, a description of each argument (f=
or
>>      commands and events), member (for structs and unions), branch (for
>>      alternates), or value (for enums), and finally optional tagged
>>      sections.
>
> I was confused because I understood "@rx: since 5.0" as a tagged
> section, not as an "Optional overview".

It's actually "a description of a value", not "optional overview".

[...]


