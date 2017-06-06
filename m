Received: from eggs.gnu.org ([2001:4830:134:3::10]:36072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI2js-00010A-GU
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 20:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI2jr-0000X9-Oc
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 20:52:52 -0400
References: <20170605203845.24351-1-eblake@redhat.com>
	<20170605203845.24351-3-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c4eddbb1-0d10-2735-9a3d-4a4498aa735d@redhat.com>
Date: Mon, 5 Jun 2017 20:52:39 -0400
MIME-Version: 1.0
In-Reply-To: <20170605203845.24351-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/4] block: Guarantee that *file is set
 on bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>



On 06/05/2017 04:38 PM, Eric Blake wrote:
> We document that *file is valid if the return is not an error and
> includes BDRV_BLOCK_OFFSET_VALID, but forgot to obey this contract
> when a driver (such as blkdebug) lacks a callback.  Messed up in
> commit 67a0fd2 (v2.6), when we added the file parameter.
> 
> Enhance qemu-iotest 177 to cover this, using a sequence that would
> print garbage or even SEGV, because it was dererefencing through
> uninitialized memory.  [The resulting test output shows that we
> have less-than-ideal block status from the blkdebug driver, but
> that's a separate fix coming up soon.]
> 
> Setting *file on all paths that return BDRV_BLOCK_OFFSET_VALID is
> enough to fix the crash, but we can go one step further: always
> setting *file, even on error, means that a broken caller that
> blindly dereferences file without checking for error is now more
> likely to get a reliable SEGV instead of randomly acting on garbage,
> making it easier to diagnose such buggy callers.  Adding an
> assertion that file is set where expected doesn't hurt either.
> 
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
