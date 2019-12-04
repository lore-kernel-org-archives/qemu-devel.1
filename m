Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D29C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7062077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/+h5EAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7062077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icUZz-0003yU-Om
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icUYv-0003G2-4n
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:19:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icUYt-0000Xi-FD
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:19:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37356
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icUYs-0000X1-C0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575465560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVcPM2QqeV0nAjqyW+XeHLMHZqTbtUiZFdF8oHvpZ2o=;
 b=L/+h5EAkKWIwxa21ITaF4Yh0QwPcXq9LT5jXRhhwSsKk1FWSovZ5X9Ddac1jqgNr7sAmTy
 HBvea3otv1i+NPu6Wqt7O3CPgPmY5oqEJ7iBgnoo/QZwzyCTqbDNXMGH/M4enVmMLGGt/N
 O6KSXAsJszbe6pDJEJK+mVTDlre7tAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-PxUhytMxPGyJ9TDU_dlUNQ-1; Wed, 04 Dec 2019 08:19:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7564018B6328;
 Wed,  4 Dec 2019 13:19:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 297D45D6BE;
 Wed,  4 Dec 2019 13:19:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B177E1138606; Wed,  4 Dec 2019 14:19:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 7/6] Makefile: Make Makefile depend on generated qga files, too
References: <20191120182551.23795-1-armbru@redhat.com>
 <20191129095927.17382-1-armbru@redhat.com>
 <45cff400-7e88-cefe-560e-7642d2ea1d00@redhat.com>
 <8736e0h93m.fsf@dusky.pond.sub.org>
 <42dbda81-f1a0-bb15-cee6-3040f41f38ef@redhat.com>
Date: Wed, 04 Dec 2019 14:19:14 +0100
In-Reply-To: <42dbda81-f1a0-bb15-cee6-3040f41f38ef@redhat.com> (Eric Blake's
 message of "Wed, 4 Dec 2019 06:58:16 -0600")
Message-ID: <87blso9qjx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: PxUhytMxPGyJ9TDU_dlUNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 12/4/19 12:56 AM, Markus Armbruster wrote:
>
>>>> +++ b/Makefile
>>>> @@ -130,6 +130,15 @@ GENERATED_QAPI_FILES +=3D qapi/qapi-doc.texi
>>>>      generated-files-y +=3D $(GENERATED_QAPI_FILES)
>>>>    +GENERATED_QGA_FILES :=3D qga-qapi-types.c qga-qapi-types.h
>>>> +GENERATED_QGA_FILES +=3D qga-qapi-visit.c qga-qapi-visit.h
>>>> +GENERATED_QGA_FILES +=3D qga-qapi-commands.h qga-qapi-commands.c
>>>> +GENERATED_QGA_FILES +=3D qga-qapi-init-commands.h qga-qapi-init-comma=
nds.c
>>>> +GENERATED_QGA_FILES +=3D qga-qapi-doc.texi
>>>> +GENERATED_QGA_FILES :=3D $(addprefix qga/qapi-generated/, $(GENERATED=
_QGA_FILES))
>>>
>>> Would it be worth using two separate variable names (maybe
>>> GENERATED_QGA_BASEFILES for the first list) rather than exploiting the
>>> arcane knowledge that consecutive use of :=3D causes GNU make to rewrit=
e
>>> an existing variable with new contents?
>>
>> Our rules.mak relies on this already.  It's full of magic, which
>> admittedly diminishes its suitability to serve as a good example.
>>
>> Your worry might be rooted in old "=3D" burns.  "=3D" makes the variable
>> recursively expanded, and
>>
>>      GENERATED_QGA_FILES =3D $(addprefix qga/qapi-generated/, $(GENERATE=
D_QGA_FILES))
>
> Indeed, but I have to refer to the manual to remind myself of whether
> =3D or :=3D is what I want in a given situation.

Trust me, you're either sure you want "=3D", or you want ":=3D".

On a green field, I recommend a hard rule "no =3D without a comment
explaining why".

>> would be an infinite loop.  ":=3D" makes it simply expanded; there's not
>> even a loop, let alone an infinite one.  The GNU Make manual explains
>> this clearly at
>> https://www.gnu.org/software/make/manual/html_node/Flavors.html
>>
>> Aside: there's a reason one of the two flavors is called "simple".  It
>> could additionally be called "not as slow".  One of my pet makefile
>> peeves: unthinking use of recursively expanded variables, complicating
>> semantics and slowing down builds.
>>
>> Back to this patch.  I had started to write the thing in longhand, but
>> got tired of repeating qga/qapi-generated/, so I factored that out.
>> Would longhand be easier to understand?
>
> It's more verbose.  My suggestion was more:
>
> GENERATED_QGA_BASENAMES :=3D qga-qapi-types.c qga-qapi-types.h
> GENERATED_QGA_BASENAMES +=3D qga-qapi-visit.c qga-qapi-visit.h
> ...
> GENERATED_QGA_FILES :=3D $(addprefix qga/qapi-generated/,
> $(GENERATED_QGA_BASENAMES))
>
> to avoid the reassignment-to-self issue altogether, while still
> remaining concise compared to longhand.

Either way, we use multiple assignments to build GENERATED_QGA_FILES.
The only difference is that the version using two variables would also
work with recursive expansion, due to the magic of +=3D.


