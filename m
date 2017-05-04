Received: from eggs.gnu.org ([2001:4830:134:3::10]:39174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6GMP-0005KU-Aw
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6GMK-0008Ed-Gq
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:59:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6GMK-0008EP-9a
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:59:52 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DB8E7F40B
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 12:59:51 +0000 (UTC)
References: <20170503072819.14462-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f3ca702-7ea8-bcee-af55-71a645b7e39c@redhat.com>
Date: Thu, 4 May 2017 14:59:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170503072819.14462-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dump: Acquire BQL around vm_start() in
 dump thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, peterx@redhat.com



On 03/05/2017 09:28, Fam Zheng wrote:
> This fixes an assertion failure in the following backtrace:
> 
>     __GI___assert_fail
>     memory_region_transaction_commit
>     memory_region_add_eventfd
>     virtio_pci_ioeventfd_assign
>     virtio_bus_set_host_notifier
>     virtio_blk_data_plane_start
>     virtio_bus_start_ioeventfd
>     virtio_vmstate_change
>     vm_state_notify
>     vm_prepare_start
>     vm_start
>     dump_cleanup
>     dump_process
>     dump_thread
>     start_thread
>     clone
> 
> vm_start need BQL, acquire it if doing cleaning up from main thread.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  dump.c                | 7 +++++++
>  include/sysemu/dump.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/dump.c b/dump.c
> index f7b80d8..d9090a2 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -77,7 +77,13 @@ static int dump_cleanup(DumpState *s)
>      memory_mapping_list_free(&s->list);
>      close(s->fd);
>      if (s->resume) {
> +        if (s->detached) {
> +            qemu_mutex_lock_iothread();
> +        }
>          vm_start();
> +        if (s->detached) {
> +            qemu_mutex_unlock_iothread();
> +        }
>      }
>  
>      return 0;
> @@ -1804,6 +1810,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
>  
>      if (detach_p) {
>          /* detached dump */
> +        s->detached = true;
>          qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
>                             s, QEMU_THREAD_DETACHED);
>      } else {
> diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
> index ef931be..2672a15 100644
> --- a/include/sysemu/dump.h
> +++ b/include/sysemu/dump.h
> @@ -157,6 +157,7 @@ typedef struct DumpState {
>      uint32_t sh_info;
>      bool have_section;
>      bool resume;
> +    bool detached;
>      ssize_t note_size;
>      hwaddr memory_offset;
>      int fd;
> 

Queued, thanks.

Paolo
