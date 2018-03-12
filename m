Received: from eggs.gnu.org ([2001:4830:134:3::10]:47194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evNBs-000448-Dl
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evNBp-0006fY-6h
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:08:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evNBp-0006es-28
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:08:33 -0400
Date: Mon, 12 Mar 2018 13:08:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312130829.GR3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180311201239.25506-1-nia.alarie@gmail.com>
	<486e1b60-e453-c3de-040b-8b2951ddf3a5@redhat.com>
	<20180312140229.66930d5d@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312140229.66930d5d@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] 9p: Convert use of atoi to qemu_strtol to
 allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Eric Blake <eblake@redhat.com>, Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au

On Mon, Mar 12, 2018 at 02:02:29PM +0100, Greg Kurz wrote:
> On Mon, 12 Mar 2018 07:12:52 -0500
> Eric Blake <eblake@redhat.com> wrote:
> 
> > On 03/11/2018 03:12 PM, Nia Alarie wrote:
> > > Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> > > ---
> > >   hw/9pfs/9p.c | 12 ++++++++++--
> > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > >   
> > 
> > >       } else if (perm & P9_STAT_MODE_LINK) {
> > > -        int32_t ofid = atoi(extension.data);
> > > -        V9fsFidState *ofidp = get_fid(pdu, ofid);
> > > +        long ofid;
> > > +        V9fsFidState *ofidp;
> > > +
> > > +        if (qemu_strtol(extension.data, NULL, 10, &ofid) ||
> > > +            ofid > INT32_MAX || ofid < INT32_MIN) {  
> > 
> > Dan has a pending patch that will add qemu_strtoi, which might be a 
> > nicer fit for this situation:
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00952.html
> > 
> > int32_t is not necessarily int, but all platforms that compile qemu have 
> > 'int32_t' and 'int' both at 32 bits, so it's simpler to change to 'int 
> > ofid' and use Dan's function than it is to parse to long and then do 
> > bounds checking.  Except that Dan still needs to post an updated version 
> > of his patch...
> > 
> 
> I wasn't aware of Dan's patch but I agree it would result in a nicer
> change for 9p. This being said, tomorrow is soft freeze... is there
> a chance Dan's patch reaches master anytime soon ?

I just sent an update of my series. If it gets acked by Eric, I'd be able
to send a pull request today.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
