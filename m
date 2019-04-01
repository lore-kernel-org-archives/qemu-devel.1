Received: from eggs.gnu.org ([209.51.188.92]:46245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hAtJG-0006Kb-FN
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hAtJF-0001H0-Cl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:32:54 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hAtJF-0001GU-4n
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:32:53 -0400
Received: by mail-wm1-f49.google.com with SMTP id z24so10579608wmi.5
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 02:32:51 -0700 (PDT)
Date: Mon, 1 Apr 2019 11:32:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190401093247.6olermdtozvjin22@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] qcow2 and rbd driver question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>

Hi Kevin,
I'm working on an issue where I'm not able to create a qcow2 image with
the rbd driver (https://bugzilla.redhat.com/show_bug.cgi?id=1171007).

What I found is the following:
- when qcow2 uses the rbd driver, the new file is created (rbd_create)
  with the size equals to 0. (qemu_opt_get_size_del(opts,
  BLOCK_OPT_SIZE, 0) returns 0 in qemu_rbd_co_create_opts())
- the file is truncated (implemented with rbd_resize) to 0 before to
  write the qcow2 header.
- the "size" parameter passed to rbd_create() or rbd_resize() is
  interpreted as the maximum size of the file, this means that all
  writes that exceed that size, fails and returns -22.

As a workaround, I'm checking if the write operation exceeds the maximum
size and then I'll resize the file. It works, but I'm not sure it is the
right way.
I also checked the RBD API, but I didn't find any useful function or
flags that allow writes to increase file size.

Any suggestions?

Thank you very much,
Stefano
