Received: from eggs.gnu.org ([2001:4830:134:3::10]:33151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dcUla-0007x5-9u
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dcUlW-00019t-5H
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:51:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dcUlV-00015b-VQ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:51:06 -0400
Date: Tue, 1 Aug 2017 07:50:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170801105052.GA3108@localhost.localdomain>
References: <20170731085110.1050-1-apahim@redhat.com>
	<20170731085110.1050-3-apahim@redhat.com>
	<20170801100925.GF13521@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170801100925.GF13521@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v6 2/7] qemu.py: fix is_running() return
 before first launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Tue, Aug 01, 2017 at 11:09:25AM +0100, Stefan Hajnoczi wrote:
> On Mon, Jul 31, 2017 at 10:51:05AM +0200, Amador Pahim wrote:
> > is_running() returns None when called before the first time we
> > call launch():
> > 
> >     >>> import qemu
> >     >>> vm = qemu.QEMUMachine('qemu-system-x86_64')
> >     >>> vm.is_running()
> >     >>>
> > 
> > It should retunt False instead. This patch fixes that.
> 
> s/retunt/return/
> 
> > 
> > Signed-off-by: Amador Pahim <apahim@redhat.com>
> > ---
> >  scripts/qemu.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index 2f1984c93c..77565eb092 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -86,7 +86,7 @@ class QEMUMachine(object):
> >              raise
> >  
> >      def is_running(self):
> > -        return self._popen and (self._popen.poll() is None)
> > +        return self._popen is not None and (self._popen.poll() is None)
> 
> The parentheses are inconsistent:
> 
>   return (self._popen is not None) and (self._popen.poll() is None)
> 
> An alternative:
> 
>   return bool(self._popen and self._popen.poll())

is_running() should be True only if self._popen.poll() is None
(and not if it's 0), so the "self._popen.poll() is None" part is
necessary.


-- 
Eduardo
