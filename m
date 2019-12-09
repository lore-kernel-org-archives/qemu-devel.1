Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FD4C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517B22073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dA53JiTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517B22073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieM8Q-0003om-DD
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ieM7Z-0003A4-47
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ieM7X-0008K6-Qw
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:42:52 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ieM7X-0008Jl-M3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:42:51 -0500
Received: by mail-oi1-x244.google.com with SMTP id j22so6874458oij.9
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 08:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=b8vXYsSVKsNBeBAfyVFZC4KkBnsU85iNmEq2tQIHo6Q=;
 b=dA53JiTf+kZUAACMy3+iwuZE3Z3Y3/u7gaE8DDsh/Ek8KY8DlxrFyeJ3FIcszTp4QL
 W4cjMr65TNbsRqicTukkj9oeQUcwP6I+Tw8vytRsI5RkZOuMJmqcSBA9wqOvBhdO4URf
 XYymnVjW9aim1DNPiIXSKZsyceZrvXfSiqsR9kc7263r/E1xDmjPlnaAinPXAA4D4vGq
 MFMb+ZxeHS79qTN99v+Zxfqw0WBBP1cfP+7sBebyvElZHjGD/ljm5PhlTKqzID0QpJu8
 HbeBTmxKrHPS2AB95VWXBkWjMKWHey3I+SaKAFTf+QoA0WopzHEOlKznv8BC7L0edgjC
 6Tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b8vXYsSVKsNBeBAfyVFZC4KkBnsU85iNmEq2tQIHo6Q=;
 b=oOWjfbSMQCzi0rHc62y/tFJuQulqc6CAczoCXJr+CelWX2PTQ8JyFSrqOUn7O0SE5i
 fnupLzoqGyJ1mooUGzhoFKGVV8RGsuzk+s51rnEanO5hvZlYgrFv2nseUhRcsFm07A/b
 Gy4i6gkWsVu3n8/riV31RP7EzLXH3Gofx52YuKiAkJZrnZ4avMsb2ZwV14ttXE2iAQwx
 EjW75+NipGxYbIDsO0QCsIh5C09nxm3fsHA9HxZjox7dIVjxIiGQovvpz606pslDEqI0
 gFdnZuIrNyP8WxGwXWrf19AuJ0xX+gDTV4qlQoDQDbUzA9wPqUzpU757D1Xa9BS7vjsk
 u7gQ==
X-Gm-Message-State: APjAAAWXDV5s3CBTZ0bod88mjd6DKR6o7avLtRMvzaBKwsy1Lm2LyIPm
 y5AejkPwGKq+p95nf5fAAj8t+hGOT+6v0wOU0gHubA==
X-Google-Smtp-Source: APXvYqyAOZyJbvZKvodKUvYk3jgYimsQNkMyyO3ydRSZN9Q3wahR8j7Ntc7/zA2hCqWROGEY1CAVDHIcUE+VAnyneEQ=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr25510812oih.98.1575909770330; 
 Mon, 09 Dec 2019 08:42:50 -0800 (PST)
MIME-Version: 1.0
References: <157589808041.21182.18121655959115011353.stgit@bahia.lan>
 <bf095dc0-321e-0d19-9d18-309317654050@redhat.com>
 <20191209172716.175a86b5@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191209172716.175a86b5@bahia.w3ibm.bluemix.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Dec 2019 16:42:39 +0000
Message-ID: <CAFEAcA-WFd9XVXS5bt4sWOw9BzuS=ODTDneTUJzQ4z8Mks4X3A@mail.gmail.com>
Subject: Re: [for-5.0 PATCH] ppc: Make PPCVirtualHypervisor an incomplete type
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Dec 2019 at 16:28, Greg Kurz <groug@kaod.org> wrote:
>
> On Mon, 9 Dec 2019 15:02:38 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>
> > On 12/9/19 2:28 PM, Greg Kurz wrote:
> > > PPCVirtualHypervisor is an interface instance. It should never be
> > > dereferenced. Drop the dummy type definition for extra safety, which
> > > is the common practice with QOM interfaces.
> >
> > This "common practice" is also referenced in commit 00ed3da9b5:
> >
> >      xics: Minor fixes for XICSFabric interface
> >
> >      Interface instances should never be directly dereferenced.  So, th=
e
> > common
> >      practice is to make them incomplete types to make sure no-one does
> > that.
> >      XICSFrabric, however, had a dummy type which is less safe.
> >
> >      We were also using OBJECT_CHECK() where we should have been using
> >      INTERFACE_CHECK().
> >
> > This indeed follow the changes from commit aa1b35b975d8:
> >
> >      qom: make interface types abstract
> >
> >      Interfaces don't have instance, let's make the interface type real=
ly
> >      abstract to avoid confusion.
> >
> > Now I can't find guidelines for this. If you don't know about it and us=
e
> > 'git-grep', it is very confusing to see we use structures we never defi=
ne.
> >
>
> I agree that this deliberate usage of incomplete types isn't common.
>
> > Can we document this use please?
> >
>
> Probably we could amend the related section in the object.h header file.
> Something like:
>
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -200,8 +200,11 @@ typedef struct InterfaceInfo InterfaceInfo;
>   *
>   * Interfaces allow a limited form of multiple inheritance.  Instances a=
re
>   * similar to normal types except for the fact that are only defined by
> - * their classes and never carry any state.  You can dynamically cast an=
 object
> - * to one of its #Interface types and vice versa.
> + * their classes and never carry any state.  As a consequence, a pointer=
 to
> + * an interface instance should always be of incomplete type in order to=
 be
> + * sure it cannot be dereferenced.

It might be helpful to add here the concrete details of how to do that,
so people don't have to look up what an incomplete type is:

"That is, you should define the 'typedef struct SomethingIf SomethingIf'
so that you can pass around 'SomethingIf *si' arguments, but not define
a 'struct SomethingIf { ... }'. The only things you can validly do with
a 'SomethingIf *' are to pass it as an argument to a method on its correspo=
nding
SomethingIfClass, or to dynamically cast the interface pointer to a pointer
to the concrete object which is implementing the interface."

?

> + * You can dynamically cast an object to one of its #Interface types and=
 vice
> + * versa.

...though that last part is then kind of awkwardly similar to this sentence=
.
There's probably better wording possible than what I suggest above.

thanks
-- PMM

