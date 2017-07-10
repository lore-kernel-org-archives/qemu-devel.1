Received: from eggs.gnu.org ([2001:4830:134:3::10]:60119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUPjR-0000Nl-7E
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 23:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUPjO-0002kv-0U
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 23:51:33 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUPjN-0002kj-OF
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 23:51:29 -0400
Date: Sun, 9 Jul 2017 23:51:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170710035128.GA25231@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-23-git-send-email-cota@braap.org>
	<5b3531bf-5e06-f5d3-6ba0-6a0baa810cee@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3531bf-5e06-f5d3-6ba0-6a0baa810cee@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 22/22] translate-all: do not hold tb_lock
 during code generation in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Sun, Jul 09, 2017 at 11:38:50 -1000, Richard Henderson wrote:
> On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
(snip)
> I think it would be better to have a tb_htable_lookup_or_insert function,
> which performs the insert iff a matching object isn't already there,
> returning the entry which *is* there in either case.

qht_insert behaves exactly like this, except that it returns a bool.
But we could make it return a void *.

> The hash table already has per-bucket locking.  So here you're taking 3
> locks (tb_lock, bucket lock for lookup, bucket lock for insert) instead of
> just taking the bucket lock once.  And, recall, the htable is designed such
> that the buckets do not contend often, so you ought to be eliminating most
> of the contention that you're seeing on tb_lock.

Minor nit: the lookup is just a seqlock_read, so it's not really a lock.

Your point is correct though. Performing a lookup here (that qht_insert
will do anyway) is wasteful. I didn't look further into this because I
thought getting rid of tb_lock here (due to tb_link_page) wasn't trivial.
But I'll look into it; if we manage to just have the lock in qht_insert,
we'll get great scalability.

		E.
