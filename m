Received: from eggs.gnu.org ([2001:4830:134:3::10]:60068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUElz-0002ci-KY
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUElv-0002sw-2n
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:46:15 -0500
References: <20181204172535.2799-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae25db42-74e7-0870-46f8-7def27e5cf43@redhat.com>
Date: Tue, 4 Dec 2018 11:46:01 -0600
MIME-Version: 1.0
In-Reply-To: <20181204172535.2799-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, Richard Henderson <rth@twiddle.net>

On 12/4/18 11:25 AM, Markus Armbruster wrote:
> Clean up includes so that osdep.h is included first and headers
> which it implies are not included manually.
> 
> This commit was created with scripts/clean-includes, with the changes
> to the following files manually reverted:
> 
>      contrib/libvhost-user/libvhost-user-glib.h
>      contrib/libvhost-user/libvhost-user.c
>      contrib/libvhost-user/libvhost-user.h

The script should probably auto-exclude contrib/ if none of those files 
make it into our final binary, and especially if they are meant to be 
compiled as stand-alone examples.

>      linux-user/mips64/cpu_loop.c
>      linux-user/mips64/signal.c
>      linux-user/sparc64/cpu_loop.c
>      linux-user/sparc64/signal.c
>      linux-user/x86_64/cpu_loop.c
>      linux-user/x86_64/signal.c
>      target/s390x/gen-features.c
>      tests/migration/s390x/a-b-bios.c
>      tests/test-rcu-simpleq.c
>      tests/test-rcu-tailq.c

Should any of these files be renamed *.c.inc to match their usage? 
(Presuming that you excluded them because they are pulled in via another 
.c file?)

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   contrib/elf2dmp/pdb.h                     | 2 --
>   contrib/elf2dmp/pe.h                      | 1 -
>   contrib/elf2dmp/qemu_elf.h                | 1 -
>   contrib/vhost-user-blk/vhost-user-blk.c   | 1 -
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 1 -

Hmm - my earlier question about auto-excluding contrib/ gets trickier. 
What's the rationale for including some files in here?

>   hw/rdma/rdma_utils.c                      | 1 +
>   hw/rdma/rdma_utils.h                      | 1 -
>   hw/rdma/vmw/pvrdma_dev_ring.h             | 1 -
>   hw/vfio/ap.c                              | 2 +-
>   include/qemu/vfio-helpers.h               | 1 -
>   include/sysemu/whpx.h                     | 1 -
>   target/i386/sev.c                         | 3 ++-
>   target/i386/whp-dispatch.h                | 1 -
>   target/riscv/fpu_helper.c                 | 1 -
>   tests/fp/platform.h                       | 1 -
>   tests/tpm-util.h                          | 1 -
>   tests/vhost-user-bridge.c                 | 2 +-
>   util/qemu-thread-common.h                 | 1 -
>   18 files changed, 5 insertions(+), 18 deletions(-)

The remainder of these files look reasonable.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
