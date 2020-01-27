Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92B8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EB7214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8oYQwIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EB7214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3wf-0001KJ-PB
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iw3w5-0000pF-Fc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iw3w4-0002xP-7o
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:56:13 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iw3w4-0002ws-0m
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:56:12 -0500
Received: by mail-wr1-x444.google.com with SMTP id w15so11174716wru.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 04:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BnZ0q+Tssd0RAZBX91cVG0K31426QbEcYTlMguk2lBc=;
 b=s8oYQwIhe4W0zNWCxN1OZ7U6F8Rt7HiLzx/hZBj8lP/q706OobFOmcowJHZfn98oQN
 eXIRmvUexblibMgUK/TSKuCvKqvNZ/1TaKwZ2TDXXDqasmKER8m8kJt5G4V6bgidYGQw
 +bK2s0npY6OKuDptrabacY1J6ABwgM5ccnRnLTfb3vRhr8DLSErXCRsXMtqi9rqBSDN7
 dfgCYpxCppO377M3uiTjZ+mG2s3sJqPgQYFNFKHGfNy0Z30oq7zkHXagjSc4vK0fayDv
 eQi8gI3bwGuyJI74G2W8N8poHR67WfoCTWNbno39fZoIZv8rWknAhBvmiJybE9fodWm6
 hPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BnZ0q+Tssd0RAZBX91cVG0K31426QbEcYTlMguk2lBc=;
 b=Z50dVm14Q3bLo5uy+0oPNx/zbOdStykHqFAWdXVDUJpPizfCbGB3dSLJNKDS+32TSv
 hCdX2B6mUZiv9nQfmPdKZTFP9tI3Y+YsTOVObNZwukpfTFjIx+cBX4NFByZHPYV/TJZ+
 M4qzRiPTRb/Kc1fJhjJ/IPpU2IOop9WbMiaTfWMc6Fa4KgtKbE7JBAqfs45TS/8bF+Qi
 IpI3QWg3mn0ene/Lyl/T6D31MkdcJWKpg+o0bczZWZha1y00ogGmg1g04ywZhyMHr4I9
 CtfPf5qDpA6gGoUa5Df0+BE9UVmtbmiWClwdJBSpQ7hfABVgeH7FDKMSOr+Wjszj09T6
 eraQ==
X-Gm-Message-State: APjAAAWI0SERpm5LCRldRRTl1mNweBpK2MfiRLa5ymYEf5GTQQqfL3y3
 YRdLY64J1RsIIWyb2ogiJbufjA==
X-Google-Smtp-Source: APXvYqz3MMB/qBnn+l8FUiD7FfWHGLIGe1doawfHsZ4NhyPXEKJ1yOpSwD0HnwhyWwzVQwsanV9vsg==
X-Received: by 2002:adf:f605:: with SMTP id t5mr20897435wrp.282.1580129770591; 
 Mon, 27 Jan 2020 04:56:10 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm20236288wrt.57.2020.01.27.04.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 04:56:09 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B3C341FF87;
 Mon, 27 Jan 2020 12:56:08 +0000 (GMT)
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-7-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 6/8] tests/vm: add --boot-console switch
In-reply-to: <20200124165335.422-7-robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 12:56:08 +0000
Message-ID: <87mua9f47r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, peter.puhov@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Added ability to view console during boot via
> --boot-console switch.  This helps debug issues that occur
> during the boot sequence.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> ---
>  tests/vm/basevm.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 08a8989ac0..aa8b39beb7 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -489,6 +489,8 @@ def parse_args(vmcls):
>      parser.add_option("--config", "-c", default=3DNone,
>                        help=3D"Provide config yaml for configuration. "\
>                             "See config_example.yaml for example.")
> +    parser.add_option("--boot-console", action=3D"store_true",
> +                      help=3D"Show console during boot. ")
>      parser.disable_interspersed_args()
>      return parser.parse_args()
>=20=20
> @@ -523,6 +525,10 @@ def main(vmcls, config=3DNone):
>          if args.snapshot:
>              img +=3D ",snapshot=3Don"
>          vm.boot(img)
> +        wait_boot =3D getattr(vm, "wait_boot", None)

Didn't we add a __getattr method, so we can do self._config['wait_boot']

> +        if args.boot_console and callable(wait_boot):
> +            vm.console_init()
> +            wait_boot()

isn't wait_boot always callable because it's part of the basevm?

>          vm.wait_ssh()
>      except Exception as e:
>          if isinstance(e, SystemExit) and e.code =3D=3D 0:


--=20
Alex Benn=C3=A9e

