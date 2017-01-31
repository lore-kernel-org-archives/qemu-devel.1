Received: from eggs.gnu.org ([2001:4830:134:3::10]:49296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYebL-0003DF-Pp
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cYebG-0007VZ-Sw
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:00:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cYebG-0007VS-Mb
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:00:22 -0500
Date: Tue, 31 Jan 2017 20:00:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170131200016.GP2395@work-vm>
References: <20161020132556.67321-1-pasic@linux.vnet.ibm.com>
	<20161020132556.67321-3-pasic@linux.vnet.ibm.com>
	<b1f6f338-601f-8525-1f1b-cffdbe203453@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f6f338-601f-8525-1f1b-cffdbe203453@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] migration: drop unused
 VMStateField.start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Guenther Hutzl <hutzl@linux.vnet.ibm.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 10/20/2016 03:25 PM, Halil Pasic wrote:
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index fc29acf..8767e40 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -66,10 +66,10 @@ static void *vmstate_base_addr(void *opaque, VMStateField *field, bool alloc)
> >                  }
> >              }
> >              if (size) {
> > -                *((void **)base_addr + field->start) = g_malloc(size);
> > +                *(void **)base_addr = g_malloc(size);
> >              }
> >          }
> > -        base_addr = *(void **)base_addr + field->start;
> > +        base_addr = *(void **)base_addr;
> >      }
> > 
> >      return base_addr;
> Hi!
> 
> It is been a while, and IMHO this is still broken, and the
> VMSTATE_VBUFFER* macros are still only used with the start argument
> being zero.
> 
> What changed is that with commit 94869d5c ("migration: migrate QTAILQ")
> from Jan 19 we have code actually using VMStateDecription.start -- but
> for something different (IMHO), as allocation is done by get_qtailq and
> not by vmstate_base_addr (as in case of VMSTATE_VBUFFER_ALLOC_UINT32).
> Thus I would need to update the commit message and keep the start field
> at least.
> 
> But before I do so, I would like to ask the maintainers if there is
> interest in a change like this?

I think it's certainly worth fixing VMSTATE_BUFFER_ALLOC*; if it can't
use the start field properly then it should have the start parameter
removed.

I'll admit I can't remember the details of why field->start as an offset
didn't work; are the other macros that take a start value correct?
If we can't remove the start variable then it's probably not removing
the start parameter everywhere.

That alloc case looks the most unusual in that vmstate_base_addr()
function; I *think* the non-alloc case makes sense
(i.e. follow a pointer and then use an offset from that pointer?)
even if no one currently uses it.

Dave

> Regards,
> Halil
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
