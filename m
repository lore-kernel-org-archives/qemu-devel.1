Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C1C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A482C20692
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4d6hNzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A482C20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWfzS-0008P0-CH
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 07:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWfx4-00077v-Ff
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWfx1-0006mY-4y
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:16:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25252
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWfx0-0006mG-W1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574079373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpJmHCJLwI+GJzftrBwi8liCiJI0Eu/V/kfq0IRJK9Q=;
 b=F4d6hNzlnuCPeTm8I2bYOSHlqoqM5fRosm2fbr8Gfg2WKWg3AkZdcyUeGK0IAuOXBPgR9u
 CmbrW5Pk4thyXQVtlzISPOzQX2ZYR/FfHEodXv8qeReavw+8uzqfZx7o/DKI5oRuGkD3Ea
 Zk+YlS/qVWH/0pFTeRLICjtzKSkBE84=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-xvIduL1rMQmc7q-ALmifog-1; Mon, 18 Nov 2019 07:16:09 -0500
Received: by mail-wm1-f72.google.com with SMTP id y133so11188270wmd.8
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 04:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U9u6kZ1kf6lQ3GtzsvpO6o+5pG+cEfp5/vD28JkDxBc=;
 b=AWRh+BSYItbiORgFQTlHLyzjHlP4/6+l3S0nBOZzUAHwBGcr2KdUbsQA9vp+Gffa8X
 tGNebqvlMkiAoUsHbEjT+12B6P2I53OPQyoTpDCkbmfaN3swU/AvwN+HNzXOQk23RX7k
 TTB2j+d2bMuRqtltTksm+ObSPbL4qJ/mfawJccavkvjxXMVIuHhweyS5N3gIWGtWGxoh
 eLAP7WKJpVAruX37y2kQCOflQgIpIRErMHXsufnH8pJuiY2XuOR9+BvekjrIeNjrJMZ0
 RHjktZbTs6Jyu8F/MZLIjRxWo+Fxs1MsdFvL/uYe4ttHqViajzDIASXzALbTjpXLiIUN
 dXMA==
X-Gm-Message-State: APjAAAUQ4DPOvEL8qi33Wl6S/WQe26BmUcieEWqnYvwkCKGbyb9TRamc
 L8KDEoaSn0dDSpU1w0NALJ849vk5F8GAoIm3T/TiR+9n5sAdwTTzhCpWo0sgfxNeHymtcCZe/Qp
 X7/P5CWh7xPskftY=
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr16908661wrt.14.1574079368684; 
 Mon, 18 Nov 2019 04:16:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLpN2seeqFH9RiljhnQTqRHmXjs2UfFkaEkh52QkmnIDmstvlGlF5K3ckTEPEU3T/CqmqJDA==
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr16908626wrt.14.1574079368491; 
 Mon, 18 Nov 2019 04:16:08 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id a26sm11873208wmm.14.2019.11.18.04.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 04:16:07 -0800 (PST)
Subject: Re: [PATCH 08/26] tests/acceptance: Introduce LinuxUserTest base class
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-9-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0eb2299b-62e2-14c4-072e-35886e3b524e@redhat.com>
Date: Mon, 18 Nov 2019 13:16:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-9-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: xvIduL1rMQmc7q-ALmifog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent, you weren't Cc'ed on this series, you might find it helpful to=20
test linux-user code. The next patch (09/26 Add bFLT loader linux-user=20
test) is provided as an example, and tests a STM32 BusyBox.

On 10/28/19 8:34 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Similarly to the MachineTest base class, this class contains
> methods common to linux-user tests.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 9 +++++++++
>   1 file changed, 9 insertions(+)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index d23681818d..2611a5146c 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -14,6 +14,7 @@ import sys
>   import uuid
>  =20
>   import avocado
> +from avocado.utils import process
>  =20
>   SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), '..', '..', '.=
.')
>   sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
> @@ -138,3 +139,11 @@ class MachineTest(Test):
>       def tearDown(self):
>           for vm in self._vms.values():
>               vm.shutdown()
> +
> +
> +class LinuxUserTest(Test):
> +    def setUp(self):
> +        self.base_setUp("%s-linux-user", "qemu-%s")
> +
> +    def run(self, cmd):
> +        return process.run("%s %s" % (self.qemu_bin, cmd))
>=20


