Received: from eggs.gnu.org ([2001:4830:134:3::10]:33572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eeL8b-0000Sw-AB
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eeL8Y-0000GK-6K
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:30:49 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:47490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eeL8X-0000DN-Ve
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:30:46 -0500
Received: from player692.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id DFFED112468
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 14:30:41 +0100 (CET)
Date: Wed, 24 Jan 2018 14:30:31 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180124143031.7fc9c90f@bahia.lan>
In-Reply-To: <20180120220349.GA20376@flamenco>
References: <081955e1-84ec-4877-72d4-f4e8b46be350@huawei.com>
	<20180112171416.6048ae9e@bahia.lan>
	<e059ddfb-030d-98b6-8e6e-4938270bcebf@huawei.com>
	<20180119112733.4a9dd43f@bahia.lan>
	<20180120000506.GA3859@flamenco> <20180120220349.GA20376@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] qid path collision issues in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Antonios Motakis <antonios.motakis@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Veaceslav Falico <veaceslav.falico@huawei.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, Eduard Shishkin <Eduard.Shishkin@huawei.com>, "vfalico@gmail.com" <vfalico@gmail.com>, "Wangguoli (Andy)" <andy.wangguoli@huawei.com>, Jiangyiwen <jiangyiwen@huawei.com>, "zhangwei (CR)" <zhangwei555@huawei.com>

Thanks Emilio for providing these valuable suggestions ! :)

On Sat, 20 Jan 2018 17:03:49 -0500
"Emilio G. Cota" <cota@braap.org> wrote:

> On Fri, Jan 19, 2018 at 19:05:06 -0500, Emilio G. Cota wrote:
> > > > > On Fri, 12 Jan 2018 19:32:10 +0800
> > > > > Antonios Motakis <antonios.motakis@huawei.com> wrote:  
> > > > Since inodes are not completely random, and we usually have a handful of device IDs,
> > > > we get a much smaller number of entries to track in the hash table.
> > > > 
> > > > So what this would give:
> > > > (1)	Would be faster and take less memory than mapping the full inode_nr,devi_id
> > > > tuple to unique QID paths
> > > > (2)	Guaranteed not to run out of bits when inode numbers stay below the lowest
> > > > 54 bits and we have less than 1024 devices.
> > > > (3)	When we get beyond this this limit, there is a chance we run out of bits to
> > > > allocate new QID paths, but we can detect this and refuse to serve the offending
> > > > files instead of allowing a collision.
> > > > 
> > > > We could tweak the prefix size to match the scenarios that we consider more likely,
> > > > but I think close to 10-16 bits sounds reasonable enough. What do you think?  
> > 
> > Assuming assumption (2) is very likely to be true, I'd suggest
> > dropping the intermediate hash table altogether, and simply refuse
> > to work with any files that do not meet (2).
> > 
> > That said, the naive solution of having a large hash table with all entries
> > in it might be worth a shot.  
> 
> hmm but that would still take a lot of memory.
> 
> Given assumption (2), a good compromise would be the following,
> taking into account that the number of total gids is unlikely to
> reach even close to 2**64:
> - bit 63: 0/1 determines "fast" or "slow" encoding
> - 62-0:
>   - fast (trivial) encoding: when assumption (2) is met
>     - 62-53: device id (it fits because of (2))
>     - 52-0: inode (it fits because of (2))

And as pointed by Eduard, we may have to take the mount id into account
as well if we want to support the case where we have bind mounts in the
exported directory... My understanding is that mount ids are incremental
and reused when the associated fs gets unmounted: if we assume that the
host doesn't have more than 1024 mounts, we would need 10 bits to encode
it.

The fast encoding could be something like:

62-53: mount id
52-43: device id
42-0: inode

>   - slow path: assumption (2) isn't met. Then, assign incremental
>     IDs in the [0,2**63-1] range and track them in a hash table.
> 
> Choosing 10 or whatever else bits for the device id is of course TBD,
> as Antonios you pointed out.
> 

This is a best effort to have a fallback in QEMU. The right way to
address the issue would really be to extend the protocol to have
bigger qids (eg, 64 for inode, 32 for device and 32 for mount).

Cheers,

--
Greg

> Something like this will give you great performance and 0 memory
> overhead for the majority of cases if (2) indeed holds.
> 
> 		Emilio
