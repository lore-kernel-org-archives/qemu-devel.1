Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28CAC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E94206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P43Rz+6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E94206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnL6e-0003Sl-Vt
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnL6T-0002x4-Fm
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnL6S-0000fN-9y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:54:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnL6S-0000d6-2g
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:54:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id x1so5412156wrr.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 03:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Az9tplKx6PcAC17lrhcmOPyb3KOO7UgOT4cPGBGlJ0M=;
 b=P43Rz+6zF6BGkcmWyyFRR+h3Gtg9arubadZrvdY5HGPV/BGObIj/kKiA7vmxuORr6X
 GaATuJgcYXB2RFT6YaL6EUh3A4xvh3ltQ/j1BOHTj/WXEJjZ3nE9NTVVoukRUIH1Za0p
 k4wiWBehg8BO6aKLdjnPLjFe74qvEbEk3Ju+edwQh+G3PRaKHykMuSVj27byjPwldUs2
 +WeinL5N9ceXbUrKNjCduFP6elaAiB5FZAjqjNqeLFidTeragTFf2BUUxRtZP6710uZz
 /nDwE2Ikpmp7JPzUKf84+T6VuWgE9ThaobcZ3u+8umufEl0VDS9qX89OPdh+6+dqxi6l
 SMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Az9tplKx6PcAC17lrhcmOPyb3KOO7UgOT4cPGBGlJ0M=;
 b=cWr6fyTgfJTYQWHYpZQqOuUHF/obAaVTSRoP8lOaQ1Uf+/COGt8F8xv/Rd+D9vCsuv
 O1pHfwB4ogVf/3uiRa4eys/n5LljjHjdhJMnGBosSR6UyJmx/Xw71sxaurTbkWQBVC7+
 Q/pjrwxruvoQJ0Ojg44LcnqpvjngEl/GbsoPIQgSw74wOKRqVSIUCOfFctQoyGH8XELc
 9VHJQBa/yuMH+0zJrpNGw5ndd9XDkW5g5cc8v1dhoLw0dldDYnpJDNc9PB4PvzD7U67c
 GWSl35rXE6oGbfhGuUGQomQVeC1pgcxaiQ0hzOpZ0LCdK8WzGbPdEtCfL8jbBmh7Y8nf
 QKPw==
X-Gm-Message-State: APjAAAWpVKnqCgsTVhpUNg4dMLmRXjaOzYxwgHYRaKPR6QCsadDBoXsL
 SEz81zNxOvEMHd/PUnZloPdQqg==
X-Google-Smtp-Source: APXvYqzorZ+2Q9KKaQp8jHrSgsslqhXWdF7aSIfyyaEAY/7mHjN93hg6l4xtzs0cN/c5ZML9x3vNfg==
X-Received: by 2002:adf:c594:: with SMTP id m20mr5183325wrg.126.1563274473628; 
 Tue, 16 Jul 2019 03:54:33 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o24sm25068572wmh.2.2019.07.16.03.54.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 03:54:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9EBE01FF87;
 Tue, 16 Jul 2019 11:54:32 +0100 (BST)
References: <20190715174817.18981-1-philmd@redhat.com>
 <20190715174817.18981-2-philmd@redhat.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190715174817.18981-2-philmd@redhat.com>
Date: Tue, 16 Jul 2019 11:54:32 +0100
Message-ID: <87ef2quu53.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [NOTFORMERGE PATCH v2 1/9] tests/docker: Kludge to
 build the Fedora image
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Helge Deller <deller@gmx.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?utf-8?Q?C?= =?utf-8?Q?=C3=A9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Rebuilding the Fedora image is failing:
>
>   $ make docker-image-fedora V=3D1

Broken build state? Just do:

  make docker-image-fedora V=3D1 NOCACHE=3D1

>   [...]
>   Step 4/8 : RUN dnf install -y $PACKAGES
>    ---> Running in cef9615efafb
>   Fedora Modular 30 - x86_64                      2.0 MB/s | 2.7 MB     0=
0:01
>   Fedora Modular 30 - x86_64 - Updates            1.6 MB/s | 2.3 MB     0=
0:01
>   Fedora 30 - x86_64 - Updates                    6.1 MB/s |  17 MB     0=
0:02
>   Failed to synchronize cache for repo 'updates'
>   Error: Failed to synchronize cache for repo 'updates'
>   The command '/bin/sh -c dnf install -y $PACKAGES' returned a non-zero c=
ode: 1
>   Traceback (most recent call last):
>     File "./tests/docker/docker.py", line 615, in <module>
>       sys.exit(main())
>     File "./tests/docker/docker.py", line 611, in main
>       return args.cmdobj.run(args, argv)
>     File "./tests/docker/docker.py", line 413, in run
>       extra_files_cksum=3Dcksum)
>     File "./tests/docker/docker.py", line 280, in build_image
>       quiet=3Dquiet)
>     File "./tests/docker/docker.py", line 207, in _do_check
>       return subprocess.check_call(self._command + cmd, **kwargs)
>     File "/usr/lib64/python2.7/subprocess.py", line 190, in check_call
>       raise CalledProcessError(retcode, cmd)
>   subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu=
:fedora', '-f', '/tmp/docker_buildbKtWAa/tmpIctHw2.docker', '/tmp/docker_bu=
ildbKtWAa']' returned non-zero exit status 1
>   make: *** [tests/docker/Makefile.include:53: docker-image-fedora] Error=
 1
>
> The fix found in one of the comment from this thread helped to have
> it working again: https://bugzilla.redhat.com/show_bug.cgi?id=3D1706627
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> I have no idea what it does, it just works (TM).
> ---
>  tests/docker/dockerfiles/fedora.docker | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index e6d39e14cb..f6be5e2dd7 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -94,6 +94,7 @@ ENV PACKAGES \
>      zlib-devel
>  ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
>
> -RUN dnf install -y $PACKAGES
> +RUN echo zchunk=3DFalse >> /etc/dnf/dnf.conf
> +RUN dnf clean metadata && dnf install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
>  ENV FEATURES mingw clang pyyaml asan


--
Alex Benn=C3=A9e

