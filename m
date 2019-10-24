Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E9BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF36321925
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ17Vsgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF36321925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNiH0-0000zN-Rj
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iNiFw-0005fu-LR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iNiFt-0005ue-Ui
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:54:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iNiFt-0005ql-Pd
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571943279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=jynmMqpKNeKV3JzTsUW9BhidE9cMOiYp+FOxh2lHLeY=;
 b=WJ17VsgzKVkclvre2/IhFr76xWg9c1faoJ9p+5AmxnMa8InF/6DQ5pxnntJuDh/8lioD2d
 +rkYrPgPB/fULh3RdwJVeXGzCUlwv+kcqd8zoJMIN2rr743twkDJbfg9haOKOlPD1Dj558
 umci34DITYnw+HF9Wtf6UwRDLpbO6wU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-VsEe_OpwMTm8tIa8-W0cmw-1; Thu, 24 Oct 2019 14:54:37 -0400
Received: by mail-wm1-f70.google.com with SMTP id g13so1065439wme.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6yJjsMKTKIQ8186Ut9F69hXzw2UPrl7hcIMPBBbZhCY=;
 b=Gt6EV2LAWO3xQ9kSRHiWYrnF/Ve0N51yP2ctPyYUVwLGiCkqBKQ9gboCT6v31bBzXx
 QQGGNxF/fb3ubm9VyerO1gjUERTl7kFR0mlBUFT+uUnAdFMv0ZRntj9LX2vDYcXyX2av
 miUdS4P7GZECzWh/oKZJwLaymYQMBWqApdZKby+5pXonOXLVU9jJ45yhCvmCGpADXH6u
 /sObdmFyoC1qMhEXGgW5zrZF6hXJw8b4r5kQ9OonixyeE7Bu2ByfS1j/ssZUVQlt3/YF
 6XDSXAnIrkQlRYKB0jx4MkmKASwnPMP8NPSKQ8S6DOhARNFT7H0Y6yVR1zPJuOQOujoR
 tPTA==
X-Gm-Message-State: APjAAAV4+1scgrwiQQsG/VsedAR5EwElMK8u0f0+j6VXLNAybmB4gE3W
 pEK2lKiQJxyz6i5sHFZq4aw6W/07Txl5TNuts5X0vn0Kekk+/q3rVV+qsPcTsCAmaXtHiU0rfH8
 yYSRzDspxG65Jn9M=
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr4011045wma.176.1571943276053; 
 Thu, 24 Oct 2019 11:54:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyI7N6u37APu50YDEpvJ8ywuCMgebch0Bzi4e0Iqv2fUHHpzUQZyh0S3xPQTJj4kFMFpvCxxw==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr4011020wma.176.1571943275670; 
 Thu, 24 Oct 2019 11:54:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:302c:998e:a769:c583?
 ([2001:b07:6468:f312:302c:998e:a769:c583])
 by smtp.gmail.com with ESMTPSA id d11sm29279675wrf.80.2019.10.24.11.54.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 11:54:35 -0700 (PDT)
Subject: Re: [PATCH] Semihost SYS_READC implementation (v3)
To: qemu-devel@nongnu.org, keithp@keithp.com
References: <157193841432.8331.7323182040062540268@37313f22b938>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
Date: Thu, 24 Oct 2019 20:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <157193841432.8331.7323182040062540268@37313f22b938>
Content-Language: en-US
X-MC-Unique: VsEe_OpwMTm8tIa8-W0cmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi, alex.bennee@linaro.org,
 laurent@vivier.eu, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/19 19:33, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191023192640.13125-1-keithp@keith=
p.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>   CC      aarch64-softmmu/target/arm/translate-sve.o
> ../vl.o: In function `main':
> /tmp/qemu-test/src/vl.c:4385: undefined reference to `qemu_semihosting_co=
nsole_init'
> collect2: error: ld returned 1 exit status
> make[1]: *** [qemu-system-x86_64] Error 1
> make: *** [x86_64-softmmu/all] Error 2
> make: *** Waiting for unfinished jobs....
>   LINK    aarch64-softmmu/qemu-system-aarch64
> Traceback (most recent call last):
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3D3c82d370996f429bb4be7fef56e7247b', '-u'=
, '1001', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-e=
', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', =
'-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/=
var/tmp/patchew-tester-tmp-nju6kwxi/src/docker-src.2019-10-24-13.29.33.2420=
5:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' =
returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D3c82d370996f429bb4be=
7fef56e7247b
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-nju6kwxi/src'
> make: *** [docker-run-test-quick@centos7] Error 2

Looks like you need to add a dummy implementation of the new function to
stubs/semihost.c, for use in targets that don't support semihosting.

Thanks,

Paolo


