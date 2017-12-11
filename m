Received: from eggs.gnu.org ([2001:4830:134:3::10]:51868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eOWDl-0003BR-Aw
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eOWDg-0004JR-C8
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:06:45 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eOWDg-0004Ij-3T
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:06:40 -0500
Date: Mon, 11 Dec 2017 17:06:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171211220638.GA9830@flamenco>
References: <20171208105553.12249-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171208105553.12249-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] Scoped locks using
 attribute((cleanup))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Dec 08, 2017 at 11:55:48 +0100, Paolo Bonzini wrote:
> So I'm a bit underwhelmed by this experiment.  Other opinions?

I am on the same boat. Most use cases in this patchset are arguably
adding more complexity because they substitute already very simple
code (e.g. "lock; do_something; unlock"), as others have pointed out
as well.

I usually deal with tricky cases (i.e. functions with many return
paths) with an inline "__locked" function. In most cases this will
be clearer than using the macros. I concede though that the separate
inline is not always an option.

That said, two comments:

- We might be better off just exposing the cleanup attribute
  via some convenience macros. The systemd codebase does this,
  mostly for freeing memory or closing file descriptors. I suspect
  a large percentage of goto's in our codebase could be eliminated.

  This could be also used for locks, although we'd need a variant
  of mutex_lock that returned the mutex, so that in the cleanup
  function we could just check for NULL.

- Does the cleanup attribute work on all compilers used to build QEMU?
  (I'm thinking of Windows in particular.)

Thanks,

		Emilio
