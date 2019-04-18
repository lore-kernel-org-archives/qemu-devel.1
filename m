Received: from eggs.gnu.org ([209.51.188.92]:51165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hH5Hu-000466-6A
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hH5Ht-0006Zi-2W
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:33:06 -0400
Date: Thu, 18 Apr 2019 12:32:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190418113249.GP13773@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190417115343.30527-1-pbonzini@redhat.com>
	<CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
	<cf51d357-d9c0-3a20-1d23-7f6671d7948a@redhat.com>
	<20190418104737.GC5242@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418104737.GC5242@linux.fritz.box>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] scsi-generic: prevent guest
 from exceeding SG_IO limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On Thu, Apr 18, 2019 at 12:47:37PM +0200, Kevin Wolf wrote:
> Am 18.04.2019 um 11:48 hat Paolo Bonzini geschrieben:
> > On 17/04/19 14:30, Stefan Hajnoczi wrote:
> > > On Wed, Apr 17, 2019 at 12:54 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >> Linux places a limit of UIO_MAXIOV pages on SG_IO ioctls (and if the limit
> > >> is exceeded, a confusing ENOMEM error is returned[1]).  Prevent the guest
> > >> from exceeding these limits, by capping the maximum transfer length to
> > >> that value in the block limits VPD page.
> > >>
> > >> [1] Oh well, at least it was easier to follow the kernel source knowing
> > >>     it had to end as ENOMEM...
> > >>
> > >> Cc: qemu-stable@nongnu.org
> > >> Cc: qemu-block@nongnu.org
> > >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > >> ---
> > >>  hw/scsi/scsi-generic.c | 17 +++++++++++++----
> > >>  1 file changed, 13 insertions(+), 4 deletions(-)
> > > 
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > 
> > 
> > This is acually only an issue with kernels prior to 4.5, so it should be
> > fixed downstream instead.
> 
> I don't think that upstream QEMU has kernels > 4.5 as an official
> requirement, though? We try to be compatible with quite old libs, so we
> should stay compatible with old kernels, too.

We've not explicitly stated or checked a min kernel version, but our
min kernel is defined implicitly by our targetted build platforms:

  https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

The oldest Linux distro under those rules is RHEL-7 (3.10.0), since
Debian Jessie actually updates its kernel version so is already on
version 4.5


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
