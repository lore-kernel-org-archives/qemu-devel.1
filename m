Received: from eggs.gnu.org ([2001:4830:134:3::10]:55061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fjGgu-0003Ti-H5
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 00:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fjGgt-0001Dj-CQ
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 00:18:52 -0400
Date: Sat, 28 Jul 2018 00:18:39 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180728041839.GA1325070@localhost.localdomain>
References: <20180727081939.28185-1-ndevos@redhat.com>
	<f0a7edbd-f731-7ac5-4aee-ef2ba594ed64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a7edbd-f731-7ac5-4aee-ef2ba594ed64@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Niels de Vos <ndevos@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

On Fri, Jul 27, 2018 at 08:24:05AM -0500, Eric Blake wrote:
> On 07/27/2018 03:19 AM, Niels de Vos wrote:
> >From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> >
> >New versions of Glusters libgfapi.so have an updated glfs_ftruncate()
> >function that returns additional 'struct stat' structures to enable
> >advanced caching of attributes. This is useful for file servers, not so
> >much for QEMU. Nevertheless, the API has changed and needs to be
> >adopted.
> >
> 
> Oh, one other comment.
> 
> >+++ b/block/gluster.c
> >@@ -20,6 +20,10 @@
> >  #include "qemu/option.h"
> >  #include "qemu/cutils.h"
> >+#ifdef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
> >+# define glfs_ftruncate(fd, offset, _u1, _u2) glfs_ftruncate(fd, offset)
> >+#endif
> 
> Someday, when we can assume new enough gluster everywhere, we can drop this
> hunk...
> 

Part of me wishes that libgfapi had just created a new function
'glfs_ftruncate2', so that existing users don't need to handle the api
change.  But I guess in the grand scheme, not a huge deal either way.

> >+++ b/configure
> 
> >+	/* new glfs_ftruncate() passes two additional args */
> >+	return glfs_ftruncate(NULL, 0 /*, NULL, NULL */);
> >+}
> >+EOF
> >+    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
> >+      glusterfs_legacy_ftruncate="yes"
> >+    fi
> 
> ...but it will be easier to remember to do so if this comment in configure
> calls out the upstream gluster version that no longer requires the legacy
> workaround, as our hint for when...
> 

I can go ahead and add that to the comment in my branch after applying, if
Niels can let me know what that version is/will be (if known).

> >    else
> >      if test "$glusterfs" = "yes" ; then
> >        feature_not_found "GlusterFS backend support" \
> >@@ -6644,6 +6658,10 @@ if test "$glusterfs_zerofill" = "yes" ; then
> >    echo "CONFIG_GLUSTERFS_ZEROFILL=y" >> $config_host_mak
> >  fi
> >+if test "$glusterfs_legacy_ftruncate" = "yes" ; then
> >+  echo "CONFIG_GLUSTERFS_LEGACY_FTRUNCATE=y" >> $config_host_mak
> 
> ...this #define is no longer necessary.
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
