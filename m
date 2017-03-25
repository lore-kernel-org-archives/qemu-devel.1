Received: from eggs.gnu.org ([2001:4830:134:3::10]:42998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1craL0-0000Vm-3c
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 21:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1craKx-00029B-0W
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 21:17:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1craKw-00028x-QP
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 21:17:46 -0400
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <db8ccb55-0570-4b6f-1635-7df2ff0b9ec3@redhat.com>
Date: Fri, 24 Mar 2017 21:17:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] slirp + ipxe + ipv6 dns issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: samuel.thibault@ens-lyon.org
Cc: ondrejj@salstar.sk, qemu-devel <qemu-devel@nongnu.org>

Hi Samuel,

A Fedora user reported a regression for his ipxe setup (Jan, CCd). He has a
public PXE server and config. You can see details about his config here:
http://boot.salstar.sk/ipxe/

Reproducer:

  wget http://boot.salstar.sk/ipxe/ipxe.lkrn
  qemu-system-x86_64 -kernel ipxe.lkrn

Non-working output looks like:

Configuring (net0 52:54:00:12:34:56)..... ok
Could not get time and date: Connection timed out (http://ipxe.org/4c116035)
https://boot.salstar.sk/by_mac/52%3A54%3A00%3A12%3A34%3A56..................
Connection timed out (http://ipxe.org/4c116035)
https://boot.salstar.sk/by_ip/10.0.2.15.................. Connection timed out
(http://ipxe.org/4c116035)
https://boot.salstar.sk/menu.ipxe.................. Connection timed out
(http://ipxe.org/4c116035)
Press any key to enter failsafe menu ...


Working output will quickly drop into a text UI boot menu.


I bisected to this commit:

commit f7725df38750c1eaebc6665159bb58ec23864c92
Author: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date:   Sun Mar 20 16:02:52 2016 +0100

    slirp: Add RDNSS advertisement


And infact just reverting it on top of qemu.git makes things work again.

I'm not really sure if this is a bug or if it's just exposing a config issue
on the ipxe server... I tried enabling some ipxe debug commands like
ping/nslookup but didn't really get anywhere. Any thoughts/ideas?

Thanks,
Cole
