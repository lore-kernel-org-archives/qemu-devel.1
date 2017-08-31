Received: from eggs.gnu.org ([2001:4830:134:3::10]:58764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnEHv-0003Fl-SW
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnEHr-0003pt-0b
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:28:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnEHq-0003pc-Pc
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 21:28:50 -0400
Date: Thu, 31 Aug 2017 09:28:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170831012845.GC17741@lemon.lan>
References: <20170818170526.13496-1-apahim@redhat.com>
	<20170818170526.13496-8-apahim@redhat.com>
	<aff4b90a-1109-8fee-43de-1e1f42f893ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aff4b90a-1109-8fee-43de-1e1f42f893ea@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 07/11] qemu.py: include debug
 information on launch error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, stefanha@gmail.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, ldoktor@redhat.com

On Wed, 08/30 11:55, Cleber Rosa wrote:
> 
> 
> On 08/18/2017 01:05 PM, Amador Pahim wrote:
> > When launching a VM, if an exception happens and the VM is not
> > initiated, it might be useful to see the qemu command line and
> > the qemu command output.
> > 
> > This patch creates that message. Notice that self._iolog needs to be
> > cleaned up in the beginning of the launch() to make sure we will not
> > expose the qemu log from a previous launch if the current one fails.
> > 
> > Signed-off-by: Amador Pahim <apahim@redhat.com>
> > ---
> >  scripts/qemu.py | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index 0bcec4b3b1..29fd2469f9 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -147,6 +147,7 @@ class QEMUMachine(object):
> >  
> >      def launch(self):
> >          '''Launch the VM and establish a QMP connection'''
> > +        self._iolog = None
> >          self._qemu_full_args = None
> >          devnull = open(os.path.devnull, 'rb')
> >          qemulog = open(self._qemu_log_path, 'wb')
> > @@ -162,6 +163,13 @@ class QEMUMachine(object):
> >              self._post_launch()
> >          except:
> >              self.shutdown()
> > +
> > +            LOG.debug('Error launching VM')
> > +            if self._qemu_full_args:
> > +                LOG.debug('Command: %r', ' '.join(self._qemu_full_args))
> > +            if self._iolog:
> > +                LOG.debug('Output: %r', self._iolog)
> > +
> 
> Based on Fam's comment about the signal message being a warning (worth
> showing by default), I also think this deserves more than a "debug"
> classification.

Yes, LOG.error, please.

Fam
