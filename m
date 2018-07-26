Received: from eggs.gnu.org ([2001:4830:134:3::10]:34461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ficeX-0000Up-Nr
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ficeU-000401-Oi
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:33:45 -0400
Date: Thu, 26 Jul 2018 11:33:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180726093326.GB4215@localhost.localdomain>
References: <1532542049-21893-1-git-send-email-frederic.konrad@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532542049-21893-1-git-send-email-frederic.konrad@adacore.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0] qcow: fix a reference leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, mreitz@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org

Am 25.07.2018 um 20:07 hat KONRAD Frederic geschrieben:
> Since 42a3e1ab367cdf38cce093de24eb406b99a4ef96 qemu asserts when using the
> vvfat driver:
> 
> git clone git://qemu.org/qemu.git
> cd qemu
> ./configure --target-list=ppc-softmmu --enable-debug
> make -j8
> mkdir foo
> touch foo/hello
> ./ppc-softmmu/qemu-system-ppc -M prep --nographic --monitor null             \
>                               -hda fat:rw:./foo
> 
> "Ctrl-C"
> 
> qemu-system-ppc: block.c:3368: bdrv_close_all: Assertion                     \
>    `((&all_bdrv_states)->tqh_first == ((void *)0))' failed.
> 
> This is because we reference bs twice in qcow_co_create(..) one time in
> bdrv_open_blockdev_ref(..) and in blk_insert_bs(..) but we unref it only once
> in blk_unref which leads to the reference leak.
> 
> Note that I didn't tested much QCOW after this change as I don't use it much.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Thanks, applied to the block branch.

Kevin
