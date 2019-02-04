Received: from eggs.gnu.org ([209.51.188.92]:43258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqjl7-0005Ma-9l
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqjXV-0003ze-EN
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:04:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gqjXV-0003vj-6K
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:04:17 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-34-git-send-email-pbonzini@redhat.com>
	<6e8609da-a198-4457-afc2-88f911261994@redhat.com>
	<20190204154557.GI2306@perard.uk.xensource.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <038db75f-ab55-947d-41ab-54aff32b744b@redhat.com>
Date: Mon, 4 Feb 2019 20:04:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190204154557.GI2306@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 33/52] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>, yang.zhong@intel.com, thuth@redhat.com

On 04/02/19 16:45, Anthony PERARD wrote:
> I've tested the series, and here is the first issue:
>   CC      hw/9pfs/xen-9p-backend.o
>   LINK    i386-softmmu/qemu-system-i386
> /usr/bin/ld: ../hw/xen/xen-legacy-backend.o: in function `xen_be_register_common':
> xen-legacy-backend.c:(.text+0x1cb6): undefined reference to `xen_9pfs_ops'
> 
> The `struct xen_9pfs_ops` is in "xen-9p-backend", so it's built, but
> link time still fails.

Ok, I'll take a look.  My Xen builds were broken until recently.

> Building QEMU with --disable-virtfs works. (Same as commenting out the
> line that uses xen_9pfs_ops in xen-legacy-backend.) Part of the other
> options I have for configure: --enable-xen --target-list=i386-softmmu
> --disable-user --cpu=x86_64
> 
> 
> I did also other build tests and one without --target-list, and that
> fails, but not because of xen:
> $ ./configure --enable-xen
> ...
> $ make
> ...
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     alpha-softmmu/config-devices.mak.tmp
>   GEN     arm-softmmu/config-devices.mak.tmp
>   GEN     cris-softmmu/config-devices.mak.tmp
>   GEN     hppa-softmmu/config-devices.mak.tmp
>   GEN     i386-softmmu/config-devices.mak.tmp
>   GEN     lm32-softmmu/config-devices.mak.tmp
>   GEN     m68k-softmmu/config-devices.mak.tmp
>   GEN     microblaze-softmmu/config-devices.mak.tmp
> undefined symbol ARMSSE_CPUID
> undefined symbol ARMSSE

This is just a rebasing issue, the patches are based on an older master
that didn't have the symbols.

Paiolo
