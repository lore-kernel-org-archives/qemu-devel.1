Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823A5C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC0D206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LK9jbbuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC0D206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix810-00029Q-GV
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ix7yr-0007ec-Sy
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ix7yq-0005p5-SA
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:27:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ix7yq-0005or-NT
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580383648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbFkGSbP4v9su3dr8zIFRQHEnDKlGt6WODekK1AFCT4=;
 b=LK9jbbuD2ZRhRnVHoD6EVGFDld9b2bqVV5NEBo8B5Fw0BEWemh+wPbWIHz28oNovmu2Y+S
 6/XgdfB8g9GS08LBhkKGaMiMJ8krAVHSfvUDeIGcfQec20hg6/N67EtUVhtdCv0+JgQ/FM
 wbp+TlDeNI5EN+G+ijNuPcOvBHUsico=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-LafuDznWPdqW19ElsjW4WQ-1; Thu, 30 Jan 2020 06:27:26 -0500
Received: by mail-wr1-f69.google.com with SMTP id y7so1579050wrm.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7vsQc/iAUG4jzCzBp6+/NlJC2k5WdnAqONCb+kmFKaQ=;
 b=YTPXizkabxtcvhePh8+mPLilkE82ncCAwTg+fDW2P64DzOUpuTLaWGa3SB11Pn8fc4
 XU/EJNy/ydOXXosrjZL6tzFSgkwVIh/Tj4FkFPJqPTXcitKxmofWgYy3VjQPqOraITwS
 oqOXE/lbOazoDkBNGKIhoroOgumdXamEHr+jLRJ1z53Dwiup1vKSx5d8i9KYcqWvLvJK
 EE99Bq+h29oUEsawYMeSF0Yucamm/+sSMBsc2KxzbqQJsGsgSg07gPQuPn2frughFXF8
 mKgsBjSlUfye5RmJYYsft5L6IpJuFTVoGsN2OTCsuTFtm+ILJCg0cH9rg9UPvEVEYo4E
 e5WQ==
X-Gm-Message-State: APjAAAUSALKyuk9zXcKTvwvkTetue/GM+lDNYxiukbNMF9k0OKd6FWCy
 49ZYf9930tUUEAuv6pTFiXWeRFgbEJWmg8r5KtPFiT67o0BAqhqgU5XoSo+AdRE9DwqEuHhaY8y
 uqDjwUUjp0BnO940=
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr5034173wmg.86.1580383645471;
 Thu, 30 Jan 2020 03:27:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9iSnl8LWhTQXDLKu+y1pasva7oY9i+xJQQkpTk+kwaI/wECbnI8JiGyH1qBnQxnWR6Z06uQ==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr5034157wmg.86.1580383645247;
 Thu, 30 Jan 2020 03:27:25 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id k13sm6752098wrx.59.2020.01.30.03.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:27:23 -0800 (PST)
Date: Thu, 30 Jan 2020 12:27:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH 2/6] tests/boot_linux_console: add BIOS acceptance test
Message-ID: <20200130112721.vm5u5zv7bifjremw@steredhat>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-3-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-3-git-send-email-liam.merwick@oracle.com>
X-MC-Unique: LafuDznWPdqW19ElsjW4WQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Hi Liam,

On Mon, Jan 27, 2020 at 04:36:30PM +0000, Liam Merwick wrote:
> Add tests to use qboot with the 'pc' and 'microvm' machine classes
> by adding the '-bios' option via self.vm.add_args() before calling
> do_test_x86_64_machine().
>=20
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>  tests/acceptance/boot_linux_console.py | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index aa5b07b1c609..8daf6461ffac 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -60,7 +60,6 @@ class BootLinuxConsole(Test):
>                        '/vmlinuz')
>          kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
>          kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> -
>          self.vm.set_console()
>          kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyS0'
>          self.vm.add_args('-kernel', kernel_path,
> @@ -75,12 +74,26 @@ class BootLinuxConsole(Test):
>          """
>          self.do_test_x86_64_machine()
> =20
> +    def test_x86_64_pc_qboot(self):
> +        """
> +        :avocado: tags=3Dmachine:pc
> +        """
> +        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
> +        self.do_test_x86_64_machine()
> +
>      def test_x86_64_microvm(self):
>          """
>          :avocado: tags=3Dmachine:microvm
>          """
>          self.do_test_x86_64_machine()
> =20
> +    def test_x86_64_microvm_qboot(self):
> +        """
> +        :avocado: tags=3Dmachine:microvm
> +        """
> +        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
> +        self.do_test_x86_64_machine()
> +

Reading the docs/microvm.rst, microvm should use qboot as default, so
the test_x86_64_microvm() and test_x86_64_microvm_qboot() maybe are the
same (I didn't test them).

>      def test_mips_malta(self):
>          """
>          :avocado: tags=3Darch:mips

Thanks for doing these tests!
Stefano


