Received: from eggs.gnu.org ([2001:4830:134:3::10]:58130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehIGO-0003WN-EJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehIGI-0000rG-Eq
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:03:04 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:46594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehIGI-0000qu-AD
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:02:58 -0500
Received: by mail-qt0-x242.google.com with SMTP id o35so27275938qtj.13
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 09:02:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180201162625.4276-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0a0672a2-1c8b-8257-caea-ba97e7eb6b5d@amsat.org>
Date: Thu, 1 Feb 2018 14:02:52 -0300
MIME-Version: 1.0
In-Reply-To: <20180201162625.4276-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] trace: avoid SystemTap "char const"
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

On 02/01/2018 01:26 PM, Stefan Hajnoczi wrote:
> SystemTap's dtrace(1) produces the following warning when it encounters
> "char const" instead of "const char":
> 
>   Warning: /usr/bin/dtrace:trace-dtrace-root.dtrace:66: syntax error near:
>   probe flatview_destroy_rcu
> 
>   Warning: Proceeding as if --no-pyparsing was given.
> 
> This is a limitation in current SystemTap releases.  I have sent a patch
> upstream to accept "char const" since it is valid C:
> 
>   https://sourceware.org/ml/systemtap/2018-q1/msg00017.html

Valid but bad practice :)

It is easier to confuse:

char const* a;
char *const a;

while this is clearer:

const char* a;
char *const a;

also:

cdecl> explain const char* a
declare a as pointer to const char
cdecl> explain char *const a
declare a as const pointer to char

but:

cdecl> explain char const* a
syntax error

and while here,

cdecl> explain const char *const a
declare a as const pointer to const char

:)

Personally I'd like checkpatch not accepting this confuse syntax.

> 
> In QEMU we still wish to avoid warnings in the current SystemTap
> release.  It's simple enough to replace "char const" with "const char".
> 
> I'm not changing the documentation or implementing checks to prevent
> this from occurring again in the future.  The next release of SystemTap
> will hopefully resolve this issue.
> 
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/block/trace-events |  4 ++--
>  trace-events          | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 5acd495207..6b9e733412 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -17,7 +17,7 @@ nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
>  nvme_irq_pin(void) "pulsing IRQ pin"
>  nvme_irq_masked(void) "IRQ is masked"
>  nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
> -nvme_rw(char const *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
> +nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
>  nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
>  nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
>  nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
> @@ -25,7 +25,7 @@ nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=%"PRIu16""
>  nvme_identify_ctrl(void) "identify controller"
>  nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
>  nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
> -nvme_getfeat_vwcache(char const* result) "get feature volatile write cache, result=%s"
> +nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
>  nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
>  nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
>  nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
> diff --git a/trace-events b/trace-events
> index ec95e67089..89fcad0fd1 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -73,13 +73,13 @@ flatview_destroy(FlatView *view, MemoryRegion *root) "%p (root %p)"
>  flatview_destroy_rcu(FlatView *view, MemoryRegion *root) "%p (root %p)"
>  
>  # gdbstub.c
> -gdbstub_op_start(char const *device) "Starting gdbstub using device %s"
> +gdbstub_op_start(const char *device) "Starting gdbstub using device %s"
>  gdbstub_op_exiting(uint8_t code) "notifying exit with code=0x%02x"
>  gdbstub_op_continue(void) "Continuing all CPUs"
>  gdbstub_op_continue_cpu(int cpu_index) "Continuing CPU %d"
>  gdbstub_op_stepping(int cpu_index) "Stepping CPU %d"
> -gdbstub_op_extra_info(char const *info) "Thread extra info: %s"
> -gdbstub_hit_watchpoint(char const *type, int cpu_gdb_index, uint64_t vaddr) "Watchpoint hit, type=\"%s\" cpu=%d, vaddr=0x%" PRIx64 ""
> +gdbstub_op_extra_info(const char *info) "Thread extra info: %s"
> +gdbstub_hit_watchpoint(const char *type, int cpu_gdb_index, uint64_t vaddr) "Watchpoint hit, type=\"%s\" cpu=%d, vaddr=0x%" PRIx64 ""
>  gdbstub_hit_internal_error(void) "RUN_STATE_INTERNAL_ERROR"
>  gdbstub_hit_break(void) "RUN_STATE_DEBUG"
>  gdbstub_hit_paused(void) "RUN_STATE_PAUSED"
> @@ -87,9 +87,9 @@ gdbstub_hit_shutdown(void) "RUN_STATE_SHUTDOWN"
>  gdbstub_hit_io_error(void) "RUN_STATE_IO_ERROR"
>  gdbstub_hit_watchdog(void) "RUN_STATE_WATCHDOG"
>  gdbstub_hit_unknown(int state) "Unknown run state=0x%x"
> -gdbstub_io_reply(char const *message) "Sent: %s"
> -gdbstub_io_binaryreply(size_t ofs, char const *line) "0x%04zx: %s"
> -gdbstub_io_command(char const *command) "Received: %s"
> +gdbstub_io_reply(const char *message) "Sent: %s"
> +gdbstub_io_binaryreply(size_t ofs, const char *line) "0x%04zx: %s"
> +gdbstub_io_command(const char *command) "Received: %s"
>  gdbstub_io_got_ack(void) "Got ACK"
>  gdbstub_io_got_unexpected(uint8_t ch) "Got 0x%02x when expecting ACK/NACK"
>  gdbstub_err_got_nack(void) "Got NACK, retransmitting"
> 
