Received: from eggs.gnu.org ([2001:4830:134:3::10]:55064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dv4FT-000458-49
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dv4FS-0003rw-5N
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:22:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dv4FR-0003pr-TF
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:22:46 -0400
Date: Thu, 21 Sep 2017 09:17:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170921121711.GT3030@localhost.localdomain>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-3-apahim@redhat.com>
	<20170921103508.GB4677@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921103508.GB4677@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v8 02/13] qemu.py: avoid writing to
 stdout/stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, mreitz@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Thu, Sep 21, 2017 at 12:35:08PM +0200, Kevin Wolf wrote:
> Am 01.09.2017 um 13:28 hat Amador Pahim geschrieben:
> > This module should not write directly to stdout/stderr. Instead, it
> > should either raise exceptions or just log the messages and let the
> > callers handle them and decide what to do. For example, scripts could
> > choose to send the log messages stderr or/and write them to a file if
> > verbose or debugging mode is enabled.
> > 
> > This patch replaces the writes to stderr by an exception in the
> > send_fd_scm() when _socket_scm_helper is not set or not present. In the
> > same method, the subprocess Popen will now redirect the stdout/stderr to
> > logging.debug instead of writing to system stderr. As consequence, since
> > the Popen.communicate() is now used (in order to get the stdout), the
> > further call to wait() became redundant and was replaced by
> > Popen.returncode.
> > 
> > The shutdown() message on negative exit code will now be logged
> > to logging.warn instead of written to system stderr.
> > 
> > Signed-off-by: Amador Pahim <apahim@redhat.com>
> > ---
> >  scripts/qemu.py | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> > 
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index 0ae5d39414..aca6fa4d82 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -13,6 +13,7 @@
> >  #
> >  
> >  import errno
> > +import logging
> >  import string
> >  import os
> >  import sys
> > @@ -20,6 +21,15 @@ import subprocess
> >  import qmp.qmp
> >  
> >  
> > +LOG = logging.getLogger(__name__)
> 
> This logger isn't properly initialised, so whenever it would actually be
> used, the only thing that ends up in the qemu-iotests output is:
> 
> +No handlers could be found for logger "qemu"
> 
> The actual error message (that was previously logged to stderr) doesn't
> make it to the output any more.
> 
> I find it sad how the recent test infrastructure "improvements" tend to
> break the tests instead of making them easier to work with. Please be a
> bit more careful when touching this code, and *test* your code before
> you submit it. I expect from anyone that they test their code, but if we
> don't even manage to do that for the tests themselves, I'm losing hope.

Is the test that was broken triggered as part of "make check"?
What can we do to ensure it is?

-- 
Eduardo
