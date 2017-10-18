Received: from eggs.gnu.org ([2001:4830:134:3::10]:58113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4qcO-0003k2-7u
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4qcN-0001TA-8m
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:50:52 -0400
Date: Wed, 18 Oct 2017 11:50:38 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171018155038.GG17962@localhost.localdomain>
References: <cover.1508257445.git.jcody@redhat.com>
	<503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
	<2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
	<20171018150352.GE17962@localhost.localdomain>
	<d3682b70-64c6-1284-77c4-8df561a61098@redhat.com>
	<20171018153416.GF17962@localhost.localdomain>
	<07a69c86-aae3-9174-b646-dee04bf191de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a69c86-aae3-9174-b646-dee04bf191de@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 03/10] qemu-iotests: automatically clean
 up bash protocol servers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

On Wed, Oct 18, 2017 at 05:39:40PM +0200, Paolo Bonzini wrote:
> On 18/10/2017 17:34, Jeff Cody wrote:
> >> Well, I have no idea (hence the "not very constructive" part).  I'm only
> >> "nacking" the sourcing of common.rc in the check script.
> >>
> >> The series improves the harness, but it also sets a very different
> >> separation between the tests and the harness (especially WRT the tests
> >> cleaning up after themselves).  The level of separation would at least
> >> be clearer if check didn't include common.rc.
> >>
> > I can get rid of the common.rc includes prior to running the tests, but this
> > series really requires including common.rc in the spot you mentioned, for
> > automatically cleaning up protocol and QEMU processes.
> 
> Understood, but does it have to be common.rc?  Can it be a different
> file?  That at least would still make it clear what check is doing (for
> example it is not launching qemu, which is part of common.rc).
> 

Here is what we need from common.rc for this series:

_rm_test_img
_cleanup_nbd
_cleanup_vxhs
_cleanup_rbd
_cleanup_sheepdog
_cleanup_protocols
_cleanup_test_img


They all have a common theme (cleanup), so I could move them all to a
common.cleanup (naming suggestion?) file (which would need to be included by
common.rc, as well).

Would this be a strong enough delineation to overcome your concerns?


> > That auto-cleanup is arguably a big improvement, as it has been relatively
> > common to run across tests that leave processes running in the background.
> > 
> > I agree that it sets up different expectations, but that is at least partly
> > intentional.  I don't really want to have to rely on individually written
> > tests to clean up properly. That is ~200 chances (and growing) for a
> > mistake; instead, this series moves that responsibility into a single place
> > to maintain.
> 
> Understood, that's also why I'm all but nacking the entire series!
> 
> Paolo
