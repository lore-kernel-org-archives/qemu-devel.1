Received: from eggs.gnu.org ([2001:4830:134:3::10]:54894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQIEI-0003jL-7R
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQIEH-0003DA-3t
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:06:54 -0400
Date: Tue, 5 Jun 2018 23:06:41 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605225717-mutt-send-email-mst@kernel.org>
References: <20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<20180605190324.GA11372@localhost.localdomain>
	<20180605223934-mutt-send-email-mst@kernel.org>
	<a9fdbe0f-2c39-7da3-11f2-6752b74cce08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9fdbe0f-2c39-7da3-11f2-6752b74cce08@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 05, 2018 at 02:54:07PM -0500, Eric Blake wrote:
> On 06/05/2018 02:47 PM, Michael S. Tsirkin wrote:
> 
> > > > Layer 1:
> > > >     The string shall always be a JSON 'object'; i.e. of the form
> > > >      { "something": ... , "more": ... }
> > > > 
> > > >     The key strings shall be non-null and non-empty and shall
> > > >     be unique.
> 
> > > 
> > > I think it would be simpler if layer 0 simply provided a list of
> > > names/value pairs, where names are ascii strings, and values are
> > > binary data[1].  It would make layer 1 unnecessary, and allow (3)
> > > and (4) to happen.
> > > 
> > > [1] In other words, Rich's proposal of "named blobs":
> > > https://www.mail-archive.com/qemu-block@nongnu.org/msg37856.html
> > 
> > I think simple is beautiful, too. But assuming they
> > really are binary how are blobs encoded?
> > Did binary really mean UTF-8 here?
> 
> Binary blobs can always be base64 encoded for representation within a valid
> JSON UTF-8 string (and we already have several QMP interfaces that utilize
> base64 encoding to pass through what is otherwise invalid UTF-8).  It does
> inflate things slightly compared to a format that allows a raw length
> coupled with raw data, but that is not necessarily a problem.

OK so what's proposed here is something like the following:

[A-Za-z][^=\0]*=[^\0]*

Sound reasonable?

How about a fixed key at the beginning to specify the format?

E.g. 16 first bytes:

qcow2-format=00\0

anything else in first 16 bytes means some other format?

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
