Received: from eggs.gnu.org ([2001:4830:134:3::10]:41130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fFzzh-0001yF-5Z
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fFzzb-0000N0-9t
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:37:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fFzzb-0000Mq-4y
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:37:11 -0400
Date: Tue, 8 May 2018 11:37:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180508103704.GK5967@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<20180507033214.19219-2-zyimin@linux.ibm.com>
	<e4041508-c6ba-5e83-8bd8-50a4bd996009@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4041508-c6ba-5e83-8bd8-50a4bd996009@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] sandbox: avoid to compile options if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Yi Min Zhao <zyimin@linux.ibm.com>, qemu-devel@nongnu.org, otubo@redhat.com, borntraeger@de.ibm.com, fiuczy@linux.ibm.com, jtomko@redhat.com, jferlan@redhat.com

On Mon, May 07, 2018 at 01:04:17PM -0500, Eric Blake wrote:
> On 05/06/2018 10:32 PM, Yi Min Zhao wrote:
> 
> In the subject line: s/avoid to compile/avoid compiling/
> 
> > If CONFIG_SECCOMP is undefined, the option 'elevatorprivileges' remains
> 
> s/elevator/elevate/
> 
> > complied. This would make libvirt set the corresponding capability and
> 
> s/complied/compiled/
> 
> > then trigger the guest startup fails. So let's wrap the options with
> > CONFIG_SECCOMP.
> > 
> > Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> > ---
> >   vl.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/vl.c b/vl.c
> > index fce1fd12d8..cb07b19c02 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -268,6 +268,7 @@ static QemuOptsList qemu_sandbox_opts = {
> >               .name = "enable",
> >               .type = QEMU_OPT_BOOL,
> >           },
> > +#ifdef CONFIG_SECCOMP
> >           {
> >               .name = "obsolete",
> >               .type = QEMU_OPT_STRING,
> > @@ -284,6 +285,7 @@ static QemuOptsList qemu_sandbox_opts = {
> >               .name = "resourcecontrol",
> >               .type = QEMU_OPT_STRING,
> >           },
> > +#endif
> 
> The commit message mentions only 'elevateprivileges' (once the typo is
> fixed), but you are also crippling 'obsolete', 'spawn', and
> 'resourcecontrol'.  Perhaps the commit message should call that out better?
> Or, since libvirt is looking at just 'elevateprivileges', per this line in
> libvirt's qemu_capabilities.c:
> 
> src/qemu/qemu_capabilities.c:    { "sandbox", "elevateprivileges",
> QEMU_CAPS_SECCOMP_BLACKLIST },
> 
> is it sufficient to just mask out that one option?

If seccomp is disabled, we should really disable the entire -sandbox
argument, not merly the options to it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
