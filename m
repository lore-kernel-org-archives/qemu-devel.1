Received: from eggs.gnu.org ([2001:4830:134:3::10]:52605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJ3TO-00008b-1C
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJ3TN-000413-De
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:34 -0400
Date: Wed, 16 May 2018 22:56:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180516205626.GI4435@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-15-kwolf@redhat.com>
	<ecc2431e-ee7d-13b7-319e-e69d499330f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc2431e-ee7d-13b7-319e-e69d499330f8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/42] job: Add reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Am 16.05.2018 um 20:17 hat Eric Blake geschrieben:
> On 05/09/2018 11:26 AM, Kevin Wolf wrote:
> > This moves reference counting from BlockJob to Job.
> > 
> > In order to keep calling the BlockJob cleanup code when the job is
> > deleted via job_unref(), introduce a new JobDriver.free callback. Every
> > block job must use block_job_free() for this callback, this is asserted
> > in block_job_create().
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> 
> > +++ b/job.c
> 
> > +
> > +void job_unref(Job *job)
> > +{
> > +    if (--job->refcnt == 0) {
> 
> Should this be free()-like and allow an incoming job == NULL as a no-op?

This behaves like block_job_unref() always behavec, and I don't see a
single caller having a NULL check before calling job_unref(), so is it
worth it?

Kevin
