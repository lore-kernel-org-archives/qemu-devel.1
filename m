Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B70DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D3B2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIBYS7OT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D3B2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixK0l-000072-L1
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixJrW-00082u-8B
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixJrV-0006FV-0j
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:08:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45808
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixJrU-0006Ef-TT
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580429320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cWFeGbfOde6zsE6AsSexVnApO0+c/p/D0hneNf7rPUY=;
 b=WIBYS7OTvC5YK2gNw6LcD7R+Y7hD+RdHwnC1TkQhlJZMVgY8NtUno9d7G081NgQij6U6la
 lN2gtovv+E3KcI4V7/9A+a5TA09Gi1qqRBo4Q0ZkN416mOqr4nVcypPNY+mnlkWDA1eryc
 3Y8WAOXnCgiEpAUk/JZcm+yY1jxQo/U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-cEdPEqykN-irivYYJJFfXQ-1; Thu, 30 Jan 2020 19:08:30 -0500
Received: by mail-wm1-f70.google.com with SMTP id n17so2042396wmk.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HS/Q2dEgKLk3NCpgo2yx7ccd09VDmjo0oxNkHQsC21Q=;
 b=plHo3JmdLhLboqHPLNw0DEUmU2AW9QUw2hupVgxfAOXUW5A4VMurISTub4GrZSe5bn
 yjgPGdDi97dRdi4U3sYCAhMzcrQCNH5whhFmiUeyYnYgiui2rmtFe7v+8OawtxhQjWkv
 HuwKVQyMBCxHQf1yauKeibgiwHJxNDve0deE5XJO/aqjjevZOqefjmUF094D1Z9PlcTq
 9dTrZ3JLnrbAL7yQbAajDPquRBQJUA31MoZyaqIiJLeWel1wlMLLNHLvqNbs0V3Il6ew
 VLyU/xtFVjZ75VRZHYrApnq6wL/SndZ+pH0p9kuTM7OVA3GALnRW0IPs68e1Bpsn3gXI
 bTFA==
X-Gm-Message-State: APjAAAXhRMm5naAnzuGWiHd+JX1CHh9WtTqKCg1kWFVALerBlXKYhsLy
 VA7bLYfT/XWC4/If3G/eJpw/OK7enJdOYO4GrXYvor2qVYv9RtcrEY211TYzB9n66cFlv0H/mst
 HidAcPrI1sJ4CdJM=
X-Received: by 2002:a1c:3906:: with SMTP id g6mr8575673wma.49.1580429309453;
 Thu, 30 Jan 2020 16:08:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqzp6Sar7iqM8k5XV4ROJeaESaNrWjle3T74mxNm2YxFMqNqSBjpvMAtKWot/T6kBvXdba/v/g==
X-Received: by 2002:a1c:3906:: with SMTP id g6mr8575652wma.49.1580429309231;
 Thu, 30 Jan 2020 16:08:29 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q124sm17485129wme.2.2020.01.30.16.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 16:08:28 -0800 (PST)
Subject: Re: [PATCH v2 18/29] tests/acceptance/virtio_check_params: List
 machine being tested
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-19-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57f7c506-a6a4-23ec-f8c0-a12363c7526c@redhat.com>
Date: Fri, 31 Jan 2020 01:08:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-19-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: cEdPEqykN-irivYYJJFfXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 10:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add logging for easier debugging of failures:
>=20
>    $ avocado --show=3Dmachine run tests/acceptance/virtio_check_params.py
>     (1/1) tests/acceptance/virtio_check_params.py:VirtioMaxSegSettingsChe=
ck.test_machine_types:
>    machine: {'name': 'pc-i440fx-2.12', 'seg_max_adjust': 'false', 'device=
': 'virtio-scsi-pci'}
>    machine: {'name': 'pc-i440fx-2.0', 'seg_max_adjust': 'false', 'device'=
: 'virtio-scsi-pci'}
>    machine: {'name': 'pc-q35-4.2', 'seg_max_adjust': 'false', 'device': '=
virtio-scsi-pci'}
>    machine: {'name': 'pc-i440fx-2.5', 'seg_max_adjust': 'false', 'device'=
: 'virtio-scsi-pci'}
>    machine: {'name': 'pc-i440fx-4.2', 'seg_max_adjust': 'false', 'device'=
: 'virtio-scsi-pci'}
>    ...
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/virtio_check_params.py | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/v=
irtio_check_params.py
> index 51a2dd76e8..f679b0eec7 100755
> --- a/tests/acceptance/virtio_check_params.py
> +++ b/tests/acceptance/virtio_check_params.py
> @@ -21,6 +21,7 @@
>   import sys
>   import os
>   import re
> +import logging
>  =20
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'py=
thon'))
>   from qemu.machine import QEMUMachine
> @@ -73,6 +74,9 @@ class VirtioMaxSegSettingsCheck(Test):
>           return query_ok, props, error
>  =20
>       def check_mt(self, mt, dev_type_name):
> +        mt['device'] =3D dev_type_name # Only for the debug() call.
> +        logger =3D logging.getLogger('machine')
> +        logger.debug(mt)
>           with QEMUMachine(self.qemu_bin) as vm:
>               vm.set_machine(mt["name"])
>               for s in VM_DEV_PARAMS[dev_type_name]:
>=20

Thanks, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


