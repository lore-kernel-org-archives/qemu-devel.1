Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1134C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FBF2068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8UprIri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FBF2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY8Rk-0003x3-Op
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iY8R5-0003RP-Oc
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iY8R2-0002yF-V1
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:53:19 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iY8R2-0002xv-7J
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:53:16 -0500
Received: by mail-wr1-x443.google.com with SMTP id b18so8471383wrj.8
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 04:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MEyAfmDQ0p/o6CWl/ujUL4w/o4/SOYDWkEzxUTLBfkA=;
 b=t8UprIriQH7HqfouImV76sax/N6I9fOkmF78OLXTAKkYazMZD+SfkYSOyWSelHk9Sk
 Ago0NFQdm9isBQnkyjKuuhy4e+/yV87l7MWnA5fNcLwwDMgG8jKUaEpYpU+orW2VlXZZ
 PMJmnZaBSng1FxX79jVM8vlrViQkDhboE2wGdqC8HXVpx++TD8T8dtxhLrzcmOUG9qDm
 d1nvJoitUPwoAf2I197iWwV+3vebM/HKgox+yy6T63bO07HQ/dyafnNn4IUI3ZQxS8PV
 3/uK+TOjAWZ0m2TUMr9u8rXATiYJZX0BKpM2D95ucnvcj+4IIDP86EWNI90rHPhs9qpr
 QnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MEyAfmDQ0p/o6CWl/ujUL4w/o4/SOYDWkEzxUTLBfkA=;
 b=YqBj0cF2fIfhx36TS70m0Ze6BiuqAW+baUezRG3OPxa7rZoTjs+mxlLiMxq6cbI9Al
 CGM8BH5Fu2ZXiaixbMaAlPQ+MMYe7p6/fc7gaq5PeRcJDkRH2Z9RpDQV347qxT6EOSkq
 fWP/lw+VzQULo6Ad8UOwwJMe8/l7cBbUNBEzFhRH+8jhcgKbnEgt1adwQJYSCM2sXZmX
 dWwSLeiZZ2VukRZG5qo+DzA1pohssQWApvgZ5qD9Sg9fpcjRmt7Fk9m5zlZDwOtCQuic
 QPr7QlsIZICGgDKZZX1H85xddJV+p0kIseDdXBnNoCOBJzHHTYto423H70+5yq/sIzfm
 COrA==
X-Gm-Message-State: APjAAAVN1d9e8elEI+ocE6ME2DQu4V24AXvEDJrTvnlulWh/4b/mx1+O
 ieCsh5OpWe4bNZe4GxJ3JURmdQ==
X-Google-Smtp-Source: APXvYqxeuhd0hgY9XLWzxTwbo8QQDCSPUeHnCyrsfkFZBOPKNxwo1DdE1P5Ge8qodLNIarAzC1KwAQ==
X-Received: by 2002:adf:ef0e:: with SMTP id e14mr17938336wro.204.1574427194559; 
 Fri, 22 Nov 2019 04:53:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x2sm1735356wmc.3.2019.11.22.04.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 04:53:13 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC83D1FF87;
 Fri, 22 Nov 2019 12:53:11 +0000 (GMT)
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-2-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/6] iotests: Skip test 060 if it is not possible to
 create large files
In-reply-to: <20191119170822.45649-2-thuth@redhat.com>
Date: Fri, 22 Nov 2019 12:53:11 +0000
Message-ID: <87k17s843s.fsf@linaro.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Test 060 fails in the arm64, s390x and ppc64le LXD containers, which
> apparently do not allow large files to be created. The repair process
> in test 060 creates a file of 64 GiB, so test first whether such large
> files are possible and skip the test if that's not the case.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qemu-iotests/060 | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index b91d8321bb..e7ee865c55 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -49,6 +49,12 @@ _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
>=20=20
> +# The repair process will create a large file - so check for availabilit=
y first
> +if ! truncate --size=3D64G "$TEST_IMG"; then
> +    _notrun "file system on $TEST_DIR does not support large enough file=
s"
> +fi
> +rm "$TEST_IMG"
> +
>  rt_offset=3D65536  # 0x10000 (XXX: just an assumption)
>  rb_offset=3D131072 # 0x20000 (XXX: just an assumption)
>  l1_offset=3D196608 # 0x30000 (XXX: just an assumption)


--=20
Alex Benn=C3=A9e

