Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7191C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56D2206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgBjjCSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56D2206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8dW-0004yD-SG
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ix8cr-0004XC-4m
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ix8cp-0001MB-ST
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:08:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ix8cp-0001LS-OY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580386127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQkr37P3wT+j2zb7nIW/ZpplqJYLktcWdljU7AwQJOU=;
 b=UgBjjCSRIF57SzYCTyPKrhwkHONQfLIWx6TC92ZpeIy4OCxBWQP+KCxL7gidR5wmGU8M8x
 x971AWLRO1+2FYs8EIBOFLkO+2HYg4cue84K/j4aURDppuN3pmLme0Pc4462/GlWT4CWcd
 bzX+dlYu8F/gqxE5DT2VmX3TnIKpEMI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-tV-N2bp9OyK3Romt-qrFnw-1; Thu, 30 Jan 2020 07:08:37 -0500
Received: by mail-wr1-f69.google.com with SMTP id f17so1608565wrt.19
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 04:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p5BBHU2C9JsaGC0vMppc6DoQVK9NNkJWp8wx/IxGIW4=;
 b=SfKtbghsvLwv35LWhNkht1rJi2OG5znJPIsxPJ+j+d+IZKTvyfdGHJEb5uuQIoWLtn
 /ccEcWnQ8BudgMPfDJpHFlXWqJirzldsrPy5l5fFZoisKY3ompo5sWCGSZTJh0owvLBF
 swEPAuoinQhvdTBE2Bu1RdS4FVBN2Q3VdJM4NMVBcxX9o11eV8fWSYKNwzDZCIwti1Pv
 xscmlok4h4x3vog+VRE9xmbRsAg9dCQDGy1n33Zgn2X1qqlGAjGGZUska95UFwg6D+L4
 m6NTyjkllRSFTdRVs0OHQF94gsmv0ims7wqLkYqAGmR0WO0ZT/bdd9/iNrIWGJYrLHM4
 38rA==
X-Gm-Message-State: APjAAAUcagJ4igmgAwCmHuqpVAdLXfB+sMDIPKeDnKe7YMBHF6pTpvXP
 cIlBM8ypBtIxNfbMT0bVxvR3WAv3DNRNox15m94gxPSH5ckfPobk9ACpg0NnpyqylKxw68yULhg
 x2gOKUAnbQ6X0NZs=
X-Received: by 2002:adf:e38f:: with SMTP id e15mr884833wrm.271.1580386115711; 
 Thu, 30 Jan 2020 04:08:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxHfHFrhPfmdrc3sj16YfulZd36P0gtJL/9Q2as2xbptWQ7snAMWTGs1uyrk0QNAz+4u7naQ==
X-Received: by 2002:adf:e38f:: with SMTP id e15mr884795wrm.271.1580386115394; 
 Thu, 30 Jan 2020 04:08:35 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id r15sm6065061wmh.21.2020.01.30.04.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 04:08:34 -0800 (PST)
Date: Thu, 30 Jan 2020 13:08:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH 6/6] tests/boot_linux_console: add PVH acceptance tests
Message-ID: <20200130120832.hlltgk26u5h3ddrz@steredhat>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-7-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-7-git-send-email-liam.merwick@oracle.com>
X-MC-Unique: tV-N2bp9OyK3Romt-qrFnw-1
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

On Mon, Jan 27, 2020 at 04:36:34PM +0000, Liam Merwick wrote:
> Add tests to boot an uncompressed kernel using the x86/HVM direct boot AB=
I.
> The vmlinux binary is obtained from a small RPM for Kata containers and
> extracted using the new extract_from_rpm() method.
>=20
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>  tests/acceptance/boot_linux_console.py | 49 ++++++++++++++++++++++++++++=
+-----
>  1 file changed, 43 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 6af19ae3b14a..ab2200aa0e47 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -65,15 +65,26 @@ class BootLinuxConsole(Test):
>          os.chdir(cwd)
>          return self.workdir + '/' + path
> =20
> -    def do_test_x86_64_machine(self):
> +    def do_test_x86_64_machine(self, pvh=3DFalse):
>          """
>          :avocado: tags=3Darch:x86_64
>          """
> -        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora'
> -                      '/linux/releases/29/Everything/x86_64/os/images/px=
eboot'
> -                      '/vmlinuz')
> -        kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
> -        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +        if pvh:
> +            rpm_url =3D ('https://yum.oracle.com/repo/OracleLinux/'
> +                       'OL7/olcne/x86_64/getPackage/'
> +                       'kernel-uek-container-4.14.35-1902.6.6.1.el7.x86_=
64.rpm')
> +            rpm_hash =3D '4c781711a9d32dcb8e81da2b397cb98926744e23'
> +            rpm_path =3D self.fetch_asset(rpm_url, asset_hash=3Drpm_hash=
)
> +            kernel_path =3D self.extract_from_rpm(rpm_path,
> +                                                './usr/share/kata-contai=
ners/'
> +                                    'vmlinux-4.14.35-1902.6.6.1.el7.cont=
ainer')
> +        else:
> +            kernel_url =3D ('https://archives.fedoraproject.org/pub/arch=
ive/'
> +                          'fedora/linux/releases/29/Everything/x86_64/os=
/'
> +                          'images/pxeboot/vmlinuz')
> +            kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
> +            kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dke=
rnel_hash)
> +
>          self.vm.set_console()
>          kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyS0'
>          self.vm.add_args('-kernel', kernel_path,
> @@ -95,6 +106,19 @@ class BootLinuxConsole(Test):
>          self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
>          self.do_test_x86_64_machine()
> =20
> +    def test_x86_64_pc_pvh(self):
> +        """
> +        :avocado: tags=3Dmachine:pc
> +        """
> +        self.do_test_x86_64_machine(pvh=3DTrue)
> +
> +    def test_x86_64_pc_qboot_pvh(self):
> +        """
> +        :avocado: tags=3Dmachine:pc
> +        """
> +        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
> +        self.do_test_x86_64_machine(pvh=3DTrue)
> +
>      def test_x86_64_microvm(self):
>          """
>          :avocado: tags=3Dmachine:microvm
> @@ -108,6 +132,19 @@ class BootLinuxConsole(Test):
>          self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
>          self.do_test_x86_64_machine()
> =20
> +    def test_x86_64_microvm_pvh(self):
> +        """
> +        :avocado: tags=3Dmachine:microvm
> +        """
> +        self.do_test_x86_64_machine(pvh=3DTrue)
> +
> +    def test_x86_64_microvm_qboot_pvh(self):
> +        """
> +        :avocado: tags=3Dmachine:microvm
> +        """
> +        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
> +        self.do_test_x86_64_machine(pvh=3DTrue)

Also in this case I think we are using qboot in both tests.
Maybe we can remove one of them.

Thanks,
Stefano


