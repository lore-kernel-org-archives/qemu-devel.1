Received: from eggs.gnu.org ([2001:4830:134:3::10]:38382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ffpST-0006Mn-Hc
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ffpSQ-0001qd-Cs
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:37:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ffpSQ-0001q9-7N
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:37:42 -0400
Date: Wed, 18 Jul 2018 10:37:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180718103736.2406cdc8@t450s.home>
In-Reply-To: <20180718064015.GI20520@xz-mi>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180717224737.14019.3324.stgit@gimli.home>
	<20180718064015.GI20520@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] balloon: Allow nested inhibits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Wed, 18 Jul 2018 14:40:15 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Jul 17, 2018 at 04:47:37PM -0600, Alex Williamson wrote:
> > A simple true/false internal state does not allow multiple users.  Fix
> > this within the existing interface by converting to a counter, so long
> > as the counter is elevated, ballooning is inhibited.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  balloon.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/balloon.c b/balloon.c
> > index 6bf0a9681377..2a6a7e1a22a0 100644
> > --- a/balloon.c
> > +++ b/balloon.c
> > @@ -37,16 +37,17 @@
> >  static QEMUBalloonEvent *balloon_event_fn;
> >  static QEMUBalloonStatus *balloon_stat_fn;
> >  static void *balloon_opaque;
> > -static bool balloon_inhibited;
> > +static int balloon_inhibited;
> >  
> >  bool qemu_balloon_is_inhibited(void)
> >  {
> > -    return balloon_inhibited;
> > +    return balloon_inhibited > 0;
> >  }
> >  
> >  void qemu_balloon_inhibit(bool state)
> >  {
> > -    balloon_inhibited = state;
> > +    balloon_inhibited += (state ? 1 : -1);
> > +    assert(balloon_inhibited >= 0);  
> 
> Better do it atomically?

I'd assumed we're protected by the BQL anywhere this is called.  Is
that not the case?  Generally when I try to add any sort of locking to
QEMU it's shot down because the code paths are already serialized.
Thanks,

Alex
