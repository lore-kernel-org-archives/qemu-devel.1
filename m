Received: from eggs.gnu.org ([2001:4830:134:3::10]:46292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fn1ZE-00065T-G2
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fn1ZA-0003sn-RX
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:58:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38122 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fn1ZA-0003sW-Lw
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:58:24 -0400
Date: Tue, 7 Aug 2018 13:58:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180807125819.GP7335@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
	<20180807125223.GF2556@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180807125223.GF2556@work-vm>
Subject: Re: [Qemu-devel] [PATCH for-3.0] slirp: Correct size check in
 m_inc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, patches@linaro.org, Jan Kiszka <jan.kiszka@siemens.com>, jasowang@redhat.com, qemu-devel@nongnu.org, liqsub1 <liqsub1@163.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Tue, Aug 07, 2018 at 01:52:24PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > The data in an mbuf buffer is not necessarily at the start of the
> > allocated buffer. (For instance m_adj() allows data to be trimmed
> > from the start by just advancing the pointer and reducing the length.)
> > This means that the allocated buffer size (m->m_size) and the
> > amount of space from the m_data pointer to the end of the
> > buffer (M_ROOM(m)) are not necessarily the same.
> > 
> > Commit 864036e251f54c9 tried to change the m_inc() function from
> > taking the new allocated-buffer-size to taking the new room-size,
> > but forgot to change the initial "do we already have enough space"
> > check. This meant that if we were trying to extend a buffer which
> > had a leading gap between the buffer start and the data, we might
> > incorrectly decide it didn't need to be extended, and then
> > overrun the end of the buffer, causing memory corruption and
> > an eventual crash.
> > 
> > Change the "already big enough?" condition from checking the
> > argument against m->m_size to checking against M_ROOM().
> > This only makes a difference for the callsite in m_cat();
> > the other three callsites all start with a freshly allocated
> > mbuf from m_get(), which will have m->m_size == M_ROOM(m).
> > 
> > Fixes: 864036e251f54c9

IIUC, this changeset was a security fix for CVE-2018-11806.

Given that the fix was flawed and allowed guest to crash the host
with a new buffer overrun, it seems we need to get a new CVE allocated
too.

> > Fixes: https://bugs.launchpad.net/qemu/+bug/1785670
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> > ---
> >  slirp/mbuf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/slirp/mbuf.c b/slirp/mbuf.c
> > index 0c189e1a7bf..1b7868355a3 100644
> > --- a/slirp/mbuf.c
> > +++ b/slirp/mbuf.c
> > @@ -154,7 +154,7 @@ m_inc(struct mbuf *m, int size)
> >      int datasize;
> >  
> >      /* some compilers throw up on gotos.  This one we can fake. */
> > -    if (m->m_size > size) {
> > +    if (M_ROOM(m) > size) {
> >          return;
> >      }
> >  
> > -- 
> > 2.17.1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
