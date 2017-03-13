Received: from eggs.gnu.org ([2001:4830:134:3::10]:47440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnWG9-0002M5-70
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnWG6-00070N-2n
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:08:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cnWG5-0006zp-Rs
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:07:57 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 130D5C05B1D1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 20:07:58 +0000 (UTC)
Date: Mon, 13 Mar 2017 20:07:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170313200752.GG5512@work-vm>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170313195547.21466-7-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/30] trace: Fix parameter types in
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Juan Quintela <quintela@redhat.com>

* Eric Blake (eblake@redhat.com) wrote:
> An upcoming patch will let the compiler warn us when we are silently
> losing precision in traces; update the trace definitions to pass
> through the full value at the callsite.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  migration/trace-events | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/trace-events b/migration/trace-events
> index 7372ce2..079d4e6 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> -loadvm_handle_cmd_packaged(unsigned int length) "%u"
> +loadvm_handle_cmd_packaged(size_t length) "%zu"

OK, that makes sense.

>  loadvm_handle_cmd_packaged_main(int ret) "%d"
>  loadvm_handle_cmd_packaged_received(int ret) "%d"
>  loadvm_postcopy_handle_advise(void) ""
> @@ -186,7 +186,7 @@ postcopy_ram_enable_notify(void) ""
>  postcopy_ram_fault_thread_entry(void) ""
>  postcopy_ram_fault_thread_exit(void) ""
>  postcopy_ram_fault_thread_quit(void) ""
> -postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
> +postcopy_ram_fault_thread_request(unsigned long long hostaddr, const char *ramblock, size_t offset) "Request for HVA=%llx rb=%s offset=%zx"

Hmm - why?
That's called as:
        trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
                                                qemu_ram_get_idstr(rb),
                                                rb_offset);
    struct uffd_msg msg;
struct uffd_msg {
..
        union {
                struct {
                        __u64   flags;
                        __u64   address;
                } pagefault;
..
        } arg;
}

So why is a PRIx64 not the right way to print a __u64 ?
(I prefer %llx to the horrid PRIx64 syntax, but it still seems weird in this case)

Dave


>  postcopy_ram_incoming_cleanup_closeuf(void) ""
>  postcopy_ram_incoming_cleanup_entry(void) ""
>  postcopy_ram_incoming_cleanup_exit(void) ""
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
