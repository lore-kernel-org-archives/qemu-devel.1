Received: from eggs.gnu.org ([2001:4830:134:3::10]:40081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxYu-00050L-Rc
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxYs-0000V8-3f
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:38:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxYr-0000Uq-UA
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:38:46 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14A5F7E9C5
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:38:46 +0000 (UTC)
Date: Tue, 24 Jan 2017 09:38:40 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124093840.GD14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/17] aio_context_acquire/release pushdown, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com

On Fri, Jan 20, 2017 at 05:43:05PM +0100, Paolo Bonzini wrote:
> This series pushes down aio_context_acquire/release to the point
> where we can actually reason on using different fine-grained mutexes.
> 
> The main infrastructure is introduced in patch 1.  The new API aio_co_wake
> starts a coroutine with aio_context_acquire/release protection, which
> requires tracking each coroutine's "home" AioContext.  aio_co_schedule
> instead takes care of moving a sleeping coroutine to a different
> AioContext, also ensuring that it runs under aio_context_acquire/release.
> This is useful to implement bdrv_set_aio_context, as a simpler alternative
> to bottom halves.  Even though one-shot BHs are already simpler than
> what we had before, after this patch aio_co_wake and aio_co_schedule
> save you from having to do aio_context_acquire/release explicitly.
> 
> After patch 2 to 4, which are just small preparatory changes, patches
> 5 to 8 provide an example of how to use the new API.  In particular patch
> 5 to 7 implement a new organization of coroutines in the NBD client,
> which allows not blocking on partial reply header reads.

FYI, I added my S-o-B to the two io: patches, so when this series is ready
just include them in your main pull request - no need for me to take those
io: patches separately.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
