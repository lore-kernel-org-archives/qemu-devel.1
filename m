Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEE5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DAE2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWeJo+OG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DAE2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXpY-0006FT-2c
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtXok-0005pD-8i
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:46:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtXoi-0004Vz-R7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:46:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id z2so2695762wrp.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9dKwz//3AwzYNynjkxlRBm5evhkkUUyP/YvKkgs6xCM=;
 b=FWeJo+OG/nTFpfXWBj+tobHYOK4AGFb9i5eRUDVExZ68w3MkFCimw7KmXMvBpg3udL
 mJoZSWAD21h8JDh7ANFDHqdAYCZoZbLUBfrlsz0DxT2+v+i9YacWFrIjFh73Sx6I9VNg
 FuzG3BgvL+/N4GR4gQv/Cd5QDuzsY8pa1evowIgcuOqA8sUuUwfKXkR0HrJX/9bttpo+
 4qI7iNHuGq9Dzzs3gX1/n4lNkMIKvzCRRmlOA4Q5dzB1vURWyQPg5VD6Knvraoe++DAO
 c+4i/LqSUuQ5zf533qxdeSsSHwphugdPpDWH1aA80GJeYj00VU8yT5UmsVgeLdl3RAG7
 jJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9dKwz//3AwzYNynjkxlRBm5evhkkUUyP/YvKkgs6xCM=;
 b=ZefU9XBApWaWF7g9supmjbRbATx+Woi5IooROMpAp5Po1JyYFOxHl0tzyxJt5bXokW
 9oKztOvZGgwgYN/cEUcc4ylU2disRH6oXmPxyTKpfDC5yMjui5MwwxC3JkWDNfDIysYG
 xn3laHVWgNrbe+mOzNYZ5MQOFh+g3CGWXzxzY7pAFT5YBgOIuzCZl73RHJVreXHtomoU
 +W94Ooo9pbSqlD6oKfVMHphv4doAnaXcevKipvnage+kDqgpodiVaxTV4Nwx32zyXooG
 cO/c+yxS4fUe57c6xRfnintQVjQK/G4nxpHtvtzwS2voBIonwutKQcDIFwA2v1C23/Wp
 ixTw==
X-Gm-Message-State: AOAM531mCeDjlykeZbcL7/518gzA7wyAM9mLqaiMADbEdzGu8Hzlly8H
 0mwZ2eKsyOVXWrfooDvetN8=
X-Google-Smtp-Source: ABdhPJwhRMPRuvo0hE9cDE5z/KgdyOQbT+NPDG7AnlAiPoZ9/VzYe9aV/u69ZpvFuQq3SoPmRtlHmA==
X-Received: by 2002:adf:c142:: with SMTP id w2mr60400234wre.337.1594305987260; 
 Thu, 09 Jul 2020 07:46:27 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v12sm5746517wrt.31.2020.07.09.07.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 07:46:26 -0700 (PDT)
Subject: Re: [PATCH v1 11/13] tests/docker: fall back more gracefully when
 pull fails
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <475ac2d6-552a-62af-afe1-fe93c747d6da@amsat.org>
Date: Thu, 9 Jul 2020 16:46:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709141327.14631-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 4:13 PM, Alex Bennée wrote:
> I only spotted this in the small window between my testing with my
> registry while waiting for the gitlab PR to go in. As we pre-pull the
> registry image we know if that fails there isn't any point attempting
> to use the cache. Fall back to the way we used to do it at that point.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/docker.py | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 9684f07bdebe..2d67bbd15a5b 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -306,13 +306,14 @@ class Docker(object):
>          checksum = _text_checksum(_dockerfile_preprocess(dockerfile))
>  
>          if registry is not None:
> -            dockerfile = dockerfile.replace("FROM qemu/",
> -                                            "FROM %s/qemu/" %
> -                                            (registry))
>              # see if we can fetch a cache copy, may fail...
>              pull_args = ["pull", "%s/%s" % (registry, tag)]
> -            self._do(pull_args, quiet=quiet)
> -
> +            if self._do(pull_args, quiet=quiet) == 0:

Maybe worth defining EXIT_SUCCESS = 0. Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +                dockerfile = dockerfile.replace("FROM qemu/",
> +                                                "FROM %s/qemu/" %
> +                                                (registry))
> +            else:
> +                registry = None
>  
>          tmp_df = tempfile.NamedTemporaryFile(mode="w+t",
>                                               encoding='utf-8',
> 

