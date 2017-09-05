Received: from eggs.gnu.org ([2001:4830:134:3::10]:53227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpC5v-0003XR-Pl
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpC5r-0007lf-6p
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:32:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpC5r-0007kA-0u
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:32:35 -0400
Date: Tue, 5 Sep 2017 12:32:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170905113226.GB2112@work-vm>
References: <20170825141940.20740-1-dgilbert@redhat.com>
	<20170825141940.20740-3-dgilbert@redhat.com>
	<20170828091025.GQ14174@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828091025.GQ14174@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] snapshot/tests: Try loadvm twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, shorne@gmail.com, quintela@redhat.com, mreitz@redhat.com, lvivier@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Aug 25, 2017 at 03:19:40PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > It's legal to loadvm twice, modify the existing save/loadvm test
> > to do it twice.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> (a question below though)
> 
> > ---
> >  tests/qemu-iotests/068     | 2 +-
> >  tests/qemu-iotests/068.out | 4 ++++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
> > index cfa0f2aed5..e7fca6a494 100755
> > --- a/tests/qemu-iotests/068
> > +++ b/tests/qemu-iotests/068
> > @@ -78,7 +78,7 @@ for extra_args in \
> >      # Give qemu some time to boot before saving the VM state
> >      { sleep 1; printf "savevm 0\nquit\n"; } | _qemu $extra_args
> >      # Now try to continue from that VM state (this should just work)
> > -    echo quit | _qemu $extra_args -loadvm 0
> > +    { sleep 1; printf "loadvm 0\nloadvm 0\nquit\n"; } | _qemu $extra_args -S
> 
> Curious about why there are both "sleep 1" and "-S" added - I thought
> "-S" means CPU won't really run, then why wait for one more second?

Mostly because I copied it from the savevm line above :-)

Dave

> >  done
> >  
> >  # success, all done
> > diff --git a/tests/qemu-iotests/068.out b/tests/qemu-iotests/068.out
> > index aa063cf711..f07a938a38 100644
> > --- a/tests/qemu-iotests/068.out
> > +++ b/tests/qemu-iotests/068.out
> > @@ -7,6 +7,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
> >  (qemu) savevm 0
> >  (qemu) quit
> >  QEMU X.Y.Z monitor - type 'help' for more information
> > +(qemu) loadvm 0
> > +(qemu) loadvm 0
> >  (qemu) quit
> >  
> >  === Saving and reloading a VM state to/from a qcow2 image (-object iothread,id=iothread0 -set device.hba0.iothread=iothread0) ===
> > @@ -16,5 +18,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
> >  (qemu) savevm 0
> >  (qemu) quit
> >  QEMU X.Y.Z monitor - type 'help' for more information
> > +(qemu) loadvm 0
> > +(qemu) loadvm 0
> >  (qemu) quit
> >  *** done
> > -- 
> > 2.13.5
> > 
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
