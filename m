Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA86C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF6820767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clqEF4x6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF6820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttQv-0003R2-Sh
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jttQN-00031D-Jp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:50:48 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jttQL-0000Lr-Iq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:50:47 -0400
Received: by mail-wm1-x343.google.com with SMTP id l2so6001865wmf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FgJh6Kj2zNd8gOIDNj0VrBGIZSq1wKAtrJoYsQP1BbI=;
 b=clqEF4x6OxpjrjNy19fUfWkRaWSQr6Qz5NvxwVxejQNe/0Z33RF6KxInc2YaPeW39Y
 cRif9oSu9l4SbOSYBM0av4GULfBIe2de2g3a0b+2PC7BzpntawASfigJi7Xh9TXrJWfE
 oo3bDJxdd3msbKfR3ADZrrkXBHKKeMzQCWU3JCw0/w28nkCLqmJTFsWi50tzJh3LIJzx
 sC12fv8o43elRXIyMcbCzvM3l1CuWCueLteDiSGonI8wIfbJyuB4MAhp5s4CJskYdhkG
 TX3G1bSQoJjhOYDoWNywuYldSiN8WPq/wPD5/6nFfLyn0TCIkeOaQmV2xPrMi2D3RtkS
 5UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FgJh6Kj2zNd8gOIDNj0VrBGIZSq1wKAtrJoYsQP1BbI=;
 b=O7HiRqVRTSfPMZ+1QnR/SUhutUEAflEXxL7O5UbMpv+a/ZQdN37BrkiKjOVM2RpzeN
 t8CO3l5mokTWaLoQ5QKF5wvDmgSVvfo0Y+IbfHfFCBg13abrTrj4274JFEb1w0VogDGM
 WIJIm/mjAknoxZNs0UHtwLcoDKitH0vQR+rB1wRn1CEIQeKaKpXyKCy35DwHylclYRtv
 FxTi+Ik2qBqS0taLKpVguyVTaW2hApn/Gc7TimRDr7mFRJsigs41d5hRlOXF4HjAAAGy
 fuwHf0nJPurns2cmhknwOJN8f/dFkr0+Em5t3QmH/Ln+yykDfu5/Dk4UFpt2C4p90J3X
 IMxQ==
X-Gm-Message-State: AOAM532aHMTLnY7/cIgNVHoZqUb5JyoK6rCnmw6Kl8Kc/LfPPFvxtkQn
 nhDsCCayuVhJbs6DnUR6YV9JTw==
X-Google-Smtp-Source: ABdhPJxX6frTLlVkTC6zh5XhkGmcRiaOgtHChVaLvhQIT3lcgtFGZtG4BDCBfrlUipHpJ2vWNyIGTQ==
X-Received: by 2002:a7b:c952:: with SMTP id i18mr5624382wml.65.1594389043799; 
 Fri, 10 Jul 2020 06:50:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v12sm10106409wrt.31.2020.07.10.06.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 06:50:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F4CE1FF7E;
 Fri, 10 Jul 2020 14:50:36 +0100 (BST)
References: <20200707070858.6622-1-alex.bennee@linaro.org>
 <20200707070858.6622-5-alex.bennee@linaro.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: Re: [PULL 04/41] tests/vm: Add configuration to basevm.py
In-reply-to: <20200707070858.6622-5-alex.bennee@linaro.org>
Date: Fri, 10 Jul 2020 14:50:36 +0100
Message-ID: <875zavlbrn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Robert Foley <robert.foley@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Puhov <peter.puhov@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> From: Robert Foley <robert.foley@linaro.org>
>
> Added use of a configuration to tests/vm/basevm.py.
> The configuration provides parameters used to configure a VM.
> This allows for providing alternate configurations to the VM being
> created/launched. cpu, machine, memory, and NUMA configuration are all
> examples of configuration which we might want to vary on the VM being cre=
ated
> or launched.
> This will for example allow for creating an aarch64 vm.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20200601211421.1277-3-robert.foley@linaro.org>
> Message-Id: <20200701135652.1366-7-alex.bennee@linaro.org>
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 5a58e6c39300..cfe20c58f7ef 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -29,16 +29,41 @@ import tempfile
>  import shutil
>  import multiprocessing
>  import traceback
> -
> -SSH_KEY =3D open(os.path.join(os.path.dirname(__file__),
> -               "..", "keys", "id_rsa")).read()
> -SSH_PUB_KEY =3D open(os.path.join(os.path.dirname(__file__),
> -                   "..", "keys", "id_rsa.pub")).read()
> -
> +import shlex
> +
> +SSH_KEY_FILE =3D os.path.join(os.path.dirname(__file__),
> +               "..", "keys", "id_rsa")
> +SSH_PUB_KEY_FILE =3D os.path.join(os.path.dirname(__file__),
> +                   "..", "keys", "id_rsa.pub")
> +
> +# This is the standard configuration.
> +# Any or all of these can be overridden by
> +# passing in a config argument to the VM constructor.
> +DEFAULT_CONFIG =3D {
> +    'cpu'             : "max",
> +    'machine'         : 'pc',
> +    'guest_user'      : "qemu",
> +    'guest_pass'      : "qemupass",
> +    'root_pass'       : "qemupass",
> +    'ssh_key_file'    : SSH_KEY_FILE,
> +    'ssh_pub_key_file': SSH_PUB_KEY_FILE,
> +    'memory'          : "4G",
> +    'extra_args'      : [],
> +    'qemu_args'       : "",
> +    'dns'             : "",
> +    'ssh_port'        : 0,
> +    'install_cmds'    : "",
> +    'boot_dev_type'   : "block",
> +    'ssh_timeout'     : 1,
> +}
<snip>
>=20=20
> -def main(vmcls):
> +def main(vmcls, config=3DNone):
>      try:
> +        if config =3D=3D None:
> +            config =3D {}

Ahh I think this is where is went wrong - should be config =3D DEFAULT_CONF=
IG

Just re-running the rest of the vm builds now.

--=20
Alex Benn=C3=A9e

