Received: from eggs.gnu.org ([2001:4830:134:3::10]:55774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMvdD-0004B1-99
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMvd8-0007vK-E1
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:54:59 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181011072135.588-3-famz@redhat.com>
References: <20181011072135.588-1-famz@redhat.com>
	<20181011072135.588-3-famz@redhat.com>
Date: Wed, 14 Nov 2018 14:54:51 +0100
Message-ID: <w51tvkjkbmc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 2/3] file-posix: Drop
 s->lock_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 11 Oct 2018 09:21:34 AM CEST, Fam Zheng wrote:
> The lock_fd field is not strictly necessary because transferring locked
> bytes from old fd to the new one shouldn't fail anyway. This spares the
> user one fd per image.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

One of my tests (not published yet) starts to fail after this
patch. Here's how you can reproduce the error:

$ qemu-img create -f qcow2 hd.qcow2 4G
$ qemu-system-x86_64 -qmp stdio

{ "execute": "qmp_capabilities" }
{ "execute": "blockdev-add", "arguments": {"driver": "qcow2", "node-name": "hd0", "file": {"driver": "file", "filename": "hd.qcow2", "locking": "on" }}}
{ "execute": "human-monitor-command", "arguments": {"command-line": "qemu-io hd0 \"reopen -o file.locking=on\""}}
{ "execute": "human-monitor-command", "arguments": {"command-line": "qemu-io hd0 \"reopen -o file.locking=off\""}}
{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
{ "execute": "blockdev-add", "arguments": {"driver": "qcow2", "node-name": "hd0", "file": {"driver": "file", "filename": "hd.qcow2"}}}

{"error": {"class": "GenericError", "desc": "Failed to get \"consistent read\" lock"}}

Berto
