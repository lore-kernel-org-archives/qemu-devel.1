Received: from eggs.gnu.org ([2001:4830:134:3::10]:40784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=463712e83=anthony.perard@citrix.com>)
	id 1e6y3k-0002sZ-Nl
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=463712e83=anthony.perard@citrix.com>)
	id 1e6y3g-0003CE-OQ
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:11:52 -0400
Received: from smtp.citrix.com ([66.165.176.89]:64388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=463712e83=anthony.perard@citrix.com>)
	id 1e6y3g-0003BY-HI
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:11:48 -0400
Date: Tue, 24 Oct 2017 13:11:40 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171024121140.GE1885@perard.uk.xensource.com>
References: <20171002163058.15651-1-anthony.perard@citrix.com>
	<20171002191822.GA2707@work-vm>
	<20171004130349.GB9801@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171004130349.GB9801@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Wei Liu <wei.liu2@citrix.com>, Juan Quintela <quintela@redhat.com>

On Wed, Oct 04, 2017 at 03:03:49PM +0200, Kevin Wolf wrote:
> Am 02.10.2017 um 21:18 hat Dr. David Alan Gilbert geschrieben:
> > Adding in kwolf;  it looks sane to me; Kevin?
> > If I'm reading this right, this is just after the device state save.
> 
> Is this actual migration? Because the code looks more like it's copied
> and adapted from the snapshot code rather than from the actual migration
> code.

Well the Xen tool stack takes care of the migration, we only need to
save the device states from QEMU, I guess similair to a snapshot.

> If Xen doesn't use the standard mechanisms, I don't know what they need
> to do. Snapshots don't need to inactivate images, but migration does.
> Compared to the normal migration path, this looks very simplistic, so I
> wouldn't be surprised if there was more wrong than just file locking.

I realize now that if one would want to take a snapshot of a running
Xen guest, this xen-save-devices-state qmp command will be called as
well.

So I can see a few options to better handle snapshots, we could:
- Add a new parameter to xen-save-devices-state, "live_migration" which
  could default to 'true' so older version of Xen will still works.
- Create a new qmp command that sole purpose is to call
  bdrv_inactivate_all, I don't know what else this command would have to
  do.
- or just take this patch.

Thanks.

> This looks like it could work as a hack to the problem at hand. Whether
> it is a proper solution, I can't say without investing a lot more time.


-- 
Anthony PERARD
