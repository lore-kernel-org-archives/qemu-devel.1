Received: from eggs.gnu.org ([2001:4830:134:3::10]:49578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgrCU-0000oT-RD
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgrCR-0001cW-Lq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:04:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cgrCR-0001cM-Ge
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:04:39 -0500
Date: Thu, 23 Feb 2017 11:04:33 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170223110433.GL10047@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170220185020.774-1-dgilbert@redhat.com>
	<20170220185020.774-5-dgilbert@redhat.com>
	<8760k3od2r.fsf@emacs.mitica> <20170223105155.GA2383@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223105155.GA2383@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] slirp: VMStatify socket level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, samuel.thibault@ens-lyon.org, qemu-devel@nongnu.org, jan.kiszka@siemens.com

On Thu, Feb 23, 2017 at 10:51:56AM +0000, Dr. David Alan Gilbert wrote:
> Samual, Jan: Can you just take 1-3 of this series;  4 has a problem;
> 
> * Juan Quintela (quintela@redhat.com) wrote:
> > "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >
> > > Working up the stack, this replaces the slirp_socket_load/save
> > > with VMState definitions.
> > >
> > > A place holder for IPv6 support is added as a comment; it needs
> > > testing once the rest of the IPv6 code is there.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > 
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > 
> > 
> > > +/* Win has a signed family number */
> > > +#define VMSTATE_SS_FAMILY(f, s) VMSTATE_INT16(f, s)
> > 
> > Great!
> > Just hope that there is no 32000 families soon :-)
> 
> Actually; that's a problem;  it turns out FreeBSD has a char for it's
> family type rahter than the uint16 that linux and windows have.
> I need to think hth to abstract that.

What, if any, promises have we made about the migration data format
being ABI stable across platforms ?

It strikes me that even if FreeBSD & Linux had the same sized type
for ss_family, the constants used to popuate it might be different
on each platform. eg AF_INET6 is 10 on Linux but 23 on Mingw and
probably something else again on FreeBSD.

IOW if we transmit this data on the wire, we've effectively said that
our migration data format is *not* portable across different host OS
platforms. At that point, sending different sized types on BSD vs
Linux is no big deal since we're already incompatible semantically.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
