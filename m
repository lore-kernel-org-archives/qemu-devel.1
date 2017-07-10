Received: from eggs.gnu.org ([2001:4830:134:3::10]:48900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUXGF-0001V2-Pb
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUXGC-0006Cn-OO
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:53:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dUXGC-0006Bj-EP
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:53:52 -0400
Date: Mon, 10 Jul 2017 12:53:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170710115346.GB5924@work-vm>
References: <1499429683-73361-1-git-send-email-agraf@suse.de>
	<20170707150011.GH2451@work-vm>
	<1b6bf5d1-8477-1697-16e9-091c1b762bd4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b6bf5d1-8477-1697-16e9-091c1b762bd4@suse.de>
Subject: Re: [Qemu-devel] [PATCH] migration: Make analyze-migration script
 target-page-size aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Alexander Graf (agraf@suse.de) wrote:
> 
> 
> On 07.07.17 17:00, Dr. David Alan Gilbert wrote:
> > * Alexander Graf (agraf@suse.de) wrote:
> > > The configuration section has a new subsection to transmit the target page
> > > size along with the migration stream. The analyze migration script needs
> > > to learn about that to read configuration streams that were triggering
> > > this subsection to get transmitted.
> > > 
> > > With this patch applied, I can successfully analyze migration streams
> > > on AArch64 again.
> > > 
> > > Signed-off-by: Alexander Graf <agraf@suse.de>
> > > ---
> > >   scripts/analyze-migration.py | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> > > index 1455387..02784f2 100755
> > > --- a/scripts/analyze-migration.py
> > > +++ b/scripts/analyze-migration.py
> > > @@ -254,12 +254,25 @@ class HTABSection(object):
> > 
> > (Note I'm not a particularly python person, so take lightly)
> > 
> > >   class ConfigurationSection(object):
> > > +    QEMU_VM_SUBSECTION    = 0x05
> > > +
> > 
> > It's odd, you already have this constant defined twice in this script.
> 
> Yes, it lives once per class. I am not sure how to easily make it a global.
> 
> > 
> > >       def __init__(self, file):
> > >           self.file = file
> > >       def read(self):
> > >           name_len = self.file.read32()
> > >           name = self.file.readstr(len = name_len)
> > > +        oldpos = self.file.tell()
> > > +        if self.file.read8() == self.QEMU_VM_SUBSECTION:
> > > +            name = self.file.readstr()
> > > +            version_id = self.file.read32()
> > > +            if name == "configuration/target-page-bits":
> > > +                target_page_size = self.file.read32()
> > 
> > All of your other references to target_page_size in the script
> > are self.TARGET_PAGE_SIZE.
> 
> Well, all other ones are actual page sizes :). This variable is never used
> anywhere - we just want to stash it somewhere.

Well you do read self.TARGET_PAGE_SIZE elsewhere - it determines the
amount of data to read from each RAM header in RamSections::read

Also note that the value being read in the config header is
target_page_bits - i.e. ln2(target_page_size).

> > You might want to make the conditional subsection check into a function
> > somewhere, but that's OK for now.
> 
> I really hope we don't need it again. All subsections should be described
> via the in-stream json description. We just missed out the configuration one
> because it's not part of the object model.

Dave

> 
> Alex
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
