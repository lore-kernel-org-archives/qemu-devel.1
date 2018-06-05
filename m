Received: from eggs.gnu.org ([2001:4830:134:3::10]:59784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQIZm-0006Pb-Pt
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQIZl-0006sk-Rm
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:29:06 -0400
Date: Tue, 5 Jun 2018 23:28:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605231419-mutt-send-email-mst@kernel.org>
References: <20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<20180605190324.GA11372@localhost.localdomain>
	<20180605223934-mutt-send-email-mst@kernel.org>
	<a9fdbe0f-2c39-7da3-11f2-6752b74cce08@redhat.com>
	<20180605195855.GC1455@redhat.com>
	<6f6ecbb5-3175-44d0-5922-b13ac163f006@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6ecbb5-3175-44d0-5922-b13ac163f006@redhat.com>
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
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 05, 2018 at 03:09:17PM -0500, Eric Blake wrote:
> On 06/05/2018 02:58 PM, Richard W.M. Jones wrote:
> > > Binary blobs can always be base64 encoded for representation within
> > > a valid JSON UTF-8 string (and we already have several QMP
> > > interfaces that utilize base64 encoding to pass through what is
> > > otherwise invalid UTF-8).  It does inflate things slightly compared
> > > to a format that allows a raw length coupled with raw data, but that
> > > is not necessarily a problem.
> > 
> > Of course how we represent them externally and/or while
> > using QMP / qemu-img to store and retrieve them is up for grabs.
> > Doesn't JSON allow binary to be encoded?  (Knowing how poorly
> > done JSON is, I wouldn't be surprised if not)
> 
> JSON itself does not have a binary primitive; to pass arbitrary data through
> JSON you have to first encode that data into something like base64 that can
> then be represented as a UTF-8 string.  For reference, look at
> qapi/crypto.json and the definition of QCryptoSecretFormat.

But there isn't a way to figure out that a string is base64, which
means each application needs to know whether it's a string or
a binary.

How about specifying the encoding in the value?

string value:
[A-Za-z][^=\0]=S[^\0]*

base64 value:
[A-Za-z][^=\0]=B[A-Za-z0-9+/]*

or the key:
S[A-Za-z][^=\0]=[^\0]*

base64 value:
B[A-Za-z][^=\0]=[A-Za-z0-9+/]*

?

-- 
MST
