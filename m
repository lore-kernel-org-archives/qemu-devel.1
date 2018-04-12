Received: from eggs.gnu.org ([2001:4830:134:3::10]:42422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1f6hLX-0005G2-Ad
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1f6hLS-0001wl-DM
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:53:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ndevos@redhat.com>) id 1f6hLS-0001wU-8y
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:53:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D92D981A88A6
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 18:53:07 +0000 (UTC)
Date: Thu, 12 Apr 2018 20:53:01 +0200
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20180412185301.GC21158@ndevos-x270>
References: <20180412111614.9724-1-prasanna.kalever@redhat.com>
	<20180412133158.GB21158@ndevos-x270>
	<74ea6d81-1800-d580-ecb1-6d85d83115bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ea6d81-1800-d580-ecb1-6d85d83115bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/gluster: defend on legacy ftruncate
 api use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org

On Thu, Apr 12, 2018 at 11:21:42AM -0500, Eric Blake wrote:
> n 04/12/2018 08:31 AM, Niels de Vos wrote:
> > This change looks good to me, but a commit message would have been
> > helpful. I suggest something like this:
> > 
> >   Gluster 4.0 changed the signature of glfs_ftruncate(). The function
> >   now has two additional arguments, namely prestat and poststat. These
> >   provide not benefit for QEMU, so ignoring them and passing NULL makes
> >   the gluster-block driver compile with the new Gluster version again.
> > 
> > And maybe add this too:
> > 
> >   Glusters libgfapi uses symbol versioning and provides backwards
> >   compatible functions. Binaries compiled against previous versions of
> >   Gluster keep on functioning with the new library.
> > 
> 
> >> @@ -3856,6 +3857,9 @@ if test "$glusterfs" != "no" ; then
> >>        glusterfs_fallocate="yes"
> >>        glusterfs_zerofill="yes"
> >>      fi
> >> +    if ! $pkg_config --atleast-version=7.4 glusterfs-api; then
> >> +      glusterfs_legacy_ftruncate="yes"
> 
> Also, version-based tests are lousy.  Feature-based tests (does a call
> to glfs_ftruncate(0, 0) compile without error? then we are legacy) are
> less brittle, especially when features can be backported across
> versions.  So this should be reworked to a compile check, rather than a
> version query.

In this case, the cange to glfs_ftruncate() will not be backported in
the releases from the Gluster Community or any distributions that I am
familiar with.

I agree that a compile-test is safer and can understand that those are
preferred over pkg-config version checks.

Niels
