Received: from eggs.gnu.org ([2001:4830:134:3::10]:35982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3XRw-00057o-DB
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 21:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f3XRt-00017K-A8
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 21:42:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f3XRt-000177-3u
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 21:42:53 -0400
Date: Wed, 4 Apr 2018 09:42:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180404014241.GG26441@xz-mi>
References: <20180326061157.24865-1-peterx@redhat.com>
	<20180326104739.GC5267@localhost.localdomain>
	<20180327022155.GE17789@xz-mi>
	<20180403125918.GF4467@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403125918.GF4467@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH] iotests: fix wait_until_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Apr 03, 2018 at 01:59:18PM +0100, Stefan Hajnoczi wrote:
> On Tue, Mar 27, 2018 at 10:21:55AM +0800, Peter Xu wrote:
> > On Mon, Mar 26, 2018 at 12:47:39PM +0200, Kevin Wolf wrote:
> > > Am 26.03.2018 um 08:11 hat Peter Xu geschrieben:
> > > > If there are more than one events, wait_until_completed() might return
> > > > the 2nd event even if the 1st event is JOB_COMPLETED, since the for loop
> > > > will continue to run even if completed is set to True.
> > > > 
> > > > It never happened before, but it can be triggered when OOB is enabled
> > > > due to the RESUME startup message. Fix that up by removing the boolean
> > > > and make sure we return the correct event.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  tests/qemu-iotests/iotests.py | 20 ++++++++------------
> > > >  1 file changed, 8 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> > > > index b5d7945af8..11704e6583 100644
> > > > --- a/tests/qemu-iotests/iotests.py
> > > > +++ b/tests/qemu-iotests/iotests.py
> > > > @@ -470,18 +470,14 @@ class QMPTestCase(unittest.TestCase):
> > > >  
> > > >      def wait_until_completed(self, drive='drive0', check_offset=True):
> > > >          '''Wait for a block job to finish, returning the event'''
> > > > -        completed = False
> > > > -        while not completed:
> > > > -            for event in self.vm.get_qmp_events(wait=True):
> > > > -                if event['event'] == 'BLOCK_JOB_COMPLETED':
> > > > -                    self.assert_qmp(event, 'data/device', drive)
> > > > -                    self.assert_qmp_absent(event, 'data/error')
> > > > -                    if check_offset:
> > > > -                        self.assert_qmp(event, 'data/offset', event['data']['len'])
> > > > -                    completed = True
> > > > -
> > > > -        self.assert_no_active_block_jobs()
> > > > -        return event
> > > > +        for event in self.vm.get_qmp_events(wait=True):
> > > > +            if event['event'] == 'BLOCK_JOB_COMPLETED':
> > > > +                self.assert_qmp(event, 'data/device', drive)
> > > > +                self.assert_qmp_absent(event, 'data/error')
> > > > +                if check_offset:
> > > > +                    self.assert_qmp(event, 'data/offset', event['data']['len'])
> > > > +                self.assert_no_active_block_jobs()
> > > > +                return event
> > > >  
> > > >      def wait_ready(self, drive='drive0'):
> > > >          '''Wait until a block job BLOCK_JOB_READY event'''
> > > 
> > > If an event is pending, but it's not the expected event, won't we return
> > > None now instead of waiting for the BLOCK_JOB_COMPLETED event?
> > 
> > If so, we'll return none.
> 
> Kevin is pointing out that this patch is broken.  Previously the
> function waited for BLOCK_JOB_COMPLETED, even when other events were
> pending when we entered the function.  Now it returns None and does not
> wait for BLOCK_JOB_COMPLETED!

Aha!  Surely I missed that. :)

> 
> > The patch fixes the other case when there
> > are two events: one JOB_COMPLETED plus another (e.g., RESUME) event.
> > When that happens, logically we should return one JOB_COMPLETED event,
> > but the old code will return the other event (e.g., RESUME).
> > 
> > > 
> > > Wouldn't it be much easier to just add a 'break'?
> > 
> > Yes, it's the same.  But IMHO those logics (e.g., the completed
> > variable) are not really needed at all.  This one is simpler.
> 
> No, the outer loop is needed so that the function waits until
> BLOCK_JOB_COMPLETED is received.  It's not possible to do it with a
> single for loop.

Indeed.  But then I would still slightly prefer removing the
"completed" var:

    def wait_until_completed(self, drive='drive0', check_offset=True):
        '''Wait for a block job to finish, returning the event'''
        while True:
            for event in self.vm.get_qmp_events(wait=True):
                if event['event'] == 'BLOCK_JOB_COMPLETED':
                    self.assert_qmp(event, 'data/device', drive)
                    self.assert_qmp_absent(event, 'data/error')
                    if check_offset:
                        self.assert_qmp(event, 'data/offset', event['data']['len'])
                    self.assert_no_active_block_jobs()
                    return event

Or a single break would work too.  Do either of you have any
preference?  I can repost in either way.  Thanks,

-- 
Peter Xu
