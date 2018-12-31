Received: from eggs.gnu.org ([208.118.235.92]:48539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1ge0z4-0001b5-Aw
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 12:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1ge0z1-0007nb-5d
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 12:04:10 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:51568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joseph_myers@mentor.com>)
	id 1ge0z0-0007Rs-Ut
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 12:04:07 -0500
Date: Mon, 31 Dec 2018 17:03:40 +0000
From: Joseph Myers <joseph@codesourcery.com>
In-Reply-To: <ae0530c9-5c46-5560-9734-1eacaf173b8d@linaro.org>
Message-ID: <alpine.DEB.2.21.1812311657050.27287@digraph.polyomino.org.uk>
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
	<957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org>
	<87pntmu9iw.fsf@mid.deneb.enyo.de>
	<ae0530c9-5c46-5560-9734-1eacaf173b8d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org, qemu-devel@nongnu.org, ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de

On Fri, 28 Dec 2018, Adhemerval Zanella wrote:

> >> Currently we only have nios2 and csky (unfortunately).  But since generic 
> >> definition for off_t and off64_t still assumes non-LFS support, all new
> >> 32-bits ports potentially might carry the issue.
> > 
> > For csky, we could still change the type of the non-standard d_off
> > field to long long int.  This way, only telldir would have to fail
> > when truncation is necessary, as mentioned below:
> 
> I think it makes no sense to continue making non-LFS as default for
> newer 32 bits ports, the support will be emulated with LFS syscalls.

Any new 32-bit port that uses 64-bit time_t will also use 64-bit offsets 
(because we don't have any glibc configurations that support the 
combination of 64-bit time with 32-bit offsets, and don't want to add 
them).  That should apply for RISC-V 32-bit at least.

I've filed <https://sourceware.org/bugzilla/show_bug.cgi?id=24050> for 
missing overflow checks in telldir when the default off_t is wider than 
long int (currently just applies to x32; not sure why we don't see glibc 
test failures on x32 resulting from the quiet truncation, as the issue is 
certainly there in the source code).

-- 
Joseph S. Myers
joseph@codesourcery.com
