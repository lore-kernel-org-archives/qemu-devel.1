Received: from eggs.gnu.org ([2001:4830:134:3::10]:33765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhhz8-0003zV-Rq
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhhz5-0007aB-Hz
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:58:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhhz5-0007Ze-BN
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:58:39 -0400
Date: Tue, 15 Aug 2017 16:58:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170815195827.GW3108@localhost.localdomain>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-4-apahim@redhat.com>
	<87zib1s13v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zib1s13v.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v6 3/7] qemu.py: use python logging system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, famz@redhat.com, stefanha@gmail.com, mreitz@redhat.com, crosa@redhat.com

On Tue, Aug 15, 2017 at 10:10:12AM +0200, Markus Armbruster wrote:
> Please spell "Python" with a capital "P" (it's a proper name).
> 
> Amador Pahim <apahim@redhat.com> writes:
> 
> > Let's provide extra control and flexibility by using python logging
> > system instead of print and/or sys.std*.write().
> >
> > Signed-off-by: Amador Pahim <apahim@redhat.com>
> 
> How exactly does this change error messages?
> 
> Is logging the right tool to report errors to the human user?  I'm
> asking because logging and error reporting are generally separate
> things.  Example: a program runs into a recoverable error.  It logs the
> error, but does not report it.
> 
> Is reporting errors to stderr the right thing to do for library class
> QEMUMachine?  I doubt it.  Libraries throw exceptions and let their
> users decide how to handle them.

I believe the "qemu received signal" event is supposed to be
logged, not necessarily reported.  Callers can then choose where
the log messages should go (scripts could choose to send them
directly to stderr if verbose or debugging mode is enabled).  We
don't even need an exception for it: we can let callers check
exitcode() and decide what to do about the QEMU exit code.

The send_fd_scm() messages, on the other hand, could become
exceptions, and don't need the logging system at all.

-- 
Eduardo
