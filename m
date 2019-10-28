Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C24CA9EC1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52651214B2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqCxYArm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52651214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9dv-00053s-Jx
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 14:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iP82l-0004mW-Nt
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iP82j-0001O9-RM
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:38:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iP82H-0000xz-N6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572280709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRtx+QRulOt24z1SB7DYT5igrzfklJlUOT21Q2XU120=;
 b=fqCxYArm0iSGRcXJRW/C9ZUidYq1TNlkeSoZgpKmH6SngGNkncJVBiebxh3De0InaUJqUn
 07D0/XfSq6JGmabza+fGbPtEPLN+Np6gAVY1GOhYZ6EdWd9/C3xdCzfiM14JsDZL21ghtP
 SAzLmLEJeyGvjVGkUeM8dMayxryeJzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-IardZwJLOG2NoLgW8QEvqA-1; Mon, 28 Oct 2019 12:38:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5242801E64;
 Mon, 28 Oct 2019 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A83A75C21E;
 Mon, 28 Oct 2019 16:38:06 +0000 (UTC)
Date: Mon, 28 Oct 2019 12:38:04 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 10/26] tests/acceptance: Add test that boots the HelenOS
 microkernel on Leon3
Message-ID: <20191028163804.GE3978@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-11-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-11-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: IardZwJLOG2NoLgW8QEvqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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

On Mon, Oct 28, 2019 at 08:34:25AM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Release notes:
> http://www.helenos.org/wiki/Download#HelenOS0.6.0
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  MAINTAINERS                             |  1 +
>  tests/acceptance/machine_sparc_leon3.py | 37 +++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 tests/acceptance/machine_sparc_leon3.py
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 556ce0bfe3..17ff741c63 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1173,6 +1173,7 @@ S: Maintained
>  F: hw/sparc/leon3.c
>  F: hw/*/grlib*
>  F: include/hw/*/grlib*
> +F: tests/acceptance/machine_sparc_leon3.py
> =20
>  S390 Machines
>  -------------
> diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/m=
achine_sparc_leon3.py
> new file mode 100644
> index 0000000000..a1394ba8ad
> --- /dev/null
> +++ b/tests/acceptance/machine_sparc_leon3.py
> @@ -0,0 +1,37 @@
> +# Functional test that boots a Leon3 machine and checks its serial conso=
le.
> +#
> +# Copyright (c) Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +import os
> +import logging
> +

Those imports are not needed.

> +from avocado import skipIf
> +from avocado_qemu import MachineTest
> +
> +
> +class Leon3Machine(MachineTest):

I have some diverging opinions on the test class rename (which I'll
address as responses to the respective patches), so I've tested this
using the original name and implementation (from avocado_qemu import
Test).

> +
> +    timeout =3D 60
> +
> +    def test_leon3_helenos_uimage(self):
> +        """
> +        :avocado: tags=3Darch:sparc
> +        :avocado: tags=3Dmachine:leon3
> +        :avocado: tags=3Dbinfmt:uimage
> +        """
> +        kernel_url =3D ('http://www.helenos.org/releases/'
> +                      'HelenOS-0.6.0-sparc32-leon3.bin')
> +        kernel_hash =3D 'a88c9cfdb8430c66650e5290a08765f9bf049a30'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +
> +        self.vm.set_machine('leon3_generic')
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_path)
> +
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self,'Copyright (c) 2001-2014 HelenOS p=
roject')
> +        wait_for_console_pattern(self,'Booting the kernel ...')

But this needs an import:

from avocado_qemu import wait_for_console_pattern

> --=20
> 2.21.0
>=20

The core of the test is good, and I've tested it with the changes
listed above, and it runs reliably.

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

Queuing on my python-next branch (and sending shortly in a PR).

Thanks,
- Cleber.


