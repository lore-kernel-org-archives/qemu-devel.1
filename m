Received: from eggs.gnu.org ([2001:4830:134:3::10]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtoSd-00043Q-8C
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 01:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtoSa-0000I7-27
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 01:19:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dtoSZ-0000HH-Pb
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 01:19:07 -0400
Date: Mon, 18 Sep 2017 07:18:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170918051858.GA31915@localhost.localdomain>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-5-apahim@redhat.com>
	<20170905030255.GH22515@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170905030255.GH22515@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v8 04/13] qemu.py: improve message on
 negative exit code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Amador Pahim <apahim@redhat.com>, ldoktor@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com, crosa@redhat.com, mreitz@redhat.com

Am 05.09.2017 um 05:02 hat Fam Zheng geschrieben:
> On Fri, 09/01 13:28, Amador Pahim wrote:
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
> > ---
> >  scripts/qemu.py | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index a6e06291ea..670c048569 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -49,6 +49,7 @@ class QEMUMachine(object):
> >          self._iolog = None
> >          self._socket_scm_helper = socket_scm_helper
> >          self._debug = debug
> > +        self._qemu_full_args = None
> >  
> >      # This can be used to add an unused monitor instance.
> >      def add_monitor_telnet(self, ip, port):
> > @@ -140,13 +141,18 @@ class QEMUMachine(object):
> >  
> >      def launch(self):
> >          '''Launch the VM and establish a QMP connection'''
> > +        self._qemu_full_args = None
> >          devnull = open(os.path.devnull, 'rb')
> >          qemulog = open(self._qemu_log_path, 'wb')
> >          try:
> >              self._pre_launch()
> > -            args = self._wrapper + [self._binary] + self._base_args() + self._args
> > -            self._popen = subprocess.Popen(args, stdin=devnull, stdout=qemulog,
> > -                                           stderr=subprocess.STDOUT, shell=False)
> > +            self._qemu_full_args = (self._wrapper + [self._binary] +
> > +                                    self._base_args() + self._args)
> 
> The parentheses seem superfluous. With those removed:
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>

Congratulations, with this advice you just killed all Python-based
qemu-iotests and filled up my inbox with CI failure messages. :-)

+Traceback (most recent call last):
+  File "194", line 22, in <module>
+    import iotests
+  File "/home/kwolf/source/qemu/tests/qemu-iotests/iotests.py", line 27, in <module>
+    import qtest
+  File "/home/kwolf/source/qemu/tests/qemu-iotests/../../scripts/qtest.py", line 16, in <module>
+    import qemu
+  File "/home/kwolf/source/qemu/tests/qemu-iotests/../../scripts/qemu.py", line 196
+    self._qemu_full_args = self._wrapper + [self._binary] +
+                                                          ^
+SyntaxError: invalid syntax

Kevin
