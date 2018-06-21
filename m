Received: from eggs.gnu.org ([2001:4830:134:3::10]:59351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fW63K-0000tk-Ng
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 16:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fW63H-0001et-Fu
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 16:19:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fW63H-0001e9-6e
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 16:19:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5LKJ3p8096412
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 16:19:29 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jrh8yc1b2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 16:19:29 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Thu, 21 Jun 2018 16:19:27 -0400
Date: Thu, 21 Jun 2018 17:19:23 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180621102153.28443-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621102153.28443-1-danielhb413@gmail.com>
Message-Id: <20180621201923.GA27759@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] QGA: systemd
 hibernate/suspend/hybrid-sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com

On Thu, Jun 21, 2018 at 07:21:47AM -0300, Daniel Henrique Barboza wrote:
> changes in v2 from Marc-Andre Lureau review:
> - use error_free() accordingly
> - use g_spawn_sync() instead of fork() in run_process_child()
> - previous version link:
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05499.html
> 
> 
> This series adds systemd suspend support for QGA. Some newer
> guests don't have pmutils anymore, leaving us with just the
> Linux state file mechanism to suspend the guest OS, which does
> not support hybrid-sleep. With this implementation, QGA is
> now able to hybrid suspend newer guests again.
> 
> Most of the patches are cleanups in the existing suspend code,
> aiming at both simplifying it and making it easier to extend
> it with systemd.
> 
> 
> Daniel Henrique Barboza (6):
>   qga: refactoring qmp_guest_suspend_* functions
>   qga: bios_supports_mode: decoupling pm-utils and sys logic
>   qga: guest_suspend: decoupling pm-utils and sys logic
>   qga: removing switch statements, adding run_process_child
>   qga: systemd hibernate/suspend/hybrid-sleep support
>   qga: removing bios_supports_mode

Hi, Daniel.

Your patches look good, just some minor comments about how they're
organized and coding style, if you allow me.

I'd suggest to introduce the new API, functions, and typedef at first
(preferably one thing per patch to easier the review) without wiring
them up.

After the new stuff is ready to use, I'd wire them up (one per patch)
and update/remove old API they're replacing.

Introducing the new API and wiring it up later makes it easier to
review.  For example, bios_supports_mode() is changed by patch 1/6, then
it's moved around by patch 3/6, and finally removed by patch 6/6.

Do we need an empty line after opening a switch statement?  I'd drop it,
as seen in other parts of the code.

Does run_process_child() fit better under util/, or another place where
it can be shared throughout the code, if that's the case?

Cheers
Murilo
