Received: from eggs.gnu.org ([2001:4830:134:3::10]:35388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f41BA-0005Q5-Hu
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f41B9-0001R5-Kg
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:27:36 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:41201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f41B9-0001Qd-Ez
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:27:35 -0400
Received: by mail-ot0-x233.google.com with SMTP id i28-v6so26482524otf.8
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 02:27:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180405012241.25714-2-f4bug@amsat.org>
References: <20180405012241.25714-1-f4bug@amsat.org>
	<20180405012241.25714-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 10:27:14 +0100
Message-ID: <CAFEAcA9Qvjo680JX1yQRKLdqTcL1r7V42adaQrVDh3ne=jt8WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] memory: Avoid to create tiny RAM
 regions, handled as subpages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>

On 5 April 2018 at 02:22, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> If an user creates a RAM region smaller than TARGET_PAGE_SIZE,
> this region will be handled as a subpage.
> While the subpage behavior can be noticed by an experienced QEMU
> developper, it might takes hours to a novice to figure it out.
> To save time to novices, do not allow subpage creation via the
> memory_region_init_ram_*() functions.

This commit message doesn't make it clear to me what actually
goes wrong. Why doesn't the subpage mechanism do the right thing
here?

Also, a quick grep revealed at least one caller that's currently
creating a less-than-a-page sized RAM block, in
hw/pci-host/xilinx-pcie.c. We would need to change all the
call sites that rely on creating small RAM blocks before we
could make this throw an error. (Better still would be if we
could make small lumps of RAM actually work.)

thanks
-- PMM
