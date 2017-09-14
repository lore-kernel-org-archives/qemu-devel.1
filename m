Received: from eggs.gnu.org ([2001:4830:134:3::10]:59889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dsZvQ-0006wH-04
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dsZvM-0004uc-QG
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dsZvM-0004tx-IS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:35:44 -0400
Date: Thu, 14 Sep 2017 16:35:40 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170914193540.GB25664@localhost.localdomain>
References: <20170824192315.5897-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824192315.5897-1-ehabkost@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zack Cornelius <zack.cornelius@kove.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Series queued on machine-next.

On Thu, Aug 24, 2017 at 04:23:12PM -0300, Eduardo Habkost wrote:
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
>   '[PATCH 0/5] hostmem-file: Add "persistent" option'
> * Replaced 'persistent=no' with 'discard-data=yes', to make it
>   clear that the flag will destroy data on the backing file.
> * Use qemu_madvise() instead of madvise()
>   * New patch added to series: "osdep: define QEMU_MADV_REMOVE"
> * Call qemu_madvise() directly from the backend unparent()
>   method, insteead of adding a new flag to the memory API and
>   reusing ram_block_discard_range()
>   * In addition to simplifying the code a lot, this fixes a bug,
>     because v1 relied on getting the memory region reference
>     count back to 0, which doesn't happen when QEMU is exiting
>     because there's no machine cleanup code to ensure that.
> 
> Eduardo Habkost (3):
>   vl: Clean up user-creatable objects when exiting
>   osdep: Define QEMU_MADV_REMOVE
>   hostmem-file: Add "discard-data" option
> 
>  include/qemu/osdep.h            |  7 +++++++
>  include/qom/object_interfaces.h |  8 ++++++++
>  backends/hostmem-file.c         | 29 +++++++++++++++++++++++++++++
>  qom/object_interfaces.c         |  5 +++++
>  vl.c                            |  1 +
>  qemu-options.hx                 |  5 ++++-
>  6 files changed, 54 insertions(+), 1 deletion(-)
> 
> -- 
> 2.9.4
> 
> 

-- 
Eduardo
