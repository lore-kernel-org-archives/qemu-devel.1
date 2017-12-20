Received: from eggs.gnu.org ([208.118.235.92]:47339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eRgn5-0004rC-2l
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eRgn3-0006d9-P5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:00:18 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:49180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@weiser.dinsnail.net>)
	id 1eRgn3-0006YC-6R
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:00:17 -0500
Date: Wed, 20 Dec 2017 16:37:15 +0100
From: Michael Weiser <michael.weiser@gmx.de>
Message-ID: <20171220153715.GC15475@weiser.dinsnail.net>
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-6-michael.weiser@gmx.de>
	<6f0ce872-849b-dc5a-25e7-3242a6e5c624@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0ce872-849b-dc5a-25e7-3242a6e5c624@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] linux-user: Add aarch64_be magic
 numbers to qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Hi Laurent,

On Wed, Dec 20, 2017 at 03:18:34PM +0100, Laurent Vivier wrote:

> > +aarch64_be_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7'
> > +aarch64_be_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
> > +aarch64_be_family=arm

> You need a different family, something like "armbe", to let
> qemu_set_binfmts() registers aarch64_be on aarch64 and vice-versa.

> The principle is binaries of a given family can be executed natively on
> the host of the same family, so we don't want to register a binfmt
> handler. Is that the case between aarch64 and arch64_be?

Right, while the CPU certainly is capable of switching endianess on the
fly I'm not sure if there is any multilib/multiarch userland setup and
kernel interface that would support mixed little/big-endianess of
arm or aarch64 binaries. Even if, it would likely need further detection
in the script to make sure it's there.

Based on that I suspect that qemu-binfmt-conf.sh's current assignment of
armeb and aarch64 into the arm CPU family is over-optimistic as well.
So I'd suggest treating all of arm, armeb, aarch64 and aarch64_be as
separate families.

Incidentally: I noticed that armeb is missing from qemu_target_list. Is
that intentional?

How about the following changes, maybe split into two patches "add
armeb" and "separate ARM CPU families"?

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index d69953525c..69ebfe7a6e 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -2,7 +2,7 @@
 # enable automatic i386/ARM/M68K/MIPS/SPARC/PPC/s390/HPPA
 # program execution by the kernel
 
-qemu_target_list="i386 i486 alpha arm sparc32plus ppc ppc64 ppc64le m68k \
+qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
 mips mipsel mipsn32 mipsn32el mips64 mips64el \
 sh4 sh4eb s390x aarch64 aarch64_be hppa"
 
@@ -24,7 +24,7 @@ arm_family=arm
 
 armeb_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28'
 armeb_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
-armeb_family=arm
+armeb_family=armeb
 
 sparc_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x02'
 sparc_mask='\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
@@ -90,11 +90,11 @@ s390x_family=s390x
 
 aarch64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7\x00'
 aarch64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
-aarch64_family=arm
+aarch64_family=aarch64
 
 aarch64_be_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7'
 aarch64_be_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
-aarch64_be_family=arm
+aarch64_be_family=aarch64_be
 
 hppa_magic='\x7f\x45\x4c\x46\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x0f'
 hppa_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'

Okay?
-- 
bye, Michael
