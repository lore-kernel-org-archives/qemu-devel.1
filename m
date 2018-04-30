Received: from eggs.gnu.org ([2001:4830:134:3::10]:48012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5j9-0003Jl-9w
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fD5j7-00027y-3u
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:08:11 -0400
References: <20180305194906.GA3630@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e22d153e-8e90-d514-6f29-fbf1ff817363@redhat.com>
Date: Mon, 30 Apr 2018 12:07:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180305194906.GA3630@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/block/nvme: Add doorbell buffer config
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com
Cc: Huaicheng Li <huaicheng@cs.uchicago.edu>, qemu-devel@nongnu.org, qemu block <qemu-block@nongnu.org>

Ping... Keith, can you review this?

Thanks,

Paolo

On 05/03/2018 20:49, Huaicheng Li wrote:
> This patch adds Doorbell Buffer Config support (NVMe 1.3) to QEMU NVMe,
> based on Mihai Rusu / Lin Ming's Google vendor extension patch [1]. The
> basic idea of this optimization is to use a shared buffer between guest
> OS and QEMU to reduce # of MMIO operations (doorbell writes). This patc=
h
> ports the original code to work under current QEMU and make it also
> work with SPDK.
>=20
> Unlike Linux kernel NVMe driver which builds the shadow buffer first an=
d
> then creates SQ/CQ, SPDK first creates SQ/CQ and then issues this comma=
nd
> to create shadow buffer. Thus, in this implementation, we also try to
> associate shadow buffer entry with each SQ/CQ during queue initializati=
on.
>=20
> [1] http://lists.nongnu.org/archive/html/qemu-devel/2015-11/msg04127.ht=
ml
>=20
> Peroformance results using a **ramdisk** backed virtual NVMe device in
> guest
> Linux 4.14 is as below:
>=20
> Note: "QEMU" represent stock QEMU and "+dbbuf" is QEMU with this patch.
> For psync, QD represents # of threads being used.
>=20
>=20
> IOPS (Linux kernel NVMe driver)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psync=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libaio
> QD QEMU=C2=A0 +dbbuf=C2=A0 QEMU +dbbuf
> 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 47k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 50k=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 45k=C2=A0=C2=A0=C2=A0 47k
> 4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 86k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 107k=C2=
=A0=C2=A0=C2=A0=C2=A0 59k=C2=A0=C2=A0 143k
> 16=C2=A0=C2=A0=C2=A0 95k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 198k=C2=A0=C2=A0=
=C2=A0=C2=A0 58k=C2=A0=C2=A0 185k
> 64=C2=A0=C2=A0=C2=A0 97k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 259k=C2=A0=C2=A0=
=C2=A0=C2=A0 59k=C2=A0=C2=A0 216k
>=20
>=20
> IOPS (SPDK)
> QD=C2=A0 QEMU=C2=A0 +dbbuf
> 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 62k=C2=A0=C2=A0=C2=A0=C2=A0 71k
> 4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 61k=C2=A0=C2=A0=C2=A0=C2=A0 191k
> 16=C2=A0=C2=A0=C2=A0 60k=C2=A0=C2=A0=C2=A0=C2=A0 319k
> 64=C2=A0=C2=A0=C2=A0 62k=C2=A0=C2=A0=C2=A0=C2=A0 364k
>=20
> We can see that this patch can greatly increase the IOPS (and lower the
> latency, not shown) (2.7x for psync, 3.7x for libaio and 5.9x for SPDK)=
.
>=20
> =3D=3DSetup=3D=3D:
>=20
> (1) VM script:
> x86_64-softmmu/qemu-system-x86_64 \
> -name "nvme-FEMU-test" \
> -enable-kvm \
> -cpu host \
> -smp 4 \
> -m 8G \
> -drive
> file=3D$IMGDIR/u14s.qcow2,if=3Dide,aio=3Dnative,cache=3Dnone,format=3Dq=
cow2,id=3Dhd0 \
> -drive file=3D/mnt/tmpfs/test1.raw,if=3Dnone,aio=3Dthreads,format=3Draw=
,id=3Did0 \
> -device nvme,drive=3Did0,serial=3Dserial0,id=3Dnvme0 \
> -net user,hostfwd=3Dtcp::8080-:22 \
> -net nic,model=3Dvirtio \
> -nographic \
>=20
> (2) FIO configuration:
>=20
> [global]
> ioengine=3Dlibaio
> filename=3D/dev/nvme0n1
> thread=3D1
> group_reporting=3D1
> direct=3D1
> verify=3D0
> time_based=3D1
> ramp_time=3D0
> runtime=3D30
> ;size=3D1G
> iodepth=3D16
> rw=3Drandread
> bs=3D4k
>=20
> [test]
> numjobs=3D1
>=20
>=20
> Signed-off-by: Huaicheng Li <huaicheng@cs.uchicago.edu>
> ---
> hw/block/nvme.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 97
> +++++++++++++++++++++++++++++++++++++++++++++++++---
> hw/block/nvme.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++
> include/block/nvme.h |=C2=A0 2 ++
> 3 files changed, 102 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 85d2406400..3882037e36 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -9,7 +9,7 @@
> =C2=A0*/
>=20
> /**
> - * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
> + * Reference Specs: http://www.nvmexpress.org, 1.3, 1.2, 1.1, 1.0e
> =C2=A0*
> =C2=A0*=C2=A0 http://www.nvmexpress.org/resources/
> =C2=A0*/
> @@ -33,6 +33,7 @@
> #include "qapi/error.h"
> #include "qapi/visitor.h"
> #include "sysemu/block-backend.h"
> +#include "exec/memory.h"
>=20
> #include "qemu/log.h"
> #include "trace.h"
> @@ -244,6 +245,14 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n,
> uint8_t *ptr, uint32_t len,
> =C2=A0=C2=A0=C2=A0 return status;
> }
>=20
> +static void nvme_update_cq_head(NvmeCQueue *cq)
> +{
> +=C2=A0=C2=A0=C2=A0 if (cq->db_addr) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dma_read(&cq->ctrl->par=
ent_obj, cq->db_addr, &cq->head,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sizeof(cq->head));
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> static void nvme_post_cqes(void *opaque)
> {
> =C2=A0=C2=A0=C2=A0 NvmeCQueue *cq =3D opaque;
> @@ -254,6 +263,8 @@ static void nvme_post_cqes(void *opaque)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NvmeSQueue *sq;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr addr;
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme_update_cq_head(cq);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nvme_cq_full(cq)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -461,6 +472,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *c=
md)
> static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr=
,
> =C2=A0=C2=A0=C2=A0 uint16_t sqid, uint16_t cqid, uint16_t size)
> {
> +=C2=A0=C2=A0=C2=A0 uint32_t stride =3D 4 << NVME_CAP_DSTRD(n->bar.cap)=
;
> =C2=A0=C2=A0=C2=A0 int i;
> =C2=A0=C2=A0=C2=A0 NvmeCQueue *cq;
>=20
> @@ -480,6 +492,11 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl
> *n, uint64_t dma_addr,
> =C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 sq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_=
process_sq, sq);
>=20
> +=C2=A0=C2=A0=C2=A0 if (sqid && n->dbbuf_dbs && n->dbbuf_eis) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sq->db_addr =3D n->dbbuf_db=
s + 2 * sqid * stride;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sq->ei_addr =3D n->dbbuf_ei=
s + 2 * sqid * stride;
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0 assert(n->cq[cqid]);
> =C2=A0=C2=A0=C2=A0 cq =3D n->cq[cqid];
> =C2=A0=C2=A0=C2=A0 QTAILQ_INSERT_TAIL(&(cq->sq_list), sq, entry);
> @@ -559,6 +576,8 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *c=
md)
> static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr=
,
> =C2=A0=C2=A0=C2=A0 uint16_t cqid, uint16_t vector, uint16_t size, uint1=
6_t irq_enabled)
> {
> +=C2=A0=C2=A0=C2=A0 uint32_t stride =3D 4 << NVME_CAP_DSTRD(n->bar.cap)=
;
> +
> =C2=A0=C2=A0=C2=A0 cq->ctrl =3D n;
> =C2=A0=C2=A0=C2=A0 cq->cqid =3D cqid;
> =C2=A0=C2=A0=C2=A0 cq->size =3D size;
> @@ -569,11 +588,51 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl
> *n, uint64_t dma_addr,
> =C2=A0=C2=A0=C2=A0 cq->head =3D cq->tail =3D 0;
> =C2=A0=C2=A0=C2=A0 QTAILQ_INIT(&cq->req_list);
> =C2=A0=C2=A0=C2=A0 QTAILQ_INIT(&cq->sq_list);
> +=C2=A0=C2=A0=C2=A0 if (cqid && n->dbbuf_dbs && n->dbbuf_eis) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cq->db_addr =3D n->dbbuf_db=
s + (2 * cqid + 1) * stride;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cq->ei_addr =3D n->dbbuf_ei=
s + (2 * cqid + 1) * stride;
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 msix_vector_use(&n->parent_obj, cq->vector);
> =C2=A0=C2=A0=C2=A0 n->cq[cqid] =3D cq;
> =C2=A0=C2=A0=C2=A0 cq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_=
post_cqes, cq);
> }
>=20
> +static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeCmd *cmd)
> +{
> +=C2=A0=C2=A0=C2=A0 uint32_t stride =3D 4 << NVME_CAP_DSTRD(n->bar.cap)=
;
> +=C2=A0=C2=A0=C2=A0 uint64_t dbs_addr =3D le64_to_cpu(cmd->prp1);
> +=C2=A0=C2=A0=C2=A0 uint64_t eis_addr =3D le64_to_cpu(cmd->prp2);
> +=C2=A0=C2=A0=C2=A0 int i;
> +
> +=C2=A0=C2=A0=C2=A0 /* Address should not be NULL and should be page al=
igned */
> +=C2=A0=C2=A0=C2=A0 if (dbs_addr =3D=3D 0 || dbs_addr & (n->page_size -=
 1) ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eis=
_addr =3D=3D 0 || eis_addr & (n->page_size - 1)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NVME_INVALID_FIELD |=
 NVME_DNR;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /* Save shadow buffer base addr for use during queu=
e creation */
> +=C2=A0=C2=A0=C2=A0 n->dbbuf_dbs =3D dbs_addr;
> +=C2=A0=C2=A0=C2=A0 n->dbbuf_eis =3D eis_addr;
> +
> +=C2=A0=C2=A0=C2=A0 for (i =3D 1; i < n->num_queues; i++) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NvmeSQueue *sq =3D n->sq[i]=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NvmeCQueue *cq =3D n->cq[i]=
;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sq) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
Submission queue tail pointer location, 2 * QID * stride */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sq-=
>db_addr =3D dbs_addr + 2 * i * stride;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sq-=
>ei_addr =3D eis_addr + 2 * i * stride;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cq) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
Completion queue head pointer location, (2 * QID + 1) *
> stride */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cq-=
>db_addr =3D dbs_addr + (2 * i + 1) * stride;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cq-=
>ei_addr =3D eis_addr + (2 * i + 1) * stride;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 return NVME_SUCCESS;
> +}
> +
> static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
> {
> =C2=A0=C2=A0=C2=A0 NvmeCQueue *cq;
> @@ -753,12 +812,30 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n,
> NvmeCmd *cmd, NvmeRequest *req)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nvme_set_feature(n, c=
md, req);
> =C2=A0=C2=A0=C2=A0 case NVME_ADM_CMD_GET_FEATURES:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nvme_get_feature(n, c=
md, req);
> +=C2=A0=C2=A0=C2=A0 case NVME_ADM_CMD_DBBUF_CONFIG:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nvme_dbbuf_config(n,=
 cmd);
> =C2=A0=C2=A0=C2=A0 default:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nvme_err_invalid_admin=
_opc(cmd->opcode);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NVME_INVALID_OPCODE |=
 NVME_DNR;
> =C2=A0=C2=A0=C2=A0 }
> }
>=20
> +static void nvme_update_sq_eventidx(const NvmeSQueue *sq)
> +{
> +=C2=A0=C2=A0=C2=A0 if (sq->ei_addr) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dma_write(&sq->ctrl->pa=
rent_obj, sq->ei_addr, &sq->tail,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sizeof(sq->tail));
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +static void nvme_update_sq_tail(NvmeSQueue *sq)
> +{
> +=C2=A0=C2=A0=C2=A0 if (sq->db_addr) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_dma_read(&sq->ctrl->par=
ent_obj, sq->db_addr, &sq->tail,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sizeof(sq->tail));
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> static void nvme_process_sq(void *opaque)
> {
> =C2=A0=C2=A0=C2=A0 NvmeSQueue *sq =3D opaque;
> @@ -770,6 +847,8 @@ static void nvme_process_sq(void *opaque)
> =C2=A0=C2=A0=C2=A0 NvmeCmd cmd;
> =C2=A0=C2=A0=C2=A0 NvmeRequest *req;
>=20
> +=C2=A0=C2=A0=C2=A0 nvme_update_sq_tail(sq);
> +
> =C2=A0=C2=A0=C2=A0 while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_=
list))) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D sq->dma_addr + sq->=
head * n->sqe_size;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme_addr_read(n, addr, (voi=
d *)&cmd, sizeof(cmd));
> @@ -787,6 +866,9 @@ static void nvme_process_sq(void *opaque)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req-=
>status =3D status;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme=
_enqueue_req_completion(cq, req);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme_update_sq_eventidx(sq)=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvme_update_sq_tail(sq);
> =C2=A0=C2=A0=C2=A0 }
> }
>=20
> @@ -1105,7 +1187,9 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr
> addr, int val)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_sqs =3D nvme_cq_full(c=
q) ? 1 : 0;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cq->head =3D new_head;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cq->db_addr) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cq-=
>head =3D new_head;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (start_sqs) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Nvme=
SQueue *sq;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QTAI=
LQ_FOREACH(sq, &cq->sq_list, entry) {
> @@ -1142,7 +1226,9 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr
> addr, int val)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sq->tail =3D new_tail;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sq->db_addr) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sq-=
>tail =3D new_tail;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_mod(sq->timer, qemu_cl=
ock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
> =C2=A0=C2=A0=C2=A0 }
> }
> @@ -1256,7 +1342,7 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r
> **errp)
> =C2=A0=C2=A0=C2=A0 id->ieee[0] =3D 0x00;
> =C2=A0=C2=A0=C2=A0 id->ieee[1] =3D 0x02;
> =C2=A0=C2=A0=C2=A0 id->ieee[2] =3D 0xb3;
> -=C2=A0=C2=A0=C2=A0 id->oacs =3D cpu_to_le16(0);
> +=C2=A0=C2=A0=C2=A0 id->oacs =3D cpu_to_le16(NVME_OACS_DBBUF);
> =C2=A0=C2=A0=C2=A0 id->frmw =3D 7 << 1;
> =C2=A0=C2=A0=C2=A0 id->lpa =3D 1 << 0;
> =C2=A0=C2=A0=C2=A0 id->sqes =3D (0x6 << 4) | 0x6;
> @@ -1320,6 +1406,9 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r
> **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_=
to_le64(n->ns_size >>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].d=
s);
> =C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 n->dbbuf_dbs =3D 0;
> +=C2=A0=C2=A0=C2=A0 n->dbbuf_eis =3D 0;
> }
>=20
> static void nvme_exit(PCIDevice *pci_dev)
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 8f3981121d..b532dbe160 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -33,6 +33,8 @@ typedef struct NvmeSQueue {
> =C2=A0=C2=A0=C2=A0 QTAILQ_HEAD(sq_req_list, NvmeRequest) req_list;
> =C2=A0=C2=A0=C2=A0 QTAILQ_HEAD(out_req_list, NvmeRequest) out_req_list;
> =C2=A0=C2=A0=C2=A0 QTAILQ_ENTRY(NvmeSQueue) entry;
> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0 db_addr;
> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0 ei_addr;
> } NvmeSQueue;
>=20
> typedef struct NvmeCQueue {
> @@ -48,6 +50,8 @@ typedef struct NvmeCQueue {
> =C2=A0=C2=A0=C2=A0 QEMUTimer=C2=A0=C2=A0 *timer;
> =C2=A0=C2=A0=C2=A0 QTAILQ_HEAD(sq_list, NvmeSQueue) sq_list;
> =C2=A0=C2=A0=C2=A0 QTAILQ_HEAD(cq_req_list, NvmeRequest) req_list;
> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0 db_addr;
> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0 ei_addr;
> } NvmeCQueue;
>=20
> typedef struct NvmeNamespace {
> @@ -88,6 +92,9 @@ typedef struct NvmeCtrl {
> =C2=A0=C2=A0=C2=A0 NvmeSQueue=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 admin_sq;
> =C2=A0=C2=A0=C2=A0 NvmeCQueue=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 admin_cq;
> =C2=A0=C2=A0=C2=A0 NvmeIdCtrl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id_ctrl;
> +
> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
dbbuf_dbs;
> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
dbbuf_eis;
> } NvmeCtrl;
>=20
> #endif /* HW_NVME_H */
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 849a6f3fa3..4890aaf491 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -235,6 +235,7 @@ enum NvmeAdminCommands {
> =C2=A0=C2=A0=C2=A0 NVME_ADM_CMD_ASYNC_EV_REQ=C2=A0=C2=A0 =3D 0x0c,
> =C2=A0=C2=A0=C2=A0 NVME_ADM_CMD_ACTIVATE_FW=C2=A0=C2=A0=C2=A0 =3D 0x10,
> =C2=A0=C2=A0=C2=A0 NVME_ADM_CMD_DOWNLOAD_FW=C2=A0=C2=A0=C2=A0 =3D 0x11,
> +=C2=A0=C2=A0=C2=A0 NVME_ADM_CMD_DBBUF_CONFIG=C2=A0=C2=A0 =3D 0x7c,
> =C2=A0=C2=A0=C2=A0 NVME_ADM_CMD_FORMAT_NVM=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
0x80,
> =C2=A0=C2=A0=C2=A0 NVME_ADM_CMD_SECURITY_SEND=C2=A0 =3D 0x81,
> =C2=A0=C2=A0=C2=A0 NVME_ADM_CMD_SECURITY_RECV=C2=A0 =3D 0x82,
> @@ -572,6 +573,7 @@ enum NvmeIdCtrlOacs {
> =C2=A0=C2=A0=C2=A0 NVME_OACS_SECURITY=C2=A0 =3D 1 << 0,
> =C2=A0=C2=A0=C2=A0 NVME_OACS_FORMAT=C2=A0=C2=A0=C2=A0 =3D 1 << 1,
> =C2=A0=C2=A0=C2=A0 NVME_OACS_FW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D 1 << 2,
> +=C2=A0=C2=A0=C2=A0 NVME_OACS_DBBUF=C2=A0=C2=A0=C2=A0=C2=A0 =3D 1 << 8,
> };
>=20
> enum NvmeIdCtrlOncs {
