Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCC7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DD620708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Abp4PNRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DD620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJBm-0002Q2-Eu
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1ixJAT-0001FO-Kz
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1ixJAS-0007nE-Ny
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:24:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39090
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1ixJAS-0007m6-BI
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580426652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXAby82sq6aO3/yILgTjJTaPt/RZD/jCOWYwNZwQLWg=;
 b=Abp4PNRhfv9tcoYdAMPDiXL8Yjr1dsbRGkkHy82BQ3wtrr2ovEP/gueKou6OEdLE7PMlVQ
 ofG5Xg3KIeMK6PU6vgNzv5fEoyFuckzak6eFokZ1XWLqVBrLTQPxmO8Xshwea4ySr3vNwy
 O1qjUFXSpquwT1o3I0hL/ILbzEc1lOw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-jtdob7-6P2iLAyi9frADmw-1; Thu, 30 Jan 2020 18:24:08 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so2389660wrx.22
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 15:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KXAby82sq6aO3/yILgTjJTaPt/RZD/jCOWYwNZwQLWg=;
 b=qcS08yLbPyHKQMjBvv4izWtN8Q2n8bYaM4OHcrU/769Z1v7jvkiETFCzjZbaR3NxWg
 dOpqEtC4+L3bgUCO3n27P/NktONg8kQFLjBaUDjbwftqJzWcuupFEVYgsYny/UPNY03m
 gC6XdOlD5ho23UK4WV3rTs6sNd/oHIqt0xuhTzicLeyOMqKfi3QVz2HlJgm8RPS2NcJu
 k9ffkg1QR3lOdic0Kyj1tFO8UUSkewWT7zF82rTgjqBZuBGB4mdxlw4Lx1dP3N3YBAMR
 6MZCLb+XdNKR+RVHPbkalvcfhjHz+1WPqUwkQhvUNkFB83miD8A6Ty2B84ZWFdmjt6Cn
 lrrQ==
X-Gm-Message-State: APjAAAXs587vBzGe68vBm0iBhKAdpST2wll76CRiaGs2z7fJe+B0YUz3
 jbt34MOa46wMPrs0wO6rn+EJEfxZmnlBPpyiyM921e0Q67yAX73Wg0D8f8GIL6+hfaIMimFnchm
 I8zkA5916Zi9VzVpbUiXOlVWj7TJ6cE4=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr8384687wmd.39.1580426647068; 
 Thu, 30 Jan 2020 15:24:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+Ib+/radtj01CfefzSYr3F9RpN/YTqOIdf/Agkis5tbg2VTM0l82oSEVbFsuQgjsf3PzG7QS1uyzNIm2wXIs=
X-Received: by 2002:a05:600c:291d:: with SMTP id
 i29mr8384668wmd.39.1580426646859; 
 Thu, 30 Jan 2020 15:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-4-wainersm@redhat.com>
In-Reply-To: <20200122012753.9846-4-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 31 Jan 2020 00:23:55 +0100
Message-ID: <CAP+75-WVZ8fpCN+0H4oYJrkwkgnmNZBnDu2kdAczq1r=YxspOA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] tests/acceptance: avocado_qemu: Refactor the
 handler of 'machine' parameter
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
X-MC-Unique: jtdob7-6P2iLAyi9frADmw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 2:28 AM Wainer dos Santos Moschetta
<wainersm@redhat.com> wrote:
>
> The Test._param_to_vm_args variable contain VM arguments that should be a=
dded
> at launch which were originated from test parameters. Use this variable
> to set -M from 'machine' parameter as well.
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index c83a75ccbc..443ac02aff 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -120,6 +120,8 @@ class Test(avocado.Test):
>
>          self.machine =3D self.params.get('machine',
>                                         default=3Dself._get_unique_tag_va=
l('machine'))
> +        if self.machine:
> +            self._param_to_vm_args.extend(['-M', self.machine])
>
>          default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
>          self.qemu_bin =3D self.params.get('qemu_bin',
> @@ -162,8 +164,6 @@ class Test(avocado.Test):
>              name =3D str(uuid.uuid4())
>          if self._vms.get(name) is None:
>              self._vms[name] =3D self._new_vm(*args)
> -            if self.machine is not None:
> -                self._vms[name].set_machine(self.machine)
>          return self._vms[name]
>
>      def tearDown(self):
> --
> 2.23.0
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


