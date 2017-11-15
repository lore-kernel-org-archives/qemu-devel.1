Received: from eggs.gnu.org ([2001:4830:134:3::10]:33191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEthb-0002Wc-Lr
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEtha-0003r1-PJ
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:09:47 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171114184127.24238-1-mreitz@redhat.com>
References: <20171114184127.24238-1-mreitz@redhat.com>
Date: Wed, 15 Nov 2017 10:09:36 +0100
Message-ID: <w51efozkiwf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: Fix overly broad madvise()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Tue 14 Nov 2017 07:41:27 PM CET, Max Reitz wrote:
> @mem_size and @offset are both size_t, thus subtracting them from one
> another will just return a big size_t if mem_size < offset -- even more
> obvious here because the result is stored in another size_t.
>
> Checking that result to be positive is therefore not sufficient to
> excluse the case that offset > mem_size.  Thus, we currently sometimes
> issue an madvise() over a very large address range.
>
> This is triggered by iotest 163, but with -m64, this does not result in
> tangible problems.  But with -m32, this test produces three segfaults,
> all of which are fixed by this patch.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Oh, I guess this happens when the page size is larger than the cluster
size? Otherwise I don't see how...

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
