Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3F4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A0320823
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OafGimvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A0320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbWba-0006hI-Oj
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbWat-00067h-Qh
 for qemu-devel@nongnu.org; Wed, 20 May 2020 17:49:43 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbWas-0003ZL-Ng
 for qemu-devel@nongnu.org; Wed, 20 May 2020 17:49:43 -0400
Received: by mail-ed1-x541.google.com with SMTP id d24so4831029eds.11
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mrv7tkfUYp6bVYnNkt/gkJ3Kq/AQr4mStq5B4cO0DY4=;
 b=OafGimvp/t/oszkYf+MkI+KMnj4vR+jD8yz/TbdxPym/uPf1maJ2vHwImX0XZ/q/pn
 0UudN2ZZDgSXdRfw7f9afpkYb8fXDrPBeRAEinDDrgEEYkdIIwdLxGVDj3zSaJyaFjin
 5wH02WnnESlTdg6g6nH4wC6fpZBUXD6SFAMV7NRmbVdrAjVEepZ6eCED2HPJ5tcxbl6x
 fM/ZIG6J1oHI9x5X+C+qW95N2H7T+3cdYgykZkPJJlZu1BBu5sHKkDUJPOIZyy0Z2lri
 M6FkaTFISFb4yykzT27iOTBt3F6EwyAJ4v0LW3v6St7/1KZXiYOIdXP0O7eVa1GbThrD
 R0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mrv7tkfUYp6bVYnNkt/gkJ3Kq/AQr4mStq5B4cO0DY4=;
 b=jUS7CaXGVUFCD8k7tDHo8LQRmaf3+b5KwkZqmLr21iCDTey4s/KxBzxNaaIjvDZY2h
 lkpIwE+LmHyrBzpj5RuT/EQwyJS6PdwNgdCjqhT2S5tqN8Ks7vpDASFHK69B6WoLwle/
 185BMDG5IU0ypqPETmUYt1WTm/l/AHJ2ZB+SFNSzX4HJJ8SuiKpkj2INgzsbDPuMP07i
 18Htaub84YqJLd/JTb/e+bJ9r9QrNs4HTwzQauHqvgLY4gJCiv/yLvQgO1HX5FSF/9ve
 gDLMBfezdCp31ycPROi+xFtxt+U8kj9SQX155WZgPqjCZHK3d0F602eMyvT/IfKt2mkK
 er4Q==
X-Gm-Message-State: AOAM531TRnEuugByGb4vM/+xWTAD8ud+HNnnBKZkYSClNe1/vFfSj5Lk
 Uq80BbyYwi/eXoo0vLeP6R9cjw==
X-Google-Smtp-Source: ABdhPJwKohCAg72ClFYvZ/UAgcLRsS92RK4JG/mqNZIzAkjqLu336iUck8+m1z8qTHOd6/8f+Hn0Xg==
X-Received: by 2002:a50:a7e3:: with SMTP id i90mr5500723edc.6.1590011380831;
 Wed, 20 May 2020 14:49:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm2908756ejr.90.2020.05.20.14.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 14:49:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA13C1FF7E;
 Wed, 20 May 2020 22:49:38 +0100 (BST)
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-4-robert.foley@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v7 03/12] tests/vm: pass args through to BaseVM's __init__
In-reply-to: <20200519132259.405-4-robert.foley@linaro.org>
Date: Wed, 20 May 2020 22:49:38 +0100
Message-ID: <87h7waff9p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

A brief rationale wouldn't go amiss in the commit message. e.g. "We will
shortly need to pass more parameters to the class so lets just pass args
rather than growing the parameter list."

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  tests/vm/basevm.py | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index a2d4054d72..fbefda0595 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -61,9 +61,9 @@ class BaseVM(object):
>      # 4 is arbitrary, but greater than 2,
>      # since we found we need to wait more than twice as long.
>      tcg_ssh_timeout_multiplier =3D 4
> -    def __init__(self, debug=3DFalse, vcpus=3DNone, genisoimage=3DNone):
> +    def __init__(self, args):
>          self._guest =3D None
> -        self._genisoimage =3D genisoimage
> +        self._genisoimage =3D args.genisoimage
>          self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"vm-=
test-",
>                                                           suffix=3D".tmp",
>                                                           dir=3D"."))
> @@ -76,7 +76,7 @@ class BaseVM(object):
>          self._ssh_pub_key_file =3D os.path.join(self._tmpdir, "id_rsa.pu=
b")
>          open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
>=20=20
> -        self.debug =3D debug
> +        self.debug =3D args.debug
>          self._stderr =3D sys.stderr
>          self._devnull =3D open(os.devnull, "w")
>          if self.debug:
> @@ -90,8 +90,8 @@ class BaseVM(object):
>                         (",ipv6=3Dno" if not self.ipv6 else ""),
>              "-device", "virtio-net-pci,netdev=3Dvnet",
>              "-vnc", "127.0.0.1:0,to=3D20"]
> -        if vcpus and vcpus > 1:
> -            self._args +=3D ["-smp", "%d" % vcpus]
> +        if args.jobs and args.jobs > 1:
> +            self._args +=3D ["-smp", "%d" % args.jobs]
>          if kvm_available(self.arch):
>              self._args +=3D ["-enable-kvm"]
>          else:
> @@ -438,8 +438,7 @@ def main(vmcls):
>              return 1
>          logging.basicConfig(level=3D(logging.DEBUG if args.debug
>                                     else logging.WARN))
> -        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs,
> -                   genisoimage=3Dargs.genisoimage)
> +        vm =3D vmcls(args)
>          if args.build_image:
>              if os.path.exists(args.image) and not args.force:
>                  sys.stderr.writelines(["Image file exists: %s\n" % args.=
image,


--=20
Alex Benn=C3=A9e

