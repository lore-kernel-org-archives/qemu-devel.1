Received: from eggs.gnu.org ([2001:4830:134:3::10]:43354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dtuVW-0003pe-Is
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dtuVT-0000tU-GV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:46:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dtuVT-0000sn-8B
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:46:31 -0400
Date: Mon, 18 Sep 2017 08:46:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170918114623.GG10621@localhost.localdomain>
References: <20170915233739.26860-1-ehabkost@redhat.com>
	<20170915233739.26860-15-ehabkost@redhat.com>
	<20170918094400.GC2951@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918094400.GC2951@redhat.com>
Subject: Re: [Qemu-devel] [PULL 14/15] qemu.py: improve message on negative
 exit code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Sep 18, 2017 at 10:44:00AM +0100, Daniel P. Berrange wrote:
> On Fri, Sep 15, 2017 at 08:37:38PM -0300, Eduardo Habkost wrote:
> > From: Amador Pahim <apahim@redhat.com>
> > 
> > The current message shows 'self._args', which contains only part of the
> > options used in the Qemu command line.
> > 
> > This patch makes the qemu full args list an instance variable and then
> > uses it in the negative exit code message.
> > 
> > Message was moved outside the 'if is_running' block to make sure it will
> > be logged if the VM finishes before the call to shutdown().
> > 
> > Signed-off-by: Amador Pahim <apahim@redhat.com>
> > Message-Id: <20170901112829.2571-5-apahim@redhat.com>
> > [ehabkost: removed superfluous parenthesis]
> > Reviewed-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  scripts/qemu.py | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index c9bcaafe41..9440261ac3 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -87,6 +87,7 @@ class QEMUMachine(object):
> >          self._socket_scm_helper = socket_scm_helper
> >          self._debug = debug
> >          self._qmp = None
> > +        self._qemu_full_args = None
> >  
> >      def __enter__(self):
> >          return self
> > @@ -186,13 +187,16 @@ class QEMUMachine(object):
> >  
> >      def launch(self):
> >          '''Launch the VM and establish a QMP connection'''
> > +        self._qemu_full_args = None
> >          devnull = open(os.path.devnull, 'rb')
> >          qemulog = open(self._qemu_log_path, 'wb')
> >          try:
> >              self._pre_launch()
> > -            args = (self._wrapper + [self._binary] + self._base_args() +
> > -                    self._args)
> > -            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
> > +            self._qemu_full_args = self._wrapper + [self._binary] +
> > +                                    self._base_args() + self._args
> 
> FYI, this change causes a syntax error because you need either the ()
> brackets, or an explicit \ continuation. Unfortunately this wasn't
> caught by Peter's merge tests, since this code is only execised by
> the qemu iotests which aren't run from a 'make check'.
> 
> If someone has cycles, it would be great to write some unit tests
> directly targetting the qemu.py and qmp.py code, so that we get test
> coverage of it independantly of the iotest execution.

Oops, sorry!  I thought "make check" was exercising that code
path.

-- 
Eduardo
