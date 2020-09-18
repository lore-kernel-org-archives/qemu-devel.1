Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DCDC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2AA20717
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYHND8OX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2AA20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIGL-0002yD-BW
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kJI5c-0007Ug-My
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kJI5a-0002OZ-Rl
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600442057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=goF7EzQB7KJ4j+9uvwvaKyUXFj22kaSJsn5VGTJPni0=;
 b=SYHND8OXbZyIEoqw4xB+bns4ESYnE6+nJZKO4tog+HkaBxj0bTlLz1WmHwXplRPCBzvq9B
 iMR6GIjtscmIh8HzI3jCnOPLsEnU+cqIuocGRmym4XrrRkL/YOAOG/1GFFSO0Cwt0wFOYv
 ynPO0Jku7yBRJWmgLszC4/3n6eZCzQI=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-C2bSIQXnO1KvHi-qZQkZ7g-1; Fri, 18 Sep 2020 11:14:16 -0400
X-MC-Unique: C2bSIQXnO1KvHi-qZQkZ7g-1
Received: by mail-ua1-f71.google.com with SMTP id x14so798697uan.12
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=goF7EzQB7KJ4j+9uvwvaKyUXFj22kaSJsn5VGTJPni0=;
 b=F4k18oyIsrnKiT4i+mv1cHyk5/UZf6JWX3FasqMvylU4Vfkjw1lxzR0j8/1fDfQ1bh
 8E8MAdLA4L+wgTjvMFGBgLb+QxEpB/eQAxqH+unGqueAQ8xaCkCKS7JGCXdfaVx6Yg7J
 HclP8GMNg3z+QM18EQOnYrJRerH983rPf5AeRJBN7iHOh6ZXSp36OwLiPFQotzAOishn
 xWNbvXwYUiagL8KOGL98m39kYXGINmSvR9SDvO510j7b4xSskuopG1uPRKe0CopmVQZY
 llb8r4dArtfEp5M9aq8RzCmHco4AoIgqNJIqZsjogLBRoJ8U+7/sEOjBZcLGwVE0/9O7
 paNQ==
X-Gm-Message-State: AOAM530ypqlxCpH2Fhtz+FD4zoTYq7LgN/c1LSDsoBRVVCo+3sCdg7Nc
 C71vfn1fIO/iUIY7zl+FHD60anslTmin5Ay5eg/T8p969/T66Sck0cjPREmvNZiacg79/RAAs9k
 mof/EbFtVVtXHLe8ootnIPA2IpVKECjM=
X-Received: by 2002:a1f:26cd:: with SMTP id m196mr20833117vkm.7.1600442055815; 
 Fri, 18 Sep 2020 08:14:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdQigqOmqFYLQlorIzJXQ6zbJI9597Dh8OzutV3HRkHHLLuyckYyuvpqU+ZYUdm+/zAfxE3gOrQz2JkaVhINM=
X-Received: by 2002:a1f:26cd:: with SMTP id m196mr20833080vkm.7.1600442055566; 
 Fri, 18 Sep 2020 08:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200918143355.153522-1-f4bug@amsat.org>
In-Reply-To: <20200918143355.153522-1-f4bug@amsat.org>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Fri, 18 Sep 2020 12:14:04 -0300
Message-ID: <CAKJDGDarnnnEKVT=V=NDR9gjQO6XnOrVTtcZUOWUNhwJhdye1w@mail.gmail.com>
Subject: Re: [PATCH v2] tests/acceptance: Skip slow quanta-gsj U-boot+Linux
 test
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 11:35 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> The 'arm_quanta_gsj_initrd' test is timeouting on GitLab CI:
> https://gitlab.com/philmd/qemu/-/jobs/745483978#L846
> and also sometimes on my workstation, so proceed as with
> the other slow tests: do not run it by default.
> The test can still be run setting the AVOCADO_TIMEOUT_EXPECTED
> environment variable.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Supersedes: <20200918142344.150749-1-f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 4a366ce93e4..9b58f6f9003 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -568,6 +568,7 @@ def test_arm_cubieboard_sata(self):
>                                                  'sda')
>          # cubieboard's reboot is not functioning; omit reboot test.
>
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
>      def test_arm_quanta_gsj(self):
>          """
>          :avocado: tags=3Darch:arm
> --
> 2.26.2
>
>

At least, this time, skipUnless is already there :D

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


