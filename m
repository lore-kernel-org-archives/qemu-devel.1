Received: from eggs.gnu.org ([2001:4830:134:3::10]:38674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejjbD-0003wi-5b
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejjb9-00025l-TG
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:38:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ejjb9-00025Q-Oo
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:38:35 -0500
Date: Thu, 8 Feb 2018 18:38:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180208103830.GA23592@xz-mi>
References: <20180208103132.28452-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180208103132.28452-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/28] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Feb 08, 2018 at 06:31:04PM +0800, Peter Xu wrote:

[...]

> 6. On source, manually trigger a "fake network down" using
>    "migrate-cancel" command:
> 
>   {"execute": "migrate_cancel"}
>   {"return": {}}
> 
>   During postcopy, it'll not really cancel the migration, but pause
>   it.  On both sides, we should see this on stderr:
> 
>   qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
> 
>   It means now both sides are in postcopy-pause state.

Sorry I forgot to update this part.  We need to use migrate-pause in
this version to explicitly pause the migration.  If on source:

  { "execute": "migrate-pause" }

If on destination, don't forget to run with OOB:

  { "execute": "migrate-pause", "id": "pause-cmd",
    "control": { "run-oob": true } }

-- 
Peter Xu
