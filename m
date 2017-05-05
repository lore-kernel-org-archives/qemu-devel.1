Received: from eggs.gnu.org ([2001:4830:134:3::10]:47956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d6dx7-0003CF-Qd
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d6dx3-0001LN-Pl
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d6dx3-0001LB-G4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:11:21 -0400
Date: Fri, 5 May 2017 15:11:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170505141113.GA3293@work-vm>
References: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170428065754eucas1p1f51713373ce8c2d19945a4f91c52bd5c@eucas1p1.samsung.com>
	<1493362658-8179-5-git-send-email-a.perevalov@samsung.com>
	<20170428093825.GA22801@pxdev.xzpeter.org>
	<3a95fb33-f496-7e9d-50cb-6286d23dbdf6@samsung.com>
	<20170428100700.GC22801@pxdev.xzpeter.org>
	<20170428162205.GE3276@work-vm>
	<20170429091634.GA6721@aperevalov-ubuntu>
	<20170502085143.GA2072@work-vm>
	<20170504130949.GA20340@aperevalov-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170504130949.GA20340@aperevalov-ubuntu>
Subject: Re: [Qemu-devel] [PATCH RESEND V3 4/6] migration: add postcopy
 downtime into MigrationIncommingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey <a.perevalov@samsung.com>
Cc: i.maximets@samsung.com, f4bug@amsat.org, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org

* Alexey (a.perevalov@samsung.com) wrote:
> On Tue, May 02, 2017 at 09:51:44AM +0100, Dr. David Alan Gilbert wrote:
> > * Alexey (a.perevalov@samsung.com) wrote:
> > > On Fri, Apr 28, 2017 at 05:22:05PM +0100, Dr. David Alan Gilbert wrote:
> > > > * Peter Xu (peterx@redhat.com) wrote:
> > > > > On Fri, Apr 28, 2017 at 01:03:45PM +0300, Alexey Perevalov wrote:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > >>diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > > > > >>index 21e7150..f3688f5 100644
> > > > > > >>--- a/migration/postcopy-ram.c
> > > > > > >>+++ b/migration/postcopy-ram.c
> > > > > > >>@@ -132,6 +132,14 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
> > > > > > >>          return false;
> > > > > > >>      }
> > > > > > >>+#ifdef UFFD_FEATURE_THREAD_ID
> > > > > > >>+    if (mis && UFFD_FEATURE_THREAD_ID & supported_features) {
> > > > > > >>+        /* kernel supports that feature */
> > > > > > >>+        mis->downtime_ctx = downtime_context_new();
> > > > > > >>+        new_features |= UFFD_FEATURE_THREAD_ID;
> > > > > > >So here I know why in patch 2 new_features == 0...
> > > > > > >
> > > > > > >If I were you, I would like the series be done in below 4 patches:
> > > > > > >
> > > > > > >1. update header
> > > > > > >2. introduce THREAD_ID feature, and enable it conditionally
> > > > > > >3. squash all the downtime thing (downtime context, calculation) in
> > > > > > >    one patch here
> > > > > > >4. introduce trace
> > > > > > >
> > > > > > >IMHO that's clearer and easier for review. But I'm okay with current
> > > > > > >as well as long as the maintainers (Dave/Juan) won't disagree. :)
> > > > > > In previous series, David asked me to split one patch into 2
> > > > > > [Qemu-devel] [PATCH 3/6] migration: add UFFD_FEATURE_THREAD_ID feature
> > > > > > support
> > > > > > 
> > > > > > >There seem to be two parts to this:
> > > > > > >  a) Adding the mis parameter to ufd_version_check
> > > > > > >  b) Asking for the feature
> > > > > > 
> > > > > > >Please split it into two patches.
> > > > > > 
> > > > > > So in current patch set, I also added re-factoring, which was missed before
> > > > > > "migration: split ufd_version_check onto receive/request features part"
> > > > > 
> > > > > Sure. As long as Dave agrees, I'm okay with either way.
> > > > 
> > > > I'm OK with the split, it pretty much matches what I asked last time I think.
> > > > 
> > > > The question I still have is how is this memory-expensive feature turned
> > > > on and off by the user?
> > > > Also I think Peter had some ideas for simpler data structures, how did
> > > > that play out?
> > > Maybe introduce it as extension of MigrationParameter,
> > > I mean { "execute": "migrate-set-parameters" , "arguments":
> > > 	{ "calculate-postcopy-downtime": 1 } }
> > 
> > Use migrate-set-capabilities, they're effectively the same but just booleans.
> 
> For me it's not so clear, where to set that capability, on destination or on source
> side. User sets postcopy ram capability on source side, probably on
> source side user wants to set postcopy-downtime.
> If I'm not wrong, neither capabilities nor parameters are transferring
> from source to destination.

Use a capability on the destination specifically for this; it's OK to set capabilities
on the destination, and actually libvirt already sets some for us.

One question: Now we're using Peter's idea, so you don't have that big tree
structure, what are the costs now - is it as big a problem as it was?

> I wanted to pass in in MIG_CMD_POSTCOPY_ADVISE, but it holds only 2
> uint64, and they are already occupied.
> Like with RETURN PATH protocol, MIG couldn't be extended w/o breaking backward
> compatibility. Length for cmd is transmitted, but compared with
> predefined len from mig_cmd_args.
> 
> Maybe just increase QEMU_VM_FILE_VERSION in this case, it will be
> possible to return downtime back to source by return path.
> For supporting backward compatibility keep several versions of mig_cmd_args
> per QEMU_VM_FILE_VERSION. 

No, we'll only change file version on some massive improvement.

Dave

> 
> > Dave
> > 
> > > 
> > > > 
> > > > Dave
> > > > 
> > > > 
> > > > > -- 
> > > > > Peter Xu
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > > 
> > > 
> > > -- 
> > > 
> > > BR
> > > Alexey
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
> -- 
> 
> BR
> Alexey
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
