Received: from eggs.gnu.org ([209.51.188.92]:38998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqgW7-0001YP-9f
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqgRe-0002Hs-TK
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:46:04 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:1251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9310878b0=anthony.perard@citrix.com>)
	id 1gqgRe-0002EJ-JZ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:46:02 -0500
Date: Mon, 4 Feb 2019 15:45:57 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190204154557.GI2306@perard.uk.xensource.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-34-git-send-email-pbonzini@redhat.com>
	<6e8609da-a198-4457-afc2-88f911261994@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e8609da-a198-4457-afc2-88f911261994@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 33/52] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>, yang.zhong@intel.com, thuth@redhat.com

On Thu, Jan 31, 2019 at 10:48:50PM +0100, Philippe Mathieu-Daudé wrote:
> I cc'ed the Xen team, it would be nice if one of them also tests this.

I've tested the series, and here is the first issue:
  CC      hw/9pfs/xen-9p-backend.o
  LINK    i386-softmmu/qemu-system-i386
/usr/bin/ld: ../hw/xen/xen-legacy-backend.o: in function `xen_be_register_common':
xen-legacy-backend.c:(.text+0x1cb6): undefined reference to `xen_9pfs_ops'

The `struct xen_9pfs_ops` is in "xen-9p-backend", so it's built, but
link time still fails.

Building QEMU with --disable-virtfs works. (Same as commenting out the
line that uses xen_9pfs_ops in xen-legacy-backend.) Part of the other
options I have for configure: --enable-xen --target-list=i386-softmmu
--disable-user --cpu=x86_64


I did also other build tests and one without --target-list, and that
fails, but not because of xen:
$ ./configure --enable-xen
...
$ make
...
  GEN     aarch64-softmmu/config-devices.mak.tmp
  GEN     alpha-softmmu/config-devices.mak.tmp
  GEN     arm-softmmu/config-devices.mak.tmp
  GEN     cris-softmmu/config-devices.mak.tmp
  GEN     hppa-softmmu/config-devices.mak.tmp
  GEN     i386-softmmu/config-devices.mak.tmp
  GEN     lm32-softmmu/config-devices.mak.tmp
  GEN     m68k-softmmu/config-devices.mak.tmp
  GEN     microblaze-softmmu/config-devices.mak.tmp
undefined symbol ARMSSE_CPUID
undefined symbol ARMSSE
Traceback (most recent call last):
  File "/var/tmp/qemu.rjWNchMAI4/qemu/scripts/minikconf.py", line 680, in <module>
    config = data.compute_config()
  File "/var/tmp/qemu.rjWNchMAI4/qemu/scripts/minikconf.py", line 214, in compute_config
    raise Exception(parser, "there were undefined symbols")
Exception: (<__main__.KconfigParser instance at 0x7f635c24e200>, 'there were undefined symbols')
undefined symbol ARMSSE_CPUID
undefined symbol ARMSSE
Traceback (most recent call last):
  File "/var/tmp/qemu.rjWNchMAI4/qemu/scripts/minikconf.py", line 680, in <module>
    config = data.compute_config()
  File "/var/tmp/qemu.rjWNchMAI4/qemu/scripts/minikconf.py", line 214, in compute_config
    raise Exception(parser, "there were undefined symbols")
Exception: (<__main__.KconfigParser instance at 0x7fd4d2374248>, 'there were undefined symbols')

...

make: *** No rule to make target 'aarch64-softmmu/config-devices.mak', needed by 'config-all-devices.mak'.  Stop.
make: *** Waiting for unfinished jobs....

Cheers,

-- 
Anthony PERARD
