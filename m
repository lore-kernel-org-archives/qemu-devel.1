Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E63C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2522E21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzJQRdcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2522E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjIT-0000Ib-Aa
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izjHm-00080f-OF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izjHk-0004Cq-RQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:41:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izjHk-000495-Nb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581003704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YO0Wwjx9mzBUr1OIqyXYYhxyVlRPax5s6R/lgL5ofyo=;
 b=PzJQRdcdpPdnycwIui7dI76ARvYgfv6Ji0jsNBRBEnAvLUnC2I+bgytQZTQ1U1O+gpGwkV
 3cahpkpDEZlCwQcW6XbE6kBQHS7h/qBsVBy+2f/B/8ZahYAtikideN8d+i4jWfPZv2D16x
 2nkqQLi/DIkuVks7yMEvp+Mzopof/kM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-hw5dYKkrMEOTuj0wuJfqJg-1; Thu, 06 Feb 2020 10:41:40 -0500
Received: by mail-wr1-f69.google.com with SMTP id j4so3603463wrs.13
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 07:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NACPoE6lMVDUQagZ4ES/94wDjCqnD6TyE5sJ6nbo8j8=;
 b=c2ARnoI/k/1ar19P3FKgNbsn0mdS9UWPhBk11KS0cZDPlKWrAJwy6MUb0i3gJ9m6+W
 DD8AjhNi0j8RgqNwcYy07iF/mXpw1CXridmGCRA78+lfd4vnIJZXe7QU6GmMn+SO1/2C
 VK+wadodACBusUsxoB77yimJXLzgqNth4TAyi9T61aVL6WEgoJ8xDkx5qh1Mb8hZ2982
 6ouLecZlL64Qb7CLES3LYAwha+XUfDedmr6QvzryKf0F3IXzM1NlgGDrAef9cJdhBrQd
 cjD1AInrzM8irdNJ8F6tyuk1Ci1LCMBinf3Gu3VVIencnZShsvVttKby7dfFiBoijHAX
 IBCg==
X-Gm-Message-State: APjAAAUgPzxZlqqS1pxyYFN4LcN7VTxBQmwwiSKgd9IDatRGwTlGUuwj
 QURCcNAOXWeru1wQITh+GgmDn7sDRfByYkSQ6fIN68WYDVhdv2RLMWvgNTl9OWEKhEpOLQi5PhF
 DRNDfKAUhDNrFmms=
X-Received: by 2002:a5d:484d:: with SMTP id n13mr4322261wrs.420.1581003698845; 
 Thu, 06 Feb 2020 07:41:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqx28iClND2FEhtgV/Y65y07nQ6cWwxg89qXiP0fAxb/vmWYOGW6gT+4BlGgDI0IzznrdySObA==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr4322243wrs.420.1581003698654; 
 Thu, 06 Feb 2020 07:41:38 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s1sm4834905wro.66.2020.02.06.07.41.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 07:41:38 -0800 (PST)
Subject: Re: [PATCH v4 7/8] tests/acceptance: avocado_qemu: Refactor the
 handler of 'machine' parameter
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200205203250.30526-1-wainersm@redhat.com>
 <20200205203250.30526-8-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <20692eec-968f-a6b3-3591-d7a08d4293d6@redhat.com>
Date: Thu, 6 Feb 2020 16:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205203250.30526-8-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: hw5dYKkrMEOTuj0wuJfqJg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: drjones@redhat.com, thuth@redhat.com, alex.bennee@linaro.org,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 9:32 PM, Wainer dos Santos Moschetta wrote:
> The Test._param_to_vm_args variable contain VM arguments that should be a=
dded
> at launch which were originated from test parameters. Use this variable
> to set -M from 'machine' parameter as well.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index c83a75ccbc..443ac02aff 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -120,6 +120,8 @@ class Test(avocado.Test):
>  =20
>           self.machine =3D self.params.get('machine',
>                                          default=3Dself._get_unique_tag_v=
al('machine'))
> +        if self.machine:
> +            self._param_to_vm_args.extend(['-M', self.machine])
>  =20
>           default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
>           self.qemu_bin =3D self.params.get('qemu_bin',
> @@ -162,8 +164,6 @@ class Test(avocado.Test):
>               name =3D str(uuid.uuid4())
>           if self._vms.get(name) is None:
>               self._vms[name] =3D self._new_vm(*args)
> -            if self.machine is not None:
> -                self._vms[name].set_machine(self.machine)
>           return self._vms[name]
>  =20
>       def tearDown(self):
>=20

It would be cleaner if you add _param_to_vm_args[] with this fix as 1st=20
patch of the series, then 2nd patch 'Introduce the 'accel' test=20
parameter' on top.


