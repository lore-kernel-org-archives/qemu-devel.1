Received: from eggs.gnu.org ([209.51.188.92]:47708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDx2u-0000XR-GM
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDx2t-0007JA-Bl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:08:40 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDx2s-0007IS-RJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:08:39 -0400
Received: by mail-oi1-x243.google.com with SMTP id w139so14659427oie.9
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190409174018.25798-1-armbru@redhat.com>
In-Reply-To: <20190409174018.25798-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 03:08:28 +0700
Message-ID: <CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>

On Wed, 10 Apr 2019 at 00:40, Markus Armbruster <armbru@redhat.com> wrote:
>
> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
> computation of @dt_size overflows to a negative number, which then
> gets converted to a very large size_t for g_malloc0() and
> load_image_size().  In the (fortunately improbable) case g_malloc0()
> succeeds and load_image_size() survives, we'd assign the negative
> number to *sizep.  What that would do to the callers I can't say, but
> it's unlikely to be good.
>
> Fix by rejecting images whose size would overflow.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I think this patch is missing some attributions for the
security researchers who found the issue initially.
PJP's patch for this from a couple of weeks back has a
reported-by credit:
https://patchew.org/QEMU/20190322073555.20889-1-ppandit@redhat.com/

thanks
-- PMM
