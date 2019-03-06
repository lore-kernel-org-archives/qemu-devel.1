Received: from eggs.gnu.org ([209.51.188.92]:59405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1eWo-0006xK-SF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1eWo-0000PF-0Q
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:56:42 -0500
Date: Wed, 6 Mar 2019 22:56:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190306215633.GM6818@localhost.localdomain>
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tcmu: Introduce qemu-tcmu
 utility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>

Am 21.12.2018 um 11:16 hat Yaowei Bai geschrieben:
> This patch introduces a new utility, qemu-tcmu. Apart from the
> underlaying protocol it interacts with the world much like
> qemu-nbd. This patch bases on Fam's version.
> 
> Qemu-tcmu handles SCSI commands which are passed through userspace
> from kernel by LIO subsystem using TCMU protocol. Libtcmu is the
> library for processing TCMU protocol in userspace. With qemu-tcmu,
> we can export images/formats like qcow2, rbd, etc. that qemu supports
> using iSCSI protocol or loopback for remote or local access.
> 
> Currently qemu-tcmu implements several SCSI command helper functions
> to work. Our goal is to refactor and reuse SCSI code in scsi-disk.
> 
> Please refer to docs/tcmu.txt to use qemu-tcmu. We test it on CentOS
> 7.3.(Please use 3.10.0-514 or lower version kernel, there's one issuse
> in higher kernel version we're resolving.)
> 
> Cc: Mike Christie <mchristi@redhat.com>
> Cc: Amar Tumballi<atumball@redhat.com>
> Cc: Prasanna Kalever <pkalever@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>

Sorry, with the email backlog after the Christmas break, this patch went
completely unnoticed on my side.

I'm not going to review the code in detail yet, because I think there
are a few very high level points that need to be addressed first:

* Patchew replied with a ton of coding style problems. This patch isn't
  mergable without these problems fixed.

* The first priority should be adding an in-process iscsi target that
  can be managed with QMP, similar to the built-in NBD server.

* The standalone tool should configure its block backend using -blockdev
  based code paths instead of duplicating legacy -drive code, which
  cannot provide advanced functionality.

* Even worse, you can't get the configuration from the iscsi initiator.
  This would be a security nightmare. Instead, the user needs to
  configure named exports either in QMP or on the command line for the
  tool and the initiator then connects to an export name.

* It should be considered if we can have a single standalone tool for
  all export mechanisms (NBD, TCMU, vhost-user, fuse, and whatever new
  ideas we will have in the future) that could have advanced
  functionality like a QMP monitor instead of adding a minimal
  specialised tool for each of them.

Kevin
