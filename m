Received: from eggs.gnu.org ([2001:4830:134:3::10]:43252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKyIM-0002q2-NP
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKyIJ-0008S0-Kj
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:49:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fKyIJ-0008Rw-GB
	for qemu-devel@nongnu.org; Mon, 21 May 2018 23:49:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 095F240122A3
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 03:49:03 +0000 (UTC)
Date: Tue, 22 May 2018 11:48:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180522034853.GE17282@xz-mi>
References: <20180412061108.10875-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180412061108.10875-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Apr 12, 2018 at 02:11:08PM +0800, Peter Xu wrote:
> In the future the monitor iothread may be accessing the cur_mon as
> well (via monitor_qmp_dispatch_one()).  Before we introduce a real
> Out-Of-Band command, let's convert the cur_mon variable to be a
> per-thread variable to make sure there won't be a race between threads.
> 
> Note that thread variables are not initialized to a valid value when new
> thread is created.  However for our case we don't need to set it up,
> since the cur_mon variable is only used in such a pattern:
> 
>   old_mon = cur_mon;
>   cur_mon = xxx;
>   (do something, read cur_mon if necessary in the stack)
>   cur_mon = old_mon;
> 
> It plays a role as stack variable, so no need to be initialized at all.
> We only need to make sure the variable won't be changed unexpectedly by
> other threads.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v3:
> - fix code style warning from patchew
> v2:
> - drop qemu-thread changes

Ping?

-- 
Peter Xu
