Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA460C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D53520663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emIWZhrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D53520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDrgy-0006Yx-5m
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 11:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDpWi-0004Jn-RW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDpWh-0006ej-90
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:11:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDpWg-0006Ot-VS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:11:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id w16so4727739wrv.13
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GTGbDrZWAe1kBhlQPsBLVtU3hWPPyCvRJvwhRo3puPU=;
 b=emIWZhrlfqf02XoBcGQ40O5z+7xNmxQ7ImuQghZ7tpt3MwMHPOjgvOgEQn7i7EHGUM
 vYtnjq5vUns28O97b2udgXl2OC8OmsFuMmc6Gv6si4KA0QIHvqcDDY6Hx2V4IDe6sxry
 kelsscWhB52FhVT+m8cOxlaLHwz2NHKz0Y9CoV0eqQYZDUTUMxcuCwpNM4VYyX3ULQ2m
 Xl9+WkbSXr+bqJicvOFtlYh+2Mj04AxWodWY/AAVY8lCTq24nIEki1flJblpCi1qtFLv
 Mtb3YCi/hi/t/UVvj60tsLeYu4jCRpdkj7iaa5ewJldmcvtV+EcUss6axqDRhUQ5QlN6
 Z+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GTGbDrZWAe1kBhlQPsBLVtU3hWPPyCvRJvwhRo3puPU=;
 b=Y9ZrFKkddHUW5GaeFgxzge6u2+Jg3ysN2GiZ2LTJoIVOPKEO0Ov3v59md74AmjVhA9
 V8EmrAtlp1XvmvBanIiy9FxV3IK3Evn4t1/SPng6EgZpVUKeOYxyc1P92/LYoUBBWmKa
 qZZDIde6+kOJrq/GudrMFqRJZamGlDqKrxBSAHVvjxBpsuwiRBWNGo0dNIUKyTlYMwhH
 rr04NnAwN6vP+S7iDyrsvCsyhqXh+ahORoI628MLuY2KW1Gwy1gS9uvcaHmJP4dl/9js
 NMK9d7+8C6T2H2HS05ys9kBZIypxceqCgyQUEcgVNq1YgzBXnrTf/F+j/GARqvWqYnoX
 6sAw==
X-Gm-Message-State: ANhLgQ2VGln/CjDjEijWBES+22T8K8JZ5Q+Pls4thkMnSLtzFshwUTyM
 G8zzJDJ1iw38C1FgvUmaFn3fmA==
X-Google-Smtp-Source: ADFU+vvHKGgCXT4MoMymF61HizAgOpLiD2C5KB3kv+UCJQQeLZazjpaU2Vavmd2+z7qXlQdRl4Nfzw==
X-Received: by 2002:adf:e581:: with SMTP id l1mr22215033wrm.395.1584364285688; 
 Mon, 16 Mar 2020 06:11:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d18sm30891278wrq.22.2020.03.16.06.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 06:11:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 33E391FF7E;
 Mon, 16 Mar 2020 13:11:23 +0000 (GMT)
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200316123807.GG1528804@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
In-reply-to: <20200316123807.GG1528804@redhat.com>
Date: Mon, 16 Mar 2020 13:11:23 +0000
Message-ID: <87zhcgjvgk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Erik Skultety <eskultet@redhat.com>, Wainer Moschetta <wmoschet@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Mar 12, 2020 at 03:36:11PM -0400, Cleber Rosa wrote:
>> The idea about a public facing Gating CI for QEMU was lastly
>> summarized in an RFC[1].  Since then, it was decided that a
>> simpler version should be attempted first.
>>=20
>> Changes from the RFC patches[2] accompanying the RFC document:
>>=20
>> - Moved gating job definitions to .gitlab-ci-gating.yml
>> - Added info on "--disable-libssh" build option requirement
>>   (https://bugs.launchpad.net/qemu/+bug/1838763) to Ubuntu 18.04 jobs
>> - Added info on "--disable-glusterfs" build option requirement
>>   (there's no static version of those libs in distro supplied
>>   packages) to one
>> - Dropped ubuntu-18.04.3-x86_64-notools job definition, because it
>>   doesn't fall into the general scope of gating job described by PMM
>>   (and it did not run any test)
>> - Added w32 and w64 cross builds based on Fedora 30
>> - Added a FreeBSD based job that builds all targets and runs `make
>>   check`
>> - Added "-j`nproc`" and "-j`sysctl -n hw.ncpu`" options to make as a
>>   simple but effective way of speeding up the builds and tests by
>>   using a number of make jobs matching the number of CPUs
>> - Because the Ansible playbooks reference the content on Dockerfiles,
>>   some fixes to some Dockerfiles caught in the process were included
>> - New patch with script to check or wait on a pipeline execution
>>=20
>> [1] - https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00231.html
>> [2] - https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00154.html
>>=20
>> Cleber Rosa (5):
>>   tests/docker: add CentOS 8 Dockerfile
>>   tests/docker: make "buildah bud" output similar to "docker build"
>>   GitLab CI: avoid calling before_scripts on unintended jobs
>>   GitLab Gating CI: introduce pipeline-status contrib script
>>   GitLab Gating CI: initial set of jobs, documentation and scripts
>>=20
>>  .gitlab-ci-gating.yml                         | 111 ++++++++++
>>  .gitlab-ci.yml                                |  32 ++-
>>  contrib/ci/orgs/qemu/build-environment.yml    | 208 ++++++++++++++++++
>>  contrib/ci/orgs/qemu/gitlab-runner.yml        |  65 ++++++
>>  contrib/ci/orgs/qemu/inventory                |   2 +
>>  contrib/ci/orgs/qemu/vars.yml                 |  13 ++
>>  contrib/ci/scripts/gitlab-pipeline-status     | 148 +++++++++++++
>
> FYI, the contrib/ directory is generally a place for arbitrary / adhoc
> but interesting user contributed files/sources that are not officially
> supported deliverables of the project.
>
> IOW, this is not a good home for the official CI scripts.
>
> We already have a .gitlab-ci.d/ directory that looks like it would
> be good for this.  Or if that's not suitable, then scripts/ci/ is
> a second choice.

I'd vote for scripts/ci/ or scripts/gitlab/ as the .gitlab-ci.d might be
a little hidden.

--=20
Alex Benn=C3=A9e

