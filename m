Received: from eggs.gnu.org ([2001:4830:134:3::10]:41504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwVJb-0006lL-QX
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwVJY-0004Hw-Ix
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cwVJY-0004Hj-Ab
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:56:40 -0400
Date: Fri, 7 Apr 2017 15:56:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170407145634.GA2623@work-vm>
References: <20170407143254.22061-1-dgilbert@redhat.com>
	<a9e3490a-0a70-7b9d-53cb-0a2fd389c796@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e3490a-0a70-7b9d-53cb-0a2fd389c796@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] slirp/smb: Replace constant
 strings by glib string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, berrange@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 04/07/2017 09:32 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > gcc 7 (on fedora 26) objects to many of the snprintf's
> > in the smb path and command creation because it can't
> > figure out that the smb_dir (i.e. the /tmp dir for the configuration)
> > is known to be short.
> > 
> > Replace all these fixed length buffers by g_str* functions that dynamically
> > allocate and use g_dir_make_tmp to make the directory.
> > (It's fairly new glib but we have a compat function for it).
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  net/slirp.c | 30 +++++++++++++++++-------------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> > 
> > diff --git a/net/slirp.c b/net/slirp.c
> > index f97ec23345..9f6521190b 100644
> > --- a/net/slirp.c
> > +++ b/net/slirp.c
> > @@ -80,7 +80,7 @@ typedef struct SlirpState {
> >      Slirp *slirp;
> >      Notifier exit_notifier;
> >  #ifndef _WIN32
> > -    char smb_dir[128];
> > +    gchar *smb_dir;
> 
> Does it really have to be gchar? That's one of the more pointless
> typedefs in glib; and I think 'char *' is just fine.

Yes I'm happy either way.

> > -    snprintf(smb_cmdline, sizeof(smb_cmdline), "%s -l %s -s %s",
> > +    smb_cmdline = g_strdup_printf("%s -l %s -s %s",
> >               CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);
> 
> Gross that we're parsing a command line through a shell, but
> pre-existing and looks like CONFIG_SMBD_COMMAND, s->smb_dir, and
> smb_conf should all be enough under our control to ensure that there are
> no shell metacharacters and therefore exploits possible.

Yes, it's quite hacky.

> The cleanup is useful, and resolves one of the build issues I pointed
> out earlier on Rawhide (looks like it is now Fedora 26 in addition to
> Rawhide that have new-enough gcc).  In that thread, we argued that it's
> not going to be essential to get this in for 2.9, but as more and more
> people move to newer gcc, it will probably be a candidate for
> qemu-stable for 2.9.1 in addition to 2.10.

Ah which thread is that?
I just posted:
https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg01294.html

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Dave

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
