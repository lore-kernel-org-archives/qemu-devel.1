Received: from eggs.gnu.org ([2001:4830:134:3::10]:53112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gKlAB-0004Vl-AU
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:20:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gKlA9-00077Z-VY
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:20:03 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gKlA9-00070m-LJ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:20:01 -0500
Received: by mail-io1-xd43.google.com with SMTP id c6-v6so14684493iob.11
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 06:19:51 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  8 Nov 2018 08:19:42 -0600
Message-Id: <20181108141944.15769-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 0/2] ipmi: Allow UUID to be set for a BMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The code was using the qemu UUID for the BMC.  But that's really
not a good method.  In general, you don't want the GUID to change
when you migrate, and you want the GUID to be the same between
invocations of qemu (if you have a GUID).

Plus, if you have multiple BMCs, they need to have different
GUIDs or the host code cannot tell them apart.  I'm not sure
anyone really uses multiple BMCs, but I do a lot of testing
with that scenario.

This change lets the user set the GUID on the command line, and
if the GUID is not set return an error for the GUID fetch command.
This maps better to how IPMI should work.

This change relies on the UUID being set to all zeros to know that
it is not set.  This is not optimal, perhaps, but an all zero
UUID isn't valid (it's the Nil UUID), so it should be ok.
