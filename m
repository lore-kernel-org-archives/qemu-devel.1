Received: from eggs.gnu.org ([2001:4830:134:3::10]:33942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOEwP-0005Z3-K2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOEwM-0000Tc-E2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:11:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fOEwM-0000TF-A3
	for qemu-devel@nongnu.org; Thu, 31 May 2018 00:11:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36690401EF07
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 04:11:53 +0000 (UTC)
Date: Thu, 31 May 2018 12:11:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180531041147.GK27442@xz-mi>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-6-peterx@redhat.com>
	<20180530163552.GG5973@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180530163552.GG5973@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v9 5/7] monitor: remove event_clock_type
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

On Wed, May 30, 2018 at 05:35:52PM +0100, Stefan Hajnoczi wrote:
> On Tue, May 29, 2018 at 01:57:53PM +0800, Peter Xu wrote:
> > Instead, use a dynamic function to detect which clock we'll use.  The
> > problem is that the old code will let monitor initialization depends on
> > qtest_enabled().  After this change, we don't have such a dependency any
> > more.
> 
> There is a hidden dependency:
> 
>   monitor_get_clock() returns the wrong value before main() has
>   processed command-line arguments.

To be more explicit:

    monitor_get_clock() returns the wrong value before accelerator is
    correctly setup (in configure_accelerator()).

Since the only thing that matters here is whether we're using the
qtest accelerator.

> 
> Where is the guarantee that monitor_get_clock() is never called too
> early?

You are right, there is no guarantee except from programming POV.
It's only used in:

  monitor_qapi_event_queue
  monitor_qapi_event_handler

These two functions will never be called until accelerator is setup.

> 
> At the least, monitor_get_clock() should call abort(3) if invoked too
> early.  Even better would be an interface that cannot be used
> incorrectly.

Maybe then I should export the accel_initialised variable in
configure_accelerator() and then I assert with that.  But that'll
further expand the series a bit.

Or, I can also mention above in the commit message to explain that a
bit.

What would you prefer?

Thanks,

-- 
Peter Xu
