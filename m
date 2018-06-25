Received: from eggs.gnu.org ([2001:4830:134:3::10]:35827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fXUdk-0005O9-Of
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fXUdj-0001pX-TX
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:46:56 -0400
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:40456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fXUdj-0001p7-MU
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:46:55 -0400
Received: by mail-yb0-x243.google.com with SMTP id v17-v6so5419376ybe.7
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:46:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529944302-14186-1-git-send-email-cota@braap.org>
References: <1529944302-14186-1-git-send-email-cota@braap.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 25 Jun 2018 09:46:53 -0700
Message-ID: <CAMo8BfLWAAks92OZdNNp=ZRqL9VVTae5yV53Km6YvCE6X7V=9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] translate-all: fix locking of TBs whose
 two pages share the same physical page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On Mon, Jun 25, 2018 at 9:31 AM, Emilio G. Cota <cota@braap.org> wrote:
> Commit 0b5c91f ("translate-all: use per-page locking in !user-mode",
> 2018-06-15) introduced per-page locking. It assumed that the physical
> pages corresponding to a TB (at most two pages) are always distinct,
> which is wrong. For instance, an xtensa test provided by Max Filippov
> is broken by the commit, since the test maps two virtual pages
> to the same physical page:
>
>         virt1: 7fff, virt2: 8000
>         phys1 6000fff, phys2 6000000
>
> Fix it by removing the assumption from page_lock_pair.
> If the two physical page addresses are equal, we only lock
> the PageDesc once. Note that the two callers of page_lock_pair,
> namely page_unlock_tb and tb_link_page, are also updated so that
> we do not try to unlock the same PageDesc twice.
>
> Fixes: 0b5c91f74f3c83a36f37740969df8c775c997e69
> Reported-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)

Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Thank you!

-- Max
