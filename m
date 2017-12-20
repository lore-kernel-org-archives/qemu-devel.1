Received: from eggs.gnu.org ([2001:4830:134:3::10]:35173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eRhGV-0007BC-E0
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eRhGU-0004Vs-Iz
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:30:43 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:49256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@weiser.dinsnail.net>)
	id 1eRhGU-0004UX-4M
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:30:42 -0500
Date: Wed, 20 Dec 2017 17:15:56 +0100
From: Michael Weiser <michael.weiser@gmx.de>
Message-ID: <20171220161556.GF15475@weiser.dinsnail.net>
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-6-michael.weiser@gmx.de>
	<6f0ce872-849b-dc5a-25e7-3242a6e5c624@vivier.eu>
	<20171220153715.GC15475@weiser.dinsnail.net>
	<1d8aa1e1-2160-015a-28f5-58baaa51f728@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d8aa1e1-2160-015a-28f5-58baaa51f728@vivier.eu>
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

On Wed, Dec 20, 2017 at 04:56:41PM +0100, Laurent Vivier wrote:

> > Based on that I suspect that qemu-binfmt-conf.sh's current assignment of
> > armeb and aarch64 into the arm CPU family is over-optimistic as well.
> > So I'd suggest treating all of arm, armeb, aarch64 and aarch64_be as
> > separate families.
> So it's not like on intel/AMD where we can execute a 32bit binary on a
> 64bit kernel?

An aarch64 CPU is capable of running arm (i.e. aarch32) code. And I
think this is supported as a multilib setup on Linux. But not in mixed
endianess as far as I know.

Looking at the code again, I'm confused now: Wouldn't the current logic
treat an actual i386 machine as capable of running x86_64 binaries
natively and omit registering the handler for x86_64?

> > Incidentally: I noticed that armeb is missing from qemu_target_list. Is
> > that intentional?
> no. please fix it :)

Will do.

> > Okay?
> It looks good to me.

Based on the above I now lean towards the following assignments:

 arm_family=arm
[...]
-armeb_family=arm
+armeb_family=armeb
[...] 
 aarch64_family=arm
[...]
-aarch64_be_family=arm
+aarch64_be_family=armeb

This would be in line with what you recommended, how i386/x86_64 is
treated and reflects the principal platform capabilities.
-- 
Bye,
Michael
