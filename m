Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E29C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3B721569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lt2eOMnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3B721569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itu6V-0003O3-Ov
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ittvN-0007Yr-Bo
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ittvH-0008F9-SD
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:50:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ittvH-0008Eg-MT
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579614627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhxVP5aoZQHy/GBwbxlwFZKRgm3WKUy0Qytem2ijins=;
 b=Lt2eOMnZddOn6mrLqn+hv13MiV8hHD6OcvlNv0P6QxZFNh1CrKCwWbMbvLGcDF1UKUM39O
 n2CVia9xEn2DDZdQ4DHmzK2YTBnHR/2S14pSZld4yM8FWUYP8lyA3HRRkjyv2SBhiY8/Tk
 0TouE2IFprug+6NFrTXnEc3iy/INqik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-HYp5zLPDOxCDOQpQkz0-Uw-1; Tue, 21 Jan 2020 08:50:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D97B018C35B4;
 Tue, 21 Jan 2020 13:50:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1817348;
 Tue, 21 Jan 2020 13:50:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9734C1138600; Tue, 21 Jan 2020 14:50:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Proposal for handling .hx files with Sphinx
References: <CAFEAcA-_Y0Qaw-S83tMAph21opaDx-2y6aPbv5J_J0Bo4bgJuA@mail.gmail.com>
 <96e75f84-fc52-9f19-3733-671aec6dc7fc@redhat.com>
 <87k15ll3c3.fsf@dusky.pond.sub.org>
 <CAFEAcA_JyNUbKcuaXn0J_isGqGpxJrou-wyOiUsms89RRMzW3A@mail.gmail.com>
 <CAFEAcA8C0-HyqnJjc6Bik8E3w3goWr-KB+daObGDp7ZcXqxYDA@mail.gmail.com>
Date: Tue, 21 Jan 2020 14:50:20 +0100
In-Reply-To: <CAFEAcA8C0-HyqnJjc6Bik8E3w3goWr-KB+daObGDp7ZcXqxYDA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 21 Jan 2020 11:52:48 +0000")
Message-ID: <87lfq0dilf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: HYp5zLPDOxCDOQpQkz0-Uw-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 21 Jan 2020 at 11:12, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>>
>> On Tue, 21 Jan 2020 at 06:40, Markus Armbruster <armbru@redhat.com> wrot=
e:
>> > John Snow <jsnow@redhat.com> writes:
>> > > Still, I do want to ask: Are we sure we want to double-down on keepi=
ng
>> > > the .hx files around instead of trying to move to a more generic dat=
a
>> > > format?
>> >
>> > One the one hand, I'd prefer to invest as little as practical into .hx=
.
>> > On the other hand, adding more hard dependencies on QAPIfication is no=
t
>> > a good idea.
>> >
>> > What's the stupidest solution that could possibly work now?  Is it the
>> > one Peter sketched?
>>
>> FWIW, I wrote some code for the Sphinx extension approach yesterday,
>> along the 'simplest possible thing' lines. It's less than 200 lines
>> of Python (though I still need to put in the support for DEFHEADING
>> and ARCHHEADING). The actual texinfo fragments in the various .hx
>> files of course would also need to be hand-converted to rST, same
>> as the hand-written manual .texi file contents.
>
> Incidentally, I am definitely coming to the conclusion that the
> best way to do generation of docs to go in Sphinx manuals is
> to use/write a Sphinx extension -- this lets you properly create
> doctree nodes, for instance and it fits the flow better. So a
> in potential future where we were generating these docs from
> json, I think we'd want to have a Sphinx extension driving the
> 'parse the json for docs', rather than a separate script that
> spit out rst-format-text to include.

I trust your judgement.

Since the Sphinx extension is in Python, we can try to reuse the QAPI
frontend there.  We'll see.

I'd like to encourage you to not feel bound to the existing doc comment
language.  When Marc-Andr=C3=A9 created the doc generator, he chose to fit
the doc comment language to the existing doc comments, to avoid churn.
That was probably the right decision then; getting the job done was
tough enough as it was.  The resulting language was basically defined by
its (ad hoc!) parser.  I cleaned up the parser some, and
retro-documented the syntax.  It's still an idiosyncratic mess, to be
honest.


