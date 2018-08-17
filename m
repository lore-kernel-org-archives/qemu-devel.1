Received: from eggs.gnu.org ([2001:4830:134:3::10]:46456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqf6O-0006c3-Tm
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqf6O-0003g4-4y
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:47:44 -0400
Date: Fri, 17 Aug 2018 10:47:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180817134727.GC15372@localhost.localdomain>
References: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
	<1534440027-10528-4-git-send-email-vsementsov@virtuozzo.com>
	<20180817015429.GW15372@localhost.localdomain>
	<deec540b-aaf7-4f8d-5c9f-0684fb2b9b34@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deec540b-aaf7-4f8d-5c9f-0684fb2b9b34@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] scripts/qemu: add render_block_graph
 method for QEMUMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, crosa@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

On Fri, Aug 17, 2018 at 01:08:42PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 17.08.2018 04:54, Eduardo Habkost wrote:
> > On Thu, Aug 16, 2018 at 08:20:26PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Render block nodes graph with help of graphviz
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Thanks for your patch.  Comments below:
> > 
> > > ---
> > >   scripts/qemu.py | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 53 insertions(+)
> > > 
> > > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > > index f099ce7278..cff562c713 100644
> > > --- a/scripts/qemu.py
> > > +++ b/scripts/qemu.py
> > > @@ -460,3 +460,56 @@ class QEMUMachine(object):
> > >                                                    socket.SOCK_STREAM)
> > >               self._console_socket.connect(self._console_address)
> > >           return self._console_socket
> > > +
> > > +    def render_block_graph(self, filename):
> > > +        '''
> > > +        Render graph in text (dot) representation into "filename" and graphical
> > > +        representation into pdf file "filename".pdf
> > > +        '''
> > > +
> > > +        try:
> > > +            from graphviz import Digraph
> > I'm not convinced that this belongs to qemu.py, if most code
> > using the qemu.py module will never use it.  Do you see any
> > problem in moving this code to a scripts/render_block_graph.py
> > script?
> 
> Not a problem, I can do it.. Just one thought:
> Isn't it better to keep all function doing something with one vm as methods,
> not separate functions?

I don't think so.  We don't need to create a new QEMUMachine
method every time we write a function that takes a QEMUMachine as
argument in our scripts.

There are cases when we're forced to create a method: when the
new code is tightly coupled to the QEMUMachine code and need
access to its private attributes.

There are cases where we probably want to place the code in
qemu.py (as a method): when we expect many users of qemu.py to
call it.

But in other cases, I don't see any problem with another
script/module having a regular function like:

  def my_special_purpose_function(vm, ...):
     ...


-- 
Eduardo
