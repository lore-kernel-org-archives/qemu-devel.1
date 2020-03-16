Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABD1C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A90205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVc1uREF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A90205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtfV-0000xV-DS
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jDrpJ-00028p-Mz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1jDrpI-00019y-9m
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:38:49 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jDrpI-00019G-4g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:38:48 -0400
Received: by mail-ot1-x342.google.com with SMTP id a6so18213632otb.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6F4Qr3MbWDscYfKuCC/nA4le9wVF6pd3Ywp1mmcZqJ8=;
 b=SVc1uREFg/f9oVVQUCh5yDQuBZphcou8PHbrj/paizH0H73wzIr6Y5eiYc/Pw+Rygd
 yZHAKiniJgpbG0t/rsqiD7FZSEHOoTnRGhNDFns+UCcTe/0M7a6uBMH+pGMapJD/iUGf
 Kf74eiSuoGAYdL70wbiURXYV9iA4X+frjOQ6CGstkHOPIEn8EP/Y1uc7NhVZuSJ/xjbS
 KMMehqlIsIuMpYDMyPTxMDcQe/TR7m1lGf6ywH4sf8CLBzdxxr9AMUq/2eUYb+NHTYoR
 rO6enRkXllvccM20eOsCUr3ZPjjiK1SCNWJ7bur2mNq11lfiWVBCUOipI8cCKxXpbGUC
 VwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6F4Qr3MbWDscYfKuCC/nA4le9wVF6pd3Ywp1mmcZqJ8=;
 b=Zjw9Vo5UIbzEGPG3+WPyD02GDEXrC/pVoVFdH6bfuGAwNdKZ4jYPI24cWJ53WZ+Ia2
 q/gy5KF3x30mnmNFeLrPCuxsKfNYEN1G1ngscqdS1PubEKPlSo9woTKfraik9plFAvyB
 xMUBgO7vykgVcYNQ757BTPnj+r1XI7QBuG8XjYh8ftbuYzjiPbZiqfWuMUum5WY5aFgE
 IpYWq1c2au+LJPaMV+2rurFR/5TBF0iudp6HYXeOWIbd1lshzcqfc9ikFtvjNGsdKr34
 aLp+4Ui9HOCumZhRW2YHc7CwjXbWLfhkRkNtZez5n9asLlmADf4KqYjONAP88GpLjZa9
 C+dA==
X-Gm-Message-State: ANhLgQ1BZ/ANoDlWhCrKvL5bBOFZW4ixdol2A58GsW1wMWTP15a5327G
 C8kI3W3ZNjzl/byRTH+4AjlxSHZyyCyDkWSKl28=
X-Google-Smtp-Source: ADFU+vsjRb8wqD3gE2mPAL6QuUvBQWbCAt0jTJAQNyDz8L8CVcsg/986MwKbS5uZ88LngY6qoGxjZ7s8VKVVrPFFwhE=
X-Received: by 2002:a9d:2074:: with SMTP id
 n107mr13260316ota.306.1584373127432; 
 Mon, 16 Mar 2020 08:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200316123807.GG1528804@redhat.com> <87zhcgjvgk.fsf@linaro.org>
In-Reply-To: <87zhcgjvgk.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 16 Mar 2020 16:38:36 +0100
Message-ID: <CAL1e-=jFtkXFhsu1BmBp4GWdXivV4_tzeRFvkt0hmT1JdufScQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 4:24 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Thu, Mar 12, 2020 at 03:36:11PM -0400, Cleber Rosa wrote:
> >> The idea about a public facing Gating CI for QEMU was lastly
> >> summarized in an RFC[1].  Since then, it was decided that a
> >> simpler version should be attempted first.
> >>
> >> Changes from the RFC patches[2] accompanying the RFC document:
> >>
> >> - Moved gating job definitions to .gitlab-ci-gating.yml
> >> - Added info on "--disable-libssh" build option requirement
> >>   (https://bugs.launchpad.net/qemu/+bug/1838763) to Ubuntu 18.04 jobs
> >> - Added info on "--disable-glusterfs" build option requirement
> >>   (there's no static version of those libs in distro supplied
> >>   packages) to one
> >> - Dropped ubuntu-18.04.3-x86_64-notools job definition, because it
> >>   doesn't fall into the general scope of gating job described by PMM
> >>   (and it did not run any test)
> >> - Added w32 and w64 cross builds based on Fedora 30
> >> - Added a FreeBSD based job that builds all targets and runs `make
> >>   check`
> >> - Added "-j`nproc`" and "-j`sysctl -n hw.ncpu`" options to make as a
> >>   simple but effective way of speeding up the builds and tests by
> >>   using a number of make jobs matching the number of CPUs
> >> - Because the Ansible playbooks reference the content on Dockerfiles,
> >>   some fixes to some Dockerfiles caught in the process were included
> >> - New patch with script to check or wait on a pipeline execution
> >>
> >> [1] - https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00231.h=
tml
> >> [2] - https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00154.h=
tml
> >>
> >> Cleber Rosa (5):
> >>   tests/docker: add CentOS 8 Dockerfile
> >>   tests/docker: make "buildah bud" output similar to "docker build"
> >>   GitLab CI: avoid calling before_scripts on unintended jobs
> >>   GitLab Gating CI: introduce pipeline-status contrib script
> >>   GitLab Gating CI: initial set of jobs, documentation and scripts
> >>
> >>  .gitlab-ci-gating.yml                         | 111 ++++++++++
> >>  .gitlab-ci.yml                                |  32 ++-
> >>  contrib/ci/orgs/qemu/build-environment.yml    | 208 +++++++++++++++++=
+
> >>  contrib/ci/orgs/qemu/gitlab-runner.yml        |  65 ++++++
> >>  contrib/ci/orgs/qemu/inventory                |   2 +
> >>  contrib/ci/orgs/qemu/vars.yml                 |  13 ++
> >>  contrib/ci/scripts/gitlab-pipeline-status     | 148 +++++++++++++
> >
> > FYI, the contrib/ directory is generally a place for arbitrary / adhoc
> > but interesting user contributed files/sources that are not officially
> > supported deliverables of the project.
> >
> > IOW, this is not a good home for the official CI scripts.
> >
> > We already have a .gitlab-ci.d/ directory that looks like it would
> > be good for this.  Or if that's not suitable, then scripts/ci/ is
> > a second choice.
>
> I'd vote for scripts/ci/ or scripts/gitlab/ as the .gitlab-ci.d might be
> a little hidden.
>

I vote for scripts/ci/ or scripts/gitlab/ too. With a little
preference to scripts/ci/.

Aleksandar

> --
> Alex Benn=C3=A9e
>

