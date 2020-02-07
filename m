Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E324CC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CE020838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DT8XUlFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CE020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02My-0008Qq-Uf
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j02Jm-000425-HA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j02Jk-00039B-Ii
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:01:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j02Jk-00036n-CC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:01:04 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so2388670wru.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 04:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WLYOzD/3xJ/LWmKemowiSmHZ2JOR1HpYvsZ6ca2WSxA=;
 b=DT8XUlFeIfmtoGLBke+RP2ieB+KS0p00Ckbbe5CWwXA/NVV8EDIKTJax7euZd6nqCy
 BZxgbzDf9fmgdFeFWxXI1YeNo90J0lVAHEL6eSlLygd2Ur1MP1wOOUZtErDR/3zi3wOt
 CkanI1ue3nIO+iVUrhGOUZEzRuQGX1rQCZtLdP2uENDnc7NUCt070AeHP7YNpMGnHWxf
 xi5FVMCpc6q6wXbzcZW+p0Tg2MqC9BaJpAOUXcswiFDEqBPRpVPRAgR6Vs/TI+UVrt+a
 E93GaLn37LSkMXSXrhRiBvbiecFzArnGL/OHGfs7anzsPsPbQVxhbF38hms5ybYVKTL9
 w1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WLYOzD/3xJ/LWmKemowiSmHZ2JOR1HpYvsZ6ca2WSxA=;
 b=GsMJ+ijh7Yfrs88QQJv428QGNRyMOkCpBoF/ECJka4e78YIfKyxMSnpysboObfW6px
 Cfr4v7Ajb7qEASWZJKLhvZmWocfIe5N3Pkvz/MkPZQ6hyYGwzk5ublD5xYoY0e2e345q
 BgZYYdGG2dPDx4uOpALNVbGA81RKALtqFZ8UkuiOdnagtRoiidvf4nNwpZTt5D+Qq64X
 DmpKxm1tkP9FT2WrrOQvjtI7aTVGmNzFTHkaOMfG5avksLVTtkVRr6sTultIDOinaPXJ
 OweeGjnyro0KoJ4f2L1gMV5BQulGEbTm3xzOpJdtnkZMD3vj3zwGesIY9euivADclynV
 UgyA==
X-Gm-Message-State: APjAAAUFKGkNRaosR7hud2YoelVmK+fLDXPfVSPXgcxZHGFh3TWfkZ9H
 CDSkStvk+PhGVbwf5PkFfMVdHA==
X-Google-Smtp-Source: APXvYqxkcF6XCtY07dn6pHVDZcMDJyu69Fee3DSidb86Zi9sQnhpUSBOFdNyqqGxwC3bphkzEmgfuQ==
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr4594868wrq.178.1581076862998; 
 Fri, 07 Feb 2020 04:01:02 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l6sm3068620wmg.42.2020.02.07.04.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 04:01:01 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 252801FF87;
 Fri,  7 Feb 2020 12:01:01 +0000 (GMT)
References: <20200205212920.467-1-robert.foley@linaro.org>
 <20200205212920.467-4-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 03/14] tests/vm: increased max timeout for vm boot.
In-reply-to: <20200205212920.467-4-robert.foley@linaro.org>
Date: Fri, 07 Feb 2020 12:01:01 +0000
Message-ID: <87mu9u7gjm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

> Add change to increase timeout waiting for VM to boot.
> Needed for some emulation cases where it can take longer
> than 5 minutes to boot.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/vm/basevm.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 991115e44b..4de358ae22 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -59,6 +59,10 @@ class BaseVM(object):
>      poweroff =3D "poweroff"
>      # enable IPv6 networking
>      ipv6 =3D True
> +    # Scale up some timeouts under TCG.
> +    # 4 is arbitrary, but greater than 2,
> +    # since we found we need to wait more than twice as long.
> +    tcg_ssh_timeout_multiplier =3D 4
>      def __init__(self, debug=3DFalse, vcpus=3DNone):
>          self._guest =3D None
>          self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"vm-=
test-",
> @@ -311,6 +315,9 @@ class BaseVM(object):
>          sys.stderr.write("### %s ...\n" % text)
>=20=20
>      def wait_ssh(self, seconds=3D300):
> +        # Allow more time for VM to boot under TCG.
> +        if not kvm_available(self.arch):
> +            seconds *=3D self.tcg_ssh_timeout_multiplier
>          starttime =3D datetime.datetime.now()
>          endtime =3D starttime + datetime.timedelta(seconds=3Dseconds)
>          guest_up =3D False


--=20
Alex Benn=C3=A9e

