Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fOuRU-0008C1-Ld
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 20:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fOuPr-0006LL-Aj
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 20:30:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58947)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fOuPq-0006Kr-NB
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 20:29:06 -0400
Date: Fri, 1 Jun 2018 20:29:05 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180602002905.GA19122@flamenco>
References: <1526945967-9687-1-git-send-email-cota@braap.org>
	<ff49bf54-3d5c-c2a4-95cd-3cb8c2efab51@linaro.org>
	<ada5eac5-eceb-b330-6f12-ac6e9c58268d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada5eac5-eceb-b330-6f12-ac6e9c58268d@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 00/17] tcg: tb_lock removal redux v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, May 30, 2018 at 16:05:14 -0700, Richard Henderson wrote:
> On 05/30/2018 03:46 PM, Richard Henderson wrote:
> > Thanks.  Queued to tcg-next.
> Hmph.  Unqueued, at least for now.
> 
> ERROR:/home/rth/work/qemu/qemu/accel/tcg/translate-all.c:615:page_unlock__debug:
> assertion failed: (page_is_locked(pd))

Gaah, sorry. In v3 forgot to call the lock__debug function from
a successful trylock. I tested v3 on aarch64, which explains why
I didn't catch the bug. Fixed now:

--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -704,6 +704,7 @@ static bool page_entry_trylock(struct page_entry *pe)
     if (!busy) {
         g_assert(!pe->locked);
         pe->locked = true;
+        page_lock__debug(pe->pd);
     }
     return busy;
 }

I also added the following, which cannot hurt:

diff --git a/exec.c b/exec.c
index afc37e0..e874d67 100644
--- a/exec.c
+++ b/exec.c
@@ -2493,6 +2493,7 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
 {
     if (ndi->pages) {
         page_collection_unlock(ndi->pages);
+        ndi->pages = NULL;
     }

(Note that calling page_collection_unlock twice on that pointer
would blow up.)

The above two one-liners are the only code changes between v3 and v4.
I also added Alex's R-b tag for the qht patch.

I've boot-tested v4 on aarch64, arm, x86_64-softmmu, riscv64, sh4,
sparc, s390x, ppc64 and or1k, with and without TCG debug.

You can fetch v4 from:
  https://github.com/cota/qemu/tree/tb-lock-removal-redux-v4

Thanks,

		Emilio
