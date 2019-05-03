Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581EEC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DFD20675
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBIXEd9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DFD20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37415 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMUuE-0007j9-0F
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 05:55:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMUtD-0007N3-UT
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMUtC-0002gg-Cf
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:53:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMUtB-0002fL-Q1
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:53:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id t76so6367173wmt.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=RWDtO9AGdyeuUQH4kUgUbzVhf9qDIsI3isDzIqbxtXw=;
	b=wBIXEd9cc6kHx03YlfIyhlIlhyzJ6+spW6KKn5wFk9lR9odtN49QxvjWGJbOaD73iZ
	YpkBLU/mAwOeoxvK2rqQ3VkrfTpJe1+06ZSSycL2sfQCG8vnEGs7ZvM0HFNI5df2K8uD
	QQQ9kxo8URMMb4GzQHKf0zXi9iVXDicWjobEKpV+mVA9J5mzKpFzlpILoHebDXfOM7sm
	B3SFCe4imLlhfIe3ht3l1hWXPFkolFQFNOWiRr2kGolx0Hu3jbKWqv4KDiFCx4Re7Yj8
	IoemNiZ6ccITcERz6+bTly37eGMKZJsOz8csTnZEmfbgOL4d1fT1oEMeAzbEzXc4oR3g
	54Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=RWDtO9AGdyeuUQH4kUgUbzVhf9qDIsI3isDzIqbxtXw=;
	b=N9rCCoWEKOaZ3p5zl9/h9jzYqrMN9vgx1ATI8LCX8fj1wv80RR3b4F57mSAlZpCWqT
	TjzJbt9/FxDiDrGPwwNejoGTabcKnFLc8YxdTxRojgzuBwk9ba2eG/quHPXLEO60TAcm
	4CXq01q5U/HqYKBGoVWMacbvvbYJZVLKm6AQB/xlNXgOmGX6UYSDXSSOK+2M4zs69Yco
	CMVp6GHbnpjphux2MOnTNFwyI7eaAvMDQZYLGYNcpL5+68p5aI4Z4DE5LKK28SO+fiKc
	ktKx8Y/QConJMs3UjvynzI6ojGt8D9dQjNapNIVYU6eeVBI3TtQBRvoyi3YzxItwd13G
	LVAw==
X-Gm-Message-State: APjAAAUQxrRivZd/6Zj0IMAALEUYIpwGvJVb8aZx26XFpy+QP2Tuok0X
	HWYb/CHbIMAxFCOyITx7M2SyDQ==
X-Google-Smtp-Source: APXvYqyFYHtiPhDbyWchhLIVr+sYzBL2z86SEbkPuV0Gn6yo2inJIO5AAJovpcYd4I6H4aq2z7/l9w==
X-Received: by 2002:a1c:4b03:: with SMTP id y3mr5695189wma.113.1556877235815; 
	Fri, 03 May 2019 02:53:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b124sm1404514wmg.21.2019.05.03.02.53.55
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 02:53:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id B44541FF87;
	Fri,  3 May 2019 10:53:54 +0100 (BST)
References: <20190502084506.8009-1-thuth@redhat.com>
	<20190502084506.8009-8-thuth@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190502084506.8009-8-thuth@redhat.com>
Date: Fri, 03 May 2019 10:53:54 +0100
Message-ID: <87tveb50el.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 7/7] tests: Run the iotests during "make
 check" again
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Philippe =?utf-8?Q?M?= =?utf-8?Q?athieu-Daud=C3=A9?=
	<philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503095354.RqUtrVbxCO6i6K9w42sARZQOCdtRDafMXh112a2pGVM@z>


Thomas Huth <thuth@redhat.com> writes:

> People often forget to run the iotests before submitting patches or
> pull requests - this is likely due to the fact that we do not run the
> tests during our mandatory "make check" tests yet. Now that we've got
> a proper "auto" group of iotests that should be fine to run in every
> environment, we can enable the iotests during "make check" again by
> running the "auto" tests by default from the check-block.sh script.
>
> Some cases still need to be checked first, though: iotests need bash
> and GNU sed (otherwise they fail), and if gprof is enabled, it spoils
> the output of some test cases causing them to fail. So if we detect
> that one of the required programs is missing or that gprof is enabled,
> we still have to skip the iotests to avoid failures.
>
> And finally, since we are using check-block.sh now again, this patch also
> removes the qemu-iotests-quick.sh script since we do not need that anymore
> (and having two shell wrapper scripts around the block tests seem
> rather confusing than helpful).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include      |  8 +++----
>  tests/check-block.sh        | 44 ++++++++++++++++++++++++++++---------
>  tests/qemu-iotests-quick.sh |  8 -------
>  3 files changed, 38 insertions(+), 22 deletions(-)
>  delete mode 100755 tests/qemu-iotests-quick.sh
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e2432d5e77..3bb7793d4a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -140,7 +140,7 @@ check-unit-y +=3D tests/test-uuid$(EXESUF)
>  check-unit-y +=3D tests/ptimer-test$(EXESUF)
>  check-unit-y +=3D tests/test-qapi-util$(EXESUF)
>
> -check-block-$(CONFIG_POSIX) +=3D tests/qemu-iotests-quick.sh
> +check-block-$(CONFIG_POSIX) +=3D tests/check-block.sh
>
>  # All QTests for now are POSIX-only, but the dependencies are
>  # really in libqtest, not in the testcases themselves.
> @@ -1096,8 +1096,8 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>
>  QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D =
tests/qemu-iotests/socket_scm_helper$(EXESUF)
>
> -.PHONY: check-tests/qemu-iotests-quick.sh
> -check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$=
(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
> +.PHONY: check-tests/check-block.sh
> +check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) qemu-=
io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
>  	$<
>
>  .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
> @@ -1168,7 +1168,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>  check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-t=
ests/qapi-schema/doc-good.texi
>  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>  check-block: $(patsubst %,check-%, $(check-block-y))
> -check: check-qapi-schema check-unit check-softfloat check-qtest check-de=
codetree
> +check: check-qapi-schema check-unit check-softfloat check-qtest check-de=
codetree check-block
>  check-clean:
>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y)) $(check-qtest-generic-y))
> diff --git a/tests/check-block.sh b/tests/check-block.sh
> index f3d12fd602..3b971d6cf4 100755
> --- a/tests/check-block.sh
> +++ b/tests/check-block.sh
> @@ -1,24 +1,48 @@
>  #!/bin/sh
>
> -FORMAT_LIST=3D"raw qcow2 qed vmdk vpc"
> +# Honor the SPEED environment variable, just like we do it for the qtest=
s.
> +if [ "$SPEED" =3D "slow" ]; then
> +    format_list=3D"raw qcow2"
> +    group=3D
> +elif [ "$SPEED" =3D "thorough" ]; then
> +    format_list=3D"raw qcow2 qed vmdk vpc"
> +    group=3D
> +else
> +    format_list=3Dqcow2
> +    group=3D"-g auto"
> +fi
> +
>  if [ "$#" -ne 0 ]; then
> -    FORMAT_LIST=3D"$@"
> +    format_list=3D"$@"
> +fi
> +
> +if grep -q "TARGET_GPROF=3Dy" *-softmmu/config-target.mak 2>/dev/null ; =
then
> +    echo "GPROF is enabled =3D=3D> Not running the qemu-iotests."
> +    exit 0
>  fi
>
> -export QEMU_PROG=3D"$PWD/x86_64-softmmu/qemu-system-x86_64"
> -export QEMU_IMG_PROG=3D"$PWD/qemu-img"
> -export QEMU_IO_PROG=3D"$PWD/qemu-io"
> +if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
> +    echo "No qemu-system binary available =3D=3D> Not running the qemu-i=
otests."
> +    exit 0
> +fi
> +
> +if ! command -v bash >/dev/null 2>&1 ; then
> +    echo "bash not available =3D=3D> Not running the qemu-iotests."
> +    exit 0
> +fi
>
> -if [ ! -x $QEMU_PROG ]; then
> -    echo "'make check-block' requires qemu-system-x86_64"
> -    exit 1
> +if ! (sed --version | grep 'GNU sed') > /dev/null 2>&1 ; then
> +    if ! command -v gsed >/dev/null 2>&1; then
> +        echo "GNU sed not available =3D=3D> Not running the qemu-iotests=
."
> +        exit 0
> +    fi
>  fi
>
>  cd tests/qemu-iotests
>
>  ret=3D0
> -for FMT in $FORMAT_LIST ; do
> -    ./check -T -nocache -$FMT || ret=3D1
> +for fmt in $format_list ; do
> +    ./check -$fmt $group || ret=3D1

This is all looking good and my only remaining objection is aesthetic.
If you run "make check -jN" you end up with the with the block test
output intermingled with the rest of the output which is now fairly
uniform.

Any chance we could hide the verbosity unless requested and have
something like:

    TEST    check-block: test xxx

emitted for each passing test? It's OK to show more in the failing case
to help with diagnosis but the passing tests should be easy on the eye
when scanning through the logs.

>  done
>
>  exit $ret
> diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
> deleted file mode 100755
> index 0e554bb972..0000000000
> --- a/tests/qemu-iotests-quick.sh
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/sh
> -
> -cd tests/qemu-iotests
> -
> -ret=3D0
> -TEST_DIR=3D${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g =
quick || ret=3D1
> -
> -exit $ret


--
Alex Benn=C3=A9e

