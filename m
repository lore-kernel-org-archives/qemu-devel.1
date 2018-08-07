Received: from eggs.gnu.org ([2001:4830:134:3::10]:33161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn2GT-0002Ve-Uf
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn2GS-0000tY-W7
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:43:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fn2GS-0000tP-OS
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:43:08 -0400
Date: Tue, 7 Aug 2018 14:43:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180807134304.GH2556@work-vm>
References: <20180807130355.29780-1-peter.maydell@linaro.org>
	<87muty2u57.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muty2u57.fsf@trasno.org>
Subject: Re: [Qemu-devel] [PATCH] migration: Correctly handle subsections
 with no 'needed' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org

* Juan Quintela (quintela@redhat.com) wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Currently the vmstate subsection handling code treats a subsection
> > with no 'needed' function pointer as if it were the subsection
> > list terminator, so the subsection is never transferred and nor
> > is any subsection following it in the list.
> >
> > Handle NULL 'needed' function pointers in subsections in the same
> > way that we do for top level VMStateDescription structures:
> > treat the subsection as always being needed.
> >
> > This doesn't change behaviour for the current set of devices
> > in the tree, because all subsections declare a 'needed' function.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > NB: last para in the commit message is only true once the
> > "Arm migration fixes for 3.0" patchset has been committed.
> > We could optionally drop some of the "use a dummy needed fn"
> > changes once this is in...
> >
> > I thought I'd sent this out a few days back, but apparently not,
> > since it's not on-list...
> >
> >  migration/vmstate.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index 6b9079bb51e..0bc240a3175 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -418,7 +418,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >  static const VMStateDescription *
> >  vmstate_get_subsection(const VMStateDescription **sub, char *idstr)
> >  {
> > -    while (sub && *sub && (*sub)->needed) {
> > +    while (sub && *sub) {
> >          if (strcmp(idstr, (*sub)->name) == 0) {
> >              return *sub;
> >          }
> 
> Ack to this one.  Code supposed that needed was alwasy !=0.  We don't
> really care on the reception side.  Good spotted.
> 
> > @@ -486,8 +486,8 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
> >      int ret = 0;
> >  
> >      trace_vmstate_subsection_save_top(vmsd->name);
> > -    while (sub && *sub && (*sub)->needed) {
> > -        if ((*sub)->needed(opaque)) {
> > +    while (sub && *sub) {
> > +        if (vmstate_save_needed(*sub, opaque)) {
> >              const VMStateDescription *vmsdsub = *sub;
> >              uint8_t len;
> 
> 
> I am not so sure about this one.  Why are we having a subsection without
> a ->needed function?  I don't know why that it is useful for.  if we
> don't have a needed function, then it is just better to just add that
> "subsection" to the normal section, increase the version number and live
> with that, no?

I think people are probably preferring adding a subsection comparing to 
using the _V macros everywhere.  It's also a lot more robust.

Dave

> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
