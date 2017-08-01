Received: from eggs.gnu.org ([2001:4830:134:3::10]:51240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcQ3o-0002FP-9r
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcQ3l-0001uS-6E
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcQ3k-0001u3-UJ
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:49:37 -0400
Date: Tue, 1 Aug 2017 13:49:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170801054931.GF15697@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-8-git-send-email-peterx@redhat.com>
	<20170731183923.GI2122@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170731183923.GI2122@work-vm>
Subject: Re: [Qemu-devel] [RFC 07/29] migration: better error handling with
 QEMUFile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Mon, Jul 31, 2017 at 07:39:24PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:

[...]

> > @@ -2425,6 +2425,16 @@ static int ram_load_postcopy(QEMUFile *f)
> >          uint8_t ch;
> >  
> >          addr = qemu_get_be64(f);
> > +
> > +        /*
> > +         * If qemu file error, we should stop here, and then "addr"
> > +         * may be invalid
> > +         */
> > +        if (qemu_file_get_error(f)) {
> > +            ret = qemu_file_get_error(f);
> > +            break;
> > +        }
> 
> I'd prefer:
>     ret = qemu_file_get_error(f);
>     if (ret) {
>         break;
>     }

Sure.  Fixing up.

> 
> 
> > +
> >          flags = addr & ~TARGET_PAGE_MASK;
> >          addr &= TARGET_PAGE_MASK;
> >  
> > @@ -2505,6 +2515,13 @@ static int ram_load_postcopy(QEMUFile *f)
> >              error_report("Unknown combination of migration flags: %#x"
> >                           " (postcopy mode)", flags);
> >              ret = -EINVAL;
> > +            break;
> > +        }
> > +
> > +        /* Detect for any possible file errors */
> > +        if (qemu_file_get_error(f)) {
> > +            ret = qemu_file_get_error(f);
> > +            break;
> >          }
> >  
> >          if (place_needed) {
> > @@ -2519,9 +2536,6 @@ static int ram_load_postcopy(QEMUFile *f)
> >                                            place_source, block);
> >              }
> >          }
> > -        if (!ret) {
> > -            ret = qemu_file_get_error(f);
> > -        }
> 
> I think we've lost an error check here; the code before this does:
>    ret = postcopy_place_page.....
> 
> and if that failed it used to be detected by the !ret check in the
> while condition, but with that gone, we need to add a check for ret
> after the place page.

Hmm yes, I should check the ret code here in case that place_page
failed.

I was thinking it was checking only for file errors, but obviously it
was not.

>       
> >      }
> >  
> >      return ret;
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index fdd15fa..13ae9d6 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1720,6 +1720,11 @@ static int loadvm_process_command(QEMUFile *f)
> >      cmd = qemu_get_be16(f);
> >      len = qemu_get_be16(f);
> >  
> > +    /* Check validity before continue processing of cmds */
> > +    if (qemu_file_get_error(f)) {
> > +        return qemu_file_get_error(f);
> > +    }
> > +
> >      trace_loadvm_process_command(cmd, len);
> >      if (cmd >= MIG_CMD_MAX || cmd == MIG_CMD_INVALID) {
> >          error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
> > @@ -1855,6 +1860,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
> >          return -EINVAL;
> >      }
> >  
> > +    /* Check validity before load the vmstate */
> > +    if (qemu_file_get_error(f)) {
> > +        return qemu_file_get_error(f);
> > +    }
> > +
> 
> Do you need a check after the instance_id/version_id read and

I was trying to avoid checking it too many times, so I only checked it
before vmstate_load(). However yes it'll be good to check there as
well.

Generally speaking this patch is not fixing every callers for
qemu_get*(), but only those which will affect the network failure
detection for postcopy only.

> in
> check_section_footer?

Yes. Will do.

> 
> 
> >      ret = vmstate_load(f, se);
> >      if (ret < 0) {
> >          error_report("error while loading state for instance 0x%x of"
> > @@ -1888,6 +1898,11 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
> >          return -EINVAL;
> >      }
> >  
> > +    /* Check validity before load the vmstate */
> > +    if (qemu_file_get_error(f)) {
> > +        return qemu_file_get_error(f);
> > +    }
> > +
> 
> Similar question; do you need the check after the section_id =   read ?

Will do.

> 
> >      ret = vmstate_load(f, se);
> >      if (ret < 0) {
> >          error_report("error while loading state section id %d(%s)",
> > @@ -1944,8 +1959,14 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> >      uint8_t section_type;
> >      int ret = 0;
> >  
> > -    while ((section_type = qemu_get_byte(f)) != QEMU_VM_EOF) {
> > -        ret = 0;
> > +    while (true) {
> > +        section_type = qemu_get_byte(f);
> > +
> > +        if (qemu_file_get_error(f)) {
> > +            ret = qemu_file_get_error(f);
> > +            break;
> > +        }
> > +
> >          trace_qemu_loadvm_state_section(section_type);
> >          switch (section_type) {
> >          case QEMU_VM_SECTION_START:
> > @@ -1969,6 +1990,10 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> >                  goto out;
> >              }
> >              break;
> > +        case QEMU_VM_EOF:
> > +            /* This is the end of migration */
> > +            goto out;
> > +            break;
> 
> Just the goto is sufficient there.

Will fix.  Thanks,

-- 
Peter Xu
