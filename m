Received: from eggs.gnu.org ([2001:4830:134:3::10]:35889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhIOe-0001sb-MC
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhIOa-0000m4-NW
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:39:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhIOa-0000ll-H4
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:39:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64A0BC000724
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 16:39:15 +0000 (UTC)
Date: Mon, 14 Aug 2017 17:39:08 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170814163908.GG8506@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170814162142.29666-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170814162142.29666-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] trace: fix simpletrace.stp
 flight recorder mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Aug 14, 2017 at 05:21:40PM +0100, Stefan Hajnoczi wrote:
> The SystemTap flight recorder mode no longer works with simpletrace.stp because
> the event ID mapping records are emitted the first time an event fires.
> Chances are, the event ID mapping record will not be in ring buffer when the
> users wants to print the trace.
> 
> This series solves the issue by using the trace-events-all global event
> ordering for event IDs for simpletrace.stp.

I see the way you've written it means it'll still honour the event
id mappings in the header, if present, but I wonder what's the point
of keeping that anymore ? If we need to support this ring-buffer mode,
there's no way we can take advantage of having the ID mappings dynamically
defined - we must always guarantee a stable mapping.

IOW, should we just revert

  commit 7f1b588f20d027730676e627713ae3bbf6baab04
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Tue Oct 4 14:35:50 2016 +0100

    trace: emit name <-> ID mapping in simpletrace header
    
entirely ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
