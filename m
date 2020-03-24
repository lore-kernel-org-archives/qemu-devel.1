Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC26EC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9971120870
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZFTuAGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9971120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgfT-0005bO-Qt
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGgeY-00055N-Gb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGgeR-0004cX-5K
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:19:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGgeP-0004YR-Qq
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:19:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id s1so20681036wrv.5
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jNTB9UiCOvEmZjdiIH1rwukYdAv+6PN2ItTLYIoQp10=;
 b=BZFTuAGhrPosqNHtG2ThFLUKrJxn1iphk2I9uBufgX9715CyWvkWclFXFwjKFUBpUC
 XXR2vFMmN+rMpUCeI1rZynm1HlCWLwt1HrrvS1/X2GTjJme8ogdtZ1HffjIMVnKB+LmP
 ngOh51KctMLiewVGCknh4sVmHGmgtrGSN75IIn3Ag9oePsg4iTWZOllCbcE94vJWKgEp
 HJhE/Z5BBdc6YfkDK2Wx9COpjbbHI24U9UvkcELc1vONa0hwTZFPcz50/E3n6ivfgKc+
 5gU3GtcKtwPWRul4K0gurOzbPj1Rs68SLCzByOtdDL6/aLBycS5RVoOT4HXe+FzJCGxT
 FxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jNTB9UiCOvEmZjdiIH1rwukYdAv+6PN2ItTLYIoQp10=;
 b=ErpaLKyTZFwuWi17qD9cEax0x02duOMNQm5QFdab5GqIA9rwHrowu1b4lBxIxgUqCo
 NfgdsstQqlpyIHjjzW3pfKvcapEPo3JXhgqEyQEMWz56pwvg+ZetOkK0PBoyjW89/3BA
 o1NU0ZpWTEMZH4ZvWWM38D7Karz6eTA9k6HUa3gSi//PhQbVXKLParTyzSOthQMJfduY
 gZTVSPX/DsVVVtOJhgLcg6Rc+qxSp9hiCuZ/7cYXjr3VZ58XNp5ZI8fdOV63HSyhsAU1
 6W32ztf06YuCd0Jc+ntK2g68nGTcfMfPioSd72qArBUpV114e0Hg2Vx+SNQ4Mg/DkoSS
 /jhw==
X-Gm-Message-State: ANhLgQ2lTO5cuP3TdqI3bDtWkSt4/w6V42t4GTAr0IvXNM6uyysef4RT
 B8H49QnX/GKHeXBwscnCkLPtIQ==
X-Google-Smtp-Source: ADFU+vv/B74lHFDdcqb1FElgKEv/8dK7Vt4iGG0rHUCyaQVT8JMJDur/53v+0aFjl3b5b50jwyj3WA==
X-Received: by 2002:adf:f310:: with SMTP id i16mr35512055wro.100.1585045152301; 
 Tue, 24 Mar 2020 03:19:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j39sm29471981wre.11.2020.03.24.03.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 03:19:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C1211FF7E;
 Tue, 24 Mar 2020 10:19:10 +0000 (GMT)
References: <20200130163232.10446-1-philmd@redhat.com>
 <20200130163232.10446-8-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 07/12] tests/acceptance: Remove shebang header
In-reply-to: <20200130163232.10446-8-philmd@redhat.com>
Date: Tue, 24 Mar 2020 10:19:10 +0000
Message-ID: <87369yawdd.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?utf-8?Q?Dan?= =?utf-8?Q?iel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Patch created mechanically by running:
>
>   $ chmod 644 $(git grep -lF '#!/usr/bin/env python' \
>       | xargs grep -L 'if __name__.*__main__')
>   $ sed -i "/^#\!\/usr\/bin\/\(env\ \)\?python.\?$/d" \
>       $(git grep -lF '#!/usr/bin/env python' \
>       | xargs grep -L 'if __name__.*__main__')

OK, but my question is why? Aren't shebangs considered good practice for
finding the executable for a script?

If the acceptance scripts are special in this regard we should say why
in the commit message.

>
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/virtio_seg_max_adjust.py  | 1 -
>  tests/acceptance/x86_cpu_model_versions.py | 1 -
>  2 files changed, 2 deletions(-)
>  mode change 100755 =3D> 100644 tests/acceptance/virtio_seg_max_adjust.py
>
> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance=
/virtio_seg_max_adjust.py
> old mode 100755
> new mode 100644
> index 5458573138..8d4f24da49
> --- a/tests/acceptance/virtio_seg_max_adjust.py
> +++ b/tests/acceptance/virtio_seg_max_adjust.py
> @@ -1,4 +1,3 @@
> -#!/usr/bin/env python
>  #
>  # Test virtio-scsi and virtio-blk queue settings for all machine types
>  #
> diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptanc=
e/x86_cpu_model_versions.py
> index 90558d9a71..01ff614ec2 100644
> --- a/tests/acceptance/x86_cpu_model_versions.py
> +++ b/tests/acceptance/x86_cpu_model_versions.py
> @@ -1,4 +1,3 @@
> -#!/usr/bin/env python
>  #
>  # Basic validation of x86 versioned CPU models and CPU model aliases
>  #


--=20
Alex Benn=C3=A9e

