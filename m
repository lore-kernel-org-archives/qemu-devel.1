Received: from eggs.gnu.org ([2001:4830:134:3::10]:34649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFIkX-0003Zt-Jj
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFIkW-00042S-O2
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:22:13 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:39552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFIkW-00042M-He
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:22:12 -0400
Date: Mon, 29 May 2017 13:22:11 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170529112211.agqzlngan3dfsrc7@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-22-aurelien@aurel32.net>
	<a0ebc1e0-db39-218e-fcde-9c4563f98b0d@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0ebc1e0-db39-218e-fcde-9c4563f98b0d@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 21/26] target/s390x: implement PACK UNICODE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 2017-05-26 09:35, Richard Henderson wrote:
> On 05/25/2017 02:05 PM, Aurelien Jarno wrote:
> > +        } else if (srclen > ssize) {
> >               b = cpu_ldub_data_ra(env, src, ra) & 0x0f;
> > -            src--;
> > -            srclen--;
> > +            src -= ssize;
> > +            srclen -= ssize;
> 
> Surely we need to use lduw in order to correctly read the big-endian 16-bit
> value, or bias src by +1 to read the low byte of same.

The operands are read from right to left, therefore src is adjusted to
point to the last byte before the for loop:

+    /* The operands are processed from right to left.  */
+    src += srclen - 1;
+    dest += destlen - 1;

Given s390 is big-endian, it means src initially always point to the
low byte independently to the size of the value.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
