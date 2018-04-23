Received: from eggs.gnu.org ([2001:4830:134:3::10]:54153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAbGq-0002K9-3h
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAbGl-0001ms-EQ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:12:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fAbGl-0001mH-2D
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 09:12:35 -0400
Date: Mon, 23 Apr 2018 14:12:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180423131230.GH2518@work-vm>
References: <20180420175721.18479-1-dgilbert@redhat.com>
	<bf695674-aa5e-e151-d921-225086d35c5d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf695674-aa5e-e151-d921-225086d35c5d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, peter.maydell@linaro.org

* Eric Blake (eblake@redhat.com) wrote:
> On 04/20/2018 12:57 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Update the migration docs:
> > 
> > Among other changes:
> >   * Added a general list of advice for device authors
> >   * Reordered the section on conditional state (subsections etc)
> >     into the order we prefer.
> >   * Add a note about firmware
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  docs/devel/migration.rst | 524 +++++++++++++++++++++++++++------------
> >  1 file changed, 370 insertions(+), 154 deletions(-)
> 
> > @@ -40,16 +40,16 @@ to do migration:
> >  - fd migration: do the migration using an file descriptor that is
> >    passed to QEMU.  QEMU doesn't care how this file descriptor is opened.
> >  
> > -All these four migration protocols use the same infrastructure to
> > +In addition support is included for migration using RDMA migration which
> 
> The double migration in this phrase sounds redundant.  I think you can:
> 
> s/In addition/In addition,/
> s/RDMA migration which/RDMA, which/

Done

> > +transports the page data using ``RDMA``, where the hardware takes care of
> > +transporting the pages, and the load on the CPU is much lower.  While the
> > +internals of RDMA migration are a bit different, this isn't really visible
> > +outside the RAM migration code.
> > +
> 
> > +For most devices, the state is saved in a single call to the migration
> > +infrastrucutre; these are *non-iterative* devices.  The data for these
> 
> s/infrastrucutre/infrastructure/

Done

> > +devices is sent at the end of precopy migration, when the CPUs are paused.
> > +Where the data associated with the device is very large (e.g. RAM or large tables)
> > +see the iterative device section below.
> 
> > +
> > +- Migrations timing out or being failed by higher levels of management,
> > +  or failures of the destination host are not unusual, and care should
> > +  be taken to ensure that the source VM can be restarted up until the point
> > +  when the destination starts runing.  Valid examples include the management
> 
> s/runing/running/

Done

> > +  layer reverting the migration even though the QEMU level of migration has
> > +  succeeded.  For this reason, the state on the source VM should not be
> > +  destroyed during the migration process in normal use.
> > +
> > +- Busses and devices should be able to explicitly specify addresses when
> 
> s/Busses/Buses/ ? (both spellings are common, but busses can also be
> confused with a synonym of kisses)

Done (best not to ask...)

> > +When we migrate a device, we save/load the state as a series
> > +of fields.  Some times, due to bugs or new functionality, we need to
> > +change the state to store more/different information.  Changing the migration
> > +state saved for a device can break migration comppatibility unless
> 
> s/comppatibility/compatibility/

Done
> > +care is taken to use the appropriate techniques.  In general QEMU tries
> > +to maintain forward migration compaitibility (i.e. migrating from
> 
> s/compaitibility/compatibility/

Done
> 
> > +QEMU n->n+1) and there are users who benefit from backwards compatibility
> > +as well.
> 
> (fun - 3 spellings among 3 uses in 2 sentences - at least the last one
> was right)
> 
> 
> > +Note that the contents of the sections for iterative migration tend
> > +to be open-coded by the devices;  care should be taken in parsing
> 
> Why the double space?

No particular reason; gone.

> 
> > +
> > +The ``device data`` in each section consists of the data produced
> > +by the code described above.  For non-iterative devices they have a single
> > +section; iterative devices have an initial and last section and a set
> > +of parts inbetween.
> 
> s/inbetween/in between/

Done

> > +Note that there is very little checking by the common code of the integrity
> > +of the ``device data`` contents, that's upto the devices themselves.
> 
> s/upto/up to/

Done

> > +Only a unidirectional stream is required for normal migration, however a
> > +``return path`` can be created when bidirecitonal communication is desired.
> 
> s/bidirecitonal/bidirectional/

Done

Thanks

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
