Received: from eggs.gnu.org ([2001:4830:134:3::10]:39663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drm25-00041X-Ka
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drm21-0008Fx-P3
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:19:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drm21-0008FK-II
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:19:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E43A356C9
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 14:19:16 +0000 (UTC)
Date: Tue, 12 Sep 2017 15:19:10 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170912141910.GJ17633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<1505223994.31639.20.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505223994.31639.20.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Tue, Sep 12, 2017 at 03:46:34PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > The keycodemapdb code is designed to be used as a git sub-module, it
> > is
> > not an external dependancy you need installed before use. In this
> > version,
> > however, the sub-module is not directly use. Instead all the
> > generated
> > files are checked into GIT. The downside to this is that we get an
> > enourmous pile of errors from checkpatch.pl. The tool that generates
> > the
> > mapping files doesn't care about QEMU's coding style rules, because
> > it is
> > a general purpose tool intended for use by many different projects.
> > 
> > As such I'm not very happy about the idea of checking the generated
> > files into
> > GIT, and would prefer to go back to generating the files from the
> > submodule
> > on every build, as was done in v4.
> 
> The submodule approach has its share of issues too, just see how many
> patch versions you've needed until patchew builds actually worked.  And
> I guess lots of people have qemu build scripts which likewise need
> adjustments.  Handling of release tarballs must be considered too.
> 
> I still think we should not require a checked out keycodemapdb
> submodule.  But maybe it'll work better if we check in a copy of the
> script and database instead of checking in the generated files.

This feels like it all just defeats the point of submodules if you manually
copy stuff out of the submodule, or checkin generated files.

My POV is that we should a) never check generated files into GIT, and
we should use the submodule in such a way that it is indistinguish
from the content of the submodule being part of the main GIT repo.
IOW, when building from git always initialize the submodule, but
its content gets add to tar.gz dist, so people building from dist
don't rely on the submodule.

This is the way most projects deal with submodules - its been tricky
getting that working because QEMU has not used submodules in the
way other projects normally do, so there's no current framework in
the configure/makefiles todo the right thing. IMHO it is beneficial
to fix this so we can avoid pointless copying of files and/or storing
generated sources

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
