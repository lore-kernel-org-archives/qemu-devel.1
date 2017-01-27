Received: from eggs.gnu.org ([2001:4830:134:3::10]:37875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cX36q-0000Bl-33
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cX36o-0001Zd-SO
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:46:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cX36o-0001ZM-Ma
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:46:18 -0500
Date: Fri, 27 Jan 2017 09:46:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170127094613.GA3323@work-vm>
References: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
	<20170127093742.GB26553@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170127093742.GB26553@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migrate: Migration aborts abruptly for
 machine "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Ashijeet Acharya <ashijeetacharya@gmail.com>, thuth@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Thu, Jan 26, 2017 at 02:46:52PM +0530, Ashijeet Acharya wrote:
> > Migration of a "none" machine with no RAM crashes abruptly as
> > bitmap_new() fails and thus aborts. Instead, place a check for
> > last_ram_offset() being '0' at the start of ram_save_setup() and
> > error out with a meaningful error message.
> > 
> > Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> > ---
> >  migration/ram.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/migration/ram.c b/migration/ram.c
> > index ef8fadf..bf05d69 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1947,6 +1947,11 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >  {
> >      RAMBlock *block;
> >  
> > +    if (last_ram_offset() == 0) {
> > +        error_report("Failed to migrate: No RAM available!");
> > +        return -1;
> > +    }
> > +
> 
> If we're merely going to block migration, as opposed to making it work,
> then IMHO we should use migration blockers registered at machine setup
> for this task.
> 
> We have a new cli arg added to QEMU to tell it to abort startup if the
> machine configuration is not migratable. That only works if using
> migration blockers - this check you've added is too late to be detected
> at startup.

Hmm, yes you're right, that would be better.
Although it does lead to an interesting situation where starting with a 'none'
and constructing it component at a time would get rejected by --only-migratable
even though the final construction is fine.

Dave

> 
> Regards,
> Daniel
> -- 
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
