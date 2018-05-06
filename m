Received: from eggs.gnu.org ([2001:4830:134:3::10]:53409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFLD7-0004vS-8Z
	for qemu-devel@nongnu.org; Sun, 06 May 2018 11:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFLD6-0005oT-66
	for qemu-devel@nongnu.org; Sun, 06 May 2018 11:04:25 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:44874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fFLD6-0005nq-0k
	for qemu-devel@nongnu.org; Sun, 06 May 2018 11:04:24 -0400
Received: by mail-ot0-x234.google.com with SMTP id g7-v6so29369006otj.11
	for <qemu-devel@nongnu.org>; Sun, 06 May 2018 08:04:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180506133955.GP13229@umbus.fritz.box>
References: <1525396794-17042-1-git-send-email-mjc@sifive.com>
	<CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
	<20180505114812.GO13229@umbus.fritz.box>
	<CAHNT7Ns98LZzRK9AguCqrG+GQrSEm1+ZiPVLYnFKob8LgDdMKg@mail.gmail.com>
	<CAFEAcA_fC6AmZBv4ovKunEm+2YPMdQJ0OWVVZXCuiLxGxAG=SA@mail.gmail.com>
	<20180506133955.GP13229@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 6 May 2018 16:04:02 +0100
Message-ID: <CAFEAcA-bYHDSFL07f3BE_Lj-Dou+GeZod6cdX4-LSxzpRmQaDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] device_tree: Add qemu_fdt_totalsize
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair.francis@wdc.com>

On 6 May 2018 at 14:39, David Gibson <david@gibson.dropbear.id.au> wrote:
> Well, I'm biased of course, but I think we'd be better off just
> ditching the wrapper.  In its present form it is so limited as to not
> really add any value.  If it was rewritten to do something useful
> (e.g. handling reallocations), I think it would be even better if
> done as an extension to libfdt itself so it can benefit everyone, not
> just qemu.

Well, some of it is working around infelicities in libfdt's
API (like all the getprop/setprop functions taking an offset
value rather than a node name), but yes, it would be better
to fix the libfdt API if possible.

> Although, that said, I'll re-iterate that I think qemu's fdt
> manipulation is now sufficiently complex that it would be better off
> using a "live" (dynamically allocated & pointer based) tree
> representation that we just flatten immediately before loading it into
> the guest.

This sounds to me like something that should be handled
by libfdt. I don't particularly care what libfdt's
internal representation of the data structure is, I just
want to be able to (a) hand it an fdt read in from a file
(b) call various functions to modify the data structure
and then (c) write the resulting thing out to an fdt in
guest memory. Whether libfdt prefers to do that by
modifying the flat representation or by converting into
a dynamically allocated unflattened tree and back again
is something I'd rather leave to it as an implementation
detail.

thanks
-- PMM
