Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E05C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918D82063A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAC8Jcik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918D82063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixIjx-0006xZ-RV
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixIjJ-0006J0-1m
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixIjH-00052W-LV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:56:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25529
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixIjH-00050l-Hp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580424967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZl5WJLGu/Kb9nx/OMVQnbbdrthLAfMHn+roVUhfr88=;
 b=cAC8JcikJn0RTcpmQROyVg1AD/wyO011k8+40CfAVXU9IgQ8RYcUoKvQpTBRb7BYMeE7X4
 DwzzyvSqgjDse8Dlr1mHVdJmPShrfROGKQvfWkVsYkFk0u2ZVBWJT2gezIJ0FPi7lDGAf9
 IL/vFnVkyBkCQGIUl499qBYsrPn2/SM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-qkgJxA6xPBG5rytKT1ahfw-1; Thu, 30 Jan 2020 17:56:02 -0500
Received: by mail-wr1-f72.google.com with SMTP id k18so2407384wrw.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 14:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L2nh/xd8TZKAhtFAsfOxokciGQ4yE5L/QxNJVEgoMAg=;
 b=KuQYRFiMXpgh8TXUmgyv67EjNpfu6GTSXsgZU44p28YX1LCr5oWOrNYrY0jeirgMEm
 y5q5T4h0vSXIm/Hd8J84B+YuOqpSuHjBvtvsTzcrUAAjmVUKxu8Mq0px83PTjvWl8DSt
 5HBLllorMyDu+/JGEK1W1fbIot0gA2hkELbcIyhE15tHCyo7WZkZNJ2DGK08SeGsjUSG
 jF1swjxI8ZuJGjuAMCAaTy6gu7KmKtOHqZl9eeccef6FMdF24gRrQBy9XaAiqLQqR35D
 ZIMzAFLnC7vBTwKZhWh7D3Mo2+o/4zJK9xqm7iN4Jw2ZWRf1jByN2DeWFBGaW0Mybb1x
 KtxQ==
X-Gm-Message-State: APjAAAUII7DoRSz7iBrn8GFcyboueLlROYmBDLtnRJ+6xADlYC7S48St
 1J5+zTaIN25WgtW/L4JrbSD4T/Hu58TIyKR3wtVJD8WNp8qYYYoWVHJhesFbhZqniybdEReqfuY
 nH2brwv+MidALkE4=
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr7618932wmc.115.1580424961577; 
 Thu, 30 Jan 2020 14:56:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyKvUy4KlnUYKiQOVtv/iZOnH8L0RjXYEa9hmn5MEm9LR/EGAglBMwSv55kPZ9EsmT/cw+Lg==
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr7618918wmc.115.1580424961382; 
 Thu, 30 Jan 2020 14:56:01 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id y20sm8055538wmj.23.2020.01.30.14.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 14:56:00 -0800 (PST)
Subject: Re: [PATCH v2 3/3] tests/acceptance: avocado_qemu: Refactor the
 handler of 'machine' parameter
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191218170003.31356-1-wainersm@redhat.com>
 <20191218170003.31356-4-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a91835b1-dc60-2832-69cd-c25a7a658f3d@redhat.com>
Date: Thu, 30 Jan 2020 23:55:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218170003.31356-4-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: qkgJxA6xPBG5rytKT1ahfw-1
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 6:00 PM, Wainer dos Santos Moschetta wrote:
> The Test._param_to_vm_args variable contain VM arguments that should be a=
dded
> at launch which were originated from test parameters. Use this variable
> to set -M from 'machine' parameter as well.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index aff32668d9..ba9539d511 100644
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

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Also, applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


