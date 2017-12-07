Received: from eggs.gnu.org ([2001:4830:134:3::10]:47963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eMuna-00067c-48
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eMunZ-0005KR-9x
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:57:06 -0500
Date: Thu, 7 Dec 2017 12:56:48 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171207115648.5mnvoyfnig7dhgbn@eukaryote>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
	<40392ab9-ec2a-30ed-ddab-a557682a4192@virtuozzo.com>
	<4e4e28d7-aebc-4a86-e691-99afdcca27f5@redhat.com>
	<20171121172324.GC11073@localhost.localdomain>
	<1a8e9d48-5be1-e014-41ee-a1164f32dd17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8e9d48-5be1-e014-41ee-a1164f32dd17@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12 0/4] qmp dirty bitmap
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mnestratov@virtuozzo.com, armbru@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

On Tue, Nov 21, 2017 at 07:10:19PM -0500, John Snow wrote:
> On 11/21/2017 12:23 PM, Kevin Wolf wrote:

[...] # Snip lot of good discussion.

> > On another note, I would double check before adding a new block job type
> > that this is the right way to go. We have recently noticed that many, if
> > not all, of the existing block jobs (at least mirror, commit and backup)
> > are so similar that they implement the same things multiple times and
> > are just lacking different options and have different bugs. I'm
> > seriously considering merging all of them into a single job type
> > internally that just provides options that effectively turn it into one
> > of the existing job types.
> > 
> 
> I'm not particularly opposed. At the very, very least "backup" and
> "mirror" are pretty much the same thing and "stream" and "commit" are
> basically the same.
> 
> Forcing the backuppy-job and the consolidatey-job together seems like an
> ever-so-slightly harder case to make, but I suppose the truth of the
> matter in all cases is that we're copying data from one node to another...

So from the above interesting discussion, it seems like Kevin is leaning
towards a single job type that offers 'stream', 'commit', 'backup', and
'mirror' functionality as part of a single command / job type.  Based on
an instinct, this sounds a bit too stuffy and complex to me.

And John seems to be leaning towards two block device job types:

  - 'blockdev-foo' that offers both current 'stream' and 'commit'
    functionality as two different options to the same QMP command; and

  - 'blockdev-bar' will offer both 'mirror' and 'backup' functionality
    as part of the same QMP command

FWIW, this seems a bit more palatable, as it is unifying
similar-functionality-that-differ-slightly into two distinct commands.

(/me is still wrapping his head around the bitmaps and incremental
backups infrastructure.)

> > So even if we want to tie the bitmap management to a block job, we
> > should consider adding it as an option to the existing backup job rather
> > than adding a completely new fourth job type that again does almost the
> > same except for some bitmap mangement stuff on completion.
> > 
> 
> ...except here, where fleecing does not necessarily copy data in the
> same way.
> 
> (It probably could re-use the copy-on-write notifiers that will be
> replaced by filter nodes, but I don't see it reusing much else.)
> 
> We could try it before I naysay it, but where fleecing is concerned
> we're not using QEMU to move any bits around. It does feel pretty
> categorically different from the first four jobs.
> 
> I wouldn't want to see the franken-job be drowned in conditional
> branches for 5,000 options, either. Eliminating some redundancy is good,
> but asserting that all existing jobs (and this possible new one too)
> should all be the same makes me worry that the resulting code would be
> too complex to work with.

[...]

-- 
/kashyap
