Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DCEC41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B370620870
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJaPWrQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B370620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgh2-0006p9-Ts
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGggM-0006N1-9O
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGggL-0007U0-55
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:21:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGggK-0007R5-Qd
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:21:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id u10so320569wro.7
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=s36Y1G2Fc7UM+gceEjevKTUzRYs2BmzN7UUjfuXWGmY=;
 b=CJaPWrQclTiJ1+z2CtsFX2vtLMmvEmG4+D1Q45LTrmADt3YhFIR/YSpHrbQmdwoGAi
 PI1BPeUUAlvKaFXD1K5a0QDb6fUc/dyTseRtKgTmahDXnyKeMoCuXGAoLOBFYPaPumQ1
 DFPVKFhIdYRAjMciuhKe28Nfa0TVRhRbRJrGPEhHaAXtEhSv4t3694UYh2EfN23nwwk9
 2OMe4fiHf9UsZwvan0gkOf08av51roq2+87OA8pMnyWN/+SYB/uBqJg2LXe+AFgUlxML
 G4jOGN0tbGBx3+Kr2jd6SxDgtW+EiQQqEiX16etZNJjRXu7TOCM/Z6GOLX0LhteG/42k
 gVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=s36Y1G2Fc7UM+gceEjevKTUzRYs2BmzN7UUjfuXWGmY=;
 b=H5qm9aL2K7WlykSuPZBaQdjhqDnOOSu50+OPy+9su2xaCHqrcnlP90AjN2JfxnNIzI
 hFbwB9ab5osTXxL0j9gWcxgD6rWKwE6r9GHKQ9zxPL7iydf6VCj6GgYcnoNndsdZKf2o
 qLpIVCNKoP1zex/abd8Cqgy7X4BrnRRjVNFmnlEsfM0LVR1JGw+jHABoYFhydZu889kx
 nyy1M9uttV+V0vNNG4gMpvvfQT0D8zGnDfkP/vu3qTr7QSn1U32upA2BNnN7YJoDRGc/
 6fd+BNiXwBIYyzXWj/XpcRwaikFOvOw8IscjkAi47OURBB4QkHtNMpI8m6LRf9RkSVeS
 MPZA==
X-Gm-Message-State: ANhLgQ3VYWsTlhm2ZBOLq4AMk6YGUHoEkya8IbQumBmsvtRJMnYJQSsQ
 Tre2gEZ19ULeOF/pQfrmRNiaiQ==
X-Google-Smtp-Source: ADFU+vusSwD7u16QMc9CqPe72S52HsGm8DAra/O2qnWChdDPwOH7oIixXo08MwsAmX+xdc6mefIfQA==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr36331192wrn.275.1585045270506; 
 Tue, 24 Mar 2020 03:21:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f12sm3824410wmh.4.2020.03.24.03.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 03:21:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8EA111FF7E;
 Tue, 24 Mar 2020 10:21:08 +0000 (GMT)
References: <20200323184015.11565-1-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v3] tests/migration: Reduce autoconverge initial
 bandwidth
In-reply-to: <20200323184015.11565-1-philmd@redhat.com>
Date: Tue, 24 Mar 2020 10:21:08 +0000
Message-ID: <87zhc69hpn.fsf@linaro.org>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> When using max-bandwidth=3D~100Mb/s, this test fails on Travis-CI
> s390x when configured with --disable-tcg:
>
>   $ make check-qtest
>     TEST    check-qtest-s390x: tests/qtest/boot-serial-test
>   qemu-system-s390x: -accel tcg: invalid accelerator tcg
>   qemu-system-s390x: falling back to KVM
>     TEST    check-qtest-s390x: tests/qtest/pxe-test
>     TEST    check-qtest-s390x: tests/qtest/test-netfilter
>     TEST    check-qtest-s390x: tests/qtest/test-filter-mirror
>     TEST    check-qtest-s390x: tests/qtest/test-filter-redirector
>     TEST    check-qtest-s390x: tests/qtest/drive_del-test
>     TEST    check-qtest-s390x: tests/qtest/device-plug-test
>     TEST    check-qtest-s390x: tests/qtest/virtio-ccw-test
>     TEST    check-qtest-s390x: tests/qtest/cpu-plug-test
>     TEST    check-qtest-s390x: tests/qtest/migration-test
>   **
>   ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'go=
t_stop' should be FALSE
>   ERROR - Bail out! ERROR:tests/qtest/migration-test.c:1229:test_migrate_=
auto_converge: 'got_stop' should be FALSE
>   make: *** [tests/Makefile.include:633: check-qtest-s390x] Error 1
>
> Per David Gilbert, "it could just be the writing is slow on s390
> and the migration thread fast; in which case the autocomplete
> wouldn't be needed. Perhaps we just need to reduce the bandwidth
> limit."
>
> Tuning the threshold by reducing the initial bandwidth makes the
> autoconverge test pass.
>
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v3: really reduce =3D)
> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 3d6cc83b88..2568c9529c 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
>       * without throttling.
>       */
>      migrate_set_parameter_int(from, "downtime-limit", 1);
> -    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100=
Mb/s */
> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s=
 */
>=20=20
>      /* To check remaining size after precopy */
>      migrate_set_capability(from, "pause-before-switchover", true);

The vm-build tests work again.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e

