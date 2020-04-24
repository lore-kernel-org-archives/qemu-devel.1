Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE19C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005BE20736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PskKtfW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005BE20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRup0-00022a-4e
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 05:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRuoC-0001Kk-Ms
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRuo8-00066u-At
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:39:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41115
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRuo7-00065o-Tf
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587721178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65QQKAkQD69UHx96KzfXNnESVtKVthMR3jlI+VxjmZQ=;
 b=PskKtfW3dtbX00JpvKXeFvez2SvovoGvucg4gnGfqZO5tQq8p8PgAJKARXNpMJj8IPSSq7
 VHEo/ueFL4m7194xFkLrM2JQv4KrzDt874kvMzbBadcvzxCUkcNIu6rucXDDNgqr7e64bz
 w3agbthNBx++myYntl4a6wnMUzNrFAw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-gAikjl-bN1yuE4QeQ-4zdw-1; Fri, 24 Apr 2020 05:39:34 -0400
X-MC-Unique: gAikjl-bN1yuE4QeQ-4zdw-1
Received: by mail-wr1-f72.google.com with SMTP id u4so4499621wrm.13
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 02:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=65QQKAkQD69UHx96KzfXNnESVtKVthMR3jlI+VxjmZQ=;
 b=BO40EFDB3azcQiFWSGYH6JW3RMGOM0LAmoApD9Pq15hzEbHz/hYLNhQSXzd6RLUdtL
 lNmHX1uU031lagjdcbQ8Q1Hq8D9CN9MsGFWYP2jUy/EAG2m8h/wWHMXi47eJyCpgE3S2
 tjKOa6Q8rD7ci5BTfSpq92tGfarZ9O7ZZb3QCHEK3jm/rq/dnao5hEvv229V8G8LuY8E
 cHbVEfYlRGDSE/WUWt/n46hveKXOkzOOq80zY45qmDaHIZaoROyvvDIDBCP8fxBwLnSm
 jmYY0Lt7L84zHJp/vmfAVvJxkhcN2lIhDKCbjcYwFwzDNeSsrBrDTkJPKOCccrrFtxU9
 Lh/g==
X-Gm-Message-State: AGi0PuZAoYKxTL+BaM4GXax64tsqpt/LgT7fKbKBn1opu52Hi/xAT5uV
 npDfQZbkHuzNuG+YB8wO0g5EbY9R/zuXe+yyRWpPdsH6ADZDwiD6H0GW3ZgwWHVSvjTvcd9RkcF
 4mBTTZzpsuagScRSKWyILIIFfeUmEA5w=
X-Received: by 2002:a5d:4485:: with SMTP id j5mr9466714wrq.427.1587721173715; 
 Fri, 24 Apr 2020 02:39:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQTjzGWXyneF+Vecm1gldly1Y5bAXRqeg6NBC0I56yT+cFCbW8Cc47f08OGuOKqunVbbJ6ndrRIzEsLr3dXmM=
X-Received: by 2002:a5d:4485:: with SMTP id j5mr9466677wrq.427.1587721173451; 
 Fri, 24 Apr 2020 02:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <348064782.9653447.1587663408130.JavaMail.zimbra@redhat.com>
 <20200424093023.GD1212635@redhat.com>
In-Reply-To: <20200424093023.GD1212635@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 24 Apr 2020 11:39:22 +0200
Message-ID: <CAP+75-WK4gOfsHiiuhObwJb+6HPdvAJi90deaBbBM7-NG-gyiQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Erik Skultety <eskultet@redhat.com>, Wainer Moschetta <wmoschet@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 24, 2020 at 11:30 AM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > ----- Original Message -----
> > > From: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> > > To: "Cleber Rosa" <crosa@redhat.com>
[...]
> > Hi Daniel,
> >
> > We're already using the shared x86 runners, but with a different goal. =
 The
> > goal of the "Gating CI" is indeed to expand on non-x86 environments.  W=
e're
> > in a "chicken and egg" kind of situation, because we'd like to prove th=
at
> > GitLab CI will allow QEMU to expand to very different runners and jobs,=
 while
> > not really having all that hardware setup and publicly available at thi=
s time.
> >
> > My experiments were really around that point, I mean, confirming that w=
e can grow
> > the number of architectures/runners/jobs/configurations to provide a co=
verage
> > equal or greater to what Peter already does.
>
> So IIUC, you're saying that for x86 gating, the intention is to use share=
d
> runners in general.
>
> Your current work that you say is blocked on access to x86 hardware, is j=
ust
> about demonstrating the concept of plugging in custom runners, while we w=
ait
> for access to non-x86 hardware ?
>
> > > With GitLab if someone forks the repo to their personal namespace, th=
ey
> > > cannot use any custom runners setup by the origin project. So if we u=
se
> > > custom runners for x86, people forking won't be able to run the GitLa=
b
> > > CI jobs.
> > >
> >
> > They will continue to be able use the jobs and runners already defined =
in
> > the .gitlab-ci.yml file.  This work will only affect people pushing to =
the/a
> > "staging" branch.
> >
> > > As a sub-system maintainer I wouldn't like this, because I ideally wa=
nt
> > > to be able to run the same jobs on my staging tree, that Peter will r=
un
> > > at merge time for the PULL request I send.
> > >
> >
> > If you're looking for symmetry between any PR and "merge time" jobs, th=
e
> > only solution is to allow any PR to access all the diverse set of non-s=
hared
> > machines we're hoping to have in the near future.  This may be somethin=
g
> > we'll get to, but I doubt we can tackle it in the near future now.
>
> It occurred to me that we could do this if we grant selective access to
> the Gitlab repos, to people who are official subsystem maintainers.
> GitLab has a concept of "protected branches", so you can control who is
> allowed to push changes on a per-branch granularity.
>
> So, for example, in the main qemu.git, we could create branches for each
> subsystem tree eg
>
>   staging-block
>   staging-qapi
>   staging-crypto
>   staging-migration
>   ....
>
> and for each of these branches, we can grant access to relevant subsystem
> maintainer(s).

The MAINTAINERS file could help us with that, we already have scripts
to parse its sections.
Maintainers should keep it up-to-date, then the merge script would check, i=
.e.:

<newline> // section separator
--------------- // ignored
Trivial patches // description ignored
M: Michael Tokarev <mjt@tls.msk.ru>
M: Laurent Vivier <laurent@vivier.eu> // must match commit author
T: git git://git.corpit.ru/qemu.git trivial-patches
T: git https://github.com/vivier/qemu.git trivial-patches // must
match MR source

>
> When they're ready to send a pull request to Peter, they can push their
> tree to this branch. Since the branch is in the main gitlab.com/qemu/qemu
> project namespace, this branch can run CI using the private QEMU runners.
> The subsystem maintainer can thus see the full set of CI results across
> all platforms required by Gating, before Peter even gets the pull request=
.
>
> So when Peter then looks at merging the pull request to master, the only
> he's likely to see are the non-deterministic bugs, or issues caused by
> semantic conflicts with other recently merged code.
>
> It would even be possible to do the final merge into master entirely from
> GitLab, no need to go via email. When the source branch & target branch a=
re
> within the same git repo, GitLab has the ability to run CI jobs against t=
he
> resulting merge commit in a strict gating manner, before it hits master.
> They call this "Merge trains" in their documentation.
>
> IOW, from Peter's POV, merging pull requests could be as simple as hittin=
g
> the merge button in GitLab merge request UI. Everything wrt CI would be
> completely automated, and the subsystem maintainers would have the
> responsibility to dealing with merge conflicts & CI failures, which is
> more scalable for the person co-ordinating the merges into master.
>
>
> Regards,
> Daniel


