Received: from eggs.gnu.org ([2001:4830:134:3::10]:33250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zack.cornelius@kove.net>) id 1doufl-0002eQ-FY
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zack.cornelius@kove.net>) id 1doufg-0008Jr-LS
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:56:29 -0400
Received: from mail.kove.net ([67.109.75.252]:5338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zack.cornelius@kove.net>)
	id 1doufg-0008JO-G3
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:56:24 -0400
Date: Mon, 4 Sep 2017 11:56:14 -0500 (CDT)
From: Zack Cornelius <zack.cornelius@kove.net>
Reply-To: Zack Cornelius <zack.cornelius@kove.net>
Message-ID: <985325221.20010.1504544174723.JavaMail.zimbra@kove.net>
In-Reply-To: <20170824192315.5897-1-ehabkost@redhat.com>
References: <20170824192315.5897-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] hostmem-file: Add "discard-data"
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>

I've tested this patch set, and it has the expected results.

On a clean exit, with discard-data=on, madvise(MADV_REMOVE) is called, clearing any dirty data from RAM without needing to flush, and removing data from the underlying memory file. These results match our expected operation.


Run with the options:

qemu-system-x86_64 -smp 2 -m 8192 -enable-kvm -name ubuntu -vnc 0.0.0.0:5901 -object memory-backend-file,id=mem,size=4096M,mem-path=$MEM_PATH,share=on,discard-data=on -numa node,memdev=mem -mem-prealloc -hda $HD_PATH

While running (First output is the size on disk):

[root@sr3 qemu]# ls -ls /root/qemu_mem/qemu_memory.raw --block-size 1
8589934592 -rw-r--r--. 1 root root 8589934592 Sep  4 11:34 /root/qemu_mem/qemu_memory.raw

At exit, dirty data was dropped, instead of flushed to disk.

After shutting down, actual size on disk is 0:

[root@sr3 qemu]# ls -ls /root/qemu_mem/qemu_memory.raw 
0 -rw-r--r--. 1 root root 8589934592 Sep  4 11:35 /root/qemu_mem/qemu_memory.raw

--
Zack

----- Original Message -----
> From: "Eduardo Habkost" <ehabkost@redhat.com>
> To: qemu-devel@nongnu.org
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Zack Cornelius" <zack.cornelius@kove.net>, "Paolo Bonzini"
> <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Igor Mammedov" <imammedo@redhat.com>
> Sent: Thursday, August 24, 2017 2:23:12 PM
> Subject: [PATCH v2 0/3] hostmem-file: Add "discard-data" option

> This series adds a new "discard-data" option to
> memory-backend-file.  The new option will be useful if somebody
> is sharing RAM contents on a pre-existing file using share=on,
> but don't need data to be flushed to disk when QEMU exits.
> 
> Internally, it will trigger a madvise(MADV_REMOVE) call when the
> memory backend is removed or when QEMU exits.
> 
> To make we actually trigger the new code when QEMU exits, the
> first patch in the series ensures we destroy all user-created
> objects when exiting QEMU.
> 
> Changes v1 -> v2:
> * Original subject line of v1 was:
>  '[PATCH 0/5] hostmem-file: Add "persistent" option'
> * Replaced 'persistent=no' with 'discard-data=yes', to make it
>  clear that the flag will destroy data on the backing file.
> * Use qemu_madvise() instead of madvise()
>  * New patch added to series: "osdep: define QEMU_MADV_REMOVE"
> * Call qemu_madvise() directly from the backend unparent()
>  method, insteead of adding a new flag to the memory API and
>  reusing ram_block_discard_range()
>  * In addition to simplifying the code a lot, this fixes a bug,
>    because v1 relied on getting the memory region reference
>    count back to 0, which doesn't happen when QEMU is exiting
>    because there's no machine cleanup code to ensure that.
> 
> Eduardo Habkost (3):
>  vl: Clean up user-creatable objects when exiting
>  osdep: Define QEMU_MADV_REMOVE
>  hostmem-file: Add "discard-data" option
> 
> include/qemu/osdep.h            |  7 +++++++
> include/qom/object_interfaces.h |  8 ++++++++
> backends/hostmem-file.c         | 29 +++++++++++++++++++++++++++++
> qom/object_interfaces.c         |  5 +++++
> vl.c                            |  1 +
> qemu-options.hx                 |  5 ++++-
> 6 files changed, 54 insertions(+), 1 deletion(-)
> 
> --
> 2.9.4
