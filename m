Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91740C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589F220715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k30ZzJTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589F220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01ck-0005BM-Am
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j01aC-0002lH-FK
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j01aB-0000KK-ET
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:14:00 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j01aB-0000Je-7P
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:13:59 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so2313536wma.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4asHfRpO279JQfTtyBK2e9x56s/EC/2n06yX/Dn5BT8=;
 b=k30ZzJTuBJpuiQ+r9x4cd7wUXDIpizTAvn+LeGVJBsl6a/EwKPQp99OBoigzmDqXp7
 zBM+p8HfkUxr2du+h4+3V/tOrtL3mnjLGb68C1K4zd7La4rDsu7GccjTYVS0yCsTFEMS
 MK/KbWDRPpqrTDg1vy0+2bY2YjrZhrc9YrpwchR8ILzitjDHFfCGQxD8KoFuInVll0Q/
 QgtbprnrTEVZ+15LlKphBzNUneKah67A1Qr4oEIUu2v6kBQdEH4fxSGDp3GwNKpHEhdD
 vEz+bqzz+aEMQ7wdgx9qbMQo/XVpWGqdHbW1MGo3HhRFsqawRhb0O/qADyDAp4JUt+9d
 kxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4asHfRpO279JQfTtyBK2e9x56s/EC/2n06yX/Dn5BT8=;
 b=HCAu8xCHXmYbYdEoi2jyu//fGmI5v6I3Up/xL7xDa59XClGScTe4JFzTtkCWcaaLN5
 9SqDQ3Ih6p2USlYY4apwC00SQQhxz4hrRY1Vt9Qh1edn0ufQL21qgLiTpRxoBI4Iv2XH
 518+qemNPw0P6cJ17qFLb4oln+eW8muK7GkzNNKxZJW1q3vlKqhhtlStWfTq/wEoLpVi
 vWCeUt8zHN4DMZ+VK0Q5bqqP4hzbnpbp3ZhH32+nCkG9IFQn8wtuGHFOuo4Z9jfSrSkR
 flkJ+xT9tVrZnQw+yiF7v9jvlKFDgu5Fv6zobUR9WemVpkh1CtIM0WDEhIHBKWaS6Ol1
 qpUw==
X-Gm-Message-State: APjAAAWp9M1Odzgr8GXhFSycv98vUK81470baU2sD+qi32fyjnS0+W21
 PIlG42Uxd9IMrAT3Kzxy3z5T9g==
X-Google-Smtp-Source: APXvYqyb4gAVh+Ne4gSzVaJR+JrzwgcfwT/Z3YP/2kIOIQrY+JPsI/RIqz3Wf7ky7UcP/FDlWSg7bw==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr3737667wme.112.1581074037949; 
 Fri, 07 Feb 2020 03:13:57 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z133sm3152936wmb.7.2020.02.07.03.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 03:13:57 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 579611FF87;
 Fri,  7 Feb 2020 11:13:56 +0000 (GMT)
References: <20200206202543.7085-1-thuth@redhat.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] travis.yml: Test the s390-ccw build, too
In-reply-to: <20200206202543.7085-1-thuth@redhat.com>
Date: Fri, 07 Feb 2020 11:13:56 +0000
Message-ID: <87sgjm7iq3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Since we can now use a s390x host on Travis, we can also build and
> test the s390-ccw bios images there. For this we have to make sure
> that roms/SLOF is checked out, too, and then move the generated *.img
> files to the right location before running the tests.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to testing/next, thanks.

> ---
>  .travis.yml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 6c0ec6cf69..c0eeff9caa 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -508,6 +508,16 @@ matrix:
>        env:
>          - TEST_CMD=3D"make check check-tcg V=3D1"
>          - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU_=
TARGETS},s390x-linux-user"
> +      script:
> +        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
> +        - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
> +        - |
> +          if [ "$BUILD_RC" -eq 0 ] ; then
> +              mv pc-bios/s390-ccw/*.img pc-bios/ ;
> +              ${TEST_CMD} ;
> +          else
> +              $(exit $BUILD_RC);
> +          fi
>=20=20
>      # Release builds
>      # The make-release script expect a QEMU version, so our tag must sta=
rt with a 'v'.


--=20
Alex Benn=C3=A9e

