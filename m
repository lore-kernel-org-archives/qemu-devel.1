Received: from eggs.gnu.org ([2001:4830:134:3::10]:53996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fM3R8-0005qQ-Az
	for qemu-devel@nongnu.org; Thu, 24 May 2018 23:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fM3R4-0002st-8w
	for qemu-devel@nongnu.org; Thu, 24 May 2018 23:30:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fM3R4-0002sN-41
	for qemu-devel@nongnu.org; Thu, 24 May 2018 23:30:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A56FC4023B91
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 03:30:32 +0000 (UTC)
Date: Fri, 25 May 2018 11:30:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180525033022.GK12122@xz-mi>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-5-peterx@redhat.com>
	<20180524092837.GD20733@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524092837.GD20733@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] monitor: add lock to protect
 mon_fdsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, May 24, 2018 at 10:28:37AM +0100, Stefan Hajnoczi wrote:
> On Thu, May 24, 2018 at 12:39:52PM +0800, Peter Xu wrote:
> >  int monitor_fdset_get_fd(int64_t fdset_id, int flags)
> >  {
> > -#ifndef _WIN32
> > +#ifdef _WIN32
> > +    return -ENOENT;
> 
> stubs/fdset.c:monitor_fdset_get_fd() should return -ENOENT instead of -1
> now.

Yes that's intended.  That's actually a suggestion from Markus since
changing the return code will simplify the code.  I mentioned it in
the commit message too:

"""
The monitor_fdset_get_fd() handling is a bit tricky: now we need to call
qemu_mutex_unlock() which might pollute errno, so we need to make sure
the correct errno be passed up to the callers.  To make things simpler,
we let monitor_fdset_get_fd() return the -errno directly when error
happens, then in qemu_open() we translate it back into errno.
"""

Thanks,

-- 
Peter Xu
