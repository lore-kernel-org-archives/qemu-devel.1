Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B2CCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B81217D6
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOvO2X1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B81217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPCEa-0000VZ-Nz
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 17:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPBfF-0001HI-Ty
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPBfC-00009B-Ef
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:30:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27933
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPBf8-00007i-RD
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 16:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572294650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJ4wAqz5xekXMi1xDHNlkyfQwb/j+zoys/vRTL7dJIw=;
 b=VOvO2X1TvQ4gyfNtNTSGj9ajzXlF5IxNT4wK2aVCNl9HtWrURwgmzqpVRpeDHtwQvuZpsF
 SqtTo1TAe2LNOEaRk3gVGLEY+f1xdPWFVpsBECPOpUMruV26IPpUQpUxVY0eowftqFZ/6W
 P9pMq+ILCr2I6TsWDbkBESSIGa3zkb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-D0DnBl-2MDmXBbtL2pFDyA-1; Mon, 28 Oct 2019 16:30:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF64E1005509;
 Mon, 28 Oct 2019 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3D3F6085E;
 Mon, 28 Oct 2019 20:30:38 +0000 (UTC)
Date: Mon, 28 Oct 2019 16:30:36 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 21/26] tests/boot_linux_console: Test the raspi2 UART1
 (16550 based)
Message-ID: <20191028203036.GB18794@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-22-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-22-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: D0DnBl-2MDmXBbtL2pFDyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 08:34:36AM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> The current do_test_arm_raspi2() case tests the PL011 UART0.
> Our model also supports the AUX UART (16550 based).
> We can very simply test the UART1 with Linux, modifying the
> kernel command line.
>=20
> Add few lines to expand our previous test and cover the AUX
> UART.
>=20
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index cc0c73b9c1..1c9ff2bda3 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -301,6 +301,7 @@ class BootLinuxConsole(MachineTest):
>          """
>          serial_kernel_cmdline =3D {
>              0: 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
> +            1: 'earlycon=3Duart8250,mmio32,0x3f215040 console=3DttyS1,11=
5200'
>          }
>          deb_url =3D ('http://archive.raspberrypi.org/debian/'
>                     'pool/main/r/raspberrypi-firmware/'
> @@ -311,7 +312,7 @@ class BootLinuxConsole(MachineTest):
>          dtb_path =3D self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-=
2-b.dtb')
> =20
>          self.vm.set_machine('raspi2')
> -        self.vm.set_console()
> +        self.vm.set_console(console_index=3Duart_id)

While this was tested and looks good by itself, it depends on a
solution to the problem responded on
<20191028073441.6448-2-philmd@redhat.com>.

- Cleber.


