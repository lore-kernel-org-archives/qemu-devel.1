Received: from eggs.gnu.org ([2001:4830:134:3::10]:34956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cFjbk-0000J3-Bh
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cFjbj-0007Ke-9s
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:30:40 -0500
Received: from lists.cendio.se ([2a00:801:107:f000::b]:39938
	helo=mail.cendio.se)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ossman@cendio.se>) id 1cFjbi-0007KG-W8
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:30:39 -0500
Received: from mjolnir.ossman.eu (unknown
	[IPv6:2001:470:df41:0:38ac:b4cf:438f:764c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.cendio.se (Postfix) with ESMTPSA id 7019DC0A4AEC
	for <qemu-devel@nongnu.org>; Sat, 10 Dec 2016 16:30:37 +0100 (CET)
From: Pierre Ossman <ossman@cendio.se>
Message-ID: <f460049b-211e-194b-d4c3-a3cc34e4d289@cendio.se>
Date: Sat, 10 Dec 2016 16:30:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] VNC LED state buggy, interop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I'm working on adding support for the LED state extension in TigerVNC.=20
Unfortunately I discovered some bugs in the QEMU implementation so I=20
need to discuss with you guys what the proper behaviour should be.

The basic problem is that the code right now assumes that XK_Caps_Lock=20
and XK_Num_Lock will toggle their respective states. It is however not=20
assumed that XK_Scroll_Lock toggles any state.

This assumption can of course be wrong. Simply run this in your guest to=20
break things:

   xmodmap -e 'clear mod2'

Pressing NumLock will now toggle the LED and state on the client side=20
(that's what is assumed), but not on the server side. However the client=20
is never informed by the server that things are out of sync.

There are two ways to fix this:

  a) Send an update to the client when the assumption doesn't hold. This=20
will most likely be difficult in your case since there is no definite=20
point where you can assume a LED change event should have occurred.

  b) Remove the assumption from the code and the protocol.

My vote is for b). Assumptions and side effects are rarely a good idea.=20
The downside though is that it will break compatibility with older=20
versions of QEMU.

Regards
--=20
Pierre Ossman           Software Development
Cendio AB		http://cendio.com
Teknikringen 8		http://twitter.com/ThinLinc
583 30 Link=C3=B6ping	http://facebook.com/ThinLinc
Phone: +46-13-214600	http://plus.google.com/+CendioThinLinc

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
