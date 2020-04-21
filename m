Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935B1C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C05620663
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSYhSmFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C05620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqFP-00020M-Hr
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 06:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQqEU-0001Ca-RI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQqEU-0001nG-AT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:34:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQqET-0001mS-UH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587465264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7Z0BEhxEHOClIjMvM+8OFwt0QLum+hiy+VNfXoB5aY=;
 b=KSYhSmFSzWimC0AOhyZgpX0jfQ5x9ux/WfVoNRTOcdnh+bwCA3wBqq7sx9RuYcONU8Nvaz
 acwzC+WBOnyZynxuJrDx2rMXGzH1reBLwU7LxS6tQDClEgmaHU9vtphE2ELpCyHK0tNi6D
 HbALAEKF4ay2cBzhteETG/5DKryig60=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-wmWrI4tNPECdVq83s_WT9Q-1; Tue, 21 Apr 2020 06:34:23 -0400
X-MC-Unique: wmWrI4tNPECdVq83s_WT9Q-1
Received: by mail-wm1-f72.google.com with SMTP id o26so1219431wmh.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 03:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O7Z0BEhxEHOClIjMvM+8OFwt0QLum+hiy+VNfXoB5aY=;
 b=FlfLM+UIuUeGakZaYSFKK4U3v45uomWxGZVzYVR+9xv5s3IZeWdN55wkv4WwjTrVSc
 p5Ap/YJfadnmCACvVRifkjPhAcDITGiyabh7DrMUUw1v+oXubRWSRu2yWX1VvYCyDkja
 vNma14GZ2yYZlBWyuzH9+2j77vHcQIApDpObtqV9DdSE++DaqRFl2h4VF9DQL5L76WeT
 gWzfPx3Mhwh1rsclchk4C8FWW+Z5WtoDaCtFMsIglRigz44qawX7wz4VsZYZgyBk2abb
 j9Vq6QnAsIojIMBwB+JlbJwrzILnWjTVW/mWoHNc7B8uyluiQMqs2Kv4pQcU3/gyyibV
 yRbg==
X-Gm-Message-State: AGi0Pubn1r6GBjKBzJuJn7Z5fhYhKAB9BClMqj5UTRPfsA18GI6d8vlx
 hHPU7FWA64+6i1M7SIVF71AHGvs8trUVSys6LbotUbAAfu2IgFTmt7/+h9QpF58js2QsCVuArps
 VahU2I3YxS9yB9E4/0lLNrI0a7OMqq9s=
X-Received: by 2002:adf:f508:: with SMTP id q8mr25151618wro.117.1587465262005; 
 Tue, 21 Apr 2020 03:34:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypJP64+TAfap5Rj8pQy4f/mTNgi14Fih9zEdUlBUJ7Z/lSIcNufVwMm3M0c7LVLZ+1g5zccrgt2fLBjRqgj1K1M=
X-Received: by 2002:adf:f508:: with SMTP id q8mr25151596wro.117.1587465261773; 
 Tue, 21 Apr 2020 03:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+75-UisNwFqedDPfuGt=HFEEnPSO7sNq9JxpUuLPVdYDryuw@mail.gmail.com>
 <CAJ+F1C+YnbgCkYN1+7zpq0XvZYb2LWL6kbQXRSybJew1JnBgQQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+YnbgCkYN1+7zpq0XvZYb2LWL6kbQXRSybJew1JnBgQQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 21 Apr 2020 12:34:10 +0200
Message-ID: <CAP+75-Xi0gWywnGahJ6KRxp28tPkrr0T5a7LzzkVbTDufyDWpg@mail.gmail.com>
Subject: Re: SLiRP: use-afte-free in ip_reass() [CVE-2020-1983]
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 12:22 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Apr 21, 2020 at 11:18 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > Hi Samuel and Marc-Andr=C3=A9,
> >
> > Peter is going to tag 5.0-rc4 (final before release) today.
> > Do you have plans to send a last minute pull-request to fix CVE-2020-19=
83?
> >
> > https://gitlab.freedesktop.org/slirp/libslirp/-/commit/9ac0371bb
>
> libslirp is not following qemu release schedule. The master branch has
> a few changes that shouldn't be added to the release. We could create
> version/stable/qemu branches, but then between each version, we would
> end up with the submodule jumping between branches (with a non-linear
> history). Is that the only option?

I'm not sure this is the only option, but thinking about the
qemu-stable release process, this sounds like a good option.
Stable tags are sterile leaves and don't get further development.


