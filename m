Received: from eggs.gnu.org ([209.51.188.92]:33437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gpY3r-0006WU-AE
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gpY3h-00073B-SW
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:36:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gpY3Z-0006zu-ST
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:36:33 -0500
Date: Fri, 1 Feb 2019 12:36:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190201123618.GD3150@work-vm>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
	<20190131130850.6850-2-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131130850.6850-2-yuval.shaia@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 01/10] hw/rdma: Switch to generic error
 reporting way
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

* Yuval Shaia (yuval.shaia@oracle.com) wrote:
> Utilize error_report for all pr_err calls and some pr_dbg that are
> considered as errors.
> For the remaining pr_dbg calls, the important ones were replaced by
> trace points while other deleted.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  hw/rdma/rdma_backend.c        | 336 ++++++++++++++--------------------
>  hw/rdma/rdma_rm.c             | 121 +++++-------
>  hw/rdma/rdma_utils.c          |  11 +-
>  hw/rdma/rdma_utils.h          |  45 +----
>  hw/rdma/trace-events          |  32 +++-
>  hw/rdma/vmw/pvrdma.h          |   2 +-
>  hw/rdma/vmw/pvrdma_cmd.c      | 113 +++---------
>  hw/rdma/vmw/pvrdma_dev_ring.c |  26 +--
>  hw/rdma/vmw/pvrdma_main.c     | 132 +++++--------
>  hw/rdma/vmw/pvrdma_qp_ops.c   |  49 ++---
>  hw/rdma/vmw/trace-events      |  16 +-
>  11 files changed, 337 insertions(+), 546 deletions(-)
> 
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index fd571f21e5..5f60856d19 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -14,7 +14,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/error-report.h"
>  #include "sysemu/sysemu.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qlist.h"
> @@ -39,7 +38,6 @@
>  
>  typedef struct BackendCtx {
>      void *up_ctx;
> -    bool is_tx_req;
>      struct ibv_sge sge; /* Used to save MAD recv buffer */
>  } BackendCtx;
>  
> @@ -52,7 +50,7 @@ static void (*comp_handler)(void *ctx, struct ibv_wc *wc);
>  
>  static void dummy_comp_handler(void *ctx, struct ibv_wc *wc)
>  {
> -    pr_err("No completion handler is registered\n");
> +    rdma_error_report("No completion handler is registered");
>  }
>  
>  static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
> @@ -66,29 +64,24 @@ static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
>      comp_handler(ctx, &wc);
>  }
>  
> -static void poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
> +static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>  {
>      int i, ne;
>      BackendCtx *bctx;
>      struct ibv_wc wc[2];
>  
> -    pr_dbg("Entering poll_cq loop on cq %p\n", ibcq);
>      do {
>          ne = ibv_poll_cq(ibcq, ARRAY_SIZE(wc), wc);
>  
> -        pr_dbg("Got %d completion(s) from cq %p\n", ne, ibcq);
> +        trace_rdma_poll_cq(ne, ibcq);
>  
>          for (i = 0; i < ne; i++) {
> -            pr_dbg("wr_id=0x%" PRIx64 "\n", wc[i].wr_id);
> -            pr_dbg("status=%d\n", wc[i].status);
> -
>              bctx = rdma_rm_get_cqe_ctx(rdma_dev_res, wc[i].wr_id);
>              if (unlikely(!bctx)) {
> -                pr_dbg("Error: Failed to find ctx for req %" PRId64 "\n",
> -                       wc[i].wr_id);
> +                rdma_error_report("No matching ctx for req %"PRId64,
> +                                  wc[i].wr_id);

<snip>

> -#define init_pr_dbg(void)
> -#define pr_dbg(fmt, ...)
> -#define pr_dbg_buf(title, buf, len)
> -#endif
> +#define rdma_error_report(fmt, ...) \
> +    error_report("%s: " fmt, "rdma", ## __VA_ARGS__)
> +#define rdma_warn_report(fmt, ...) \
> +    warn_report("%s: " fmt, "rdma", ## __VA_ARGS__)
> +#define rdma_info_report(fmt, ...) \
> +    info_report("%s: " fmt, "rdma", ## __VA_ARGS__)

Is it worth defining these?  My temptation would be just to use the
__func__ string, i.e. the case above would become:

                error_report("%s: No matching ctx for req %"PRId64,
                                  __func__, wc[i].wr_id);

That's used in lots of places, and gives more useful information.

Dave


>  
>  void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
>  void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
> diff --git a/hw/rdma/trace-events b/hw/rdma/trace-events
> index c4c202e647..09cec43fd8 100644
> --- a/hw/rdma/trace-events
> +++ b/hw/rdma/trace-events
> @@ -1,5 +1,31 @@
>  # See docs/tracing.txt for syntax documentation.
>  
> -#hw/rdma/rdma_backend.c
> -create_ah_cache_hit(uint64_t subnet, uint64_t net_id) "subnet = 0x%"PRIx64" net_id = 0x%"PRIx64
> -create_ah_cache_miss(uint64_t subnet, uint64_t net_id) "subnet = 0x%"PRIx64" net_id = 0x%"PRIx64
> +# hw/rdma/rdma_backend.c
> +rdma_check_dev_attr(const char *name, int max_bk, int max_fe) "%s: be=%d, fe=%d"
> +rdma_create_ah_cache_hit(uint64_t subnet, uint64_t if_id) "subnet=0x%"PRIx64",if_id=0x%"PRIx64
> +rdma_create_ah_cache_miss(uint64_t subnet, uint64_t if_id) "subnet=0x%"PRIx64",if_id=0x%"PRIx64
> +rdma_poll_cq(int ne, void *ibcq) "Got %d completion(s) from cq %p"
> +rdmacm_mux(const char *title, int msg_type, int op_code) "%s: msg_type=%d, op_code=%d"
> +rdmacm_mux_check_op_status(int msg_type, int op_code, int err_code) "resp: msg_type=%d, op_code=%d, err_code=%d"
> +rdma_mad_message(const char *title, size_t len, char *data) "mad %s (%ld): %s"
> +rdma_backend_rc_qp_state_init(uint32_t qpn) "RC QP 0x%x switch to INIT"
> +rdma_backend_ud_qp_state_init(uint32_t qpn, uint32_t qkey) "UD QP 0x%x switch to INIT, qkey=0x%x"
> +rdma_backend_rc_qp_state_rtr(uint32_t qpn, uint64_t subnet, uint64_t ifid, uint8_t sgid_idx, uint32_t dqpn, uint32_t rq_psn) "RC QP 0x%x switch to RTR, subnet = 0x%"PRIx64", ifid = 0x%"PRIx64 ", sgid_idx=%d, dqpn=0x%x, rq_psn=0x%x"
> +rdma_backend_ud_qp_state_rtr(uint32_t qpn, uint32_t qkey) "UD QP 0x%x switch to RTR, qkey=0x%x"
> +rdma_backend_rc_qp_state_rts(uint32_t qpn, uint32_t sq_psn) "RC QP 0x%x switch to RTS, sq_psn=0x%x, "
> +rdma_backend_ud_qp_state_rts(uint32_t qpn, uint32_t sq_psn, uint32_t qkey) "UD QP 0x%x switch to RTS, sq_psn=0x%x, qkey=0x%x"
> +rdma_backend_get_gid_index(uint64_t subnet, uint64_t ifid, int gid_idx) "subnet=0x%"PRIx64", ifid=0x%"PRIx64 ", gid_idx=%d"
> +rdma_backend_gid_change(const char *op, uint64_t subnet, uint64_t ifid) "%s subnet=0x%"PRIx64", ifid=0x%"PRIx64
> +
> +# hw/rdma/rdma_rm.c
> +rdma_res_tbl_get(char *name, uint32_t handle) "tbl %s, handle %d"
> +rdma_res_tbl_alloc(char *name, uint32_t handle) "tbl %s, handle %d"
> +rdma_res_tbl_dealloc(char *name, uint32_t handle) "tbl %s, handle %d"
> +rdma_rm_alloc_mr(uint32_t mr_handle, void *host_virt, uint64_t guest_start, size_t guest_length, int access_flags) "mr_handle=%d, host_virt=%p, guest_start=0x%"PRIx64", length=%ld, access_flags=0x%x"
> +rdma_rm_dealloc_mr(uint32_t mr_handle, uint64_t guest_start) "mr_handle=%d, guest_start=0x%"PRIx64
> +rdma_rm_alloc_qp(uint32_t rm_qpn, uint32_t backend_qpn, uint8_t qp_type) "rm_qpn=%d, backend_qpn=0x%x, qp_type=%d"
> +rdma_rm_modify_qp(uint32_t qpn, uint32_t attr_mask, int qp_state, uint8_t sgid_idx) "qpn=0x%x, attr_mask=0x%x, qp_state=%d, sgid_idx=%d"
> +
> +# hw/rdma/rdma_utils.c
> +rdma_pci_dma_map(uint64_t addr, void *vaddr, uint64_t len) "0x%"PRIx64" -> %p (len=%" PRId64")"
> +rdma_pci_dma_unmap(void *vaddr) "%p"
> diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
> index ffae36986e..0879224957 100644
> --- a/hw/rdma/vmw/pvrdma.h
> +++ b/hw/rdma/vmw/pvrdma.h
> @@ -127,6 +127,6 @@ static inline void post_interrupt(PVRDMADev *dev, unsigned vector)
>      }
>  }
>  
> -int execute_command(PVRDMADev *dev);
> +int pvrdma_exec_cmd(PVRDMADev *dev);
>  
>  #endif
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index 89920887bf..21a55e225a 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -14,7 +14,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
> @@ -24,6 +23,7 @@
>  #include "../rdma_rm.h"
>  #include "../rdma_utils.h"
>  
> +#include "trace.h"
>  #include "pvrdma.h"
>  #include "standard-headers/rdma/vmw_pvrdma-abi.h"
>  
> @@ -35,40 +35,38 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
>      void *host_virt = NULL, *curr_page;
>  
>      if (!nchunks) {
> -        pr_dbg("nchunks=0\n");
> +        rdma_error_report("Got nchunks=0");
>          return NULL;
>      }
>  
>      dir = rdma_pci_dma_map(pdev, pdir_dma, TARGET_PAGE_SIZE);
>      if (!dir) {
> -        error_report("PVRDMA: Failed to map to page directory");
> +        rdma_error_report("Failed to map to page directory");
>          return NULL;
>      }
>  
>      tbl = rdma_pci_dma_map(pdev, dir[0], TARGET_PAGE_SIZE);
>      if (!tbl) {
> -        error_report("PVRDMA: Failed to map to page table 0");
> +        rdma_error_report("Failed to map to page table 0");
>          goto out_unmap_dir;
>      }
>  
>      curr_page = rdma_pci_dma_map(pdev, (dma_addr_t)tbl[0], TARGET_PAGE_SIZE);
>      if (!curr_page) {
> -        error_report("PVRDMA: Failed to map the first page");
> +        rdma_error_report("Failed to map the page 0");
>          goto out_unmap_tbl;
>      }
>  
>      host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
> -    pr_dbg("mremap %p -> %p\n", curr_page, host_virt);
>      if (host_virt == MAP_FAILED) {
>          host_virt = NULL;
> -        error_report("PVRDMA: Failed to remap memory for host_virt");
> +        rdma_error_report("Failed to remap memory for host_virt");
>          goto out_unmap_tbl;
>      }
> +    trace_pvrdma_map_to_pdir_host_virt(curr_page, host_virt);
>  
>      rdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
>  
> -    pr_dbg("host_virt=%p\n", host_virt);
> -
>      dir_idx = 0;
>      tbl_idx = 1;
>      addr_idx = 1;
> @@ -76,28 +74,28 @@ static void *pvrdma_map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma,
>          if (tbl_idx == TARGET_PAGE_SIZE / sizeof(uint64_t)) {
>              tbl_idx = 0;
>              dir_idx++;
> -            pr_dbg("Mapping to table %d\n", dir_idx);
>              rdma_pci_dma_unmap(pdev, tbl, TARGET_PAGE_SIZE);
>              tbl = rdma_pci_dma_map(pdev, dir[dir_idx], TARGET_PAGE_SIZE);
>              if (!tbl) {
> -                error_report("PVRDMA: Failed to map to page table %d", dir_idx);
> +                rdma_error_report("Failed to map to page table %d", dir_idx);
>                  goto out_unmap_host_virt;
>              }
>          }
>  
> -        pr_dbg("guest_dma[%d]=0x%" PRIx64 "\n", addr_idx, tbl[tbl_idx]);
> -
>          curr_page = rdma_pci_dma_map(pdev, (dma_addr_t)tbl[tbl_idx],
>                                       TARGET_PAGE_SIZE);
>          if (!curr_page) {
> -            error_report("PVRDMA: Failed to map to page %d, dir %d", tbl_idx,
> -                         dir_idx);
> +            rdma_error_report("Failed to map to page %d, dir %d", tbl_idx,
> +                              dir_idx);
>              goto out_unmap_host_virt;
>          }
>  
>          mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
>                 host_virt + TARGET_PAGE_SIZE * addr_idx);
>  
> +        trace_pvrdma_map_to_pdir_next_page(addr_idx, curr_page, host_virt +
> +                                           TARGET_PAGE_SIZE * addr_idx);
> +
>          rdma_pci_dma_unmap(pdev, curr_page, TARGET_PAGE_SIZE);
>  
>          addr_idx++;
> @@ -127,7 +125,6 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
>      struct pvrdma_port_attr attrs = {0};
>  
> -    pr_dbg("port=%d\n", cmd->port_num);
>      if (cmd->port_num > MAX_PORTS) {
>          return -EINVAL;
>      }
> @@ -159,12 +156,10 @@ static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      struct pvrdma_cmd_query_pkey *cmd = &req->query_pkey;
>      struct pvrdma_cmd_query_pkey_resp *resp = &rsp->query_pkey_resp;
>  
> -    pr_dbg("port=%d\n", cmd->port_num);
>      if (cmd->port_num > MAX_PORTS) {
>          return -EINVAL;
>      }
>  
> -    pr_dbg("index=%d\n", cmd->index);
>      if (cmd->index > MAX_PKEYS) {
>          return -EINVAL;
>      }
> @@ -172,7 +167,6 @@ static int query_pkey(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      memset(resp, 0, sizeof(*resp));
>  
>      resp->pkey = PVRDMA_PKEY;
> -    pr_dbg("pkey=0x%x\n", resp->pkey);
>  
>      return 0;
>  }
> @@ -184,8 +178,6 @@ static int create_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      struct pvrdma_cmd_create_pd_resp *resp = &rsp->create_pd_resp;
>      int rc;
>  
> -    pr_dbg("context=0x%x\n", cmd->ctx_handle ? cmd->ctx_handle : 0);
> -
>      memset(resp, 0, sizeof(*resp));
>      rc = rdma_rm_alloc_pd(&dev->rdma_dev_res, &dev->backend_dev,
>                            &resp->pd_handle, cmd->ctx_handle);
> @@ -198,8 +190,6 @@ static int destroy_pd(PVRDMADev *dev, union pvrdma_cmd_req *req,
>  {
>      struct pvrdma_cmd_destroy_pd *cmd = &req->destroy_pd;
>  
> -    pr_dbg("pd_handle=%d\n", cmd->pd_handle);
> -
>      rdma_rm_dealloc_pd(&dev->rdma_dev_res, cmd->pd_handle);
>  
>      return 0;
> @@ -216,15 +206,11 @@ static int create_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
>  
>      memset(resp, 0, sizeof(*resp));
>  
> -    pr_dbg("pd_handle=%d\n", cmd->pd_handle);
> -    pr_dbg("access_flags=0x%x\n", cmd->access_flags);
> -    pr_dbg("flags=0x%x\n", cmd->flags);
> -
>      if (!(cmd->flags & PVRDMA_MR_FLAG_DMA)) {
>          host_virt = pvrdma_map_to_pdir(pci_dev, cmd->pdir_dma, cmd->nchunks,
>                                         cmd->length);
>          if (!host_virt) {
> -            pr_dbg("Failed to map to pdir\n");
> +            rdma_error_report("Failed to map to pdir");
>              return -EINVAL;
>          }
>      }
> @@ -244,8 +230,6 @@ static int destroy_mr(PVRDMADev *dev, union pvrdma_cmd_req *req,
>  {
>      struct pvrdma_cmd_destroy_mr *cmd = &req->destroy_mr;
>  
> -    pr_dbg("mr_handle=%d\n", cmd->mr_handle);
> -
>      rdma_rm_dealloc_mr(&dev->rdma_dev_res, cmd->mr_handle);
>  
>      return 0;
> @@ -260,20 +244,19 @@ static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring,
>      char ring_name[MAX_RING_NAME_SZ];
>  
>      if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
> -        pr_dbg("invalid nchunks: %d\n", nchunks);
> +        rdma_error_report("Got invalid nchunks: %d", nchunks);
>          return rc;
>      }
>  
> -    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
>      dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
>      if (!dir) {
> -        pr_dbg("Failed to map to CQ page directory\n");
> +        rdma_error_report("Failed to map to CQ page directory");
>          goto out;
>      }
>  
>      tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
>      if (!tbl) {
> -        pr_dbg("Failed to map to CQ page table\n");
> +        rdma_error_report("Failed to map to CQ page table");
>          goto out;
>      }
>  
> @@ -284,7 +267,7 @@ static int create_cq_ring(PCIDevice *pci_dev , PvrdmaRing **ring,
>          rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
>  
>      if (!r->ring_state) {
> -        pr_dbg("Failed to map to CQ ring state\n");
> +        rdma_error_report("Failed to map to CQ ring state");
>          goto out_free_ring;
>      }
>  
> @@ -339,8 +322,6 @@ static int create_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
>          return rc;
>      }
>  
> -    pr_dbg("ring=%p\n", ring);
> -
>      rc = rdma_rm_alloc_cq(&dev->rdma_dev_res, &dev->backend_dev, cmd->cqe,
>                            &resp->cq_handle, ring);
>      if (rc) {
> @@ -359,11 +340,9 @@ static int destroy_cq(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      RdmaRmCQ *cq;
>      PvrdmaRing *ring;
>  
> -    pr_dbg("cq_handle=%d\n", cmd->cq_handle);
> -
>      cq = rdma_rm_get_cq(&dev->rdma_dev_res, cmd->cq_handle);
>      if (!cq) {
> -        pr_dbg("Invalid CQ handle\n");
> +        rdma_error_report("Got invalid CQ handle");
>          return -EINVAL;
>      }
>  
> @@ -388,42 +367,33 @@ static int create_qp_rings(PCIDevice *pci_dev, uint64_t pdir_dma,
>  
>      if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES
>          || !rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES) {
> -        pr_dbg("invalid pages: %d, %d\n", spages, rpages);
> +        rdma_error_report("Got invalid page count for QP ring: %d, %d", spages,
> +                          rpages);
>          return rc;
>      }
>  
> -    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)pdir_dma);
>      dir = rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
>      if (!dir) {
> -        pr_dbg("Failed to map to CQ page directory\n");
> +        rdma_error_report("Failed to map to CQ page directory");
>          goto out;
>      }
>  
>      tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
>      if (!tbl) {
> -        pr_dbg("Failed to map to CQ page table\n");
> +        rdma_error_report("Failed to map to CQ page table");
>          goto out;
>      }
>  
>      sr = g_malloc(2 * sizeof(*rr));
>      rr = &sr[1];
> -    pr_dbg("sring=%p\n", sr);
> -    pr_dbg("rring=%p\n", rr);
>  
>      *rings = sr;
>  
> -    pr_dbg("scqe=%d\n", scqe);
> -    pr_dbg("smax_sge=%d\n", smax_sge);
> -    pr_dbg("spages=%d\n", spages);
> -    pr_dbg("rcqe=%d\n", rcqe);
> -    pr_dbg("rmax_sge=%d\n", rmax_sge);
> -    pr_dbg("rpages=%d\n", rpages);
> -
>      /* Create send ring */
>      sr->ring_state = (struct pvrdma_ring *)
>          rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
>      if (!sr->ring_state) {
> -        pr_dbg("Failed to map to CQ ring state\n");
> +        rdma_error_report("Failed to map to CQ ring state");
>          goto out_free_sr_mem;
>      }
>  
> @@ -468,9 +438,7 @@ out:
>  
>  static void destroy_qp_rings(PvrdmaRing *ring)
>  {
> -    pr_dbg("sring=%p\n", &ring[0]);
>      pvrdma_ring_free(&ring[0]);
> -    pr_dbg("rring=%p\n", &ring[1]);
>      pvrdma_ring_free(&ring[1]);
>  
>      rdma_pci_dma_unmap(ring->dev, ring->ring_state, TARGET_PAGE_SIZE);
> @@ -487,9 +455,6 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>  
>      memset(resp, 0, sizeof(*resp));
>  
> -    pr_dbg("total_chunks=%d\n", cmd->total_chunks);
> -    pr_dbg("send_chunks=%d\n", cmd->send_chunks);
> -
>      rc = create_qp_rings(PCI_DEVICE(dev), cmd->pdir_dma, &rings,
>                           cmd->max_send_wr, cmd->max_send_sge, cmd->send_chunks,
>                           cmd->max_recv_wr, cmd->max_recv_sge,
> @@ -498,8 +463,6 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>          return rc;
>      }
>  
> -    pr_dbg("rings=%p\n", rings);
> -
>      rc = rdma_rm_alloc_qp(&dev->rdma_dev_res, cmd->pd_handle, cmd->qp_type,
>                            cmd->max_send_wr, cmd->max_send_sge,
>                            cmd->send_cq_handle, cmd->max_recv_wr,
> @@ -525,8 +488,6 @@ static int modify_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      struct pvrdma_cmd_modify_qp *cmd = &req->modify_qp;
>      int rc;
>  
> -    pr_dbg("qp_handle=%d\n", cmd->qp_handle);
> -
>      memset(rsp, 0, sizeof(*rsp));
>  
>      /* No need to verify sgid_index since it is u8 */
> @@ -551,9 +512,6 @@ static int query_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      struct ibv_qp_init_attr init_attr;
>      int rc;
>  
> -    pr_dbg("qp_handle=%d\n", cmd->qp_handle);
> -    pr_dbg("attr_mask=0x%x\n", cmd->attr_mask);
> -
>      memset(rsp, 0, sizeof(*rsp));
>  
>      rc = rdma_rm_query_qp(&dev->rdma_dev_res, &dev->backend_dev, cmd->qp_handle,
> @@ -572,7 +530,6 @@ static int destroy_qp(PVRDMADev *dev, union pvrdma_cmd_req *req,
>  
>      qp = rdma_rm_get_qp(&dev->rdma_dev_res, cmd->qp_handle);
>      if (!qp) {
> -        pr_dbg("Invalid QP handle\n");
>          return -EINVAL;
>      }
>  
> @@ -591,16 +548,10 @@ static int create_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      int rc;
>      union ibv_gid *gid = (union ibv_gid *)&cmd->new_gid;
>  
> -    pr_dbg("index=%d\n", cmd->index);
> -
>      if (cmd->index >= MAX_PORT_GIDS) {
>          return -EINVAL;
>      }
>  
> -    pr_dbg("gid[%d]=0x%llx,0x%llx\n", cmd->index,
> -           (long long unsigned int)be64_to_cpu(gid->global.subnet_prefix),
> -           (long long unsigned int)be64_to_cpu(gid->global.interface_id));
> -
>      rc = rdma_rm_add_gid(&dev->rdma_dev_res, &dev->backend_dev,
>                           dev->backend_eth_device_name, gid, cmd->index);
>  
> @@ -614,8 +565,6 @@ static int destroy_bind(PVRDMADev *dev, union pvrdma_cmd_req *req,
>  
>      struct pvrdma_cmd_destroy_bind *cmd = &req->destroy_bind;
>  
> -    pr_dbg("index=%d\n", cmd->index);
> -
>      if (cmd->index >= MAX_PORT_GIDS) {
>          return -EINVAL;
>      }
> @@ -633,8 +582,6 @@ static int create_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
>      struct pvrdma_cmd_create_uc_resp *resp = &rsp->create_uc_resp;
>      int rc;
>  
> -    pr_dbg("pfn=%d\n", cmd->pfn);
> -
>      memset(resp, 0, sizeof(*resp));
>      rc = rdma_rm_alloc_uc(&dev->rdma_dev_res, cmd->pfn, &resp->ctx_handle);
>  
> @@ -646,8 +593,6 @@ static int destroy_uc(PVRDMADev *dev, union pvrdma_cmd_req *req,
>  {
>      struct pvrdma_cmd_destroy_uc *cmd = &req->destroy_uc;
>  
> -    pr_dbg("ctx_handle=%d\n", cmd->ctx_handle);
> -
>      rdma_rm_dealloc_uc(&dev->rdma_dev_res, cmd->ctx_handle);
>  
>      return 0;
> @@ -680,22 +625,21 @@ static struct cmd_handler cmd_handlers[] = {
>      {PVRDMA_CMD_DESTROY_BIND, PVRDMA_CMD_DESTROY_BIND_RESP_NOOP, destroy_bind},
>  };
>  
> -int execute_command(PVRDMADev *dev)
> +int pvrdma_exec_cmd(PVRDMADev *dev)
>  {
>      int err = 0xFFFF;
>      DSRInfo *dsr_info;
>  
>      dsr_info = &dev->dsr_info;
>  
> -    pr_dbg("cmd=%d\n", dsr_info->req->hdr.cmd);
>      if (dsr_info->req->hdr.cmd >= sizeof(cmd_handlers) /
>                        sizeof(struct cmd_handler)) {
> -        pr_dbg("Unsupported command\n");
> +        rdma_error_report("Unsupported command");
>          goto out;
>      }
>  
>      if (!cmd_handlers[dsr_info->req->hdr.cmd].exec) {
> -        pr_dbg("Unsupported command (not implemented yet)\n");
> +        rdma_error_report("Unsupported command (not implemented yet)");
>          goto out;
>      }
>  
> @@ -704,7 +648,8 @@ int execute_command(PVRDMADev *dev)
>      dsr_info->rsp->hdr.response = dsr_info->req->hdr.response;
>      dsr_info->rsp->hdr.ack = cmd_handlers[dsr_info->req->hdr.cmd].ack;
>      dsr_info->rsp->hdr.err = err < 0 ? -err : 0;
> -    pr_dbg("rsp->hdr.err=%d\n", dsr_info->rsp->hdr.err);
> +
> +    trace_pvrdma_exec_cmd(dsr_info->req->hdr.cmd, dsr_info->rsp->hdr.err);
>  
>  out:
>      set_reg_val(dev, PVRDMA_REG_ERR, err);
> diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
> index e8e5b502f6..d7bc7f5ccc 100644
> --- a/hw/rdma/vmw/pvrdma_dev_ring.c
> +++ b/hw/rdma/vmw/pvrdma_dev_ring.c
> @@ -17,6 +17,8 @@
>  #include "hw/pci/pci.h"
>  #include "cpu.h"
>  
> +#include "trace.h"
> +
>  #include "../rdma_utils.h"
>  #include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h"
>  #include "pvrdma_dev_ring.h"
> @@ -30,13 +32,10 @@ int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
>  
>      strncpy(ring->name, name, MAX_RING_NAME_SZ);
>      ring->name[MAX_RING_NAME_SZ - 1] = 0;
> -    pr_dbg("Initializing %s ring\n", ring->name);
>      ring->dev = dev;
>      ring->ring_state = ring_state;
>      ring->max_elems = max_elems;
>      ring->elem_sz = elem_sz;
> -    pr_dbg("ring->elem_sz=%zu\n", ring->elem_sz);
> -    pr_dbg("npages=%d\n", npages);
>      /* TODO: Give a moment to think if we want to redo driver settings
>      atomic_set(&ring->ring_state->prod_tail, 0);
>      atomic_set(&ring->ring_state->cons_head, 0);
> @@ -46,14 +45,14 @@ int pvrdma_ring_init(PvrdmaRing *ring, const char *name, PCIDevice *dev,
>  
>      for (i = 0; i < npages; i++) {
>          if (!tbl[i]) {
> -            pr_err("npages=%ld but tbl[%d] is NULL\n", (long)npages, i);
> +            rdma_error_report("npages=%d but tbl[%d] is NULL", npages, i);
>              continue;
>          }
>  
>          ring->pages[i] = rdma_pci_dma_map(dev, tbl[i], TARGET_PAGE_SIZE);
>          if (!ring->pages[i]) {
>              rc = -ENOMEM;
> -            pr_dbg("Failed to map to page %d\n", i);
> +            rdma_error_report("Failed to map to page %d in ring %s", i, name);
>              goto out_free;
>          }
>          memset(ring->pages[i], 0, TARGET_PAGE_SIZE);
> @@ -78,7 +77,7 @@ void *pvrdma_ring_next_elem_read(PvrdmaRing *ring)
>  
>      e = pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &idx);
>      if (e <= 0) {
> -        pr_dbg("No more data in ring\n");
> +        trace_pvrdma_ring_next_elem_read_no_data(ring->name);
>          return NULL;
>      }
>  
> @@ -89,11 +88,6 @@ void *pvrdma_ring_next_elem_read(PvrdmaRing *ring)
>  void pvrdma_ring_read_inc(PvrdmaRing *ring)
>  {
>      pvrdma_idx_ring_inc(&ring->ring_state->cons_head, ring->max_elems);
> -    /*
> -    pr_dbg("%s: t=%d, h=%d, m=%ld\n", ring->name,
> -           ring->ring_state->prod_tail, ring->ring_state->cons_head,
> -           ring->max_elems);
> -    */
>  }
>  
>  void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
> @@ -103,13 +97,13 @@ void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
>  
>      idx = pvrdma_idx_ring_has_space(ring->ring_state, ring->max_elems, &tail);
>      if (idx <= 0) {
> -        pr_dbg("CQ is full\n");
> +        rdma_error_report("CQ is full");
>          return NULL;
>      }
>  
>      idx = pvrdma_idx(&ring->ring_state->prod_tail, ring->max_elems);
>      if (idx < 0 || tail != idx) {
> -        pr_dbg("invalid idx\n");
> +        rdma_error_report("Invalid idx %d", idx);
>          return NULL;
>      }
>  
> @@ -120,11 +114,6 @@ void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
>  void pvrdma_ring_write_inc(PvrdmaRing *ring)
>  {
>      pvrdma_idx_ring_inc(&ring->ring_state->prod_tail, ring->max_elems);
> -    /*
> -    pr_dbg("%s: t=%d, h=%d, m=%ld\n", ring->name,
> -           ring->ring_state->prod_tail, ring->ring_state->cons_head,
> -           ring->max_elems);
> -    */
>  }
>  
>  void pvrdma_ring_free(PvrdmaRing *ring)
> @@ -137,7 +126,6 @@ void pvrdma_ring_free(PvrdmaRing *ring)
>          return;
>      }
>  
> -    pr_dbg("ring->npages=%d\n", ring->npages);
>      while (ring->npages--) {
>          rdma_pci_dma_unmap(ring->dev, ring->pages[ring->npages],
>                             TARGET_PAGE_SIZE);
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index d2bdb5ba8c..b6061f4b6e 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -69,25 +69,22 @@ static int init_dev_ring(PvrdmaRing *ring, struct pvrdma_ring **ring_state,
>      uint64_t *dir, *tbl;
>      int rc = 0;
>  
> -    pr_dbg("Initializing device ring %s\n", name);
> -    pr_dbg("pdir_dma=0x%llx\n", (long long unsigned int)dir_addr);
> -    pr_dbg("num_pages=%d\n", num_pages);
>      dir = rdma_pci_dma_map(pci_dev, dir_addr, TARGET_PAGE_SIZE);
>      if (!dir) {
> -        pr_err("Failed to map to page directory\n");
> +        rdma_error_report("Failed to map to page directory (ring %s)", name);
>          rc = -ENOMEM;
>          goto out;
>      }
>      tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
>      if (!tbl) {
> -        pr_err("Failed to map to page table\n");
> +        rdma_error_report("Failed to map to page table (ring %s)", name);
>          rc = -ENOMEM;
>          goto out_free_dir;
>      }
>  
>      *ring_state = rdma_pci_dma_map(pci_dev, tbl[0], TARGET_PAGE_SIZE);
>      if (!*ring_state) {
> -        pr_err("Failed to map to ring state\n");
> +        rdma_error_report("Failed to map to ring state (ring %s)", name);
>          rc = -ENOMEM;
>          goto out_free_tbl;
>      }
> @@ -100,7 +97,6 @@ static int init_dev_ring(PvrdmaRing *ring, struct pvrdma_ring **ring_state,
>                            sizeof(struct pvrdma_cqne),
>                            (dma_addr_t *)&tbl[1], (dma_addr_t)num_pages - 1);
>      if (rc) {
> -        pr_err("Failed to initialize ring\n");
>          rc = -ENOMEM;
>          goto out_free_ring_state;
>      }
> @@ -155,11 +151,10 @@ static int load_dsr(PVRDMADev *dev)
>      free_dsr(dev);
>  
>      /* Map to DSR */
> -    pr_dbg("dsr_dma=0x%llx\n", (long long unsigned int)dev->dsr_info.dma);
>      dev->dsr_info.dsr = rdma_pci_dma_map(pci_dev, dev->dsr_info.dma,
>                                sizeof(struct pvrdma_device_shared_region));
>      if (!dev->dsr_info.dsr) {
> -        pr_err("Failed to map to DSR\n");
> +        rdma_error_report("Failed to map to DSR");
>          rc = -ENOMEM;
>          goto out;
>      }
> @@ -169,21 +164,19 @@ static int load_dsr(PVRDMADev *dev)
>      dsr = dsr_info->dsr;
>  
>      /* Map to command slot */
> -    pr_dbg("cmd_dma=0x%llx\n", (long long unsigned int)dsr->cmd_slot_dma);
>      dsr_info->req = rdma_pci_dma_map(pci_dev, dsr->cmd_slot_dma,
>                                       sizeof(union pvrdma_cmd_req));
>      if (!dsr_info->req) {
> -        pr_err("Failed to map to command slot address\n");
> +        rdma_error_report("Failed to map to command slot address");
>          rc = -ENOMEM;
>          goto out_free_dsr;
>      }
>  
>      /* Map to response slot */
> -    pr_dbg("rsp_dma=0x%llx\n", (long long unsigned int)dsr->resp_slot_dma);
>      dsr_info->rsp = rdma_pci_dma_map(pci_dev, dsr->resp_slot_dma,
>                                       sizeof(union pvrdma_cmd_resp));
>      if (!dsr_info->rsp) {
> -        pr_err("Failed to map to response slot address\n");
> +        rdma_error_report("Failed to map to response slot address");
>          rc = -ENOMEM;
>          goto out_free_req;
>      }
> @@ -193,7 +186,6 @@ static int load_dsr(PVRDMADev *dev)
>                         pci_dev, dsr->cq_ring_pages.pdir_dma,
>                         dsr->cq_ring_pages.num_pages);
>      if (rc) {
> -        pr_err("Failed to map to initialize CQ ring\n");
>          rc = -ENOMEM;
>          goto out_free_rsp;
>      }
> @@ -203,7 +195,6 @@ static int load_dsr(PVRDMADev *dev)
>                         "dev_async", pci_dev, dsr->async_ring_pages.pdir_dma,
>                         dsr->async_ring_pages.num_pages);
>      if (rc) {
> -        pr_err("Failed to map to initialize event ring\n");
>          rc = -ENOMEM;
>          goto out_free_rsp;
>      }
> @@ -230,24 +221,15 @@ static void init_dsr_dev_caps(PVRDMADev *dev)
>      struct pvrdma_device_shared_region *dsr;
>  
>      if (dev->dsr_info.dsr == NULL) {
> -        pr_err("Can't initialized DSR\n");
> +        rdma_error_report("Can't initialized DSR");
>          return;
>      }
>  
>      dsr = dev->dsr_info.dsr;
> -
>      dsr->caps.fw_ver = PVRDMA_FW_VERSION;
> -    pr_dbg("fw_ver=0x%" PRIx64 "\n", dsr->caps.fw_ver);
> -
>      dsr->caps.mode = PVRDMA_DEVICE_MODE_ROCE;
> -    pr_dbg("mode=%d\n", dsr->caps.mode);
> -
>      dsr->caps.gid_types |= PVRDMA_GID_TYPE_FLAG_ROCE_V1;
> -    pr_dbg("gid_types=0x%x\n", dsr->caps.gid_types);
> -
>      dsr->caps.max_uar = RDMA_BAR2_UAR_SIZE;
> -    pr_dbg("max_uar=%d\n", dsr->caps.max_uar);
> -
>      dsr->caps.max_mr_size = dev->dev_attr.max_mr_size;
>      dsr->caps.max_qp = dev->dev_attr.max_qp;
>      dsr->caps.max_qp_wr = dev->dev_attr.max_qp_wr;
> @@ -257,23 +239,11 @@ static void init_dsr_dev_caps(PVRDMADev *dev)
>      dsr->caps.max_mr = dev->dev_attr.max_mr;
>      dsr->caps.max_pd = dev->dev_attr.max_pd;
>      dsr->caps.max_ah = dev->dev_attr.max_ah;
> -
>      dsr->caps.gid_tbl_len = MAX_GIDS;
> -    pr_dbg("gid_tbl_len=%d\n", dsr->caps.gid_tbl_len);
> -
>      dsr->caps.sys_image_guid = 0;
> -    pr_dbg("sys_image_guid=%" PRIx64 "\n", dsr->caps.sys_image_guid);
> -
>      dsr->caps.node_guid = dev->node_guid;
> -    pr_dbg("node_guid=%" PRIx64 "\n", be64_to_cpu(dsr->caps.node_guid));
> -
>      dsr->caps.phys_port_cnt = MAX_PORTS;
> -    pr_dbg("phys_port_cnt=%d\n", dsr->caps.phys_port_cnt);
> -
>      dsr->caps.max_pkeys = MAX_PKEYS;
> -    pr_dbg("max_pkeys=%d\n", dsr->caps.max_pkeys);
> -
> -    pr_dbg("Initialized\n");
>  }
>  
>  static void uninit_msix(PCIDevice *pdev, int used_vectors)
> @@ -319,9 +289,6 @@ static void pvrdma_fini(PCIDevice *pdev)
>  {
>      PVRDMADev *dev = PVRDMA_DEV(pdev);
>  
> -    pr_dbg("Closing device %s %x.%x\n", pdev->name, PCI_SLOT(pdev->devfn),
> -           PCI_FUNC(pdev->devfn));
> -
>      pvrdma_qp_ops_fini();
>  
>      rdma_rm_fini(&dev->rdma_dev_res, &dev->backend_dev,
> @@ -335,8 +302,8 @@ static void pvrdma_fini(PCIDevice *pdev)
>          uninit_msix(pdev, RDMA_MAX_INTRS);
>      }
>  
> -    pr_dbg("Device %s %x.%x is down\n", pdev->name, PCI_SLOT(pdev->devfn),
> -           PCI_FUNC(pdev->devfn));
> +    rdma_info_report("Device %s %x.%x is down", pdev->name,
> +                     PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>  }
>  
>  static void pvrdma_stop(PVRDMADev *dev)
> @@ -353,32 +320,26 @@ static void activate_device(PVRDMADev *dev)
>  {
>      pvrdma_start(dev);
>      set_reg_val(dev, PVRDMA_REG_ERR, 0);
> -    pr_dbg("Device activated\n");
>  }
>  
>  static int unquiesce_device(PVRDMADev *dev)
>  {
> -    pr_dbg("Device unquiesced\n");
>      return 0;
>  }
>  
>  static void reset_device(PVRDMADev *dev)
>  {
>      pvrdma_stop(dev);
> -
> -    pr_dbg("Device reset complete\n");
>  }
>  
> -static uint64_t regs_read(void *opaque, hwaddr addr, unsigned size)
> +static uint64_t pvrdma_regs_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      PVRDMADev *dev = opaque;
>      uint32_t val;
>  
> -    /* pr_dbg("addr=0x%lx, size=%d\n", addr, size); */
> -
>      if (get_reg_val(dev, addr, &val)) {
> -        pr_dbg("Error trying to read REG value from address 0x%x\n",
> -               (uint32_t)addr);
> +        rdma_error_report("Failed to read REG value from address 0x%x",
> +                          (uint32_t)addr);
>          return -EINVAL;
>      }
>  
> @@ -387,25 +348,24 @@ static uint64_t regs_read(void *opaque, hwaddr addr, unsigned size)
>      return val;
>  }
>  
> -static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
> +                              unsigned size)
>  {
>      PVRDMADev *dev = opaque;
>  
> -    /* pr_dbg("addr=0x%lx, val=0x%x, size=%d\n", addr, (uint32_t)val, size); */
> -
>      if (set_reg_val(dev, addr, val)) {
> -        pr_err("Fail to set REG value, addr=0x%" PRIx64 ", val=0x%" PRIx64 "\n",
> -               addr, val);
> +        rdma_error_report("Failed to set REG value, addr=0x%"PRIx64 ", val=0x%"PRIx64,
> +                          addr, val);
>          return;
>      }
>  
> -    trace_pvrdma_regs_write(addr, val);
> -
>      switch (addr) {
>      case PVRDMA_REG_DSRLOW:
> +        trace_pvrdma_regs_write(addr, val, "DSRLOW", "");
>          dev->dsr_info.dma = val;
>          break;
>      case PVRDMA_REG_DSRHIGH:
> +        trace_pvrdma_regs_write(addr, val, "DSRHIGH", "");
>          dev->dsr_info.dma |= val << 32;
>          load_dsr(dev);
>          init_dsr_dev_caps(dev);
> @@ -413,23 +373,27 @@ static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>      case PVRDMA_REG_CTL:
>          switch (val) {
>          case PVRDMA_DEVICE_CTL_ACTIVATE:
> +            trace_pvrdma_regs_write(addr, val, "CTL", "ACTIVATE");
>              activate_device(dev);
>              break;
>          case PVRDMA_DEVICE_CTL_UNQUIESCE:
> +            trace_pvrdma_regs_write(addr, val, "CTL", "UNQUIESCE");
>              unquiesce_device(dev);
>              break;
>          case PVRDMA_DEVICE_CTL_RESET:
> +            trace_pvrdma_regs_write(addr, val, "CTL", "URESET");
>              reset_device(dev);
>              break;
>          }
>          break;
>      case PVRDMA_REG_IMR:
> -        pr_dbg("Interrupt mask=0x%" PRIx64 "\n", val);
> +        trace_pvrdma_regs_write(addr, val, "INTR_MASK", "");
>          dev->interrupt_mask = val;
>          break;
>      case PVRDMA_REG_REQUEST:
>          if (val == 0) {
> -            execute_command(dev);
> +            trace_pvrdma_regs_write(addr, val, "REQUEST", "");
> +            pvrdma_exec_cmd(dev);
>          }
>          break;
>      default:
> @@ -438,8 +402,8 @@ static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>  }
>  
>  static const MemoryRegionOps regs_ops = {
> -    .read = regs_read,
> -    .write = regs_write,
> +    .read = pvrdma_regs_read,
> +    .write = pvrdma_regs_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .impl = {
>          .min_access_size = sizeof(uint32_t),
> @@ -447,54 +411,58 @@ static const MemoryRegionOps regs_ops = {
>      },
>  };
>  
> -static uint64_t uar_read(void *opaque, hwaddr addr, unsigned size)
> +static uint64_t pvrdma_uar_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      return 0xffffffff;
>  }
>  
> -static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +static void pvrdma_uar_write(void *opaque, hwaddr addr, uint64_t val,
> +                             unsigned size)
>  {
>      PVRDMADev *dev = opaque;
>  
> -    /* pr_dbg("addr=0x%lx, val=0x%x, size=%d\n", addr, (uint32_t)val, size); */
> -
>      switch (addr & 0xFFF) { /* Mask with 0xFFF as each UC gets page */
>      case PVRDMA_UAR_QP_OFFSET:
> -        pr_dbg("UAR QP command, addr=0x%" PRIx64 ", val=0x%" PRIx64 "\n",
> -               (uint64_t)addr, val);
>          if (val & PVRDMA_UAR_QP_SEND) {
> +            trace_pvrdma_uar_write(addr, val, "QP", "SEND",
> +                                   val & PVRDMA_UAR_HANDLE_MASK, 0);
>              pvrdma_qp_send(dev, val & PVRDMA_UAR_HANDLE_MASK);
>          }
>          if (val & PVRDMA_UAR_QP_RECV) {
> +            trace_pvrdma_uar_write(addr, val, "QP", "RECV",
> +                                   val & PVRDMA_UAR_HANDLE_MASK, 0);
>              pvrdma_qp_recv(dev, val & PVRDMA_UAR_HANDLE_MASK);
>          }
>          break;
>      case PVRDMA_UAR_CQ_OFFSET:
> -        /* pr_dbg("UAR CQ cmd, addr=0x%x, val=0x%lx\n", (uint32_t)addr, val); */
>          if (val & PVRDMA_UAR_CQ_ARM) {
> +            trace_pvrdma_uar_write(addr, val, "CQ", "ARM",
> +                                   val & PVRDMA_UAR_HANDLE_MASK,
> +                                   !!(val & PVRDMA_UAR_CQ_ARM_SOL));
>              rdma_rm_req_notify_cq(&dev->rdma_dev_res,
>                                    val & PVRDMA_UAR_HANDLE_MASK,
>                                    !!(val & PVRDMA_UAR_CQ_ARM_SOL));
>          }
>          if (val & PVRDMA_UAR_CQ_ARM_SOL) {
> -            pr_dbg("UAR_CQ_ARM_SOL (%" PRIx64 ")\n",
> -                   val & PVRDMA_UAR_HANDLE_MASK);
> +            trace_pvrdma_uar_write(addr, val, "CQ", "ARMSOL - not supported", 0,
> +                                   0);
>          }
>          if (val & PVRDMA_UAR_CQ_POLL) {
> -            pr_dbg("UAR_CQ_POLL (%" PRIx64 ")\n", val & PVRDMA_UAR_HANDLE_MASK);
> +            trace_pvrdma_uar_write(addr, val, "CQ", "POLL",
> +                                   val & PVRDMA_UAR_HANDLE_MASK, 0);
>              pvrdma_cq_poll(&dev->rdma_dev_res, val & PVRDMA_UAR_HANDLE_MASK);
>          }
>          break;
>      default:
> -        pr_err("Unsupported command, addr=0x%" PRIx64 ", val=0x%" PRIx64 "\n",
> -               addr, val);
> +        rdma_error_report("Unsupported command, addr=0x%"PRIx64", val=0x%"PRIx64,
> +                          addr, val);
>          break;
>      }
>  }
>  
>  static const MemoryRegionOps uar_ops = {
> -    .read = uar_read,
> -    .write = uar_write,
> +    .read = pvrdma_uar_read,
> +    .write = pvrdma_uar_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .impl = {
>          .min_access_size = sizeof(uint32_t),
> @@ -551,11 +519,9 @@ static void init_dev_caps(PVRDMADev *dev)
>                                (wr_sz + sizeof(struct pvrdma_sge) *
>                                dev->dev_attr.max_sge) - TARGET_PAGE_SIZE;
>                                /* First page is ring state  ^^^^ */
> -    pr_dbg("max_qp_wr=%d\n", dev->dev_attr.max_qp_wr);
>  
>      dev->dev_attr.max_cqe = pg_tbl_bytes / sizeof(struct pvrdma_cqe) -
>                              TARGET_PAGE_SIZE; /* First page is ring state */
> -    pr_dbg("max_cqe=%d\n", dev->dev_attr.max_cqe);
>  }
>  
>  static int pvrdma_check_ram_shared(Object *obj, void *opaque)
> @@ -585,10 +551,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>      bool ram_shared = false;
>      PCIDevice *func0;
>  
> -    init_pr_dbg();
> -
> -    pr_dbg("Initializing device %s %x.%x\n", pdev->name,
> -           PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> +    rdma_info_report("Initializing device %s %x.%x", pdev->name,
> +                     PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>  
>      if (TARGET_PAGE_SIZE != getpagesize()) {
>          error_setg(errp, "Target page size must be the same as host page size");
> @@ -598,8 +562,6 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>      func0 = pci_get_function_0(pdev);
>      /* Break if not vmxnet3 device in slot 0 */
>      if (strcmp(object_get_typename(&func0->qdev.parent_obj), TYPE_VMXNET3)) {
> -        pr_dbg("func0 type is %s\n",
> -               object_get_typename(&func0->qdev.parent_obj));
>          error_setg(errp, "Device on %x.0 must be %s", PCI_SLOT(pdev->devfn),
>                     TYPE_VMXNET3);
>          return;
> @@ -656,7 +618,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>  out:
>      if (rc) {
>          pvrdma_fini(pdev);
> -        error_append_hint(errp, "Device fail to load\n");
> +        error_append_hint(errp, "Device failed to load\n");
>      }
>  }
>  
> diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
> index ce5a60e184..16db726dac 100644
> --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> @@ -19,6 +19,8 @@
>  #include "../rdma_rm.h"
>  #include "../rdma_backend.h"
>  
> +#include "trace.h"
> +
>  #include "pvrdma.h"
>  #include "standard-headers/rdma/vmw_pvrdma-abi.h"
>  #include "pvrdma_qp_ops.h"
> @@ -55,18 +57,14 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
>      RdmaRmCQ *cq = rdma_rm_get_cq(&dev->rdma_dev_res, cq_handle);
>  
>      if (unlikely(!cq)) {
> -        pr_dbg("Invalid cqn %d\n", cq_handle);
>          return -EINVAL;
>      }
>  
>      ring = (PvrdmaRing *)cq->opaque;
> -    pr_dbg("ring=%p\n", ring);
>  
>      /* Step #1: Put CQE on CQ ring */
> -    pr_dbg("Writing CQE\n");
>      cqe1 = pvrdma_ring_next_elem_write(ring);
>      if (unlikely(!cqe1)) {
> -        pr_dbg("No CQEs in ring\n");
>          return -EINVAL;
>      }
>  
> @@ -80,19 +78,13 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
>      cqe1->wc_flags = wc->wc_flags;
>      cqe1->vendor_err = wc->vendor_err;
>  
> -    pr_dbg("wr_id=%" PRIx64 "\n", cqe1->wr_id);
> -    pr_dbg("qp=0x%lx\n", cqe1->qp);
> -    pr_dbg("opcode=%d\n", cqe1->opcode);
> -    pr_dbg("status=%d\n", cqe1->status);
> -    pr_dbg("byte_len=%d\n", cqe1->byte_len);
> -    pr_dbg("src_qp=%d\n", cqe1->src_qp);
> -    pr_dbg("wc_flags=%d\n", cqe1->wc_flags);
> -    pr_dbg("vendor_err=%d\n", cqe1->vendor_err);
> +    trace_pvrdma_post_cqe(cq_handle, cq->notify, cqe1->wr_id, cqe1->qp,
> +                          cqe1->opcode, cqe1->status, cqe1->byte_len,
> +                          cqe1->src_qp, cqe1->wc_flags, cqe1->vendor_err);
>  
>      pvrdma_ring_write_inc(ring);
>  
>      /* Step #2: Put CQ number on dsr completion ring */
> -    pr_dbg("Writing CQNE\n");
>      cqne = pvrdma_ring_next_elem_write(&dev->dsr_info.cq);
>      if (unlikely(!cqne)) {
>          return -EINVAL;
> @@ -101,7 +93,6 @@ static int pvrdma_post_cqe(PVRDMADev *dev, uint32_t cq_handle,
>      cqne->info = cq_handle;
>      pvrdma_ring_write_inc(&dev->dsr_info.cq);
>  
> -    pr_dbg("cq->notify=%d\n", cq->notify);
>      if (cq->notify != CNT_CLEAR) {
>          if (cq->notify == CNT_ARM) {
>              cq->notify = CNT_CLEAR;
> @@ -151,23 +142,17 @@ void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>      int sgid_idx;
>      union ibv_gid *sgid;
>  
> -    pr_dbg("qp_handle=0x%x\n", qp_handle);
> -
>      qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
>      if (unlikely(!qp)) {
> -        pr_dbg("Invalid qpn\n");
>          return;
>      }
>  
>      ring = (PvrdmaRing *)qp->opaque;
> -    pr_dbg("sring=%p\n", ring);
>  
>      wqe = (struct PvrdmaSqWqe *)pvrdma_ring_next_elem_read(ring);
>      while (wqe) {
>          CompHandlerCtx *comp_ctx;
>  
> -        pr_dbg("wr_id=%" PRIx64 "\n", wqe->hdr.wr_id);
> -
>          /* Prepare CQE */
>          comp_ctx = g_malloc(sizeof(CompHandlerCtx));
>          comp_ctx->dev = dev;
> @@ -178,26 +163,25 @@ void pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
>  
>          sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
>          if (!sgid) {
> -            pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
> +            rdma_error_report("Failed to get gid for idx %d",
> +                              wqe->hdr.wr.ud.av.gid_index);
>              complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
>              continue;
>          }
> -        pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
> -               sgid->global.interface_id);
>  
>          sgid_idx = rdma_rm_get_backend_gid_index(&dev->rdma_dev_res,
>                                                   &dev->backend_dev,
>                                                   wqe->hdr.wr.ud.av.gid_index);
>          if (sgid_idx <= 0) {
> -            pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
> -                   wqe->hdr.wr.ud.av.gid_index);
> +            rdma_error_report("Failed to get bk sgid_idx for sgid_idx %d",
> +                              wqe->hdr.wr.ud.av.gid_index);
>              complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
>              continue;
>          }
>  
>          if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
> -            pr_dbg("Invalid num_sge=%d (max %d)\n", wqe->hdr.num_sge,
> -                   dev->dev_attr.max_sge);
> +            rdma_error_report("Invalid num_sge=%d (max %d)", wqe->hdr.num_sge,
> +                              dev->dev_attr.max_sge);
>              complete_with_error(VENDOR_ERR_INV_NUM_SGE, comp_ctx);
>              continue;
>          }
> @@ -221,23 +205,17 @@ void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
>      PvrdmaRqWqe *wqe;
>      PvrdmaRing *ring;
>  
> -    pr_dbg("qp_handle=0x%x\n", qp_handle);
> -
>      qp = rdma_rm_get_qp(&dev->rdma_dev_res, qp_handle);
>      if (unlikely(!qp)) {
> -        pr_dbg("Invalid qpn\n");
>          return;
>      }
>  
>      ring = &((PvrdmaRing *)qp->opaque)[1];
> -    pr_dbg("rring=%p\n", ring);
>  
>      wqe = (struct PvrdmaRqWqe *)pvrdma_ring_next_elem_read(ring);
>      while (wqe) {
>          CompHandlerCtx *comp_ctx;
>  
> -        pr_dbg("wr_id=%" PRIx64 "\n", wqe->hdr.wr_id);
> -
>          /* Prepare CQE */
>          comp_ctx = g_malloc(sizeof(CompHandlerCtx));
>          comp_ctx->dev = dev;
> @@ -247,8 +225,8 @@ void pvrdma_qp_recv(PVRDMADev *dev, uint32_t qp_handle)
>          comp_ctx->cqe.opcode = IBV_WC_RECV;
>  
>          if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
> -            pr_dbg("Invalid num_sge=%d (max %d)\n", wqe->hdr.num_sge,
> -                   dev->dev_attr.max_sge);
> +            rdma_error_report("Invalid num_sge=%d (max %d)", wqe->hdr.num_sge,
> +                              dev->dev_attr.max_sge);
>              complete_with_error(VENDOR_ERR_INV_NUM_SGE, comp_ctx);
>              continue;
>          }
> @@ -270,7 +248,6 @@ void pvrdma_cq_poll(RdmaDeviceResources *dev_res, uint32_t cq_handle)
>  
>      cq = rdma_rm_get_cq(dev_res, cq_handle);
>      if (!cq) {
> -        pr_dbg("Invalid CQ# %d\n", cq_handle);
>          return;
>      }
>  
> diff --git a/hw/rdma/vmw/trace-events b/hw/rdma/vmw/trace-events
> index b3f9e2b19f..0122266ad7 100644
> --- a/hw/rdma/vmw/trace-events
> +++ b/hw/rdma/vmw/trace-events
> @@ -1,5 +1,17 @@
>  # See docs/tracing.txt for syntax documentation.
>  
>  # hw/rdma/vmw/pvrdma_main.c
> -pvrdma_regs_read(uint64_t addr, uint64_t val) "regs[0x%"PRIx64"] = 0x%"PRIx64
> -pvrdma_regs_write(uint64_t addr, uint64_t val) "regs[0x%"PRIx64"] = 0x%"PRIx64
> +pvrdma_regs_read(uint64_t addr, uint64_t val) "pvrdma.regs[0x%"PRIx64"]=0x%"PRIx64
> +pvrdma_regs_write(uint64_t addr, uint64_t val, const char *reg_name, const char *val_name) "pvrdma.regs[0x%"PRIx64"]=0x%"PRIx64" (%s %s)"
> +pvrdma_uar_write(uint64_t addr, uint64_t val, const char *reg_name, const char *val_name, int val1, int val2) "uar[0x%"PRIx64"]=0x%"PRIx64" (cls=%s, op=%s, obj=%d, val=%d)"
> +
> +# hw/rdma/vmw/pvrdma_cmd.c
> +pvrdma_map_to_pdir_host_virt(void *vfirst, void *vremaped) "mremap %p -> %p"
> +pvrdma_map_to_pdir_next_page(int page_idx, void *vnext, void *vremaped) "mremap [%d] %p -> %p"
> +pvrdma_exec_cmd(int cmd, int err) "cmd=%d, err=%d"
> +
> +# hw/rdma/vmw/pvrdma_dev_ring.c
> +pvrdma_ring_next_elem_read_no_data(char *ring_name) "pvrdma_ring %s is empty"
> +
> +# hw/rdma/vmw/pvrdma_qp_ops.c
> +pvrdma_post_cqe(uint32_t cq_handle, int notify, uint64_t wr_id, uint64_t qpn, uint32_t op_code, uint32_t status, uint32_t byte_len, uint32_t src_qp, uint32_t wc_flags, uint32_t vendor_err) "cq_handle=%d, notify=%d, wr_id=0x%"PRIx64", qpn=0x%"PRIx64", opcode=%d, status=%d, byte_len=%d, src_qp=%d, wc_flags=%d, vendor_err=%d"
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
