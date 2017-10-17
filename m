Received: from eggs.gnu.org ([2001:4830:134:3::10]:40625)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1e4PBu-00086h-4T
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1e4PBp-0008Lq-8y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:33:42 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:60023 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1e4PBo-0008KU-Vi
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:33:37 -0400
From: Peter Lieven <pl@kamp.de>
Message-ID: <8e2160db-338f-f1dc-7f5e-8faa3dce7090@kamp.de>
Date: Tue, 17 Oct 2017 12:33:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] Clean Block Driver Shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,

I noticed that Qemu quits at several points with an exit() if the supplied parameters in the commandline are incorrect.
This at some stages happens after there have already been connections to storage backends established.
These connections are not cleanly shut down in this case. For posix file backends that doesn't matter, but for other
backends this leads to errors. E.g. iSCSI Targets log an aborted iSCSI connection due to tcp reset.

I wonder what is the best way to fix this. A simply call to bdrv_close_all() in an atexit handler seems to work.
But is this a good solution? Maybe register this handler only until the VM starts.
Or do we need an atexit handler in each block driver that requires a clean shutdown?

Thanks,
Peter
