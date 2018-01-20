Received: from eggs.gnu.org ([2001:4830:134:3::10]:57070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ed1Ew-0000X7-V1
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 17:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ed1Et-000648-GD
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 17:03:54 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1ed1Et-00063r-79
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 17:03:51 -0500
Date: Sat, 20 Jan 2018 17:03:49 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180120220349.GA20376@flamenco>
References: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
	<20180112171416.6048ae9e@bahia.lan>
	<e059ddfb-030d-98b6-8e6e-4938270bcebf@huawei.com>
	<20180119112733.4a9dd43f@bahia.lan>
	<20180120000506.GA3859@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180120000506.GA3859@flamenco>
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

On Fri, Jan 19, 2018 at 19:05:06 -0500, Emilio G. Cota wrote:
> > > > On Fri, 12 Jan 2018 19:32:10 +0800
> > > > Antonios Motakis <antonios.motakis@huawei.com> wrote:
> > > Since inodes are not completely random, and we usually have a handful of device IDs,
> > > we get a much smaller number of entries to track in the hash table.
> > > 
> > > So what this would give:
> > > (1)	Would be faster and take less memory than mapping the full inode_nr,devi_id
> > > tuple to unique QID paths
> > > (2)	Guaranteed not to run out of bits when inode numbers stay below the lowest
> > > 54 bits and we have less than 1024 devices.
> > > (3)	When we get beyond this this limit, there is a chance we run out of bits to
> > > allocate new QID paths, but we can detect this and refuse to serve the offending
> > > files instead of allowing a collision.
> > > 
> > > We could tweak the prefix size to match the scenarios that we consider more likely,
> > > but I think close to 10-16 bits sounds reasonable enough. What do you think?
> 
> Assuming assumption (2) is very likely to be true, I'd suggest
> dropping the intermediate hash table altogether, and simply refuse
> to work with any files that do not meet (2).
> 
> That said, the naive solution of having a large hash table with all entries
> in it might be worth a shot.

hmm but that would still take a lot of memory.

Given assumption (2), a good compromise would be the following,
taking into account that the number of total gids is unlikely to
reach even close to 2**64:
- bit 63: 0/1 determines "fast" or "slow" encoding
- 62-0:
  - fast (trivial) encoding: when assumption (2) is met
    - 62-53: device id (it fits because of (2))
    - 52-0: inode (it fits because of (2))
  - slow path: assumption (2) isn't met. Then, assign incremental
    IDs in the [0,2**63-1] range and track them in a hash table.

Choosing 10 or whatever else bits for the device id is of course TBD,
as Antonios you pointed out.

Something like this will give you great performance and 0 memory
overhead for the majority of cases if (2) indeed holds.

		Emilio
