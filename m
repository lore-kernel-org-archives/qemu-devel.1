Received: from eggs.gnu.org ([2001:4830:134:3::10]:54674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxYHS-00084f-Bf
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxYHR-0008QU-5l
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxYHQ-0008QK-Tk
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:51:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D032BE9E19
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 12:51:03 +0000 (UTC)
Date: Thu, 28 Sep 2017 09:50:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170928125059.GN4115@localhost.localdomain>
References: <20170927203225.30896-1-ehabkost@redhat.com>
	<20170927203225.30896-2-ehabkost@redhat.com>
	<20170928114202.GJ12919@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928114202.GJ12919@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Eliminate defconfig variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com

(CCing libvir-list)

On Thu, Sep 28, 2017 at 12:42:02PM +0100, Daniel P. Berrange wrote:
> On Wed, Sep 27, 2017 at 05:32:24PM -0300, Eduardo Habkost wrote:
> > Both -nodefconfig and -no-user-config options do the same thing
> > today, we only need one variable to keep track of them.
> 
> What reason for picking -nodefconfig instead of -no-user-config to
> deprecate ?  -nodefconfig predates -no-user-config by a few years,
> and is what libvirt has historically used. So from libvirt POV
> we'd have a slight preference to deprecate -no-user-config instead
> and keep -nodefconfig, simply to avoid need to add conditional
> logic to libvirt to pick which to use.

libvirt already prefers -no-user-config, which is the right thing
for libvirt because it needs a mechanism to disable user-provided
configuration only, not QEMU-provided data files (in case they
exist).

In other words, we have an important use case for the
-no-user-config semantics in libvirt, and I am not aware of any
existing user of the -nodefconfig semantics.

(For the record, I think the existing documented -nodefconfig
semantics is awful and useless, but that's the one we got.  Old
discussions about this can be seen at:
https://www.mail-archive.com/libvir-list@redhat.com/msg53083.html )

> 
> > 
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  vl.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/vl.c b/vl.c
> > index 4fd01fda91..b347a97a5b 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -3093,7 +3093,6 @@ int main(int argc, char **argv, char **envp)
> >      const char *qtest_log = NULL;
> >      const char *pid_file = NULL;
> >      const char *incoming = NULL;
> > -    bool defconfig = true;
> >      bool userconfig = true;
> >      bool nographic = false;
> >      DisplayType display_type = DT_DEFAULT;
> > @@ -3194,8 +3193,6 @@ int main(int argc, char **argv, char **envp)
> >              popt = lookup_opt(argc, argv, &optarg, &optind);
> >              switch (popt->index) {
> >              case QEMU_OPTION_nodefconfig:
> > -                defconfig = false;
> > -                break;
> >              case QEMU_OPTION_nouserconfig:
> >                  userconfig = false;
> >                  break;
> > @@ -3203,7 +3200,7 @@ int main(int argc, char **argv, char **envp)
> >          }
> >      }
> >  
> > -    if (defconfig && userconfig) {
> > +    if (userconfig) {
> >          if (qemu_read_default_config_file() < 0) {
> >              exit(1);
> >          }
> > -- 
> > 2.13.5
> > 
> > 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

-- 
Eduardo
