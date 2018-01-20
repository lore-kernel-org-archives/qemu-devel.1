Received: from eggs.gnu.org ([2001:4830:134:3::10]:44313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ecgem-000528-Pn
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 19:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ecgej-0002Lq-BX
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 19:05:12 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1ecgei-0002Ig-Uy
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 19:05:09 -0500
Date: Fri, 19 Jan 2018 19:05:06 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180120000506.GA3859@flamenco>
References: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
	<20180112171416.6048ae9e@bahia.lan>
	<e059ddfb-030d-98b6-8e6e-4938270bcebf@huawei.com>
	<20180119112733.4a9dd43f@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180119112733.4a9dd43f@bahia.lan>
Subject: Re: [Qemu-devel] [RFC] qid path collision issues in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Antonios Motakis <antonios.motakis@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Veaceslav Falico <veaceslav.falico@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, Eduard Shishkin <Eduard.Shishkin@huawei.com>, "vfalico@gmail.com" <vfalico@gmail.com>, "Wangguoli (Andy)" <andy.wangguoli@huawei.com>, Jiangyiwen <jiangyiwen@huawei.com>, "zhangwei (CR)" <zhangwei555@huawei.com>

On Fri, Jan 19, 2018 at 11:27:33 +0100, Greg Kurz wrote:
> On Mon, 15 Jan 2018 11:49:31 +0800
> Antonios Motakis <antonios.motakis@huawei.com> wrote:
> > On 13-Jan-18 00:14, Greg Kurz wrote:
> > > On Fri, 12 Jan 2018 19:32:10 +0800
> > > Antonios Motakis <antonios.motakis@huawei.com> wrote:
(snip)
> > >> To avoid this situation, the device id of a file needs to be also taken as
> > >> input for generating a qid path. Unfortunately, the size of both inode
> > >> nr + device id together would be 96 bits, while we have only 64 bits
> > >> for the qid path, so we can't just append them and call it a day :(
(snip)
> > >>
> > >> We have thought of a few approaches, but we would definitely like to hear
> > >> what the upstream maintainers and community think:
(snip)
> > >> * Fallback and/or interim solutions
(snip)
> > >> 3. other ideas, such as allocating new qid paths and keep a look up table of some sorts (possibly too expensive)
> > >>  
> > > 
> > > This would be acceptable for fallback.  
> > 
> > Maybe we can use the QEMU hash table (https://github.com/qemu/qemu/blob/master/util/qht.c) but I wonder
> > if it scales to millions of entries. Do you think it is appropriate in this case?
> 
> I don't know QHT, hence Cc'ing Emilio for insights.

QHT stores a 32-bit hash per entry, so with perfect hashing one wouldn't
see collisions (and the subsequent performance drop) below 2**32 entries.
So yes, millions of entries are supported.

Wrt memory overhead, each entry takes 12 bytes on 64-bit hosts
and 8 bytes on 32-bit hosts (pointer + hash). However, we have to account
for empty or partially filled buckets, as well as bucket overhead (header,
tail and lock), so on 64-bit we can approximate the overhead to 32 bytes
per entry. Given that inode sizes are >128 bytes, memory overhead
[size(ht) / size(index)] would be at most 25%. (See below for some
suggestions to lower this.)

> > I was thinking on how to implement something like this, without having to maintain
> > millions of entries... One option we could consider is to split the bits into a
> > directly-mapped part, and a lookup part. For example:
> > 
> > Inode =
> > [ 10 first bits ] + [ 54 lowest bits ]
> > 
> > A hash table maps [ inode 10 first bits ] + [ device id ] => [ 10 bit prefix ]
> > The prefix is uniquely allocated for each input.
> > 
> > Qid path = 
> > [ 10 bit prefix ] + [ inode 54 lowest bits ]
> > 
> > Since inodes are not completely random, and we usually have a handful of device IDs,
> > we get a much smaller number of entries to track in the hash table.
> > 
> > So what this would give:
> > (1)	Would be faster and take less memory than mapping the full inode_nr,devi_id
> > tuple to unique QID paths
> > (2)	Guaranteed not to run out of bits when inode numbers stay below the lowest
> > 54 bits and we have less than 1024 devices.
> > (3)	When we get beyond this this limit, there is a chance we run out of bits to
> > allocate new QID paths, but we can detect this and refuse to serve the offending
> > files instead of allowing a collision.
> > 
> > We could tweak the prefix size to match the scenarios that we consider more likely,
> > but I think close to 10-16 bits sounds reasonable enough. What do you think?

Assuming assumption (2) is very likely to be true, I'd suggest
dropping the intermediate hash table altogether, and simply refuse
to work with any files that do not meet (2).

That said, the naive solution of having a large hash table with all entries
in it might be worth a shot. With QHT and a good hash function
like xxhash, you'd support parallel lookups and at worst it'd add
an extra last-level cache miss per file operation (~300 cycles),
which on average would be dwarfed by the corresponding I/O latency.

This should be easy to implement and benchmark, so I think it is
worth trying -- you might not need to fiddle with the protocol
after all.

BTW since hashing here would be very simple, we could have a variant
of QHT where only pointers are kept in the buckets, thereby lowering
memory overhead. We could also play with the resizing algorithm to
make it less aggresive so that we end up with less (and fuller) buckets.

Thanks,

		E.
