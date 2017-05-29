Received: from eggs.gnu.org ([2001:4830:134:3::10]:42759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFO5q-0006Ru-Hf
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFO5m-0001yJ-J1
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:04:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dFO5m-0001xw-CV
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:04:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07AA381233
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 17:04:29 +0000 (UTC)
Date: Mon, 29 May 2017 14:04:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170529170425.GG32274@thinpad.lan.raisama.net>
References: <20170526181200.17227-1-ehabkost@redhat.com>
	<20170526181200.17227-3-ehabkost@redhat.com>
	<874lw3zjs4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lw3zjs4.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qemu.py: Add QEMUMachine.exitcode()
 method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>

On Mon, May 29, 2017 at 06:53:47PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > Allow the exit code of QEMU to be queried by scripts.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  scripts/qemu.py | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index 16934f1e02..ebe1c4b919 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -88,6 +88,10 @@ class QEMUMachine(object):
> >      def is_running(self):
> >          return self._popen and (self._popen.returncode is None)
> >  
> > +    def exitcode(self):
> > +        if self._popen:
> > +            return self._popen.returncode
> > +
> 
> Falling off the function's end returns None.  Do we really want to rely
> on that?
> 
> For what it's worth, I checked the Python Language Reference, found it
> less than clear, so I tried it out, too.

I agree that the intent may not be clear when looking at the
code.  I can squash this in:

diff --git a/scripts/qemu.py b/scripts/qemu.py
index ebe1c4b919..bf00eddab8 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -89,8 +89,9 @@ class QEMUMachine(object):
         return self._popen and (self._popen.returncode is None)
 
     def exitcode(self):
-        if self._popen:
-            return self._popen.returncode
+        if not self._popen:
+            return None
+        return self._popen.returncode
 
     def get_pid(self):
         if not self.is_running():

-- 
Eduardo
