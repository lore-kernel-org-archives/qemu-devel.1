Received: from eggs.gnu.org ([2001:4830:134:3::10]:36162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwu9D-0008Tw-SG
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwu9D-0007DS-2Q
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:59:55 -0400
Date: Tue, 26 Sep 2017 19:59:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170926175942.GE14717@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] blockdev-commit design
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com

Hi,

as the next step after my commit block job fixes, I'm trying to
implement a new, clean version of the QMP command, which I'm calling
blockdev-commit for consistency with all the other "modern" QMP
commands.

I'll start with the schema that I have so far:

{ 'command': 'blockdev-commit',
  'data': { 'job-id': 'str', 'top': 'str', '*base': 'str'
            '*backing-file': 'str', '*speed': 'int',
            '*filter-node-name': 'str' } }

In comparison with the old command, the important changes are:

  * top/base are node names instead of file names.

  * You don't need to specify the active layer any more (not the least
    because there could very well be more than one of them), but top
    becomes mandatory instead.

  * top/base don't accept device (BlockBackend) names, so for
    consistency with other block jobs, job-id becomes mandatory.

    Possible alternative: Accept device names and make them the default
    for job-id. This is more consistent with existing blockdev-*
    commands, but I consider BlockBackend names deprecated, so I prefer
    not adding them here.

  * filer-node-name is kept optional for now. Should we make it
    mandatory, too?

This was the easy part. Then I started looking at the code and found a
few a bit more interesting questions:

  * The old block-commit command decides between an "actual" commit job
    and the mirror-based active commit based on whether top is the
    active layer.

    We don't get an option for the active layer any more now, so this
    isn't how things can work for blockdev-commit. We could probably
    check whether top has a BlockBackend parent, but that's not really
    what we're interested in anyway. Maybe the best we could do to
    decide this automatically is to check whether there is any parent of
    top that requires write permissions. If there is, we need active
    commit, otherwise the "normal" one is good enough.

    However, who says that the intentions of the user stay as we deduce
    them at the start of the block job? Who says that the user doesn't
    want to add a writable disk as a user of the node while the block
    job is running?

    The optimal solution to this would be that the commit filter node
    responds to permission requests and switches between active and
    "normal" commit mode. I'm not sure how hard this would be to
    implement.

    As long as we don't have the automatic switch, do we have to allow
    the user to specify explicitly which mode they want instead of
    automatically choosing one?

  * The 'backing-file' option (which specifies the new backing file
    string for parents after the commit job completes) is currently not
    allowed if top is the active layer. If we allow graph changes, this
    doesn't seem to make sense to me because even if top doesn't have a
    parent node when the job starts, it could have one when it's
    completed.

Any opinions on this, especially the active/normal commit thing?

Kevin
