Received: from eggs.gnu.org ([2001:4830:134:3::10]:42687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eN4x5-0007iv-Ev
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eN4x4-0001Rn-F8
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:47:35 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
	<40392ab9-ec2a-30ed-ddab-a557682a4192@virtuozzo.com>
	<4e4e28d7-aebc-4a86-e691-99afdcca27f5@redhat.com>
	<20171121172324.GC11073@localhost.localdomain>
	<1a8e9d48-5be1-e014-41ee-a1164f32dd17@redhat.com>
	<20171207115648.5mnvoyfnig7dhgbn@eukaryote>
From: John Snow <jsnow@redhat.com>
Message-ID: <a172b331-77c7-f7bb-5bd1-2e59f0fdcde4@redhat.com>
Date: Thu, 7 Dec 2017 17:47:19 -0500
MIME-Version: 1.0
In-Reply-To: <20171207115648.5mnvoyfnig7dhgbn@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mnestratov@virtuozzo.com, armbru@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com



On 12/07/2017 06:56 AM, Kashyap Chamarthy wrote:
> On Tue, Nov 21, 2017 at 07:10:19PM -0500, John Snow wrote:
>> On 11/21/2017 12:23 PM, Kevin Wolf wrote:
> 
> [...] # Snip lot of good discussion.
> 
>>> On another note, I would double check before adding a new block job type
>>> that this is the right way to go. We have recently noticed that many, if
>>> not all, of the existing block jobs (at least mirror, commit and backup)
>>> are so similar that they implement the same things multiple times and
>>> are just lacking different options and have different bugs. I'm
>>> seriously considering merging all of them into a single job type
>>> internally that just provides options that effectively turn it into one
>>> of the existing job types.
>>>
>>
>> I'm not particularly opposed. At the very, very least "backup" and
>> "mirror" are pretty much the same thing and "stream" and "commit" are
>> basically the same.
>>
>> Forcing the backuppy-job and the consolidatey-job together seems like an
>> ever-so-slightly harder case to make, but I suppose the truth of the
>> matter in all cases is that we're copying data from one node to another...
> 
> So from the above interesting discussion, it seems like Kevin is leaning
> towards a single job type that offers 'stream', 'commit', 'backup', and
> 'mirror' functionality as part of a single command / job type.  Based on
> an instinct, this sounds a bit too stuffy and complex to me.
> 
> And John seems to be leaning towards two block device job types:
> 
>   - 'blockdev-foo' that offers both current 'stream' and 'commit'
>     functionality as two different options to the same QMP command; and
> 
>   - 'blockdev-bar' will offer both 'mirror' and 'backup' functionality
>     as part of the same QMP command
> 
> FWIW, this seems a bit more palatable, as it is unifying
> similar-functionality-that-differ-slightly into two distinct commands.
> 
> (/me is still wrapping his head around the bitmaps and incremental
> backups infrastructure.)
> 

The discussion you're honing in on is tangential to the one at the heart
of this topic, which is:

"What's the right API for pull model incremental backups?" which digs up
the question "What is the right API for our existing data copying commands?"

Kevin is probably right in the end, though; he usually is. We do need to
unify our data moving logic to avoid fixing the same bugs in four
different but nearly identical jobs.

My only concern is that the special casing will grow too complex for
that one unified job and the job will become so complicated nobody knows
how to work on it anymore without breaking other cases. Maybe this is a
reasonable concern, maybe it isn't.

I'm also not in a hurry to personally unify the loops myself, but if
someone did, they could CC me and I'd review it thoroughly.

We'd find out in a hurry from the implementation if unification was a
win for SLOC.

--js
