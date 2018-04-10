Received: from eggs.gnu.org ([2001:4830:134:3::10]:42475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5mkA-0008Ky-8N
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5mk7-0003AE-4K
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:27:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f5mk7-0003A4-0M
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:26:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B7C04068059
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 06:26:50 +0000 (UTC)
Date: Tue, 10 Apr 2018 14:26:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180410062639.GD27604@xz-mi>
References: <20180408030542.17855-1-peterx@redhat.com>
	<888b356e-284b-54a5-0646-b6999e0e2c89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <888b356e-284b-54a5-0646-b6999e0e2c89@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: fix wait_until_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Apr 09, 2018 at 09:06:59AM -0500, Eric Blake wrote:
> On 04/07/2018 10:05 PM, Peter Xu wrote:
> > If there are more than one events, wait_until_completed() might return
> > the 2nd event even if the 1st event is JOB_COMPLETED, since the for loop
> > will continue to run even if completed is set to True.
> > 
> > It never happened before, but it can be triggered when OOB is enabled
> > due to the RESUME startup message. Fix that up.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qemu-iotests/iotests.py | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> If you get the other OOB-related bug fixes working, I can include this
> along with those for -rc3 through the qapi tree.  Otherwise, I'm fine
> waiting for this until 2.13.

Hi, Eric,

I think we have settled on the other two fix patches with Stefan,
it'll be good we can include those two patches for 2.12 now (maybe
also together with this one since it's pretty safe).

> 
> 
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -470,18 +470,15 @@ class QMPTestCase(unittest.TestCase):
> >  
> >      def wait_until_completed(self, drive='drive0', check_offset=True):
> >          '''Wait for a block job to finish, returning the event'''
> > -        completed = False
> > -        while not completed:
> > +        while True:
> >              for event in self.vm.get_qmp_events(wait=True):
> 
> Do we really need two loops?  Or can you eliminate the 'while True:'
> loop and rely on just the 'for event...' loop?

Seems not; the old wait_until_completed() will block here if haven't
received the JOB_COMPETE event yet until this point.  Removing the
while loop will let the function return immediately with a None, which
might break the old semantics.  Thanks,

-- 
Peter Xu
