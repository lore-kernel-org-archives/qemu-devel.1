Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB0C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD2D21734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpMkr3rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD2D21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itnEI-0001oG-O4
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 01:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1itnDO-0001OF-AP
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1itnDK-0003jH-9m
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:40:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1itnDK-0003iM-5R
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579588837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T502W+tNmoY/8XD6lfwWY5SwVrNcBz7ESJ+n2i5q8Is=;
 b=GpMkr3rkQSjHF9BwiFN5vh3IpX1+tjB9RKdbHawo0MPow3ixb+SsFoa0iS1drorgfAl/Yw
 mee6Bd6IR/saPNsIbkNNRXae3voJ2B4a0VswoPH8BdvU0f70+2TBSP8e63JbCOtwTsq0Uc
 BnBxCRiwNgDr/Bj9eGNdGM+SqRWMtds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-cQx8sjYJOzanumP-DqhC1w-1; Tue, 21 Jan 2020 01:40:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EEFE8017CC;
 Tue, 21 Jan 2020 06:40:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E76F683860;
 Tue, 21 Jan 2020 06:40:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 75F121138600; Tue, 21 Jan 2020 07:40:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Proposal for handling .hx files with Sphinx
References: <CAFEAcA-_Y0Qaw-S83tMAph21opaDx-2y6aPbv5J_J0Bo4bgJuA@mail.gmail.com>
 <96e75f84-fc52-9f19-3733-671aec6dc7fc@redhat.com>
Date: Tue, 21 Jan 2020 07:40:28 +0100
In-Reply-To: <96e75f84-fc52-9f19-3733-671aec6dc7fc@redhat.com> (John Snow's
 message of "Mon, 20 Jan 2020 19:20:22 -0500")
Message-ID: <87k15ll3c3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: cQx8sjYJOzanumP-DqhC1w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 1/17/20 12:30 PM, Peter Maydell wrote:
>> Currently our manual creation includes some .texi files which
>> are autogenerated from .hx files by running scripts/hxtool.
>> .hx files are a simple format, where where a line is either a
>> directive or literal text to be output:
>>=20
>> HXCOMM
>>  -- comment lines, ignored
>> STEXI/ETEXI
>>  -- mark start/end of chunks of text to put into the texinfo output only
>> DEFHEADING/ARCHHEADING
>>  -- appear in the .h file output verbatim (they are defined as C macros)=
;
>>     for texi output they are parsed to add in header sections
>>=20
>> For Sphinx, rather than creating a file to include, the most
>> natural way to handle this is to have a small custom Sphinx
>> extension which will read the .hx file and process it. So
>> instead of "makefile produces foo.texi from foo.hx, qemu-doc.texi
>> says '@include foo.texi'", we have "qemu-doc.rst says
>> 'hxtool-doc:: foo.hx', the Sphinx extension for hxtool has
>> code that runs to handle that Sphinx directive, it reads the .hx
>> file and emits the appropriate documentation contents". (This is
>> pretty much the same way the kerneldoc extension works right now.
>> It also has the advantage that it should work for third-party
>> services like readthedocs that expect to build the docs directly
>> with sphinx rather than by invoking our makefiles.)
>>=20
>> We'll need to update what the markup is to handle having rST
>> fragments in it. A very minimalist approach to this would
>> simply define a new pair of SRST/ERST directives marking the
>> start/end of chunks of rST text to go into the rST only.
>> (We might be able to do better than that later, as there's
>> some repetition currently going on. But we'll probably get
>> a better idea of how easy it is to avoid the repetition if
>> we start with a simple conversion.)
>>=20
>> Here's what we do with hx files at the moment. We have four:
>>=20
>>  hmp-commands.hx
>>    -- defines monitor commands used by monitor.c; generates
>>       qemu-monitor.texi, used by qemu-doc.texi
>>  hmp-commands-info.hx
>>    -- ditto, for the "info" command's subcommand;
>>       generates qemu-monitor-info.texi, used by qemu-doc.texi
>>=20
>> These two use only the "put this in the texi or in the .h file"
>> functionality, alternating "raw C code defining an entry for the
>> monitor command array" with "lump of raw texi for the docs".
>>=20
>>  qemu-img-cmds.hx
>>    -- defines options for qemu-img, used by qemu-img.texi
>>=20
>> This uses the STEXI/ETEXI directives to alternate C and texi.
>> In the for-the-h-file section the only content is always a DEF()
>> macro invocation defining the option; in the texi is only the
>> synopsis of the command. This means there's a lot of repetition,
>> as the DEF macro includes an argument giving the text of the
>> option synopsis, and then the texi also has that synopsis with
>> some extra markup. Finally the main qemu-img.texi repeats the
>> marked-up synopsis later on when it has the actual main documentation
>> of each command.
>>=20
>>  qemu-options.hx
>>    -- options for qemu proper, used by qemu-doc.texi
>>=20
>> This uses only the DEF, DEFHEADING, ARCHHEADING macros
>> in the for-the-h-file sections (and the DEFHEADING/ARCHHEADING
>> are read also for texi generation). This also repeats the
>> synopsis in the DEF macro and in the texi fragment.
>>=20
>> So I think my current view is that we should do the very
>> simple "add SRST/ERST directives" to start with:
>>  * scripts/hxtool needs to recognize them and just ignore
>>    the text inside them
>>  * write the hxtool sphinx extension (shouldn't be too hard)
>>  * conversion of any particular .hx file then involves
>>    replacing the STEXI ...texi stuff... ETEXI sections with
>>    SRST ...rst stuff... ERST. There's no need for any
>>    particular .hx file to support both texi and rst output
>>    at the same time
>>=20
>> I would initially start with qemu-img-cmds.hx, since that's
>> pulled in by qemu-img.texi, which we can convert in the
>> same way I've been doing qemu-nbd and other standalone-ish
>> manpages. The others are part of the big fat qemu-doc.texi,
>> which is probably going to be the very last thing we convert...
>>=20
>
> At one point I did a quick mockup of turning qemu-img-cmds.hx into json
> and wrote a small tool I called "pxtool" that was used for generating
> all the rest of the subsequent information -- an attempt at getting rid
> of .hx files *entirely*.
>
> The idea at heart was: "Can we remove .hx files and describe everything
> in terms of the QAPI schema instead?"
>
> I'm still a bit partial to that idea, but realize there are some nasty
> complexities when it comes to describing the QEMU CLI as a schema. One
> of those is that I doubt we even have a full understanding of what the
> CLI syntax is at all.

My CLI QAPIfication prototype[*] gets rid of qemu-options.hx.  Three
more are left: hmp-commands.hx, hmp-commands-info.hx, qemu-img-cmds.hx.
No idea whether these could and should be QAPIfied.

Going beyond prototype is hard, not least for the reason you mentioned.

> Still, I do want to ask: Are we sure we want to double-down on keeping
> the .hx files around instead of trying to move to a more generic data
> format?

One the one hand, I'd prefer to invest as little as practical into .hx.
On the other hand, adding more hard dependencies on QAPIfication is not
a good idea.

What's the stupidest solution that could possibly work now?  Is it the
one Peter sketched?



[*] https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg00209.html
Message-Id: <20171002152552.27999-1-armbru@redhat.com>
https://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/qapi-cmdline


