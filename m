Received: from eggs.gnu.org ([2001:4830:134:3::10]:57826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecHbu-00020P-Ae
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecHbq-0004VX-Aa
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:20:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecHbq-0004V7-4Z
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 16:20:30 -0500
Date: Thu, 18 Jan 2018 19:20:23 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180118212023.GH5292@localhost.localdomain>
References: <20180118021000.27203-1-ehabkost@redhat.com>
	<CAFEAcA_JX_eevQL3kM2Kvf_Z3+xTiDRkg6C-EknfMtj_-cRA1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_JX_eevQL3kM2Kvf_Z3+xTiDRkg6C-EknfMtj_-cRA1g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/19] machine queue, 2018-01-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>

On Thu, Jan 18, 2018 at 03:22:05PM +0000, Peter Maydell wrote:
> On 18 January 2018 at 02:09, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> >
> > for you to fetch changes up to 901cc8d31f36ac82824ab68f656ab7050404100c:
> >
> >   fw_cfg: fix memory corruption when all fw_cfg slots are used (2018-01-17 23:04:37 -0200)
> >
> > ----------------------------------------------------------------
> > machine queue, 2018-01-18
> >
> > ----------------------------------------------------------------
> 
> Hi. I'm afraid this doesn't build on 32-bit hosts, due to a
> format string problem:
> 
> In file included from /home/peter.maydell/qemu/exec.c:20:0:
> /home/peter.maydell/qemu/exec.c: In function 'file_ram_alloc':
> /home/peter.maydell/qemu/include/qapi/error.h:162:25: error: format
> '%llx' expects argument of type 'long long unsigned int', but argument
> 7 has type 'size_t {aka unsigned int}' [-Werror=format=]
>                          (fmt), ## __VA_ARGS__)
>                          ^
> /home/peter.maydell/qemu/exec.c:1616:9: note: in expansion of macro 'error_setg'
>          error_setg(errp, "aligment 0x%" PRIx64
>          ^

Sorry for not catching this.  Fixup will be included on a new
pull request:

diff --git a/exec.c b/exec.c
index 00055559b8..7bba8ef4ab 100644
--- a/exec.c
+++ b/exec.c
@@ -1613,8 +1613,8 @@ static void *file_ram_alloc(RAMBlock *block,
 
     block->page_size = qemu_fd_getpagesize(fd);
     if (block->mr->align % block->page_size) {
-        error_setg(errp, "aligment 0x%" PRIx64
-                   " must be multiples of page size 0x%" PRIx64,
+        error_setg(errp, "alignment 0x%" PRIx64
+                   " must be multiples of page size 0x%zd",
                    block->mr->align, block->page_size);
         return NULL;
     }

-- 
Eduardo
