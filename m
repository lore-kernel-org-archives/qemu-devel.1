Received: from eggs.gnu.org ([2001:4830:134:3::10]:47190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOfi4-0002re-Gk
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOfi0-0004tD-O8
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:46:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fOfi0-0004sX-HU
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:46:52 -0400
Date: Fri, 1 Jun 2018 09:46:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180601084647.GA2531@work-vm>
References: <cover.1527814874.git.keno@juliacomputing.com>
	<1f6bc60305b8c1cd00f5e2a361a05d7b4bc56338.1527814874.git.keno@juliacomputing.com>
	<20180601101531.4f3dd234@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601101531.4f3dd234@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 01/20] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Keno Fischer <keno@juliacomputing.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

* Greg Kurz (groug@kaod.org) wrote:
> On Thu, 31 May 2018 21:25:56 -0400
> Keno Fischer <keno@juliacomputing.com> wrote:
> 
> > strchrnul is a GNU extension and thus unavailable on a number of targets.
> > In the review for a commit removing strchrnul from 9p, I was asked to
> > create a qemu_strchrnul helper to factor out this functionality.
> > Do so, and use it in a number of other places in the code base that inlined
> > the replacement pattern in a place where strchrnul could be used.
> > 
> > Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> > ---
> > 
> 
> And possibly we could detect in configure if the host has strchrnul() and
> use it, but this optimization can be done later.
> 
> I haven't checked if there could be other candidates in the current code
> base though. Also, this patch touches some other subsystems, so I'm Cc'ing
> to the other maintainers as reported by ./scripts/get_maintainer.pl:

That looks fine from my point of view;  I can see you could probably
also use it in the code at the start of the while loop in hmp_sendkey:

    while (1) {
        separator = strchr(keys, '-');
        keyname_len = separator ? separator - keys : strlen(keys);

Dave

> Greg Kurz <groug@kaod.org> (supporter:virtio-9p)
> Markus Armbruster <armbru@redhat.com> (supporter:QMP)
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> (maintainer:Human Monitor (HMP))
> qemu-devel@nongnu.org (open list:All patches CC here)
> 
> Anyway,
> 
> Acked-by: Greg Kurz <groug@kaod.org>
> 
> > Changes since v1: New patch
> > 
> >  hw/9pfs/9p-local.c    |  2 +-
> >  include/qemu/cutils.h |  1 +
> >  monitor.c             |  8 ++------
> >  util/cutils.c         | 13 +++++++++++++
> >  util/qemu-option.c    |  6 +-----
> >  util/uri.c            |  6 ++----
> >  6 files changed, 20 insertions(+), 16 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index b37b1db..bcf2798 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -65,7 +65,7 @@ int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
> >          assert(*path != '/');
> >  
> >          head = g_strdup(path);
> > -        c = strchrnul(path, '/');
> > +        c = qemu_strchrnul(path, '/');
> >          if (*c) {
> >              /* Intermediate path element */
> >              head[c - path] = 0;
> > diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> > index a663340..bc40c30 100644
> > --- a/include/qemu/cutils.h
> > +++ b/include/qemu/cutils.h
> > @@ -122,6 +122,7 @@ int qemu_strnlen(const char *s, int max_len);
> >   * Returns: the pointer originally in @input.
> >   */
> >  char *qemu_strsep(char **input, const char *delim);
> > +const char *qemu_strchrnul(const char *s, int c);
> >  time_t mktimegm(struct tm *tm);
> >  int qemu_fdatasync(int fd);
> >  int fcntl_setfl(int fd, int flag);
> > diff --git a/monitor.c b/monitor.c
> > index 922cfc0..e1f01c4 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -798,9 +798,7 @@ static int compare_cmd(const char *name, const char *list)
> >      p = list;
> >      for(;;) {
> >          pstart = p;
> > -        p = strchr(p, '|');
> > -        if (!p)
> > -            p = pstart + strlen(pstart);
> > +        p = qemu_strchrnul(p, '|');
> >          if ((p - pstart) == len && !memcmp(pstart, name, len))
> >              return 1;
> >          if (*p == '\0')
> > @@ -3401,9 +3399,7 @@ static void cmd_completion(Monitor *mon, const char *name, const char *list)
> >      p = list;
> >      for(;;) {
> >          pstart = p;
> > -        p = strchr(p, '|');
> > -        if (!p)
> > -            p = pstart + strlen(pstart);
> > +        p = qemu_strchrnul(p, '|');
> >          len = p - pstart;
> >          if (len > sizeof(cmd) - 2)
> >              len = sizeof(cmd) - 2;
> > diff --git a/util/cutils.c b/util/cutils.c
> > index 0de69e6..6e078b0 100644
> > --- a/util/cutils.c
> > +++ b/util/cutils.c
> > @@ -545,6 +545,19 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
> >  }
> >  
> >  /**
> > + * Searches for the first occurrence of 'c' in 's', and returns a pointer
> > + * to the trailing null byte if none was found.
> > + */
> > +const char *qemu_strchrnul(const char *s, int c)
> > +{
> > +    const char *e = strchr(s, c);
> > +    if (!e) {
> > +        e = s + strlen(s);
> > +    }
> > +    return e;
> > +}
> > +
> > +/**
> >   * parse_uint:
> >   *
> >   * @s: String to parse
> > diff --git a/util/qemu-option.c b/util/qemu-option.c
> > index 58d1c23..54eca12 100644
> > --- a/util/qemu-option.c
> > +++ b/util/qemu-option.c
> > @@ -77,11 +77,7 @@ const char *get_opt_value(const char *p, char **value)
> >  
> >      *value = NULL;
> >      while (1) {
> > -        offset = strchr(p, ',');
> > -        if (!offset) {
> > -            offset = p + strlen(p);
> > -        }
> > -
> > +        offset = qemu_strchrnul(p, ',');
> >          length = offset - p;
> >          if (*offset != '\0' && *(offset + 1) == ',') {
> >              length++;
> > diff --git a/util/uri.c b/util/uri.c
> > index 8624a7a..8bdef84 100644
> > --- a/util/uri.c
> > +++ b/util/uri.c
> > @@ -52,6 +52,7 @@
> >   */
> >  
> >  #include "qemu/osdep.h"
> > +#include "qemu/cutils.h"
> >  
> >  #include "qemu/uri.h"
> >  
> > @@ -2266,10 +2267,7 @@ struct QueryParams *query_params_parse(const char *query)
> >          /* Find the next separator, or end of the string. */
> >          end = strchr(query, '&');
> >          if (!end) {
> > -            end = strchr(query, ';');
> > -        }
> > -        if (!end) {
> > -            end = query + strlen(query);
> > +            end = qemu_strchrnul(query, ';');
> >          }
> >  
> >          /* Find the first '=' character between here and end. */
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
