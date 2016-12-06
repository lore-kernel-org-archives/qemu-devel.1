Received: from eggs.gnu.org ([2001:4830:134:3::10]:52830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cED0M-0003cn-9d
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cED0L-00085v-JD
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:29:46 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161206092523.GA4990@noname.str.redhat.com>
Date: Tue, 6 Dec 2016 10:29:41 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <91388FFC-7F1A-446A-92CF-9BA645E68BE6@alex.org.uk>
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161206092523.GA4990@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Eric Blake <eblake@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, xieyingtai@huawei.com, subo7@huawei.com, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


> On 6 Dec 2016, at 09:25, Kevin Wolf <kwolf@redhat.com> wrote:
> 
> Am 06.12.2016 um 00:42 hat Eric Blake geschrieben:
>> While not directly related to NBD_CMD_WRITE_ZEROES, the qemu
>> team discovered that it is useful if a server can advertise
>> whether an export is in a known-all-zeroes state at the time
>> the client connects.
> 
> Does a server usually have the information to set this flag, other than
> querying the block status of all blocks at startup? 

The server may have other ways of knowing this, for instance
that it has just created the file (*), or that it stat'd the file
before opening it (not unlikely) and noticed it had 0 allocated
size. The latter I suspect would be trivial to implement in nbd-server

(*) = e.g. I had one application where nbd use the export path
to signify it wanted to open a temporary file, the path consisting
of a UUID and an encoded length. If the file was not present already
it created it with ftruncate(). That could trivially have used this.

> If so, the client could just query this by itself.

Well there's no currently mainlined extension to do that, but yes
it could. On the other hand I see no issue passing complete
zero status back to the client if it's so obvious from a stat().

-- 
Alex Bligh
