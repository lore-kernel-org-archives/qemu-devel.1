Received: from eggs.gnu.org ([2001:4830:134:3::10]:39701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1em1y1-00029M-UA
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1em1xy-0004OR-RE
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:39:41 -0500
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:36762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1em1xy-0004OG-Id
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:39:38 -0500
Received: by mail-qk0-x230.google.com with SMTP id 15so27875214qkl.3
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:39:38 -0800 (PST)
Date: Wed, 14 Feb 2018 13:39:35 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20180214183935.GA11088@morn.lan>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212204609.GB30111@morn.lan>
	<b2725975-6823-8919-e937-56d8cb404372@linux.vnet.ibm.com>
	<e8cf7f36-249f-a3cc-f414-fac4e8b56b51@redhat.com>
	<20180213193758.GA21083@morn.lan>
	<17e5dd66-e54d-56a3-7852-daf5bc11b741@redhat.com>
	<ead467f1-ab61-6350-e0bf-66ce0cbb06a1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ead467f1-ab61-6350-e0bf-66ce0cbb06a1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Laszlo Ersek <lersek@redhat.com>, marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, Igor Mammedov <imammedo@redhat.com>

On Tue, Feb 13, 2018 at 03:29:20PM -0500, Stefan Berger wrote:
[...]
> In these 0x400 bytes we have 256 bytes that are used for configuration flags
> describing the supported opcode as you previously described. This array
> allows us to decouple the firmware implementation from the ACPI code and we
> need not hard code what is supported in the firmware inside the ACPI code
> (which would be difficult to do anyway since in QEMU we would not what
> firmware will be started and what PPI opcodes are support) and the ppi sysfs
> entries in Linux for example show exactly those PPI opcodes that are
> supported. The firmware needs to set those flags and the firmware knows what
> it supports.
> 
> I hope we can settle that this device is the right path.

It seems that the primary purpose of the 0x400 virtual device is to
pass information from firmware to QEMU (specifically to pass the list
of supported PPI opcodes to the QEMU generated AML code).  Passing
information between firmware and QEMU is not new territory, and fw_cfg
was specifically built to do this.  I'd prefer to use fw_cfg if we
need to pass information between firmware and QEMU.

That said, I don't see why this list is needed - why not just
implement the same opcodes in both UEFI and SeaBIOS and be done with
it?  The spec defines 22 actions, and most of these are permutations
of 4 basic features (Enable, Activate, Clear, SetOwnerInstall).

[...]
> I initially had PPI SeaBIOS code write into the TPM TIS device's memory into
> some custom addresses. I'd consider this a hack.

Well, sure, it could be considered a hack.  But, it seems to me the
whole PPI spec is a bit of a hack.  If elegance isn't an option,
settle for simplicity?

-Kevin
