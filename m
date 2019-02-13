Received: from eggs.gnu.org ([209.51.188.92]:60974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sir@cmpwn.com>) id 1gtvDI-0006hQ-8Q
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sir@cmpwn.com>) id 1gtvA8-0005XD-W3
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:05:23 -0500
Date: Wed, 13 Feb 2019 09:05:09 -0500
From: Drew DeVault <sir@cmpwn.com>
Message-ID: <20190213140509.GB1628@homura.localdomain>
References: <20190212214216.GA17279@homura.localdomain>
	<871s4ckyq7.fsf@dusky.pond.sub.org>
	<20190213104656.GC994@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213104656.GC994@localhost.localdomain>
Subject: Re: [Qemu-devel] Combining -loadvm and -snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 2019-02-13 11:46 AM, Kevin Wolf wrote:
> Reading from the backing file would be correct in your special case
> (because the overlay was only just created and doesn't contain data
> yet), but generally speaking, this would make the disk content
> inconsistent because it would mix newer data from the overlay with old
> data from the snapshot in the backing file.
> 
> But before I make suggestions how this could be addressed (it's probably
> not trivial), let me ask what your real goal is?
> 
> I'm asking because when you start a VM with '-loadvm foo', this means
> that you already got a snapshot at this exact point. So the guest will
> write to the qcow2 file, but when you start the VM the next time, and
> again with '-loadvm foo', the newly written data will be discarded and
> QEMU will revert to the snapshot 'foo' again. So you already got the
> same functionality that -snapshot is supposed to provide, even without
> using it.
> 
> Do you have other reasons why you want to use -snapshot?

The issue is that if I start with -loadvm foo, it will start from the
foo snapshot, but any changes will be written to disk. Since qcow2 is a
sparse format, a mean guest could fill up all of the sectors and balloon
the underlying disk. The next guest starts from the snapshot, too - but
the host is wasting disk space. I'm also not able to run several guests
from the same qcow2 at once - which is a non-starter.
