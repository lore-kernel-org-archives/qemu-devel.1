Received: from eggs.gnu.org ([2001:4830:134:3::10]:39747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eor6d-0000y9-Q5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eor6c-0000EJ-RA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:40:15 -0500
Date: Thu, 22 Feb 2018 14:39:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180222133956.GG4147@localhost.localdomain>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205151835.20812-4-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 03/26] block: Add BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

Am 05.02.2018 um 16:18 hat Max Reitz geschrieben:
> If the backing file is overridden, this most probably does change the
> guest-visible data of a BDS. Therefore, we will need to consider this in
> bdrv_refresh_filename().
> 
> Adding a new field to the BDS is not nice, but it is very simple and
> exactly keeps track of whether the backing file has been overridden.

...as long as we manage to actually keep it up to date all the time.

First of all, what I'm missing here (or in fact in the comment in the
code) is a definition what "overridden" really means. "specified by the
user" is kind of vague: You consider the backing file relationship for
snapshot=on as user specified, even though the user wasn't explicit
about this. On the other hand, creating a live snapshot results in a
node that isn't user specified.

Isn't the real question to ask whether the default backing file (taken
from the image header) would result in the same tree? The answer to this
changes after more operations, like qmp_change_backing_file().

Considering that there are so many ways to change the answer, I think
the simplest reliable option isn't a new BDS field that needs to updated
everywhere, but looking at the current value of bs->options and
bs->backing_file and see if they match.

> This commit adds a FIXME which will be remedied by a follow-up commit.
> Until then, the respective piece of code will not result in any behavior
> that is worse than what we currently have.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Kevin
