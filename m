Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32AEC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF4420715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z74dXr2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF4420715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYBvv-00076c-Co
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iYBoi-0001V1-KG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iYBog-0004Gi-Lw
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:29:56 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iYBog-0003ii-1R
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:29:54 -0500
Received: by mail-wr1-x442.google.com with SMTP id i12so9337123wro.5
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2V87WxeQuuNkBifmy5n9gSJnz5If5un/MPOV0lREF3I=;
 b=Z74dXr2SuknFWYJABEua9TX1trXpIpESrKkUs+sdkhxjgBR6NLo9BaOpUUf+O9Rs11
 2ra0C85bX0QG0CZwSvYD+yW7wAzO3djLQXBloe4hZzrvlDKC1T+XNGmnGsnra4oM7y4H
 XAcuqxj1fMkVY7KW0gDZ26pT4POwORb/w7EJeKoM5awMmls1Yn/9GvG1zbA7L7nQx2av
 lSHGgpOozyFof2XFqc7ax9UpcgQN/5ttGe4XH9DAAMEh9CLN0K4dgX5NBkkFTUGL4teN
 fwSr6rUxWwfvjjzzUUa18KfpM23VSQw4FzTetVrtUOSuwBeVoVVNM2MO/BAzFadMWeSW
 KHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2V87WxeQuuNkBifmy5n9gSJnz5If5un/MPOV0lREF3I=;
 b=A/bS6OHt4fDUBnz2s26dZh0GrjSeuJgAPpl49evKGj3NCHu7ZbQy0yXCIYOPhjn/GX
 8vJ/Ql2mXakZ1xZdToiHElhe4EKIjmOEtUim9V81J1cO9dEhuMdX7yW1kUEwKmollsTa
 E1AbDA5Il/ppOdYbWwJy+aylMRNSnMmi7n+Rx4VfF59EjabS/8FN6IAwVxvTrHJ2Fptj
 3RTxZW43oTKeo+Osv8/OlzmGy+LueXzYKfK3lxpNN41L5TLQDD5iDr3db1DUW+UdPvlg
 ci1pMuuBdf5Ciu/WqPBbSgZCXOKxeAapSdQcTSx40Rusj3ztEeZUFyaIYsmRRPKP7qYz
 GNlA==
X-Gm-Message-State: APjAAAUzCgvMc1c7AM57z5DM/y9EIb7EJg3YyU4au0vmuMlPC2rgFybp
 hZFSPT/GK1cW5MtKHRlV8idZwA==
X-Google-Smtp-Source: APXvYqwKmNPsG39UrjHknmH++yiL5aHh/ekRNCEH2gX4UchZUtepiDXLkDCRjSEQmB8XHDiECT4dNQ==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr18683214wrr.207.1574440163458; 
 Fri, 22 Nov 2019 08:29:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o189sm4247655wmo.23.2019.11.22.08.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 08:29:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EBB181FF87;
 Fri, 22 Nov 2019 16:29:20 +0000 (GMT)
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-5-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/6] tests/test-util-filemonitor: Skip test on non-x86
 Travis containers
In-reply-to: <20191119170822.45649-5-thuth@redhat.com>
Date: Fri, 22 Nov 2019 16:29:20 +0000
Message-ID: <875zjb98nz.fsf@linaro.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> test-util-filemonitor fails in restricted non-x86 Travis containers
> since they apparently blacklisted some required system calls there.
> Let's simply skip the test if we detect such an environment.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/test-util-filemonitor.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.c
> index 301cd2db61..45009c69f4 100644
> --- a/tests/test-util-filemonitor.c
> +++ b/tests/test-util-filemonitor.c
> @@ -406,10 +406,21 @@ test_file_monitor_events(void)
>      char *pathdst =3D NULL;
>      QFileMonitorTestData data;
>      GHashTable *ids =3D g_hash_table_new(g_int64_hash, g_int64_equal);
> +    char *travis_arch;
>=20=20
>      qemu_mutex_init(&data.lock);
>      data.records =3D NULL;
>=20=20
> +    /*
> +     * This test does not work on Travis LXD containers since some
> +     * syscalls are blocked in that environment.
> +     */
> +    travis_arch =3D getenv("TRAVIS_ARCH");
> +    if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
> +        g_test_skip("Test does not work on non-x86 Travis containers.");
> +        return;
> +    }
> +
>      /*
>       * The file monitor needs the main loop running in
>       * order to receive events from inotify. We must


--=20
Alex Benn=C3=A9e

