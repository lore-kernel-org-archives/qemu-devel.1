Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8CCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359B720866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6ValkVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359B720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zwJ-0002XQ-F0
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3zv1-0001Zd-7A
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:48:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3zuy-0003mD-No
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:48:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so1395244wmi.5
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mNg5johaTrB0dvD+RfIYuYcfMuX3b1lbDq76Wc08w6Y=;
 b=O6ValkVkLf4vDfA+Q/jM1iGlsow1OCfgvIT0aTOjn6u6mjUqL8nCMYofOqU41qZ5zm
 4dDs4W6E+t0n9ntsOR5fPIANlr84ENtlspMS5zn29i3BYtGr2JMXBJGlt33NS0q2t+2m
 9YeFQ9MMcaVlgzhs2DP0oAHHuEhK5RlFzXnSxY4LeevZTzfYc50wxxXqgVo7tihqpvEq
 mGevhh/R7o6rVMBeHmxn0gppogSSTtdUXhBvRMDRlPSJx53N0jq/Epw87KFohwyyxbjp
 b/2B0mB0zo5cAVvRfJH9t8WIWF9UcdeIEtbiSoRdrrSEKRcQCmikYhWGqSmKEIN1/Fpe
 bqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mNg5johaTrB0dvD+RfIYuYcfMuX3b1lbDq76Wc08w6Y=;
 b=BFv7aNNEvnxE4ldyXiDugwRNIKUw16QyGqSYBrWTMykrNA0s8UWS7Q89KcIhb36fB3
 nCLdStQsTFmVsBk8LSXY9CPDwMxDalTykjvv4W9nX3tTOxtgfvWSeW4qo+JIFTnul9Iw
 AWgKqnjZkxMmX12lqk4bd7mle/i8T7lYUuCu/TDApC+DFmRfjTvvn/T+l4CRifmfyHTT
 Pn64jYIedgWGe5iSZvy4Eot0slIlJ5NPPKAi84KslbPtwEUF9GEiHvEikCMMZhAPuRfD
 Q0UY7vPksFYGeKObeTtF6c2fPbUizUjBBIrv3BnsR7as8Km2GTQVRmiBeWUUPw2WCe/c
 MXbQ==
X-Gm-Message-State: AOAM533+C1DmLGkDaN4IPMk/oetZF1DvrL4Vg49Eplb4m9vncypOrgXO
 S0pLmT1ed5WFCVIYj34jaB1tuBXTCoA=
X-Google-Smtp-Source: ABdhPJy+f3gsALwIRaEmcJ4fECu/vpBnyUs5JLmYlgNwHu1SgZ3CfAP6q0N99vk02H7nDH7q/B9g+Q==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr12371554wmk.153.1596797286115; 
 Fri, 07 Aug 2020 03:48:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r16sm10547265wrr.13.2020.08.07.03.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 03:48:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 32C8C1FF7E;
 Fri,  7 Aug 2020 11:48:04 +0100 (BST)
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-21-git-send-email-pbonzini@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 020/143] meson: add testsuite Makefile generator
In-reply-to: <1596741379-12902-21-git-send-email-pbonzini@redhat.com>
Date: Fri, 07 Aug 2020 11:48:04 +0100
Message-ID: <87sgcyk9zv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Rules to execute tests are generated by a simple Python program
> that integrates into the existing "make check" mechanism.  This
> provides familiarity for developers, and also allows piecewise
> conversion of the testsuite Makefiles to meson.

Hmm not sure why check-tcg has broken then:

  11:44:37 [alex.bennee@hackbox2:~/l/q/b/all] review/meson-for-5.2|=E2=9C=
=94 + make check-tcg
  make[1]: Entering directory '/home/alex.bennee/lsrc/qemu.git/slirp'
  make[1]: Nothing to be done for 'all'.
  make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/slirp'
  make: *** No rule to make target 'run-tcg-tests-aarch64-softmmu', needed =
by 'check-tcg'.  Stop.


>
> The generated rules are based on QEMU's existing test harness
> Makefile and TAP parser.
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile               |   4 ++
>  scripts/mtest2make.py  | 102 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/Makefile.include |   1 -
>  3 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/mtest2make.py
>
> diff --git a/Makefile b/Makefile
> index 9a75047..6248fd0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -58,6 +58,10 @@ ninjatool: ninjatool.stamp
>  ninjatool.stamp: $(SRC_PATH)/scripts/ninjatool.py config-host.mak
>  	$(MESON) setup --reconfigure . $(SRC_PATH) && touch $@
>=20=20
> +Makefile.mtest: build.ninja scripts/mtest2make.py
> +	$(MESON) introspect --tests | $(PYTHON) scripts/mtest2make.py > $@
> +-include Makefile.mtest
> +
>  .git-submodule-status: git-submodule-update config-host.mak
>=20=20
>  # Check that we're not trying to do an out-of-tree build from
> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> new file mode 100644
> index 0000000..e978303
> --- /dev/null
> +++ b/scripts/mtest2make.py
> @@ -0,0 +1,102 @@
> +#! /usr/bin/env python3
> +
> +# Create Makefile targets to run tests, from Meson's test introspection =
data.
> +#
> +# Author: Paolo Bonzini <pbonzini@redhat.com>
> +
> +from collections import defaultdict
> +import json
> +import os
> +import shlex
> +import sys
> +
> +class Suite(object):
> +    def __init__(self):
> +        self.tests =3D list()
> +        self.slow_tests =3D list()
> +        self.executables =3D set()
> +
> +print('''
> +SPEED =3D quick
> +
> +# $1 =3D test command, $2 =3D test name
> +.test-human-tap =3D $1 < /dev/null | ./scripts/tap-driver.pl --test-name=
=3D"$2" $(if $(V),, --show-failures-only)
> +.test-human-exitcode =3D $1 < /dev/null
> +.test-tap-tap =3D $1 < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $2/" || =
true
> +.test-tap-exitcode =3D printf "%s\\n" 1..1 "`$1 < /dev/null > /dev/null =
|| echo "not "`ok 1 $2"
> +.test.print =3D echo $(if $(V),'$1','Running test $2') >&3
> +.test.env =3D MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} %=
 255 + 1))}
> +
> +# $1 =3D test name, $2 =3D test target (human or tap)
> +.test.run =3D $(call .test.print,$(.test.cmd.$1),$(.test.name.$1)) && $(=
call .test-$2-$(.test.driver.$1),$(.test.cmd.$1),$(.test.name.$1))
> +
> +define .test.human_k
> +        @exec 3>&1; rc=3D0; $(foreach TEST, $1, $(call .test.run,$(TEST)=
,human) || rc=3D$$?;) \\
> +              exit $$rc
> +endef
> +define .test.human_no_k
> +        $(foreach TEST, $1, @exec 3>&1; $(call .test.run,$(TEST),human)
> +)
> +endef
> +.test.human =3D \\
> +        $(if $(findstring k, $(MAKEFLAGS)), $(.test.human_k), $(.test.hu=
man_no_k))
> +
> +define .test.tap
> +        @exec 3>&1; { $(foreach TEST, $1, $(call .test.run,$(TEST),tap);=
 ) } \\
> +              | ./scripts/tap-merge.pl | tee "$@" \\
> +              | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only)
> +endef
> +''')
> +
> +suites =3D defaultdict(Suite)
> +i =3D 0
> +for test in json.load(sys.stdin):
> +    env =3D ' '.join(('%s=3D%s' % (shlex.quote(k), shlex.quote(v))
> +                    for k, v in test['env'].items()))
> +    executable =3D os.path.relpath(test['cmd'][0])
> +    if test['workdir'] is not None:
> +        test['cmd'][0] =3D os.path.relpath(test['cmd'][0], test['workdir=
'])
> +    else:
> +        test['cmd'][0] =3D executable
> +    cmd =3D '$(.test.env) %s %s' % (env, ' '.join((shlex.quote(x) for x =
in test['cmd'])))
> +    if test['workdir'] is not None:
> +        cmd =3D '(cd %s && %s)' % (shlex.quote(test['workdir']), cmd)
> +    driver =3D test['protocol'] if 'protocol' in test else 'exitcode'
> +
> +    i +=3D 1
> +    print('.test.name.%d :=3D %s' % (i, test['name']))
> +    print('.test.driver.%d :=3D %s' % (i, driver))
> +    print('.test.cmd.%d :=3D %s' % (i, cmd))
> +
> +    test_suites =3D test['suite'] or ['default']
> +    is_slow =3D any(s.endswith('-slow') for s in test_suites)
> +    for s in test_suites:
> +        # The suite name in the introspection info is "PROJECT:SUITE"
> +        s =3D s.split(':')[1]
> +        if s.endswith('-slow'):
> +            s =3D s[:-5]
> +        if is_slow:
> +            suites[s].slow_tests.append(i)
> +        else:
> +            suites[s].tests.append(i)
> +        suites[s].executables.add(executable)
> +
> +print('.PHONY: check check-report.tap')
> +print('check:')
> +print('check-report.tap:')
> +print('\t@cat $^ | scripts/tap-merge.pl >$@')
> +for name, suite in suites.items():
> +    executables =3D ' '.join(suite.executables)
> +    slow_test_numbers =3D ' '.join((str(x) for x in suite.slow_tests))
> +    test_numbers =3D ' '.join((str(x) for x in suite.tests))
> +    print('.test.suite-quick.%s :=3D %s' % (name, test_numbers))
> +    print('.test.suite-slow.%s :=3D $(.test.suite-quick.%s) %s' % (name,=
 name, slow_test_numbers))
> +    print('check-build: %s' % executables)
> +    print('.PHONY: check-%s' % name)
> +    print('.PHONY: check-report-%s.tap' % name)
> +    print('check: check-%s' % name)
> +    print('check-%s: %s' % (name, executables))
> +    print('\t$(call .test.human, $(.test.suite-$(SPEED).%s))' % (name, ))
> +    print('check-report.tap: check-report-%s.tap' % name)
> +    print('check-report-%s.tap: %s' % (name, executables))
> +    print('\t$(call .test.tap, $(.test.suite-$(SPEED).%s))' % (name, ))
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 985cd14..5e9dff9 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -674,7 +674,6 @@ check-report-unit.tap: $(check-unit-y)
>  # Reports and overall runs
>=20=20
>  check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS=
)) check-report-unit.tap
> -	$(call quiet-command, cat $^ | scripts/tap-merge.pl >$@,"GEN","$@")
>=20=20
>  # FPU Emulation tests (aka softfloat)
>  #


--=20
Alex Benn=C3=A9e

