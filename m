Received: from eggs.gnu.org ([2001:4830:134:3::10]:44418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g06my-0001TR-7o
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 11:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g06mu-0000QW-BB
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 11:10:44 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180621130622.GH5024@localhost.localdomain>
References: <cover.1528991017.git.berto@igalia.com>
	<6782db91216488e4fc1509a267a362a3f15a1aaa.1528991017.git.berto@igalia.com>
	<20180618143801.GC4667@localhost.localdomain>
	<w51in6gp213.fsf@maestria.local.igalia.com>
	<20180618161229.GD4667@localhost.localdomain>
	<w51vaaf0xnj.fsf@maestria.local.igalia.com>
	<20180619130509.GA21115@dhcp-200-186.str.redhat.com>
	<w51sh5i5047.fsf@maestria.local.igalia.com>
	<20180620105854.GC3946@localhost.localdomain>
	<w51vaadr5ys.fsf@maestria.local.igalia.com>
	<20180621130622.GH5024@localhost.localdomain>
Date: Wed, 12 Sep 2018 17:09:48 +0200
Message-ID: <w51sh2eiwg3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 06/10] block: Allow changing the
 backing file on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Gonglei <arei.gonglei@huawei.com>, Wang WeiWei <wangww.fnst@cn.fujitsu.com>, Wen Congyang <wency@cn.fujitsu.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

On Thu 21 Jun 2018 03:06:22 PM CEST, Kevin Wolf wrote:
>> > Actually, do we ever use bdrv_reopen() for flags other than
>> > read-only?  Maybe we should get rid of that flags nonsense and
>> > simply make it a bdrv_reopen_set_readonly() taking a boolean.
>> 
>> I think that's a good idea. There's however one case where other
>> flags are changed: reopen_backing_file() in block/replication.c that
>> also clears BDRV_O_INACTIVE. I'd need to take a closer look to that
>> code to see what we can do about it.
>
> Uh, and that works?
>
> Clearing BDRV_O_INACTIVE with bdrv_reopen() (which means, without
> calling bdrv_invalidate_cache()) is surely suspicious. Probably this
> code is buggy.
>
> Another reason for removing flags from the interface: We didn't do any
> sanity checks for the flag changes.

I'm working on removing the flags parameter from bdrv_reopen() and
friends, and I think this is the only clearly strange thing on the way.

The documentation is in https://wiki.qemu.org/Features/BlockReplication
or in docs/block-replication.txt.

As far as I can see there's the following backing chain:

  [secondary] <- [hidden] <- [active]

There's an NBD server writing on [secondary], a backup job copying data
from [secondary] to [hidden], and the VM writing to [active].

The reopen_backing_file() function in question simply puts the two
backing images in read-write mode (clearing BDRV_O_INACTIVE along the
way) so the NBD server and the backup job can write to them.

This is done by replication_start(), which can only be reached with the
QMP command "xen-set-replication". There's a comment that says "The
caller of the function MUST make sure vm stopped" but no one seems to
check that the vm is indeed stopped (?). This API was btw added half a
year after the replication driver, and before this point the only user
of replication_start() was a unit test.

Without having tested the COLO / replication code before, I don't see
any reason why it would make sense to clear the BDRV_O_INACTIVE flag on
the backing files, or why that flag would be there in the first place
(and I'm not even talking about whether that flag is supposed to be
set/cleared with a simple bdrv_reopen()). So I'm thinking to simply
remove it from there.

If anyone else has more information I'd be happy to hear it.

Berto
