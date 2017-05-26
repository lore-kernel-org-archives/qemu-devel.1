Received: from eggs.gnu.org ([2001:4830:134:3::10]:51347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dE5Fn-0001kX-8o
	for qemu-devel@nongnu.org; Thu, 25 May 2017 22:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dE5Fk-00047U-5G
	for qemu-devel@nongnu.org; Thu, 25 May 2017 22:45:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dE5Fj-00047H-SO
	for qemu-devel@nongnu.org; Thu, 25 May 2017 22:45:24 -0400
Date: Fri, 26 May 2017 10:45:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170526024512.GD22816@pxdev.xzpeter.org>
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-5-git-send-email-felipe@nutanix.com>
	<20170525010343.GS3873@pxdev.xzpeter.org>
	<EF06A5D3-CEF2-4F56-AC60-6EA2ABFF084A@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EF06A5D3-CEF2-4F56-AC60-6EA2ABFF084A@nutanix.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] migration: use dirty_rate_high_cnt
 more aggressively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On Thu, May 25, 2017 at 11:20:02AM +0000, Felipe Franciosi wrote:
> + Matthew Rosato, original reviewer of 070afca25
> 
> > On 25 May 2017, at 02:03, Peter Xu <peterx@redhat.com> wrote:
> > 
> > On Wed, May 24, 2017 at 05:10:03PM +0100, Felipe Franciosi wrote:
> >> The commit message from 070afca25 suggests that dirty_rate_high_cnt
> >> should be used more aggressively to start throttling after two
> >> iterations instead of four. The code, however, only changes the auto
> >> convergence behaviour to throttle after three iterations. This makes the
> >> behaviour more aggressive by kicking off throttling after two iterations
> >> as originally intended.
> > 
> > For this one, I don't think fixing the code to match the commit
> > message is that important. Instead, for me this patch looks more like
> > something "changed iteration loops from 3 to 2".
> 
> I agree. If we decide a v2 is needed I can amend the commit message accordingly.
> 
> > So the point is, what
> > would be the best practical number for it. And when we change an
> > existing value, we should have some reason, since it'll change
> > behavior of existing user (though I'm not sure whether this one will
> > affect much).
> 
> We've done a few tests with this internally using various workloads (DBs, synthetic mem stress, &c.). In summary, and along the lines with how Qemu implements auto convergence today, I would say this counter should be removed.
> 
> Consider that when live migrating a large-ish VM (100GB+ RAM), the network will be under stress for (at least) several minutes. At the same time, the sole purpose of this counter is to attempt convergence without having to throttle the guest. That is, it defers throttling in the hope that either the guest calms down or that the network gets less congested.
> 
> For real workloads, both cases are unlikely to happen. Throttling will eventually be needed otherwise the migration will not converge.

I am not much experienced with using auto convergence with real
workload, but from what you explained I see it a reasonable change to
even remove it (that sounds more persuasive to me than "just try to
follow what the commit message said", with test results :), especially
considering that we have cpu-throttle-initial and
cpu-throttle-increment parameters as tunables, so we should be fine
even we want to tune the speed down a bit in the future.

> 
> > I believe with higher dirty_rate_high_cnt, we have more smooth
> > throttling, but it'll be slower in responding; While if lower or even
> > remove it, we'll get very fast throttling response speed but I guess
> > it may be more possible to report a false positive?
> 
> With a higher dirty_rate_high_cnt, migration will simply take longer (if not converging). For real workloads, it doesn't change how much throttling is required. For spiky or varied workloads, it gives a chance for migration to converge without throttling, at the cost of massive network stress and a longer overall migration time (which is bad user experience IMO).
> 
> > IMHO here 3 is
> > okay since after all we are solving the problem of unconverged
> > migration, so as long as we can converge, I think it'll be fine.
> 
> Based on 070afca25's commit message, Jason seemed to think that four was too much and meant to change it to two. As explained above, I'd be in favour of removing this counter altogether, or at least make it configurable (perhaps a #define would be enough an improvement for now). This patch is intended as a compromise by effectively using two.

If to be a tunable, maybe another MigrationParameter? But I don't know
whether it would really worth it since the other two can do more
fine-grained tunes already. So I would prefer to remove it as well if
thorough tests are carried out.

Maybe we can also wait to see how other people think about it.

Thanks,

-- 
Peter Xu
