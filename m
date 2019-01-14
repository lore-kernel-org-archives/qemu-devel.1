Received: from eggs.gnu.org ([209.51.188.92]:56694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gizqF-0004H6-Bx
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gizqE-0002np-NI
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:51:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gizqE-0002ip-F5
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:51:38 -0500
Date: Mon, 14 Jan 2019 10:51:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190114105132.GA2524@work-vm>
References: <e5021228-184b-cc1b-7aba-3bba795127a6@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5021228-184b-cc1b-7aba-3bba795127a6@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] 3.1: second invocation of migrate crashes qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, quintela@redhat.com, kwolf@redhat.com
Cc: qemu-devel <qemu-devel@nongnu.org>

* Michael Tokarev (mjt@tls.msk.ru) wrote:
> $ qemu-system-x86_64 -monitor stdio -hda foo.img
> QEMU 3.1.0 monitor - type 'help' for more information
> (qemu) stop
> (qemu) migrate "exec:cat >/dev/null"
> (qemu) migrate "exec:cat >/dev/null"
> qemu-system-x86_64: /build/qemu/qemu-3.1/block.c:4647: bdrv_inactivate_recurse: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
> Aborted

And on head as well;  it only happens if the 1st migrate is succesful;
if it got cancelled the 2nd one works, so it's not too bad.

I suspect the problem here is all around locking/ownership - the block
devices get shutdown at the end of migration since the assumption is
that the other end has them open now and we had better release them.

Dave

> (it is irrelevant what's in foo.img, it only needs to be initialized).
> 
> If it is worth to bisect I'll do that tomorrow.
> 
> Thanks,
> 
> /mjt
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
