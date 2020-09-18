Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53711C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29ED206D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVaNxCPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29ED206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIyn-00039R-E0
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kJIrP-0001YX-W7
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:03:44 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:36574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kJIrN-00025n-Hz
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:03:43 -0400
Received: by mail-ua1-x942.google.com with SMTP id h15so2032403uab.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eJavmv98RDqSBNFvj7aK5O8bgkPapC6Wlwlb1ma1DNU=;
 b=vVaNxCPnsb4rR+kbb2Dkh2+2b9g74u79SoP2b9ggL31OBYTwYFrvQBM6clnhEjrMn2
 A7uisB8Cnc2goInSxNeVTvsLsEqCp6JESzUOyqUsbMxLK3EImOnMKPe/nJ0y4Ysjr79b
 CFcPo6SGErW64voTXVYvBqzO2Y+4nSnr4ile8MhORGPUCa+aMTUHLGFFXu+XMAWPRXTO
 97oKUST2c9oq66eDdO949jf80Tw55KB3cUvr0wzQFBTD2c4k6D8VXrbnEgi64CS7oUas
 zHarJYxsZ5yXkeX5N2aXuS/gcog1iradK8o/H8hoRT2VSYIljnFDKcKddOZrxi/v4SCU
 W+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eJavmv98RDqSBNFvj7aK5O8bgkPapC6Wlwlb1ma1DNU=;
 b=mz+o0m5MgSoiCWmXFM8sVyS2hVgXM1zuajX0nz++DTnIt5eyAST7qLmaMWtiru7Mw0
 Ox/ExxsvdtEcEKO8kb5vlmeZxozH+2aePfitFoDqYPOyyUp1RCPxTlJlKSYY3Ff+Vnia
 5MhhADGOuPrDxCXu+Ju8JSNgaBN8iZOhZDNcaG+UK7AW9kVXMxE6ifeSXfh6fq+aBlgf
 hrT9hwK9GYwpc4c4yEjcpdTit9ZT+UVbq3MLbPidnXl/oSiAh7yM1CH2Rq4dyQ/RpmOj
 xKRNUBiSAZjjygG8R2jv2MKlccw8hyEs9wcFGQUOSETtdmdhPEWvLAwFtDGGUCiYpYg+
 rruA==
X-Gm-Message-State: AOAM532EmGSeEFPuQWeMuWrZYAy586H6Omuzc+CMsl5Eu8L+9ZHdR3bz
 EsTp4+Mhnz4md70OVOizRdsu+/pHnVAKjEvFPV+Lqg==
X-Google-Smtp-Source: ABdhPJxTXGjua3c8yJRONL9rQrMomxiXYi5dyXFEa+TNEZyQpPKbnECJoZpvlr5zhBiqF1hUK6kKawhGLe9R9g6S9vE=
X-Received: by 2002:ab0:390:: with SMTP id 16mr19303355uau.12.1600445019152;
 Fri, 18 Sep 2020 09:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200918143355.153522-1-f4bug@amsat.org>
In-Reply-To: <20200918143355.153522-1-f4bug@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 18 Sep 2020 09:03:27 -0700
Message-ID: <CAFQmdRasDewYnSCO9djseL+koX_cbST-faXUPLXroCTAU+o3wA@mail.gmail.com>
Subject: Re: [PATCH v2] tests/acceptance: Skip slow quanta-gsj U-boot+Linux
 test
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::942;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x942.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 7:33 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> The 'arm_quanta_gsj_initrd' test is timeouting on GitLab CI:
> https://gitlab.com/philmd/qemu/-/jobs/745483978#L846
> and also sometimes on my workstation, so proceed as with
> the other slow tests: do not run it by default.
> The test can still be run setting the AVOCADO_TIMEOUT_EXPECTED
> environment variable.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Havard Skinnemoen <hskinnemoen@google.com>
Tested-by: Havard Skinnemoen <hskinnemoen@google.com>

Thanks!

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

