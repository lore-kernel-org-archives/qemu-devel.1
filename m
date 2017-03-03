Received: from eggs.gnu.org ([2001:4830:134:3::10]:41953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1cjqee-0000FQ-1g
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1cjqed-0007UH-0C
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:06:08 -0500
Date: Fri, 3 Mar 2017 09:06:03 -0800
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20170303170603.GW16140@ndevos-x240.usersys.redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-13-git-send-email-armbru@redhat.com>
	<20170303071125.GS16140@ndevos-x240.usersys.redhat.com>
	<87pohy4xoa.fsf@dusky.pond.sub.org>
	<20170303081743.GU16140@ndevos-x240.usersys.redhat.com>
	<87efye3ghn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efye3ghn.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 12/15] gluster: Plug memory
 leaks in qemu_gluster_parse_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, qemu-devel@nongnu.org, qemu-block@nongnu.org, namei.unix@gmail.com

On Fri, Mar 03, 2017 at 09:35:16AM +0100, Markus Armbruster wrote:
> Niels de Vos <ndevos@redhat.com> writes:
> 
> > On Fri, Mar 03, 2017 at 08:38:45AM +0100, Markus Armbruster wrote:
> >> Niels de Vos <ndevos@redhat.com> writes:
> >> 
> >> > On Thu, Mar 02, 2017 at 10:44:03PM +0100, Markus Armbruster wrote:
> >> >> To reproduce, run
> >> >> 
> >> >>     $ valgrind qemu-system-x86_64 --nodefaults -S --drive driver=gluster,volume=testvol,path=/a/b/c,server.0.type=xxx
> >> >> 
> >> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> >> ---
> >> >>  block/gluster.c | 28 ++++++++++++++--------------
> >> >>  1 file changed, 14 insertions(+), 14 deletions(-)
> >> >> 
> >> >> diff --git a/block/gluster.c b/block/gluster.c
> >> >> index 6fbcf9e..35a7abb 100644
> >> >> --- a/block/gluster.c
> >> >> +++ b/block/gluster.c
> >> >> @@ -480,7 +480,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
> >> >>                                    QDict *options, Error **errp)
> >> >>  {
> >> >>      QemuOpts *opts;
> >> >> -    GlusterServer *gsconf;
> >> >> +    GlusterServer *gsconf = NULL;
> >> >>      GlusterServerList *curr = NULL;
> >> >>      QDict *backing_options = NULL;
> >> >>      Error *local_err = NULL;
> >> >> @@ -529,17 +529,16 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
> >> >>          }
> >> >>  
> >> >>          ptr = qemu_opt_get(opts, GLUSTER_OPT_TYPE);
> >> >> +        if (!ptr) {
> >> >> +            error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_TYPE);
> >> >> +            error_append_hint(&local_err, GERR_INDEX_HINT, i);
> >> >> +            goto out;
> >> >> +
> >> >> +        }
> >> >>          gsconf = g_new0(GlusterServer, 1);
> >> >>          gsconf->type = qapi_enum_parse(GlusterTransport_lookup, ptr,
> >> >> -                                       GLUSTER_TRANSPORT__MAX,
> >> >> -                                       GLUSTER_TRANSPORT__MAX,
> >> >> +                                       GLUSTER_TRANSPORT__MAX, 0,
> >> >
> >> > What is the reason to set the default to 0 and not the more readable
> >> > GLUSTER_TRANSPORT_UNIX?
> >> 
> >> I chose 0 because the actual value must not matter: we don't want a
> >> default here.
> >> 
> >> qapi_enum_parse() returns this argument when ptr isn't found.  If ptr is
> >> non-null, it additionally sets an error.  Since ptr can't be null here,
> >> the argument is only returned together with an error.  But then we won't
> >> use *gsconf.
> >
> > Ah, right, I that see now.
> >
> >> Do you think -1 instead of 0 would be clearer?
> >
> > Yes, it would be to me. -1 is clearly not part of the GLUSTER_TRANSPORT_*
> > enum, so it suggests it is a different case.
> >
> > Thanks!
> 
> I'll change it.
> 
> May I add your R-by then?

Yes, of course.

Thanks,
Niels
