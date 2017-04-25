Received: from eggs.gnu.org ([2001:4830:134:3::10]:59482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d32qX-0005YM-G3
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d32qU-00029e-FG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:57:45 -0400
Date: Tue, 25 Apr 2017 17:57:03 +0200
From: Alberto Garcia <berto@igalia.com>
Message-ID: <20170425155703.GA11693@igalia.com>
References: <20170425151317.GF13555@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425151317.GF13555@lemon.lan>
Subject: Re: [Qemu-devel] [Qemu-block] qemu-io aborts at quit after reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, Apr 25, 2017 at 11:13:17PM +0800, Fam Zheng wrote:
> Hi Kevin,
> 
> This happens both on master and on your block-next tree:
> 
>     $ qemu-io -f raw null-co:// -c 'reopen -r'
>     Unexpected error in bdrv_check_perm() at /stor/work/qemu/block.c:1437:
>     Block node is read-only
>     Aborted
> 
> It seems bs->read_only and perms go out of sync when bdrv_reopen()
> toggles the former.

It seems that the problem started in 8ee039951dea9a809e4745c42aebb4a7.

I just took a quick look at the code, but one difference is that
after this change bdrv_check_perm(old_bs, ...) is called before
QLIST_REMOVE(child, next_parent), so the returned perms are likely
different.

Berto
