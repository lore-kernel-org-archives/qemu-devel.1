Received: from eggs.gnu.org ([2001:4830:134:3::10]:53630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk0bB-0005VY-Ir
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dk0b8-0003dH-EG
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:15:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dk0b8-0003cj-7b
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:15:26 -0400
Date: Tue, 22 Aug 2017 12:15:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170822041519.GC2146@lemon>
References: <1503301464-27886-1-git-send-email-peterx@redhat.com>
	<20170821085851.GA4371@lemon>
	<20170821100555.GC30356@pxdev.xzpeter.org>
	<20170821135743.GC4371@lemon> <20170821153622.GG2231@work-vm>
	<20170821165450.GE4371@lemon> <20170821172852.GA3236@work-vm>
	<20170822021556.GA2146@lemon>
	<20170822025654.GE30356@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822025654.GE30356@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 0/6] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 08/22 10:56, Peter Xu wrote:
> I haven't really encountered (c), but I think it's the migrate_cancel
> command that matters, which should not need BQL as well.

There is bdrv_invalidate_cache_all() in migrate_cancel which clearly isn't safe.
Is that if block unreachable in this case? If so we should assert, otherwise
this command is not okay to run without BQL.

Generically, what guarantee the thread-safety of a qmp command when you decide
BQL is not needed? In other words, how do you prove commands are safe without
BQL? I think almost every command accesses global state, but lock-free data
structures are rare AFAICT.

Fam
