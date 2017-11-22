Received: from eggs.gnu.org ([2001:4830:134:3::10]:58233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHTim-0005z0-VD
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHTie-0007Is-9h
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:01:39 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHTie-0007IJ-2S
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:01:32 -0500
Received: by mail-wr0-x243.google.com with SMTP id z75so12945894wrc.5
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 04:01:31 -0800 (PST)
References: <20171122084157.11480-1-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4e926520-1b21-5aad-6a5c-3a8d11a8ea80@linaro.org>
Date: Wed, 22 Nov 2017 13:01:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171122084157.11480-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix complilation with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>

On 11/22/2017 09:41 AM, Juan Quintela wrote:
> This commit started use tb_unlock() and tlb_set_dirty() on non TCG
> code.  Add the function as stubs.
> 
> commit 27266271977c5a30f2f7d493e042be1897827bdd
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Mon Nov 20 18:08:27 2017 +0000
> 
>     exec.c: Factor out before/after actions for notdirty memory writes
>     ....
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  accel/stubs/tcg-stub.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Hmm.  An alternate solution is


diff --git a/exec.c b/exec.c
index 03238a3449..ac902da89d 100644
--- a/exec.c
+++ b/exec.c
@@ -2378,6 +2378,7 @@ void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
 /* Called within RCU critical section. */
 void memory_notdirty_write_complete(NotDirtyInfo *ndi)
 {
+    assert(tcg_enabled());
     if (ndi->locked) {
         tb_unlock();
     }


so that the rest of the function is compiled away.

Thus my confusion about how Peter was adding any references to these functions
-- he split half the function such that half is now not protected by an assert.

Either solution works for me.  So to streamline the process,

Acked-by: Richard Henderson <richard.henderson@linaro.org>

in case we wind up going with Juan's patch.


r~
