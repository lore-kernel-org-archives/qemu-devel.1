Received: from eggs.gnu.org ([2001:4830:134:3::10]:56472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gPrpI-0003Zs-9U
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gPrpD-000833-JS
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:27:36 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <cover.1541002357.git.berto@igalia.com>
References: <cover.1541002357.git.berto@igalia.com>
Date: Thu, 22 Nov 2018 17:27:22 +0100
Message-ID: <w51wop5hyc5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] Update the inherits_from pointer after
 stream and commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

ping

> Hi all,
>
> when you open an image [A] with a few more images on the backing chain
> you get something like this:
>
>     [E] <- [D] <- [C] <- [B] <- [A]
>
> Here you can go from [A] to [E] by following the bs->backing
> pointer. At the same time each one of the backing files has an
> 'inherits_from' attribute pointing to their parent, so you can go from
> [E] to [A] following the inherits_from pointer.
>
> 'inherits_from' is used on bdrv_reopen_queue_child() to decide if a
> node's children must be reopened together with the parent and inherit
> its options.
>
> If some the intermediate nodes are removed (either by block-stream or
> by block-commit) you end up with something like this:
>
>    [E] <- [A]
>
> In this case we would expect [E] to inherit from [A], however its
> inherits_from pointer is NULL and trying to change its options by
> reopening [A] with backing.option=value fails.
>
> This patch series fixes this. See each individual patch for more
> details.
