Received: from eggs.gnu.org ([2001:4830:134:3::10]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dburo-0005dN-4K
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dburj-0007Hx-7U
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:31:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dburj-0007H7-18
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 16:31:07 -0400
Date: Sun, 30 Jul 2017 17:24:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170730202453.GS20793@localhost.localdomain>
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-4-apahim@redhat.com>
	<20170725195104.GT2757@localhost.localdomain>
	<CALAZnb3zrR0PQ26c5e0fud_ofB103oB7mqdNGJq2pEgHh9mO_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAZnb3zrR0PQ26c5e0fud_ofB103oB7mqdNGJq2pEgHh9mO_g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/6] qemu.py: cleanup message on
 negative exit code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>, Daniel Berrange <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>

On Thu, Jul 27, 2017 at 10:21:22AM +0200, Amador Pahim wrote:
> On Tue, Jul 25, 2017 at 9:51 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Tue, Jul 25, 2017 at 07:10:11PM +0200, Amador Pahim wrote:
> >> The message contains the self._args, which has only part of the
> >> options used in the qemu command line and is not representative
> >> enough to figure out what happened to the process.
> >>
> >> This patch drops the self._args part of the message.
> >>
> >> Signed-off-by: Amador Pahim <apahim@redhat.com>
> >
> > I actually think it is a very useful debugging message as is,
> > because the command-line arguments are often all we need to
> > reproduce a QEMU crash.
> 
> The message currently contains only part of the args, not all
> (base_args are not included). Let's include the full command then.
> 
> >
> > That said, sys.stderr.write doesn't belong to the QEMUMachine
> > code, as callers should decide if/when/how/where to print
> > information about a QEMU crash.
> >
> > I think a QEMUCrashed exception class would be the best way to
> > report that to callers.  Including the full QEMU command-line on
> > the exception __str__ method would make it helpful when debugging
> > crashes: existing code that doesn't catch launch() exceptions
> > will crash with a more helpful stack trace, and code that already
> > catches exceptions is probably going to print exception info
> > somewhere.
> 
> I agree using sys.stderr.write should be avoided, but I'm not
> convinced this message should raise an exception. [...]

No problem, we can discuss later when/how to raise exceptions to
indicate specific error cases.

We could make the log message conditional on self._debug by now,
but I don't think it will be a problem if we keep it
unconditional (as QEMU crashes are not supposed to happen under
normal circumstances).

>                                             [...] I think it's time to
> improve the logging capabilities here.

What about using the Python logging module?

-- 
Eduardo
