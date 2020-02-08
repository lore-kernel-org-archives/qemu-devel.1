Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B95C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 07:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE7521741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 07:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqrV2JPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE7521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Kul-0006BQ-Al
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 02:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j0KtU-0004KB-Dt
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j0KtS-0003sH-SP
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:51:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47986
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j0KtS-0003rk-E2
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581148268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqR4ut6HIrv3YBnbDqC2g9P6nmQ6zSjnlHoN1vu3oEw=;
 b=TqrV2JPoym/UCYeFe5kYuAtO9kF4ggS7zjxKnnzWM9+5bmZnfheeyGwPxe7fqkrxFvZtZU
 ydbQ+2lkTT/DkTekwoMPdtv4N8k0L4tQYgPYclZiYqNdU+CENWk3osug0eEnAWeut+fbAa
 1CGyQAHtQQRV3CJfNKTCEf8Zg93mXTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-53KCOphZN_i2oKQvrX_ovA-1; Sat, 08 Feb 2020 02:51:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0A0E8010CA;
 Sat,  8 Feb 2020 07:51:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8943B8ECEC;
 Sat,  8 Feb 2020 07:50:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E92B11386A7; Sat,  8 Feb 2020 08:50:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 02/29] configure: Check that sphinx-build is using Python 3
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-3-peter.maydell@linaro.org>
 <875zgipe1n.fsf@dusky.pond.sub.org>
 <CAFEAcA90qHdHvozNhjX0d5xzoOiFb6oTVdXWf9u9aRvV=YHw4w@mail.gmail.com>
Date: Sat, 08 Feb 2020 08:50:57 +0100
In-Reply-To: <CAFEAcA90qHdHvozNhjX0d5xzoOiFb6oTVdXWf9u9aRvV=YHw4w@mail.gmail.com>
 (Peter Maydell's message of "Fri, 7 Feb 2020 16:30:52 +0000")
Message-ID: <87d0apldpa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 53KCOphZN_i2oKQvrX_ovA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Feb 2020 at 16:18, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > Currently configure's has_sphinx_build() check simply runs a dummy
>> > sphinx-build and either passes or fails.  This means that "no
>> > sphinx-build at all" and "sphinx-build exists but is too old" are
>> > both reported the same way.
>> >
>> > Further, we want to assume that all the Python we write is running
>> > with at least Python 3.5; configure checks that for our scripts, but
>> > Sphinx extensions run with whatever Python version sphinx-build
>> > itself is using.
>> >
>> > Add a check to our conf.py which makes sphinx-build fail if it would
>> > be running our extensions with an old Python, and handle this
>> > in configure so we can report failure helpfully to the user.
>> > This will mean that configure --enable-docs will fail like this
>> > if the sphinx-build provided is not suitable:
>> >
>> > Warning: sphinx-build exists but it is either too old or uses too old =
a Python version
>> >
>> > ERROR: User requested feature docs
>> >        configure was not able to find it.
>> >        Install texinfo, Perl/perl-podlators and a Python 3 version of =
python-sphinx
>> >
>> > (As usual, the default is to simply not build the docs, as we would
>> > if sphinx-build wasn't present at all.)
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> > Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> > ---
>> >  configure    | 12 ++++++++++--
>> >  docs/conf.py | 10 ++++++++++
>> >  2 files changed, 20 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/configure b/configure
>> > index 0aceb8e50db..2c5cad13edd 100755
>> > --- a/configure
>> > +++ b/configure
>>
>> Any particular reason for having $sphinx_build default to the
>> indeterminate version sphinx-build rather than sphinx-build-3?
>
> Because that's the binary we were using before this patch.
> "Allow the user to specify" shouldn't be tangled up with
> "and also change the default".
>
> It might be sphinx-build-3 on RH, but on Debian/Ubuntu it's
> just 'sphinx-build' assuming you installed the python3-sphinx
> and not the python2-sphinx, or you can run it directly out of
> /usr/share/sphinx/scripts/python3/sphinx-build, or (like
> me) you might have a locally installed 'sphinx-build' which
> is using Python 3. My assumption is that once the python2->3
> transition has faded into the rear view mirror most distros
> will just have a /usr/bin/sphinx-build that's a Python 3 one.

Defaulting to sphinx-build-3 if it exists, else sphinx-build would be
nicer for users on some common systems, and wouldn't hurt users on the
other common systems.  It's what we do for Python.


