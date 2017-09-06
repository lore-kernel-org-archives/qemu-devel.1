Received: from eggs.gnu.org ([2001:4830:134:3::10]:40463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpbfF-0006FC-8F
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpbfC-0001SN-Mf
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dpbfC-0001S1-G5
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:50:46 -0400
Received: by mail-wm0-x243.google.com with SMTP id e64so5509940wmi.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:50:46 -0700 (PDT)
Date: Wed, 6 Sep 2017 15:50:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170906145043.GG15535@stefanha-x1.localdomain>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503471071-2233-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Aug 23, 2017 at 02:51:03PM +0800, Peter Xu wrote:
> The root problem is that, monitor commands are all handled in main
> loop thread now, no matter how many monitors we specify. And, if main
> loop thread hangs due to some reason, all monitors will be stuck.

I see a larger issue with postcopy: existing QEMU code assumes that
guest memory access is instantaneous.

Postcopy breaks this assumption and introduces blocking points that can
now take unbounded time.

This problem isn't specific to the monitor.  It can also happen to other
components in QEMU like the gdbstub.

Do we need an asynchronous memory API?  Synchronous memory access should
only be allowed in vcpu threads.

Stefan
