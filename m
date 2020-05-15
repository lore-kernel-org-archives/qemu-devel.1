Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4113C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA50206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJZsWGgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA50206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWYh-00035a-Sk
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWXo-0001rF-6j
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:22:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56099
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWXm-0006Cc-CR
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589534533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSv0SQjXJsdc5G9Tit8B+qnASXdTyC6JHtY3nm3DBZ8=;
 b=AJZsWGgctGcsGHkDFI0/xpa1lIYnBGzzmLuxjdyXe4PBVDZnga4qAwDK+0OlA/9Eb2mUQ1
 aAOZopi77UaTVNSleFVpU56BW7N950WhhAYMUfyaRH/L9VIMwOQbwxIvOqoLK8FFe3/DSI
 QkQiQwRClH+evfeUHTQd4Iep7U7NONI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-vxpZOxmbPp6dfEte1vNKEQ-1; Fri, 15 May 2020 05:22:12 -0400
X-MC-Unique: vxpZOxmbPp6dfEte1vNKEQ-1
Received: by mail-wr1-f71.google.com with SMTP id z16so869398wrq.21
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TSv0SQjXJsdc5G9Tit8B+qnASXdTyC6JHtY3nm3DBZ8=;
 b=EdlCOPteHWMH+mRxX6JMmVcr5LdRX6Pa3LMEfPon6axIprTx6sDfWl3q8mX5wUHDPz
 AmjEWh2c9sf9WU8QCgvp2fAqRC5Cj82kqdSpKwdMREsR0hsRW4UM4F4+x0zO0DTWY6gS
 Zo7X8abwgdyUwgmCga0/x8HCbs8nOhekNVX1WN5/CDuGi1m9ISS0RhtmojQv4Z3AUOEL
 CTx/CJRRe6wbBX7thI1gua/pkTFFz+dp2A9yQY+WEViH59Dt6LFmgX6tknz1Uhtl1nEI
 COuGLAC6BCrB/TzY7lT6MBDY9/+sHlRDsn3K36xBnZCQhwFb/Tn+GJ8TEEJE5FQORUwm
 /UnQ==
X-Gm-Message-State: AOAM53109rjXSF7p4TNiaaLtbuVfFHFxacNHjCpmid4RAFxyDxKma+Ro
 sWQYAMxZT/aq1yDI+V68cTtWKY1m8uY/BTcZ0z6DpmthB7MaoIPFh2ZY7S1ZrUc4wWHP0NvFk8W
 ScyRZAQ9zC6A2WC9SbzIwMjZPPUuzb1c=
X-Received: by 2002:adf:f40a:: with SMTP id g10mr3412669wro.117.1589534530764; 
 Fri, 15 May 2020 02:22:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPL/6XM3VsMXSnCsFjb9AqIj6l4ETKOSxxn7VkIzIaG23XCB//niP5tA30C+e1W3ldsRnQpMUdvqnxq+7WbwA=
X-Received: by 2002:adf:f40a:: with SMTP id g10mr3412649wro.117.1589534530500; 
 Fri, 15 May 2020 02:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200515083124.5536-1-philmd@redhat.com>
 <20200515083124.5536-2-philmd@redhat.com>
 <3fe3dc1e-8076-2a86-8c6e-a18b7f2f9952@suse.de>
In-Reply-To: <3fe3dc1e-8076-2a86-8c6e-a18b7f2f9952@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 15 May 2020 11:21:59 +0200
Message-ID: <CAP+75-WVBD_sH56kwj6nkAuW7gjBy__teQqucVL3fnFQZ2m-cQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests/docker: Remove flex/bison packages
To: Claudio Fontana <cfontana@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 11:02 AM Claudio Fontana <cfontana@suse.de> wrote:
>
> On 5/15/20 10:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > QEMU does use flex/bison packages.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Hi Philippe, "does" or "does not"?

Err... does NOT :/

>
> Ciao,
>
> Claudio
>
> > ---
> >  tests/docker/dockerfiles/centos7.docker             | 2 --
> >  tests/docker/dockerfiles/centos8.docker             | 2 --
> >  tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 --
> >  tests/docker/dockerfiles/debian10.docker            | 2 --
> >  tests/docker/dockerfiles/debian9.docker             | 2 --
> >  tests/docker/dockerfiles/fedora.docker              | 2 --
> >  tests/docker/dockerfiles/ubuntu.docker              | 2 +-
> >  tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
> >  8 files changed, 2 insertions(+), 14 deletions(-)
> >
> > diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/doc=
kerfiles/centos7.docker
> > index 9a2a2e515d..e197acdc3c 100644
> > --- a/tests/docker/dockerfiles/centos7.docker
> > +++ b/tests/docker/dockerfiles/centos7.docker
> > @@ -5,13 +5,11 @@ RUN yum -y update
> >
> >  # Please keep this list sorted alphabetically
> >  ENV PACKAGES \
> > -    bison \
> >      bzip2 \
> >      bzip2-devel \
> >      ccache \
> >      csnappy-devel \
> >      dbus-daemon \
> > -    flex \
> >      gcc-c++ \
> >      gcc \
> >      gettext \
> > diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/doc=
kerfiles/centos8.docker
> > index bfa0d33c9c..9852c5b9ee 100644
> > --- a/tests/docker/dockerfiles/centos8.docker
> > +++ b/tests/docker/dockerfiles/centos8.docker
> > @@ -3,11 +3,9 @@ FROM centos:8.1.1911
> >  RUN dnf -y update
> >  ENV PACKAGES \
> >      SDL-devel \
> > -    bison \
> >      bzip2 \
> >      bzip2-devel \
> >      dbus-daemon \
> > -    flex \
> >      gcc \
> >      gcc-c++ \
> >      gettext \
> > diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/test=
s/docker/dockerfiles/debian-xtensa-cross.docker
> > index e6f93f65ee..beb73f46ba 100644
> > --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
> > +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> > @@ -11,11 +11,9 @@ RUN apt-get update && \
> >      DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
> >      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >      apt-get install -y --no-install-recommends \
> > -        bison \
> >          build-essential \
> >          ca-certificates \
> >          curl \
> > -        flex \
> >          gettext \
> >          git \
> >          python3-minimal
> > diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/do=
ckerfiles/debian10.docker
> > index 0769700a41..bcdff04ddf 100644
> > --- a/tests/docker/dockerfiles/debian10.docker
> > +++ b/tests/docker/dockerfiles/debian10.docker
> > @@ -18,12 +18,10 @@ RUN apt update && \
> >      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >      apt install -y --no-install-recommends \
> >          bc \
> > -        bison \
> >          build-essential \
> >          ca-certificates \
> >          clang \
> >          dbus \
> > -        flex \
> >          gdb-multiarch \
> >          gettext \
> >          git \
> > diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/doc=
kerfiles/debian9.docker
> > index 08cc970feb..0f0ebe530a 100644
> > --- a/tests/docker/dockerfiles/debian9.docker
> > +++ b/tests/docker/dockerfiles/debian9.docker
> > @@ -18,11 +18,9 @@ RUN apt update && \
> >      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >      apt install -y --no-install-recommends \
> >          bc \
> > -        bison \
> >          build-essential \
> >          ca-certificates \
> >          clang \
> > -        flex \
> >          gdb-multiarch \
> >          gettext \
> >          git \
> > diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dock=
erfiles/fedora.docker
> > index 179575ecaa..92b6e11c8a 100644
> > --- a/tests/docker/dockerfiles/fedora.docker
> > +++ b/tests/docker/dockerfiles/fedora.docker
> > @@ -3,7 +3,6 @@ FROM fedora:30
> >  # Please keep this list sorted alphabetically
> >  ENV PACKAGES \
> >      bc \
> > -    bison \
> >      brlapi-devel \
> >      bzip2 \
> >      bzip2-devel \
> > @@ -13,7 +12,6 @@ ENV PACKAGES \
> >      dbus-daemon \
> >      device-mapper-multipath-devel \
> >      findutils \
> > -    flex \
> >      gcc \
> >      gcc-c++ \
> >      gettext \
> > diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dock=
erfiles/ubuntu.docker
> > index eeb3b22bf2..90ea6311c6 100644
> > --- a/tests/docker/dockerfiles/ubuntu.docker
> > +++ b/tests/docker/dockerfiles/ubuntu.docker
> > @@ -10,7 +10,7 @@
> >  #
> >
> >  FROM ubuntu:19.04
> > -ENV PACKAGES flex bison \
> > +ENV PACKAGES \
> >      ccache \
> >      clang \
> >      dbus \
> > diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/=
dockerfiles/ubuntu1804.docker
> > index f66b06f4cf..a10ea2850b 100644
> > --- a/tests/docker/dockerfiles/ubuntu1804.docker
> > +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> > @@ -1,5 +1,5 @@
> >  FROM ubuntu:18.04
> > -ENV PACKAGES flex bison \
> > +ENV PACKAGES \
> >      ccache \
> >      clang \
> >      gcc \
> >
>


