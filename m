Received: from eggs.gnu.org ([2001:4830:134:3::10]:53094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gFJ8d-00059V-BI
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gFJ8c-0004r2-Cn
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:23:55 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gFJ8c-0004qU-6D
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:23:54 -0400
Received: by mail-ot1-x341.google.com with SMTP id c32so4968157otb.8
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 06:23:53 -0700 (PDT)
MIME-Version: 1.0
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 24 Oct 2018 19:23:41 +0600
Message-ID: <CANzW0msZ6O8vWXQ4dGrQgkhYcx335R_rmU7DOR1uw0=WDyM8kQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Features/HelperNetworking wiki page: setup description
 misses root ownership
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, Liguori <anthony@codemonkey.ws>

'Setup' section of https://wiki.qemu.org/Features/HelperNetworking says
that setuid attribute needs to be turned on for 'qemu-bridge-helper'
binary, but it forgets to mention that owner of this file must be root
user. Otherwise, setuid bit makes no sense.
Looks like in most scenarios this binary already installed with root
privileges. But this isn't a case, when you build QEMU from sources and
install it in custom location, running 'make install' by non-privileged
user. Yes, maybe it's obvious for mature linux users, but it took me a lot
of time to figure out why QEMU fails with error: "failed to create tun
device: Operation not permitted" (googling this error shows mostly answers
like "you just forget setuid").
So, it would be useful to add
    sudo chown root /usr/local/libexec/qemu-bridge-helper
*before*
    sudo chmod u+s /usr/local/libexec/qemu-bridge-helper
