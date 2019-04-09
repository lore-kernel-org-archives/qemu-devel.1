Received: from eggs.gnu.org ([209.51.188.92]:52340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDv2r-0001qI-UY
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDv2q-0000sG-RT
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:00:29 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDv2q-0000qq-EC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:00:28 -0400
Received: by mail-io1-xd41.google.com with SMTP id x3so15087304iol.10
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 11:00:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <0437475a-10ff-b8e0-3914-536a78f99b6e@redhat.com>
Date: Tue, 9 Apr 2019 14:00:24 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <625D0D17-9BBA-444F-8204-A182B04238EC@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<6cf20899-f643-950b-37b9-dcc47df0d72e@redhat.com>
	<5C484463-F00B-4EC0-9272-DC23CEE8F376@oberlin.edu>
	<0437475a-10ff-b8e0-3914-536a78f99b6e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] block/pflash_cfi02: Implement
 missing AMD pflash functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>



On Apr 9, 2019, at 12:15, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:

> Since you did changes in the CFI table, I think we should add a tests
> verifying the table is correctly generated for all you FlashConfig =
entries.

That's a good idea. Some of the values are essentially arbitrary (e.g., =
how long an erase typically takes) but the CFI values that indicate =
support for erase/suspend and erase regions at least should be tested. =
I'll take a closer look at what all I changed (it has been a few months =
since I wrote the code). Are there any in particular you think I should =
be sure to test? Do you want me to add those tests to the appropriate =
patches in the series or would you like an additional patch that adds =
those tests? (The later is easier to do as modifying the earlier patches =
in the series are likely to cause conflicts with later patches that I'd =
need to resolve, but I can do either.)

> I suppose you can not share the firmware binary. Can you share these
> unlock addresses? Maybe once I reviewed carefully your series I might
> ask you the (pflash) trace event output.

I probably cannot share the binary but the unlock addresses are 0x1554 =
and 0x2AA8. This is for two interleaved x8/x16 chips in x16 mode so =
shifting right by 2 (1 for the interleaving and 1 because it's an x16 =
chip) gives 0x555 and 0xAAA. The appropriate (word) unlock addresses for =
the chips are 0x555 and 0x2AA which is what you get if you restrict to =
11 bits.

My guess is that the firmware authors took the byte unlock addresses =
(0xAAA and 0x555), shifted left by 2, discovered that this didn't work, =
tried the unlock addresses in the opposite order, and found that that =
worked due to the chips only looking at 11 bits.

Looking at hw/arm/musicpal.c, I see that it is using unlock addresses =
0x5555 and 0x2AAA. My guess is this reflects a bug in some firmware and =
it should be using 0x555 and 0x2AA. I haven't seen any AMD pflash chips =
that used other unlock addresses, but I've only looked at about a dozen =
part sheets and I'm not sure what chips the musicpal is actually using.


--=20
Stephen Checkoway
