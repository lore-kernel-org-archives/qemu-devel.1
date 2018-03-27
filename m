Received: from eggs.gnu.org ([2001:4830:134:3::10]:52024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0eFU-0000dL-8C
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0eFQ-00040I-57
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:22:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0eFQ-000406-0W
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:22:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 672678151D49
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 02:22:01 +0000 (UTC)
Date: Tue, 27 Mar 2018 10:21:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327022155.GE17789@xz-mi>
References: <20180326061157.24865-1-peterx@redhat.com>
	<20180326104739.GC5267@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180326104739.GC5267@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] iotests: fix wait_until_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, Mar 26, 2018 at 12:47:39PM +0200, Kevin Wolf wrote:
> Am 26.03.2018 um 08:11 hat Peter Xu geschrieben:
> > If there are more than one events, wait_until_completed() might return
> > the 2nd event even if the 1st event is JOB_COMPLETED, since the for loop
> > will continue to run even if completed is set to True.
> > 
> > It never happened before, but it can be triggered when OOB is enabled
> > due to the RESUME startup message. Fix that up by removing the boolean
> > and make sure we return the correct event.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qemu-iotests/iotests.py | 20 ++++++++------------
> >  1 file changed, 8 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> > index b5d7945af8..11704e6583 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -470,18 +470,14 @@ class QMPTestCase(unittest.TestCase):
> >  
> >      def wait_until_completed(self, drive='drive0', check_offset=True):
> >          '''Wait for a block job to finish, returning the event'''
> > -        completed = False
> > -        while not completed:
> > -            for event in self.vm.get_qmp_events(wait=True):
> > -                if event['event'] == 'BLOCK_JOB_COMPLETED':
> > -                    self.assert_qmp(event, 'data/device', drive)
> > -                    self.assert_qmp_absent(event, 'data/error')
> > -                    if check_offset:
> > -                        self.assert_qmp(event, 'data/offset', event['data']['len'])
> > -                    completed = True
> > -
> > -        self.assert_no_active_block_jobs()
> > -        return event
> > +        for event in self.vm.get_qmp_events(wait=True):
> > +            if event['event'] == 'BLOCK_JOB_COMPLETED':
> > +                self.assert_qmp(event, 'data/device', drive)
> > +                self.assert_qmp_absent(event, 'data/error')
> > +                if check_offset:
> > +                    self.assert_qmp(event, 'data/offset', event['data']['len'])
> > +                self.assert_no_active_block_jobs()
> > +                return event
> >  
> >      def wait_ready(self, drive='drive0'):
> >          '''Wait until a block job BLOCK_JOB_READY event'''
> 
> If an event is pending, but it's not the expected event, won't we return
> None now instead of waiting for the BLOCK_JOB_COMPLETED event?

If so, we'll return none.  The patch fixes the other case when there
are two events: one JOB_COMPLETED plus another (e.g., RESUME) event.
When that happens, logically we should return one JOB_COMPLETED event,
but the old code will return the other event (e.g., RESUME).

> 
> Wouldn't it be much easier to just add a 'break'?

Yes, it's the same.  But IMHO those logics (e.g., the completed
variable) are not really needed at all.  This one is simpler.

Or do you want me to post the oneliner that you prefer?

Thanks,

-- 
Peter Xu
