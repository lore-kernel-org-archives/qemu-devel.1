Received: from eggs.gnu.org ([2001:4830:134:3::10]:55626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bdrung+konstrukt.pb.local@profitbricks.com>)
	id 1emg7i-0006Pf-0P
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bdrung+konstrukt.pb.local@profitbricks.com>)
	id 1emg7d-0007Ou-Em
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:32:22 -0500
Received: from mx1.profitbricks.com ([46.16.72.21]:47028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <bdrung+konstrukt.pb.local@profitbricks.com>)
	id 1emg7d-0007OC-6q
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:32:17 -0500
Received: from mail.pb.local (mail.pb.local [192.168.178.100])
	by mx1.profitbricks.com (Postfix) with ESMTP id 0A0675F606
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 12:55:19 +0000 (UTC)
From: Benjamin Drung <benjamin.drung@profitbricks.com>
Date: Fri, 16 Feb 2018 13:55:03 +0100
Message-Id: <20180216125504.25955-1-benjamin.drung@profitbricks.com>
Subject: [Qemu-devel] [PATCH 0/1] slirp: Add domainname option to slirp's
 DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel@nongnu.org, Benjamin Drung <benjamin.drung@profitbricks.com>

Hi,

The DHCP server in QEMU does neither support specifying a domainname nor
a classless static route option [1]. I implemented the former (which was easy),
but I am not sure if and how to implement the classless static route option.

An example classless static route option configured in ISC's DHCP server look
like

  option rfc3442-classless-static-routes 24, 10, 0, 2, 10, 0, 2, 2, 16, 192, 168, 10, 0, 2, 2;

This translates to the routes:

10.0.2.0/24 via 10.0.2.2
192.168.0.0/16 via 10.0.2.2

Should the command line option just behave like the ISC's DHCP server and
allow specifying the byte stream passed to the client? E.g.

  -net staticroutes=24.10.0.2.10.0.2.2.16.192.168.10.0.2.2

Or should the command line option be simpler, but how should it be specified
then? Maybe

  -net staticroute=10.0.2.0/24via10.0.2.2,staticroute=192.168.0.0/16via10.0.2.2

I am open for your ideas.

[1] https://tools.ietf.org/html/rfc3442

Benjamin Drung (1):
  slirp: Add domainname option to slirp's DHCP server

 net/slirp.c      | 7 ++++---
 qapi/net.json    | 3 +++
 qemu-options.hx  | 7 +++++--
 slirp/bootp.c    | 8 ++++++++
 slirp/libslirp.h | 2 +-
 slirp/slirp.c    | 4 +++-
 slirp/slirp.h    | 1 +
 7 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.14.1
