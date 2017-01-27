Received: from eggs.gnu.org ([2001:4830:134:3::10]:39651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cX3D0-0003ov-6M
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cX3Cz-0003ff-4M
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:52:42 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:34035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cX3Cy-0003ea-Ub
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:52:41 -0500
Received: by mail-oi0-x233.google.com with SMTP id s203so22128486oie.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 01:52:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170127093742.GB26553@redhat.com>
References: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
	<20170127093742.GB26553@redhat.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Fri, 27 Jan 2017 15:22:38 +0530
Message-ID: <CAC2QTZZGT80=sJKEC5kiEkrxMs2aABVsR-rjdvk6j2yAwrf1ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: "thuth@redhat.com" <thuth@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Okay

On Friday, 27 January 2017, Daniel P. Berrange <berrange@redhat.com> wrote:

> On Thu, Jan 26, 2017 at 02:46:52PM +0530, Ashijeet Acharya wrote:
> > Migration of a "none" machine with no RAM crashes abruptly as
> > bitmap_new() fails and thus aborts. Instead, place a check for
> > last_ram_offset() being '0' at the start of ram_save_setup() and
> > error out with a meaningful error message.
> >
> > Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com
> <javascript:;>>
> > ---
> >  migration/ram.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index ef8fadf..bf05d69 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1947,6 +1947,11 @@ static int ram_save_setup(QEMUFile *f, void
> *opaque)
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


Are you referring to the new "--only-migratable" option I added along with
John last week?

migration blockers - this check you've added is too late to be detected
> at startup.


I think that the machine is not completely 'non-migratable' because if I
boot qemu with "-m 1G" (say) the migration actually completes successfully.

Ashijeet


>
> Regards,
> Daniel
> --
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/
> :|
> |: http://libvirt.org              -o-             http://virt-manager.org
> :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/
> :|
>
