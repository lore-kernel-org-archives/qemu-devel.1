Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1235C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AEFB2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi3/7nBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEFB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8RO-0008MC-Dk
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ix8Ki-0001CK-TZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ix8Kg-0002Yu-I9
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:50:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60200
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ix8Kg-0002YO-DQ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580385001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUv1P2Iq01vNmZUT9bkkpZDZe2kSMid6fMyKsFYFcaE=;
 b=Fi3/7nBTjoLYSx54Qn9Mhp4DIIWqdPEuK3HvZN18dYxhQOM+c/aXQeBKXBziCTExlz6PVF
 UyXOw7o7Bq6aQ7cD8Q35GrE+ytU42RkPz/RPKnzHRYsvcdSVnAbyNXmcdss51iZhBWM3hW
 x9ej5L1v/J3BbYZKZ1pPjBvLbn0aMb4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-JWVvGaRxP5-oqPqGfUbT1Q-1; Thu, 30 Jan 2020 06:49:55 -0500
Received: by mail-wr1-f70.google.com with SMTP id b13so1565453wrx.22
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F01aSopn8U1FsiaKf3EfBYdzuSa6/mxsOmTh+Ri5bHo=;
 b=czNx9R0sHbFxQv+JdKxQEJGNNLjgjzzNbxcqAWq9tL57nReBYIcBxqt4d8qWD3UoCs
 dntQ0TiJ+9zcXQO7tvyJEyoeWeQXcq76ZwlnF3hZRZXB789PJEx8ud22J+ZCozUE9cO8
 NHKO6Qop22kA2jqQEm65GGB78i0uIOIUjeZVdTa6iDMMmwLnIbIxt73AHzc4ZJvDlbPz
 mqvtaKjn8NmmAkcmQRbUoz1kAESvq1pzrKYIrvkMdqx8spcpAkU/2NuYjEdtQ+ow+kIX
 +s+tKqRkHuXrJWaPYxBPNuI8Zc6kkkzy53A5YwFoZFrrFKxBSM0Q+E62ObbpT3yAux1C
 rIPw==
X-Gm-Message-State: APjAAAWN8Ne4Zc68zhCCEkA8/beTyeAqI5fOgeW35oEd3GKU1sLNDHzt
 bu3heu6SHwXN4cdU9CDAT5fwVpWNuLjDAonVhFn4LfRkXIHmBVUKiKHaavGxQhsSZC+9QsWhh2x
 0dHXkfX9l47A06FU=
X-Received: by 2002:a05:600c:23ce:: with SMTP id
 p14mr5037391wmb.114.1580384994040; 
 Thu, 30 Jan 2020 03:49:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxFo4Pa9XX5/agT6DXSJc2EFrvn7Ct2xO2k5ohrEYrSpH69qTKBe7dYigCCkjUzNLECT1TqQ==
X-Received: by 2002:a05:600c:23ce:: with SMTP id
 p14mr5037352wmb.114.1580384993734; 
 Thu, 30 Jan 2020 03:49:53 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id m21sm6226441wmi.27.2020.01.30.03.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:49:53 -0800 (PST)
Date: Thu, 30 Jan 2020 12:49:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH 1/6] tests/boot_linux_console: add microvm acceptance test
Message-ID: <20200130114950.mudigrwt3n7rpffm@steredhat>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-2-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-2-git-send-email-liam.merwick@oracle.com>
X-MC-Unique: JWVvGaRxP5-oqPqGfUbT1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: fam@euphon.net, slp@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, wainersm@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 04:36:29PM +0000, Liam Merwick wrote:
> Refactor test_x86_64_pc() to test_x86_64_machine() so that separate
> functions which specify the Avocado tag of ':avocado: tags=3Dmachine:'
> as being either 'pc' or 'microvm' can be used to test booting a
> compressed kernel using either machine class.
>=20
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>  tests/acceptance/boot_linux_console.py | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index e40b84651b0b..aa5b07b1c609 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -51,10 +51,9 @@ class BootLinuxConsole(Test):
>          os.chdir(cwd)
>          return self.workdir + path
> =20
> -    def test_x86_64_pc(self):
> +    def do_test_x86_64_machine(self):
>          """
>          :avocado: tags=3Darch:x86_64
> -        :avocado: tags=3Dmachine:pc
>          """
>          kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora'
>                        '/linux/releases/29/Everything/x86_64/os/images/px=
eboot'
> @@ -70,6 +69,18 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
> =20
> +    def test_x86_64_pc(self):
> +        """
> +        :avocado: tags=3Dmachine:pc
> +        """
> +        self.do_test_x86_64_machine()
> +
> +    def test_x86_64_microvm(self):
> +        """
> +        :avocado: tags=3Dmachine:microvm
> +        """
> +        self.do_test_x86_64_machine()
> +
>      def test_mips_malta(self):
>          """
>          :avocado: tags=3Darch:mips
> --=20
> 1.8.3.1
>=20

--=20


