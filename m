Received: from eggs.gnu.org ([2001:4830:134:3::10]:33871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duJin-00086J-1L
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duJim-0005aG-6t
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:41:57 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <6cc4a99c-0212-6b7b-4a12-3e898215bea9@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb8d6f5c-ad08-500f-7d89-70d109deaa21@redhat.com>
Date: Tue, 19 Sep 2017 16:41:47 +0200
MIME-Version: 1.0
In-Reply-To: <6cc4a99c-0212-6b7b-4a12-3e898215bea9@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Block Migration and CPU throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: qemu block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

On 19/09/2017 15:36, Peter Lieven wrote:
> Hi,
> 
> I just noticed that CPU throttling and Block Migration don't work
> together very well.
> During block migration the throttling heuristic detects that we
> obviously make no progress
> in ram transfer. But the reason is the running block migration and not a
> too high dirty pages rate.
> 
> The result is that any VM is throttled by 99% during block migration.
> 
> I wonder what the best way would be fix this. I came up with the
> following ideas so far:
> 
> - disable throttling while block migration is in bulk stage
> - check if absolute number of num_dirty_pages_period crosses a threshold
> and not if its just
>   greater than 50% of transferred bytes
> - check if migration_dirty_pages > 0. This slows down throttling, but
> does not avoid it completely.

If you can use nbd-server and drive-mirror for block migration (libvirt
would do it), then you will use multiple sockets and be able to migrate
block and RAM at the same time.

Otherwise, disabling throttling during the bulk stage is the one that
seems nicest and most promising.

Paolo
