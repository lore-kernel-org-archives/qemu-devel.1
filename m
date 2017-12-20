Received: from eggs.gnu.org ([2001:4830:134:3::10]:46661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eRl0k-0004ne-2r
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eRl0j-0006AM-8m
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:30:42 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:49702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@weiser.dinsnail.net>)
	id 1eRl0j-00069j-2T
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:30:41 -0500
Date: Wed, 20 Dec 2017 21:29:18 +0100
From: Michael Weiser <michael.weiser@gmx.de>
Message-ID: <20171220202918.GA18146@weiser.dinsnail.net>
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-6-michael.weiser@gmx.de>
	<6f0ce872-849b-dc5a-25e7-3242a6e5c624@vivier.eu>
	<20171220153715.GC15475@weiser.dinsnail.net>
	<1d8aa1e1-2160-015a-28f5-58baaa51f728@vivier.eu>
	<20171220161556.GF15475@weiser.dinsnail.net>
	<bcf948cb-fe73-bc72-5e93-b776740fa80d@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf948cb-fe73-bc72-5e93-b776740fa80d@vivier.eu>
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

On Wed, Dec 20, 2017 at 05:43:34PM +0100, Laurent Vivier wrote:

> >> So it's not like on intel/AMD where we can execute a 32bit binary on a
> >> 64bit kernel?
> > 
> > An aarch64 CPU is capable of running arm (i.e. aarch32) code. And I
> > think this is supported as a multilib setup on Linux. But not in mixed
> > endianess as far as I know.
> > 
> > Looking at the code again, I'm confused now: Wouldn't the current logic
> > treat an actual i386 machine as capable of running x86_64 binaries
> > natively and omit registering the handler for x86_64?
> - on 32bit machine, we don't register the interpreter because the
> interpreter cannot work,

Okay, makes sense.

Meanwhile I verified that a little-endian arm kernel indeed refuses to
run a statically linked big-endian arm binary and vice-versa with
ENOEXEC ("Exec format error").

Looking at fs/binfmt_elf.c of the kernel, I understand that the kernel
makes no attempt to adjust for binary images of differing endianness.
Because the e_type ELF header field is byte-swapped in the big-endian
arm ELF binary, the kernel will see an invalid executable type and
return ENOEXEC.

Based on this I'm reasonably sure that a mixed little-/big-endian
userland is not currently possible on Linux. So I've gone with the
arm/armeb family split.

I'll push out a new version of the patch series with all the discussed
changes in a minute.
-- 
Bye,
Michael
