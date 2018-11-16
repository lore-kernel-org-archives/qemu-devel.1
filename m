Received: from eggs.gnu.org ([2001:4830:134:3::10]:44289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNfvV-0003dy-6C
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNfvU-0000HZ-CD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:20:57 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <w51in0xuksv.fsf@maestria.local.igalia.com>
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
	<2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
	<w51in0xuksv.fsf@maestria.local.igalia.com>
Date: Fri, 16 Nov 2018 16:20:40 +0100
Message-ID: <w51ftw1ujzr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Fri 16 Nov 2018 04:03:12 PM CET, Alberto Garcia wrote:
>> top (T) -> intermediate (I) -> base (B)
>>
>> Now you commit from top to base.  Clearly you don't want the backing
>> chain between top and base to change.  So say you unshare the GRAPH_MOD
>> permission (implying that whenever a parent doesn't care, it just shares
>> it).  But as said above, if someone just drops the backing link from I
>> to B, the permission system won't catch that.
>
> Yes it will, because the block job (either mirror or commit depending on
> the case) is the parent of all three nodes (BlockJob.nodes is where the
> list is stored) and does not alow GRAPH_MOD in any of them[*]. So
> dropping that backing link fails (I also have a test case for that).

I forgot to add the footnote [*] in my previous e-mail:

The mirror block job (in particular when in "commit-active" mode, but
also in other cases) creates a "mirror_top" node and then blocks the
target and all intermediate nodes by calling block_job_add_bdrv() in
each one of them:

   mirror_top (M) -> top (T) -> intermediate (I) -> base (B)

The problem is that those intermediate nodes start from top's
backing_bs(), so top itself is not added to the block job's list of
children and doesn't have its permissions restricted during the job's
lifetime.

This looks like a bug, I'll see if there's a way to reproduce and I'll
prepare a patch.

Berto
