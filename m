Received: from eggs.gnu.org ([2001:4830:134:3::10]:44299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fkag7-0002FQ-NL
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fkag6-0000EI-FI
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:51:31 -0400
Date: Tue, 31 Jul 2018 15:51:22 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180731195122.GA1748801@localhost.localdomain>
References: <20180727081939.28185-1-ndevos@redhat.com>
	<f0a7edbd-f731-7ac5-4aee-ef2ba594ed64@redhat.com>
	<20180728041839.GA1325070@localhost.localdomain>
	<20180728075005.GE1827@ndevos-x270>
	<2bf3b1f9-ab42-5256-8093-7c41aaa9f2d6@redhat.com>
	<20180730192729.GA443110@localhost.localdomain>
	<20180731091802.GL17519@ndevos-x270>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731091802.GL17519@ndevos-x270>
Subject: Re: [Qemu-devel] [PATCH v3] block/gluster: Handle changed
 glfs_ftruncate signature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

On Tue, Jul 31, 2018 at 11:18:02AM +0200, Niels de Vos wrote:
> On Mon, Jul 30, 2018 at 03:27:29PM -0400, Jeff Cody wrote:
> > On Mon, Jul 30, 2018 at 10:07:27AM -0500, Eric Blake wrote:
> > > On 07/28/2018 02:50 AM, Niels de Vos wrote:
> > > >>
> > > >>Part of me wishes that libgfapi had just created a new function
> > > >>'glfs_ftruncate2', so that existing users don't need to handle the api
> > > >>change.  But I guess in the grand scheme, not a huge deal either way.
> > > >
> > > >Gluster uses versioned symbols, so older binaries will keep working with
> > > >new libraries. It is (hopefully) rare that existing symbols get updated.
> > > >We try to send patches for these kind of changes to the projects we know
> > > >well in advance, reducing the number of surprises.
> > > 
> > > >>I can go ahead and add that to the comment in my branch after applying, if
> > > >>Niels can let me know what that version is/will be (if known).
> > > >
> > > >The new glfs_ftruncate() will be part of glusterfs-5 (planned for
> > > >October). We're changing the numbering scheme, it was expected to come
> > > >in glusterfs-4.2, but that is a version that never will be released.
> > > >
> > > 
> > > Wait - so you're saying gluster has not yet released the incompatible
> > > change? Now would be the right time to get rid of the API breakage, before
> > > you bake it in, rather than relying solely on the versioned symbols to avoid
> > > an ABI breakage but forcing all clients to compensate to the API breakage.
> > > 
> > 
> > If this is not yet in a released version of Gluster, I'm not real eager to
> > pollute the QEMU driver codebase with #ifdef's, especially if there is a
> > possibility the API change may not actually materialize.
> > 
> > Is there any reason that this change is being approached in a way that
> > breaks API usage, and is it too late in the Gluster development pipeline to
> > change that?
> 
> There recently have been a few changes like this in libgfapi. These have
> been introduced to improve performance in common use-cases where an
> updated 'struct stat' is needed after an operation. Some functions have
> been adapted in previous releases, glfs_ftruncate() landed too late for
> that. I hope we'll get a complete coherent API with glusterfs-5 again.
> 

Am I correct in assuming the API changes that happened in previous libgfapi
release are for APIs that QEMU does not use (i.e. no action needed from
us?)

> For QEMU this means additional changes will come related to
> glfs_fallocate(), glfs_zerofill() and probably more. The current
> glusterfs-4.1 version will be maintained for one year, after which the
> detection/#ifdef can be removed as the than maintained versions should
> all have the updated API. I'm sorry for the inconvenience that this
> causes.
> 

Understood.  I don't want to make a huge deal out of it.  I guess my
recommendation/request is that API enhancements happen in a way that don't
break existing APIs (e.g. use parallel APIs), because QEMU version usage and
supported glusterfs usage may not always follow supported versions in the
wild.  I know versioned symbols helps with this, but it still complicates
the code (and couples QEMU's code to gluster support windows).


> If you prefer, I can wait with sending patches for QEMU with future
> Gluster releases until additional changes have landed in libgfapi.
>

I think generally, we don't want to start introducing #ifdef's and new APi
usage for unreleased versions of libgfapi if possible (as unreleased APIs,
it could technically change, and then QEMU releases would have 'dead' API
support in it).

If glusterfs-5 releases in October, that may line up with 3.1 or 3.2.


-Jeff
