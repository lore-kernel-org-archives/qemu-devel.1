Received: from eggs.gnu.org ([2001:4830:134:3::10]:56559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYEse-0002nu-UE
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 13:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYEsb-0004MH-4X
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 13:04:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dYEsa-0004Lx-RY
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 13:04:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9A6D2F86D3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 17:04:47 +0000 (UTC)
Date: Thu, 20 Jul 2017 18:04:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170720170443.GG2456@work-vm>
References: <20170407143847.GM2138@work-vm> <20170720105004.GA26866@redhat.com>
	<20170720161548.GC2456@work-vm> <20170720164730.GP21566@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170720164730.GP21566@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Thu, Jul 20, 2017 at 05:15:49PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > On Fri, Apr 07, 2017 at 03:38:47PM +0100, Dr. David Alan Gilbert wrote:
> > > > Hi,
> > > >    Fedora 26 has gcc 7.0.1 which has the normal compliment
> > > > of new fussy warnings; so far I've posted :
> > > > 
> > > > tests/check-qdict: Fix missing brackets
> > > > slirp/smb: Replace constant strings by glib string
> > > > 
> > > > that fix one actual mistake and work around something it's being
> > > > fussy over.
> > > > 
> > > > But I've also got a pile of hacks, attached below that I'm
> > > > not too sure what I'll do with them yet, but they're attached
> > > > for anyone else trying to build.  Note they're smoke-only-tested.
> > > > 
> > > > I also have gcc bug https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80346
> > > > filed for what I reckon is a couple of overly pessimistic warnings.
> > > 
> > > 
> > > > diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> > > > index bd9fd55b0a..ebb0221140 100644
> > > > --- a/include/qemu/iov.h
> > > > +++ b/include/qemu/iov.h
> > > > @@ -46,7 +46,7 @@ static inline size_t
> > > >  iov_from_buf(const struct iovec *iov, unsigned int iov_cnt,
> > > >               size_t offset, const void *buf, size_t bytes)
> > > >  {
> > > > -    if (__builtin_constant_p(bytes) && iov_cnt &&
> > > > +    if (__builtin_constant_p(bytes) && iov_cnt && bytes <= INT_MAX &&
> > > >          offset <= iov[0].iov_len && bytes <= iov[0].iov_len - offset) {
> > > >          memcpy(iov[0].iov_base + offset, buf, bytes);
> > > >          return bytes;
> > > > @@ -59,7 +59,7 @@ static inline size_t
> > > >  iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
> > > >             size_t offset, void *buf, size_t bytes)
> > > >  {
> > > > -    if (__builtin_constant_p(bytes) && iov_cnt &&
> > > > +    if (__builtin_constant_p(bytes) && iov_cnt && bytes <= INT_MAX &&
> > > >          offset <= iov[0].iov_len && bytes <= iov[0].iov_len - offset) {
> > > >          memcpy(buf, iov[0].iov_base + offset, bytes);
> > > >          return bytes;
> > 
> > tbh I don't know what the right fix for this is;  the gcc discussion
> > confused me as to why it thinks it can be a valid case.
> 
> Even if gcc is broken in issuing a warning here, we still need to
> make it quiet so people on F26 and similarly new distros can build
> without warnings.

I agree.

> IMHO your patch is ok, or we could be alittle more explicit about
> catching just the case where you pass -1 for bytes, and have
> 
>   && bytes != -1

This seems bizarre to me since bytes is   size_t bytes   and size_t
is unsigned, so I'd have sympathy for a compiler that warned that
bytes != -1 was always true.

Dave

> 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
