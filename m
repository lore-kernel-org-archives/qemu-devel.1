Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E36C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028F82071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZJCwuie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028F82071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwLmh-0007tO-5f
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 04:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwLlm-0007Rt-Qo
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 04:31:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jwLlk-00027Z-9u
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 04:31:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so13775215wme.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 01:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HyfrwRU+yKxL945cVypfjoSy5UNVe95kTAIwCSqZHso=;
 b=tZJCwuieRN/cagVpvA0x24Uok2ql4/koMGB5GAo7UTdaMcQ09c6lzoW7l4AghY8+Eg
 jOWHw4lYDuKgt9kKD7niZdQRCHnn2O2Uhu9OrDXkZ4DiggbGwouTGKJdQB4b0Izobp3x
 dfuJ3ElaMpXKa+ijsZrgnpzr0H3VwlEM+CzaxvMHPcRYJ7c3oBuuDKGhEwrAmsuUgcKP
 PBA5Gd5TeBqPWsRjgE+FMXadFuPnhFYXSPXARnvWBLyZ+9Uue7bAyRX067hoNf0qOqmZ
 U7JNLDZqHVUcfxcTlRvDu/CaIvArj/zx+GRmoVz7avJbZqZdASwpEgB5J4HCO7hZzRxo
 sacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HyfrwRU+yKxL945cVypfjoSy5UNVe95kTAIwCSqZHso=;
 b=TAd97Mx5hDJMdOXkjHBsCjDOPpEFaJqMmaJHbL9ojAdAuZllS98rHNkbyW4rdrijIG
 0YFUgtodct//cndaQ0HNvbe+asUWgdojBCEJ3WH+bM94CIlfzqrDKBpFN5H2ptS9FfSb
 NLhcquiJkYKSjsozwQ7zbbbXFG2HMTln5E0pT4ivRqab087Vqi8c/iYYxsiLg2n+fVxj
 pwTrHcMzPZJ78F3X4E3Ie0FBPafU6UrFZ2RKL77iU/IUcxhR0dqkT94Uvwd68TtfccrS
 SQbJNY6dcHdYInmXiq1OiKyU2ZHg2S/Vc6E8rUHb3bfyCkSHos6+olEDTe3GP5V5FH9T
 LV3A==
X-Gm-Message-State: AOAM530yyN371Ac1kY7DCPdgoNQjVbSE4bLVjcQ5zl8FQUYVCx39MSei
 JkdeBriuFw7j0DJRUzIcMe/dAA==
X-Google-Smtp-Source: ABdhPJzF+3tCwGLYPW07/BrYCaAN5Ht1zRq7V8NDcin7DnS2qWJr4dPhfTUozkHpO98HgVvAfjlbrw==
X-Received: by 2002:a05:600c:2154:: with SMTP id
 v20mr8726944wml.185.1594974657474; 
 Fri, 17 Jul 2020 01:30:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g82sm12434005wma.37.2020.07.17.01.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 01:30:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ADD051FF7E;
 Fri, 17 Jul 2020 09:30:55 +0100 (BST)
References: <20200716163330.29141-1-alxndr@bu.edu>
 <75839163-5e7c-3ff4-6d89-870d69ea5979@redhat.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab-ci.yml: Add oss-fuzz build tests
In-reply-to: <75839163-5e7c-3ff4-6d89-870d69ea5979@redhat.com>
Date: Fri, 17 Jul 2020 09:30:55 +0100
Message-ID: <87pn8uv8zk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: darren.kenny@oracle.com, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 16/07/2020 18.33, Alexander Bulekov wrote:
>> This tries to build and run the fuzzers with the same build-script used
>> by oss-fuzz. This doesn't guarantee that the builds on oss-fuzz will
>> also succeed, since oss-fuzz provides its own compiler and fuzzer vars,
>> but it can catch changes that are not compatible with the the
>> ./scripts/oss-fuzz/build.sh script.
>> The strange way of finding fuzzer binaries stems from the method used by
>> oss-fuzz:
>> https://github.com/google/oss-fuzz/blob/master/infra/base-images/base-ru=
nner/targets_list
>>=20
>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> ---
>>=20
>> Similar to Thomas' patch:
>>=20
>>> Note: This patch needs two other patches merged first to work correctly:
>>=20
>>> - 'fuzz: Expect the cmdline in a freeable GString' from Alexander
>>=20
>>> - 'qom: Plug memory leak in "info qom-tree"' from Markus
>>=20
>> Otherwise the test will fail due to detected memory leaks.
>>=20
>> Fair warning: I haven't been able to trigger this new job yet. I tried
>> to run the pipeline with these changes on my forked repo on gitlab, but
>> did not reach the build-oss-fuzz. I think this is due to some failures
>> in the Containers-layer-2 stage:
>>=20
>> ...
>> Error response from daemon: manifest for
>> registry.gitlab.com/a1xndr/qemu/qemu/debian-all-test-cross:latest not
>> found: manifest unknown: manifest unknown
>> #2 [internal] load .dockerignore
>> #2 transferring context:
>> #2 transferring context: 2B 0.1s done
>> #2 DONE 0.1s
>> #1 [internal] load build definition from tmpg8j4xoop.docker
>> #1 transferring dockerfile: 2.21kB 0.1s done
>> #1 DONE 0.2s
>> #3 [internal] load metadata for docker.io/qemu/debian10:latest
>> #3 ERROR: pull access denied, repository does not exist or may require
>> authorization: server message: insufficient_scope: authorization failed
>
> These look like the problems that we've seen with the main repo until
> two days ago, too, e.g.:
>
>  https://gitlab.com/qemu-project/qemu/-/jobs/640410842
>
> Maybe Alex (Benn=C3=A9e) can comment on how to resolve them?

It all should be working now the qemu-project container repository has
been properly seeded:

  https://gitlab.com/qemu-project/qemu/container_registry

>
>>=20
>>  .gitlab-ci.yml | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>=20
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index e96f8794b9..a50df420c9 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -182,6 +182,20 @@ build-fuzzer:
>>              || exit 1 ;
>>        done
>
> As mentioned in my other mail, I think you can replace my build-fuzzer
> job once this is working.
>
>> +build-oss-fuzz:
>> +  <<: *native_build_job_definition
>> +  variables:
>> +    IMAGE: fedora
>> +  script:
>> +    - OUT_DIR=3D"./build" CC=3Dclang-9 CXX=3Dclang++-9 CFLAGS=3D"-fsani=
tize=3Daddress"
>> +      LIB_FUZZING_ENGINE=3D"-fsanitize=3Dfuzzer" CFL
>
> That "CFL" at the end seems to be a typo (leftover from "CFLAGS")?
>
> Also the fedora container does not have clang-9 :
>
>  https://gitlab.com/huth/qemu/-/jobs/643383032#L28
>
> I think it is at clang 10 already, so maybe just use CC=3Dclang (without
> version number)?

I think all the clang-10 fixes are in now so yes.

>
>> +      ./scripts/oss-fuzz/build.sh
>> +    - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type=
 f); do
>> +        grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || con=
tinue ;
>> +        echo Testing ${fuzzer} ... ;
>> +        "${fuzzer}" -runs=3D1000 || exit 1 ;
>> +      done
>
> Should we exclude the virtio-net tests, since they could leak network
> traffic to the host?
>
>  Thomas


--=20
Alex Benn=C3=A9e

