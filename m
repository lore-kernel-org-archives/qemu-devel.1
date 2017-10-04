Received: from eggs.gnu.org ([2001:4830:134:3::10]:41053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dzjLC-000747-RU
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dzjL9-0002Hv-Ma
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:03:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dzjL9-0002Gj-Dm
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:03:55 -0400
Date: Wed, 4 Oct 2017 15:03:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171004130349.GB9801@localhost.localdomain>
References: <20171002163058.15651-1-anthony.perard@citrix.com>
	<20171002191822.GA2707@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171002191822.GA2707@work-vm>
Subject: Re: [Qemu-devel] [PATCH] migration,
 xen: Fix block image lock issue on live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Wei Liu <wei.liu2@citrix.com>, Juan Quintela <quintela@redhat.com>

Am 02.10.2017 um 21:18 hat Dr. David Alan Gilbert geschrieben:
> Adding in kwolf;  it looks sane to me; Kevin?
> If I'm reading this right, this is just after the device state save.

Is this actual migration? Because the code looks more like it's copied
and adapted from the snapshot code rather than from the actual migration
code.

If Xen doesn't use the standard mechanisms, I don't know what they need
to do. Snapshots don't need to inactivate images, but migration does.
Compared to the normal migration path, this looks very simplistic, so I
wouldn't be surprised if there was more wrong than just file locking.

This looks like it could work as a hack to the problem at hand. Whether
it is a proper solution, I can't say without investing a lot more time.

Kevin

> * Anthony PERARD (anthony.perard@citrix.com) wrote:
> > When doing a live migration of a Xen guest with libxl, the images for
> > block devices are locked by the original QEMU process, and this prevent
> > the QEMU at the destination to take the lock and the migration fail.
> > 
> > From QEMU point of view, once the RAM of a domain is migrated, there is
> > two QMP commands, "stop" then "xen-save-devices-state", at which point a
> > new QEMU is spawned at the destination.
> > 
> > Release locks in "xen-save-devices-state" so the destination can takes
> > them.
> > 
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> > ---
> > CCing libxl maintainers:
> > CC: Ian Jackson <ian.jackson@eu.citrix.com>
> > CC: Wei Liu <wei.liu2@citrix.com>
> > ---
> >  migration/savevm.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 4a88228614..69d904c179 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2263,6 +2263,20 @@ void qmp_xen_save_devices_state(const char *filename, Error **errp)
> >      qemu_fclose(f);
> >      if (ret < 0) {
> >          error_setg(errp, QERR_IO_ERROR);
> > +    } else {
> > +        /* libxl calls the QMP command "stop" before calling
> > +         * "xen-save-devices-state" and in case of migration failure, libxl
> > +         * would call "cont".
> > +         * So call bdrv_inactivate_all (release locks) here to let the other
> > +         * side of the migration take controle of the images.
> > +         */
> > +        if (!saved_vm_running) {
> > +            ret = bdrv_inactivate_all();
> > +            if (ret) {
> > +                error_setg(errp, "%s: bdrv_inactivate_all() failed (%d)",
> > +                           __func__, ret);
> > +            }
> > +        }
> >      }
> >  
> >   the_end:
> > -- 
> > Anthony PERARD
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
