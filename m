Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B20C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB45208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hY2tWa+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB45208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLgZ-0000qu-Ja
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iBLdx-00072o-8M
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iBLdu-0007pW-Ub
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:20:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iBLdu-0007pC-L3
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:20:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id r5so7310152wrm.12
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HhkQCBzfmEfLy/cHwPg1NqRpsRScXyMR058tobAzHbI=;
 b=hY2tWa+cNT4qbEAHeycJ5ESfVelPWJRUWDFP1zgcNnOuEQkqxuJMnt/Onu4qV/n7xQ
 osgcn/KmptBfIvpaUc2stxM2XMtnGpByRrXzgm0OoUY/A6CZwZwPbZYn8DnQgpIA12rP
 PMW3eJZ33yMjx+aI/iwFmTcMsZBOgtKV3BG7jLaYCoJOt7EalGfOXrvtPbKT3Zd/zNvT
 ZIXriR0mMWYJcy6KvEwdQ3WbVVvzV16+PxW937Lpnv42gxnkkPwpqMdIi1Id7RzVw14N
 YgxNT//5g98hGFfJemDoDL8IHNZZmhh6lw1cJR2RG/LWJYxCQ5GnXQY4Wd9nDwYOirFR
 f3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HhkQCBzfmEfLy/cHwPg1NqRpsRScXyMR058tobAzHbI=;
 b=Oi6DGCoVshwUniRAOv8DCzbL5VBSE7ud6lbq8rBav8eYw9YAyIrJBi+IURLv/h/DmF
 xynzBK4vHzxCaGnFP8sQUAaa3uK9cFPwmMGPQls9zBls2tWymBQFAOj5vAh9S6RjS6BQ
 c7LNJyE0l6w6xrTIbGYnyqHXtbRt00LLOMOOvrhw/pzbXWEjfJJ4h6HzW7tWYG2/7oXm
 w1afacGFmzRVJFopcOJ2Qi3IzvqSPB2JaI0noK0E1/+/8pfvPq6TRhOG6gtLWb+J8c85
 f+BNdfw+xnThfDwmTp1BTeC0G8J9+8REoZmFXRH4fMsCt4asic/QClFDgoiZ3oLab3Fw
 BPxg==
X-Gm-Message-State: APjAAAWco4Cbs9Zlwip8TNOR3L75fiwnLPAmjbh06lEY4J9BzDZI1HHA
 iOgXGAH4hN00EUzqxhv6OgmT1g==
X-Google-Smtp-Source: APXvYqwxwR4mjF/D34AR0rJ+4n+tDB/9YiqdgZW1xSvvgRS7rYjDyQXfZvTxsjDyKOxMWl1gBZYZ6w==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr12625699wrj.277.1568996420827; 
 Fri, 20 Sep 2019 09:20:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s13sm2265276wmc.28.2019.09.20.09.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 09:20:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 59DCE1FF87;
 Fri, 20 Sep 2019 17:20:19 +0100 (BST)
References: <20190920001413.22567-1-jsnow@redhat.com>
 <20190920001413.22567-4-jsnow@redhat.com>
 <731ae95b-7c70-43ca-bea9-28b00de232d5@redhat.com>
 <c7b12028-0294-0d9c-3e94-60b2ba7d3528@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 3/3] docker: remove unused debian-sid and debian-ports
In-reply-to: <c7b12028-0294-0d9c-3e94-60b2ba7d3528@redhat.com>
Date: Fri, 20 Sep 2019 17:20:19 +0100
Message-ID: <87d0fvym64.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> On 9/20/19 4:49 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 9/20/19 2:14 AM, John Snow wrote:
>>> These are listed as "partial" images, but have no user.
>>> Remove them.
>>
>> Well, I have WiP users from them. I could restore this content when they
>> are ready... Ports is the base of deprecated Debian archs. On the other
>> side Sid is the base for edge development I use from time to time to
>> test latest gcc/binutils.
>> I'll try to find time to raise WiP branches to PoC.
>>
>
> I think that's the right thing to do. Right now, the docker tests
> directory has a lot of stale entries and unusable tests. That might be
> fine for the people working on it, but it makes it hard to understand
> and use for those of us who only occasionally traipse into the directory.
>
> I'm removing all references to python2 -- but if there's no way for me
> to test debian-sid and debian-ports, I can't test changes I need to make
> to these "partial images", so they should be removed until they are
> consumable.
>
> While I am sympathetic to the idea of having a library of partial images
> to use for future tests, they're prone to rot if there's no way to
> exercise them in-tree.

Don't forget some "partial" images are only used for building TCG tests
- we want to keep them. But as git is forever I can drop the sid/ports
stuff for now until Phillipe has something to use them again.

>
> You can always re-add them when you have a user.
>
> --js
>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  tests/docker/Makefile.include                |  4 +--
>>>  tests/docker/dockerfiles/debian-ports.docker | 36 --------------------
>>>  tests/docker/dockerfiles/debian-sid.docker   | 35 -------------------
>>>  3 files changed, 2 insertions(+), 73 deletions(-)
>>>  delete mode 100644 tests/docker/dockerfiles/debian-ports.docker
>>>  delete mode 100644 tests/docker/dockerfiles/debian-sid.docker
>>>
>>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
>>> index 7af476d957..c282b5c520 100644
>>> --- a/tests/docker/Makefile.include
>>> +++ b/tests/docker/Makefile.include
>>> @@ -5,8 +5,8 @@
>>>  DOCKER_SUFFIX :=3D .docker
>>>  DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>>>  # we don't run tests on intermediate images (used as base by another i=
mage)
>>> -DOCKER_PARTIAL_IMAGES :=3D debian8 debian9 debian10 debian-sid
>>> -DEBIAN_PARTIAL_IMAGES +=3D debian-9-mxe debian-ports debian-bootstrap
>>> +DOCKER_PARTIAL_IMAGES :=3D debian8 debian9 debian10
>>> +DEBIAN_PARTIAL_IMAGES +=3D debian-9-mxe debian-bootstrap
>>>  DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILE=
S_DIR)/*.docker))))
>>>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>>>  # Use a global constant ccache directory to speed up repetitive builds
>>> diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docke=
r/dockerfiles/debian-ports.docker
>>> deleted file mode 100644
>>> index 61bc3f2993..0000000000
>>> --- a/tests/docker/dockerfiles/debian-ports.docker
>>> +++ /dev/null
>>> @@ -1,36 +0,0 @@
>>> -#
>>> -# Docker multiarch cross-compiler target
>>> -#
>>> -# This docker target is builds on Debian Ports cross compiler targets
>>> -# to build distro with a selection of cross compilers for building tes=
t binaries.
>>> -#
>>> -# On its own you can't build much but the docker-foo-cross targets
>>> -# build on top of the base debian image.
>>> -#
>>> -FROM debian:unstable
>>> -
>>> -MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> -
>>> -RUN echo "deb [arch=3Damd64] http://deb.debian.org/debian unstable mai=
n" > /etc/apt/sources.list
>>> -
>>> -# Duplicate deb line as deb-src
>>> -RUN cat /etc/apt/sources.list | sed -ne "s/^deb\ \(\[.*\]\ \)\?\(.*\)/=
deb-src \2/p" >> /etc/apt/sources.list
>>> -
>>> -# Setup some basic tools we need
>>> -RUN apt-get update && \
>>> -    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
>>> -    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>>> -    apt-get install -y --no-install-recommends \
>>> -        bison \
>>> -        build-essential \
>>> -        ca-certificates \
>>> -        clang \
>>> -        debian-ports-archive-keyring \
>>> -        flex \
>>> -        gettext \
>>> -        git \
>>> -        pkg-config \
>>> -        psmisc \
>>> -        python \
>>> -        texinfo \
>>> -        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cu=
t -d\  -f2)
>>> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/=
dockerfiles/debian-sid.docker
>>> deleted file mode 100644
>>> index 2a1bcc33b2..0000000000
>>> --- a/tests/docker/dockerfiles/debian-sid.docker
>>> +++ /dev/null
>>> @@ -1,35 +0,0 @@
>>> -#
>>> -# Debian Sid Base
>>> -#
>>> -# Currently we can build all our guests with cross-compilers in the
>>> -# latest Debian release (Buster). However new compilers will first
>>> -# arrive in Sid. However Sid is a rolling distro which may be broken
>>> -# at any particular time. To try and mitigate this we use Debian's
>>> -# snapshot archive which provides a "stable" view of what state Sid
>>> -# was in.
>>> -#
>>> -
>>> -# This must be earlier than the snapshot date we are aiming for
>>> -FROM debian:sid-20190812-slim
>>> -
>>> - # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
>>> -ENV DEBIAN_SNAPSHOT_DATE "20190820"
>>> -RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [=
check-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPS=
HOT_DATE} \2%" /etc/apt/sources.list
>>> -
>>> -# Duplicate deb line as deb-src
>>> -RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/s=
ources.list
>>> -
>>> -# Install common build utilities
>>> -RUN apt update && \
>>> -    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
>>> -    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>>> -    apt install -y --no-install-recommends \
>>> -        bison \
>>> -        build-essential \
>>> -        ca-certificates \
>>> -        flex \
>>> -        git \
>>> -        pkg-config \
>>> -        psmisc \
>>> -        python \
>>> -        texinfo || { echo "Failed to build - see debian-sid.docker not=
es"; exit 1; }
>>>


--
Alex Benn=C3=A9e

