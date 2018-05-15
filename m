Received: from eggs.gnu.org ([2001:4830:134:3::10]:60640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIV1z-0007Jo-4K
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIV1x-0000nt-TJ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:09:59 -0400
Date: Tue, 15 May 2018 10:09:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180515100949.248bc43b.cohuck@redhat.com>
In-Reply-To: <d17ae62a-03a5-61fa-934a-4cb917d14222@redhat.com>
References: <20180515063128.7040-1-olaf@aepfle.de>
	<d17ae62a-03a5-61fa-934a-4cb917d14222@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] replace functions which are only
 available in glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:All patches
	CC here" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org

On Tue, 15 May 2018 09:18:52 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 15.05.2018 08:31, Olaf Hering wrote:
> > Currently the minimal supported version of glib is 2.22.
> > Since testing is done with a glib that claims to be 2.22, but in fact
> > has APIs from newer version of glib, this bug was not caught during
> > submit of the patch referenced below.
> > 
> > Replace g_realloc_n, which is available only since 2.24, with g_renew.
> > 
> > Fixes commit 418026ca43 ("util: Introduce vfio helpers")
> > 
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> > ---
> >  This must go into stable-2.12.  
> 
> In that case please CC: qemu-stable@nongnu.org (done now).
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> >  util/vfio-helpers.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> > index 006674c916..1d9272efa4 100644
> > --- a/util/vfio-helpers.c
> > +++ b/util/vfio-helpers.c
> > @@ -522,8 +522,7 @@ static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
> >  
> >      assert(index >= 0);
> >      s->nr_mappings++;
> > -    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
> > -                              s->nr_mappings);
> > +    s->mappings = g_renew(IOVAMapping, s->mappings, s->nr_mappings);
> >      insert = &s->mappings[index];
> >      shift = s->nr_mappings - index - 1;
> >      if (shift) {
> > @@ -577,8 +576,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping,
> >      memmove(mapping, &s->mappings[index + 1],
> >              sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
> >      s->nr_mappings--;
> > -    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
> > -                              s->nr_mappings);
> > +    s->mappings = g_renew(IOVAMapping, s->mappings, s->nr_mappings);
> >  }
> >  
> >  /* Check if the mapping list is (ascending) ordered. */
> >   

This looks fine to me, so

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

But this leads to another question: What do we do if we want a fix only
in stable? Hypothetical scenario: Same parameters as for this patch
(glib version bump, newer function sneaked in), but the older function
that could be used in stable is clearly worse (IOW, we don't want it in
the new version). Do we have a process to get a change only into stable?
