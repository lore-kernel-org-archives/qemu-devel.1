Received: from eggs.gnu.org ([2001:4830:134:3::10]:46037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dPoDy-0004Ig-Ht
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dPoDt-00011P-OP
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:00:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dPoDt-000117-At
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:59:57 -0400
Date: Tue, 27 Jun 2017 11:59:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170627105948.GD2123@work-vm>
References: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
	<1491301977-24481-10-git-send-email-yulei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491301977-24481-10-git-send-email-yulei.zhang@intel.com>
Subject: Re: [Qemu-devel] [Intel-gfx][RFC 9/9] drm/i915/gvt: Add support to
 VFIO region VFIO_PCI_DEVICE_STATE_REGION_INDEX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yulei Zhang <yulei.zhang@intel.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, xiao.zheng@intel.com, zhi.a.wang@intel.com

* Yulei Zhang (yulei.zhang@intel.com) wrote:
> Add new VFIO region VFIO_PCI_DEVICE_STATE_REGION_INDEX support in vGPU, through
> this new region it can fetch the status from mdev device for migration, on
> the target side it can retrieve the device status and reconfigure the device to
> continue running after resume the guest.
> 
> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>

This is a HUGE patch.
I can't really tell how it wires into the rest of migration.
It would probably be best to split it up into cunks
to make it easier to review.

Dave

> ---
>  drivers/gpu/drm/i915/gvt/Makefile  |   2 +-
>  drivers/gpu/drm/i915/gvt/gvt.c     |   1 +
>  drivers/gpu/drm/i915/gvt/gvt.h     |   5 +
>  drivers/gpu/drm/i915/gvt/kvmgt.c   |  19 +
>  drivers/gpu/drm/i915/gvt/migrate.c | 715 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/i915/gvt/migrate.h |  82 +++++
>  drivers/gpu/drm/i915/gvt/mmio.c    |  14 +
>  drivers/gpu/drm/i915/gvt/mmio.h    |   1 +
>  include/uapi/linux/vfio.h          |   3 +-
>  9 files changed, 840 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/i915/gvt/migrate.c
>  create mode 100644 drivers/gpu/drm/i915/gvt/migrate.h
> 
> diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
> index f5486cb9..a7e2e34 100644
> --- a/drivers/gpu/drm/i915/gvt/Makefile
> +++ b/drivers/gpu/drm/i915/gvt/Makefile
> @@ -1,7 +1,7 @@
>  GVT_DIR := gvt
>  GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
>  	interrupt.o gtt.o cfg_space.o opregion.o mmio.o display.o edid.o \
> -	execlist.o scheduler.o sched_policy.o render.o cmd_parser.o
> +	execlist.o scheduler.o sched_policy.o render.o cmd_parser.o migrate.o
>  
>  ccflags-y				+= -I$(src) -I$(src)/$(GVT_DIR)
>  i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
> diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
> index c27c683..e40af70 100644
> --- a/drivers/gpu/drm/i915/gvt/gvt.c
> +++ b/drivers/gpu/drm/i915/gvt/gvt.c
> @@ -54,6 +54,7 @@ static const struct intel_gvt_ops intel_gvt_ops = {
>  	.vgpu_reset = intel_gvt_reset_vgpu,
>  	.vgpu_activate = intel_gvt_activate_vgpu,
>  	.vgpu_deactivate = intel_gvt_deactivate_vgpu,
> +	.vgpu_save_restore = intel_gvt_save_restore,
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
> index 23eeb7c..12aa3b8 100644
> --- a/drivers/gpu/drm/i915/gvt/gvt.h
> +++ b/drivers/gpu/drm/i915/gvt/gvt.h
> @@ -46,6 +46,7 @@
>  #include "sched_policy.h"
>  #include "render.h"
>  #include "cmd_parser.h"
> +#include "migrate.h"
>  
>  #define GVT_MAX_VGPU 8
>  
> @@ -431,6 +432,8 @@ void intel_gvt_reset_vgpu_locked(struct intel_vgpu *vgpu, bool dmlr,
>  void intel_gvt_reset_vgpu(struct intel_vgpu *vgpu);
>  void intel_gvt_activate_vgpu(struct intel_vgpu *vgpu);
>  void intel_gvt_deactivate_vgpu(struct intel_vgpu *vgpu);
> +int intel_gvt_save_restore(struct intel_vgpu *vgpu, char *buf,
> +			    size_t count, uint64_t off, bool restore);
>  
>  /* validating GM functions */
>  #define vgpu_gmadr_is_aperture(vgpu, gmadr) \
> @@ -513,6 +516,8 @@ struct intel_gvt_ops {
>  	void (*vgpu_reset)(struct intel_vgpu *);
>  	void (*vgpu_activate)(struct intel_vgpu *);
>  	void (*vgpu_deactivate)(struct intel_vgpu *);
> +	int  (*vgpu_save_restore)(struct intel_vgpu *, char *buf,
> +				  size_t count, uint64_t off, bool restore);
>  };
>  
>  
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
> index e9f11a9..d4ede29 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -670,6 +670,9 @@ static ssize_t intel_vgpu_rw(struct mdev_device *mdev, char *buf,
>  						bar0_start + pos, buf, count);
>  		}
>  		break;
> +	case VFIO_PCI_DEVICE_STATE_REGION_INDEX:
> +		ret = intel_gvt_ops->vgpu_save_restore(vgpu, buf, count, pos, is_write);
> +		break;
>  	case VFIO_PCI_BAR2_REGION_INDEX:
>  	case VFIO_PCI_BAR3_REGION_INDEX:
>  	case VFIO_PCI_BAR4_REGION_INDEX:
> @@ -688,6 +691,10 @@ static ssize_t intel_vgpu_read(struct mdev_device *mdev, char __user *buf,
>  {
>  	unsigned int done = 0;
>  	int ret;
> +	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> +
> +	if (index == VFIO_PCI_DEVICE_STATE_REGION_INDEX)
> +		return intel_vgpu_rw(mdev, (char *)buf, count, ppos, false);
>  
>  	while (count) {
>  		size_t filled;
> @@ -748,6 +755,10 @@ static ssize_t intel_vgpu_write(struct mdev_device *mdev,
>  {
>  	unsigned int done = 0;
>  	int ret;
> +	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> +
> +	if (index == VFIO_PCI_DEVICE_STATE_REGION_INDEX)
> +		return intel_vgpu_rw(mdev, (char *)buf, count, ppos, true);
>  
>  	while (count) {
>  		size_t filled;
> @@ -1037,6 +1048,14 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
>  		case VFIO_PCI_VGA_REGION_INDEX:
>  			gvt_dbg_core("get region info index:%d\n", info.index);
>  			break;
> +		case VFIO_PCI_DEVICE_STATE_REGION_INDEX:
> +			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
> +			info.size = MIGRATION_IMG_MAX_SIZE;
> +
> +			info.flags =	VFIO_REGION_INFO_FLAG_READ |
> +					VFIO_REGION_INFO_FLAG_WRITE;
> +			break;
> +
>  		default:
>  			{
>  				struct vfio_region_info_cap_type cap_type;
> diff --git a/drivers/gpu/drm/i915/gvt/migrate.c b/drivers/gpu/drm/i915/gvt/migrate.c
> new file mode 100644
> index 0000000..72743df
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/gvt/migrate.c
> @@ -0,0 +1,715 @@
> +/*
> + * Copyright(c) 2011-2016 Intel Corporation. All rights reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice (including the next
> + * paragraph) shall be included in all copies or substantial portions of the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + * Authors:
> + *
> + * Contributors:
> + *
> + */
> +
> +#include "i915_drv.h"
> +#include "gvt.h"
> +#include "i915_pvinfo.h"
> +
> +#define INV (-1)
> +#define RULES_NUM(x) (sizeof(x)/sizeof(gvt_migration_obj_t))
> +#define FOR_EACH_OBJ(obj, rules) \
> +	for (obj = rules; obj->region.type != GVT_MIGRATION_NONE; obj++)
> +#define MIG_VREG_RESTORE(vgpu, off)					\
> +	{								\
> +		u32 data = vgpu_vreg(vgpu, (off));			\
> +		u64 pa = intel_vgpu_mmio_offset_to_gpa(vgpu, off);	\
> +		intel_vgpu_emulate_mmio_write(vgpu, pa, &data, 4);	\
> +	}
> +
> +/* s - struct
> + * t - type of obj
> + * m - size of obj
> + * ops - operation override callback func
> + */
> +#define MIGRATION_UNIT(_s, _t, _m, _ops) {		\
> +.img		= NULL,					\
> +.region.type	= _t,					\
> +.region.size	= _m,				\
> +.ops		= &(_ops),				\
> +.name		= "["#_s":"#_t"]\0"			\
> +}
> +
> +#define MIGRATION_END {		\
> +	NULL, NULL, 0,		\
> +	{GVT_MIGRATION_NONE, 0},\
> +	NULL,	\
> +	NULL	\
> +}
> +
> +static int image_header_load(const gvt_migration_obj_t *obj, u32 size);
> +static int image_header_save(const gvt_migration_obj_t *obj);
> +static int vreg_load(const gvt_migration_obj_t *obj, u32 size);
> +static int vreg_save(const gvt_migration_obj_t *obj);
> +static int sreg_load(const gvt_migration_obj_t *obj, u32 size);
> +static int sreg_save(const gvt_migration_obj_t *obj);
> +static int vcfg_space_load(const gvt_migration_obj_t *obj, u32 size);
> +static int vcfg_space_save(const gvt_migration_obj_t *obj);
> +static int vggtt_load(const gvt_migration_obj_t *obj, u32 size);
> +static int vggtt_save(const gvt_migration_obj_t *obj);
> +static int workload_load(const gvt_migration_obj_t *obj, u32 size);
> +static int workload_save(const gvt_migration_obj_t *obj);
> +/***********************************************
> + * Internal Static Functions
> + ***********************************************/
> +struct gvt_migration_operation_t vReg_ops = {
> +	.pre_copy = NULL,
> +	.pre_save = vreg_save,
> +	.pre_load = vreg_load,
> +	.post_load = NULL,
> +};
> +
> +struct gvt_migration_operation_t sReg_ops = {
> +	.pre_copy = NULL,
> +	.pre_save = sreg_save,
> +	.pre_load = sreg_load,
> +	.post_load = NULL,
> +};
> +
> +struct gvt_migration_operation_t vcfg_space_ops = {
> +	.pre_copy = NULL,
> +	.pre_save = vcfg_space_save,
> +	.pre_load = vcfg_space_load,
> +	.post_load = NULL,
> +};
> +
> +struct gvt_migration_operation_t vgtt_info_ops = {
> +	.pre_copy = NULL,
> +	.pre_save = vggtt_save,
> +	.pre_load = vggtt_load,
> +	.post_load = NULL,
> +};
> +
> +struct gvt_migration_operation_t image_header_ops = {
> +	.pre_copy = NULL,
> +	.pre_save = image_header_save,
> +	.pre_load = image_header_load,
> +	.post_load = NULL,
> +};
> +
> +struct gvt_migration_operation_t workload_ops = {
> +	.pre_copy = NULL,
> +	.pre_save = workload_save,
> +	.pre_load = workload_load,
> +	.post_load = NULL,
> +};
> +
> +/* gvt_device_objs[] are list of gvt_migration_obj_t objs
> + * Each obj has its operation method to save to qemu image
> + * and restore from qemu image during the migration.
> + *
> + * for each saved bject, it will have a region header
> + * struct gvt_region_t {
> + *   region_type;
> + *   region_size;
> + * }
> + *__________________  _________________   __________________
> + *|x64 (Source)    |  |image region    |  |x64 (Target)    |
> + *|________________|  |________________|  |________________|
> + *|    Region A    |  |   Region A     |  |   Region A     |
> + *|    Header      |  |   offset=0     |  | allocate a page|
> + *|    content     |  |                |  | copy data here |
> + *|----------------|  |     ...        |  |----------------|
> + *|    Region B    |  |     ...        |  |   Region B     |
> + *|    Header      |  |----------------|  |                |
> + *|    content        |   Region B     |  |                |
> + *|----------------|  |   offset=4096  |  |----------------|
> + *                    |                |
> + *                    |----------------|
> + *
> + * On the target side, it will parser the incomming data copy
> + * from Qemu image, and apply difference restore handlers depends
> + * on the region type.
> + */
> +static struct gvt_migration_obj_t gvt_device_objs[] = {
> +	MIGRATION_UNIT(struct intel_vgpu,
> +			GVT_MIGRATION_HEAD,
> +			sizeof(gvt_image_header_t),
> +			image_header_ops),
> +	MIGRATION_UNIT(struct intel_vgpu,
> +			GVT_MIGRATION_CFG_SPACE,
> +			INTEL_GVT_MAX_CFG_SPACE_SZ,
> +			vcfg_space_ops),
> +	MIGRATION_UNIT(struct intel_vgpu,
> +			GVT_MIGRATION_SREG,
> +			GVT_MMIO_SIZE, sReg_ops),
> +	MIGRATION_UNIT(struct intel_vgpu,
> +			GVT_MIGRATION_VREG,
> +			GVT_MMIO_SIZE, vReg_ops),
> +	MIGRATION_UNIT(struct intel_vgpu,
> +			GVT_MIGRATION_GTT,
> +			0, vgtt_info_ops),
> +	MIGRATION_UNIT(struct intel_vgpu,
> +			GVT_MIGRATION_WORKLOAD,
> +			0, workload_ops),
> +	MIGRATION_END,
> +};
> +
> +static inline void
> +update_image_region_start_pos(gvt_migration_obj_t *obj, int pos)
> +{
> +	obj->offset = pos;
> +}
> +
> +static inline void
> +update_image_region_base(gvt_migration_obj_t *obj, void *base)
> +{
> +	obj->img = base;
> +}
> +
> +static inline void
> +update_status_region_base(gvt_migration_obj_t *obj, void *base)
> +{
> +	obj->vgpu = base;
> +}
> +
> +static inline gvt_migration_obj_t *
> +find_migration_obj(enum gvt_migration_type_t type)
> +{
> +	gvt_migration_obj_t *obj;
> +	for ( obj = gvt_device_objs; obj->region.type != GVT_MIGRATION_NONE; obj++)
> +		if (obj->region.type == type)
> +			return obj;
> +	return NULL;
> +}
> +
> +static int image_header_save(const gvt_migration_obj_t *obj)
> +{
> +	gvt_region_t region;
> +	gvt_image_header_t header;
> +
> +	region.type = GVT_MIGRATION_HEAD;
> +	region.size = sizeof(gvt_image_header_t);
> +	memcpy(obj->img, &region, sizeof(gvt_region_t));
> +
> +	header.version = GVT_MIGRATION_VERSION;
> +	header.data_size = obj->offset;
> +	header.crc_check = 0; /* CRC check skipped for now*/
> +
> +	memcpy(obj->img + sizeof(gvt_region_t), &header, sizeof(gvt_image_header_t));
> +
> +	return sizeof(gvt_region_t) + sizeof(gvt_image_header_t);
> +}
> +
> +static int image_header_load(const gvt_migration_obj_t *obj, u32 size)
> +{
> +	gvt_image_header_t header;
> +
> +	if (unlikely(size != sizeof(gvt_image_header_t))) {
> +		gvt_err("migration object size is not match between target \
> +				and image!!! memsize=%d imgsize=%d\n",
> +		obj->region.size,
> +		size);
> +		return INV;
> +	}
> +
> +	memcpy(&header, obj->img + obj->offset, sizeof(gvt_image_header_t));
> +
> +	return header.data_size;
> +}
> +
> +static int vcfg_space_save(const gvt_migration_obj_t *obj)
> +{
> +	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
> +	int n_transfer = INV;
> +	void *src = vgpu->cfg_space.virtual_cfg_space;
> +	void *des = obj->img + obj->offset;
> +
> +	memcpy(des, &obj->region, sizeof(gvt_region_t));
> +
> +	des += sizeof(gvt_region_t);
> +	n_transfer = obj->region.size;
> +
> +	memcpy(des, src, n_transfer);
> +	return sizeof(gvt_region_t) + n_transfer;
> +}
> +
> +static int vcfg_space_load(const gvt_migration_obj_t *obj, u32 size)
> +{
> +	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
> +	void *dest = vgpu->cfg_space.virtual_cfg_space;
> +	int n_transfer = INV;
> +
> +	if (unlikely(size != obj->region.size)) {
> +		gvt_err("migration object size is not match between target \
> +				and image!!! memsize=%d imgsize=%d\n",
> +		obj->region.size,
> +		size);
> +		return n_transfer;
> +	} else {
> +		n_transfer = obj->region.size;
> +		memcpy(dest, obj->img + obj->offset, n_transfer);
> +	}
> +
> +	return n_transfer;
> +}
> +
> +static int sreg_save(const gvt_migration_obj_t *obj)
> +{
> +	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
> +	int n_transfer = INV;
> +	void *src = vgpu->mmio.sreg;
> +	void *des = obj->img + obj->offset;
> +
> +	memcpy(des, &obj->region, sizeof(gvt_region_t));
> +
> +	des += sizeof(gvt_region_t);
> +	n_transfer = obj->region.size;
> +
> +	memcpy(des, src, n_transfer);
> +	return sizeof(gvt_region_t) + n_transfer;
> +}
> +
> +static int sreg_load(const gvt_migration_obj_t *obj, u32 size)
> +{
> +	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
> +	void *dest = vgpu->mmio.sreg;
> +	int n_transfer = INV;
> +
> +	if (unlikely(size != obj->region.size)) {
> +		gvt_err("migration object size is not match between target \
> +				and image!!! memsize=%d imgsize=%d\n",
> +		obj->region.size,
> +		size);
> +		return n_transfer;
> +	} else {
> +		n_transfer = obj->region.size;
> +		memcpy(dest, obj->img + obj->offset, n_transfer);
> +	}
> +
> +	return n_transfer;
> +}
> +
> +static int vreg_save(const gvt_migration_obj_t *obj)
> +{
> +	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
> +	int n_transfer = INV;
> +	void *src = vgpu->mmio.vreg;
> +	void *des = obj->img + obj->offset;
> +
> +	memcpy(des, &obj->region, sizeof(gvt_region_t));
> +
> +	des += sizeof(gvt_region_t);
> +	n_transfer = obj->region.size;
> +
> +	memcpy(des, src, n_transfer);
> +	return sizeof(gvt_region_t) + n_transfer;
> +}
> +
> +static int vreg_load(const gvt_migration_obj_t *obj, u32 size)
> +{
> +	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
> +	void *dest = vgpu->mmio.vreg;
> +	int n_transfer = INV;
> +
> +	if (unlikely(size != obj->region.size)) {
> +		gvt_err("migration object size is not match between target \
> +				and image!!! memsize=%d imgsize=%d\n",
> +		obj->region.size,
> +		size);
> +		return n_transfer;
> +	} else {
> +		n_transfer = obj->region.size;
> +		memcpy(dest, obj->img + obj->offset, n_transfer);
> +	}
> +	return n_transfer;
> +}
> +
> +static int workload_save(const gvt_migration_obj_t *obj)
> +{
> +	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
> +	struct drm_i915_private *dev_priv = vgpu->gvt->dev_priv;
> +	int n_transfer = INV;
> +	struct gvt_region_t region;
> +	struct intel_engine_cs *engine;
> +	struct intel_vgpu_workload *pos, *n;
> +	unsigned int i;
> +	struct gvt_pending_workload_t workload;
> +	void *des = obj->img + obj->offset;
> +	unsigned int num = 0;
> +	u32 sz = sizeof(gvt_pending_workload_t);
> +
> +	for_each_engine(engine, dev_priv, i) {
> +		list_for_each_entry_safe(pos, n,
> +			&vgpu->workload_q_head[engine->id], list) {
> +			workload.ring_id = pos->ring_id;
> +			memcpy(&workload.elsp_dwords, &pos->elsp_dwords,
> +				sizeof(struct intel_vgpu_elsp_dwords));
> +			memcpy(des + sizeof(gvt_region_t) + (num * sz), &workload, sz);
> +			num++;
> +		}
> +	}
> +
> +	region.type = GVT_MIGRATION_WORKLOAD;
> +	region.size = num * sz;
> +	memcpy(des, &obj->region, sizeof(gvt_region_t));
> +
> +	n_transfer = obj->region.size;
> +
> +	return sizeof(gvt_region_t) + n_transfer;
> +}
> +
> +static int workload_load(const gvt_migration_obj_t *obj, u32 size)
> +{
> +	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
> +	struct drm_i915_private *dev_priv = vgpu->gvt->dev_priv;
> +	int n_transfer = INV;
> +	struct gvt_pending_workload_t workload;
> +	struct intel_engine_cs *engine;
> +	void *src = obj->img + obj->offset;
> +	u64 pa, off;
> +	u32 sz = sizeof(gvt_pending_workload_t);
> +	int i, j;
> +
> +	if (size == 0)
> +		return size;
> +
> +	if (unlikely(size % sz) != 0) {
> +		gvt_err("migration object size is not match between target \
> +				and image!!! memsize=%d imgsize=%d\n",
> +		obj->region.size,
> +		size);
> +		return n_transfer;
> +	}
> +
> +	for (i = 0; i < size / sz; i++) {
> +		memcpy(&workload, src + (i * sz), sz);
> +		engine = dev_priv->engine[workload.ring_id];
> +		off = i915_mmio_reg_offset(RING_ELSP(engine));
> +		pa = intel_vgpu_mmio_offset_to_gpa(vgpu, off);
> +		for (j = 0; j < 4; j++) {
> +			intel_vgpu_emulate_mmio_write(vgpu, pa,
> +					&workload.elsp_dwords.data[j], 4);
> +		}
> +	}
> +
> +	n_transfer = size;
> +
> +	return n_transfer;
> +}
> +
> +static int
> +mig_ggtt_save_restore(struct intel_vgpu_mm *ggtt_mm,
> +		void *data, u64 gm_offset,
> +		u64 gm_sz,
> +		bool save_to_image)
> +{
> +	struct intel_vgpu *vgpu = ggtt_mm->vgpu;
> +	struct intel_gvt_gtt_gma_ops *gma_ops = vgpu->gvt->gtt.gma_ops;
> +
> +	void *ptable;
> +	int sz;
> +	int shift = vgpu->gvt->device_info.gtt_entry_size_shift;
> +
> +	ptable = ggtt_mm->virtual_page_table +
> +	    (gma_ops->gma_to_ggtt_pte_index(gm_offset) << shift);
> +	sz = (gm_sz >> GTT_PAGE_SHIFT) << shift;
> +
> +	if (save_to_image)
> +		memcpy(data, ptable, sz);
> +	else
> +		memcpy(ptable, data, sz);
> +
> +	return sz;
> +}
> +
> +static int vggtt_save(const gvt_migration_obj_t *obj)
> +{
> +	int ret = INV;
> +	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
> +	struct intel_vgpu_mm *ggtt_mm = vgpu->gtt.ggtt_mm;
> +	void *des = obj->img + obj->offset;
> +	struct gvt_region_t region;
> +	int sz;
> +
> +	u64 aperture_offset = vgpu_guest_aperture_offset(vgpu);
> +	u64 aperture_sz = vgpu_aperture_sz(vgpu);
> +	u64 hidden_gm_offset = vgpu_guest_hidden_offset(vgpu);
> +	u64 hidden_gm_sz = vgpu_hidden_sz(vgpu);
> +
> +	des += sizeof(gvt_region_t);
> +
> +	/*TODO:512MB GTT takes total 1024KB page table size, optimization here*/
> +
> +	gvt_dbg_core("Guest aperture=0x%llx (HW: 0x%llx) Guest Hidden=0x%llx (HW:0x%llx)\n",
> +		aperture_offset, vgpu_aperture_offset(vgpu),
> +		hidden_gm_offset, vgpu_hidden_offset(vgpu));
> +
> +	/*TODO:to be fixed after removal of address ballooning */
> +	ret = 0;
> +
> +	/* aperture */
> +	sz = mig_ggtt_save_restore(ggtt_mm, des,
> +		aperture_offset, aperture_sz, true);
> +	des += sz;
> +	ret += sz;
> +
> +	/* hidden gm */
> +	sz = mig_ggtt_save_restore(ggtt_mm, des,
> +		hidden_gm_offset, hidden_gm_sz, true);
> +	des += sz;
> +	ret += sz;
> +
> +	/* Save the total size of this session */
> +	region.type = GVT_MIGRATION_GTT;
> +	region.size = ret;
> +	memcpy(obj->img + obj->offset, &region, sizeof(gvt_region_t));
> +
> +	ret += sizeof(gvt_region_t);
> +
> +	return ret;
> +}
> +
> +static int vggtt_load(const gvt_migration_obj_t *obj, u32 size)
> +{
> +	int ret;
> +	int ggtt_index;
> +	void *src;
> +	int sz;
> +
> +	struct intel_vgpu *vgpu = (struct intel_vgpu *) obj->vgpu;
> +	struct intel_vgpu_mm *ggtt_mm = vgpu->gtt.ggtt_mm;
> +
> +	int shift = vgpu->gvt->device_info.gtt_entry_size_shift;
> +
> +	/* offset to bar1 beginning */
> +	u64 dest_aperture_offset = vgpu_guest_aperture_offset(vgpu);
> +	u64 aperture_sz = vgpu_aperture_sz(vgpu);
> +	u64 dest_hidden_gm_offset = vgpu_guest_hidden_offset(vgpu);
> +	u64 hidden_gm_sz = vgpu_hidden_sz(vgpu);
> +
> +	gvt_dbg_core("Guest aperture=0x%llx (HW: 0x%llx) Guest Hidden=0x%llx (HW:0x%llx)\n",
> +		dest_aperture_offset, vgpu_aperture_offset(vgpu),
> +		dest_hidden_gm_offset, vgpu_hidden_offset(vgpu));
> +
> +	if ((size>>shift) !=
> +			((aperture_sz + hidden_gm_sz) >> GTT_PAGE_SHIFT)) {
> +		gvt_err("ggtt restore failed due to page table size not match\n");
> +		return INV;
> +	}
> +
> +	ret = 0;
> +	src = obj->img + obj->offset;
> +
> +	/* aperture */
> +	sz = mig_ggtt_save_restore(ggtt_mm,\
> +		src, dest_aperture_offset, aperture_sz, false);
> +	src += sz;
> +	ret += sz;
> +
> +	/* hidden GM */
> +	sz = mig_ggtt_save_restore(ggtt_mm, src,
> +			dest_hidden_gm_offset, hidden_gm_sz, false);
> +	ret += sz;
> +
> +	/* aperture/hidden GTT emulation from Source to Target */
> +	for (ggtt_index = 0; ggtt_index < ggtt_mm->page_table_entry_cnt;
> +			ggtt_index++) {
> +
> +		if (vgpu_gmadr_is_valid(vgpu, ggtt_index<<GTT_PAGE_SHIFT)) {
> +			struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
> +			struct intel_gvt_gtt_entry e;
> +			u64 offset;
> +			u64 pa;
> +
> +			/* TODO: hardcode to 64bit right now */
> +			offset = vgpu->gvt->device_info.gtt_start_offset
> +				+ (ggtt_index<<shift);
> +
> +			pa = intel_vgpu_mmio_offset_to_gpa(vgpu, offset);
> +
> +			/* read out virtual GTT entity and
> +			 * trigger emulate write
> +			 */
> +			ggtt_get_guest_entry(ggtt_mm, &e, ggtt_index);
> +			if (ops->test_present(&e)) {
> +			/* same as gtt_emulate
> +			 * _write(vgt, offset, &e.val64, 1<<shift);
> +			 * Using vgt_emulate_write as to align with vReg load
> +			 */
> +				intel_vgpu_emulate_mmio_write(vgpu, pa, &e.val64, 1<<shift);
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int vgpu_save(const void *img)
> +{
> +	gvt_migration_obj_t *node;
> +	int n_img_actual_saved = 0;
> +
> +	/* go by obj rules one by one */
> +	FOR_EACH_OBJ(node, gvt_device_objs) {
> +		int n_img = INV;
> +
> +		/* obj will copy data to image file img.offset */
> +		update_image_region_start_pos(node, n_img_actual_saved);
> +		if (node->ops->pre_save == NULL) {
> +			n_img = 0;
> +		} else {
> +			n_img = node->ops->pre_save(node);
> +			if (n_img == INV) {
> +				gvt_err("Save obj %s failed\n",
> +						node->name);
> +				n_img_actual_saved = INV;
> +				break;
> +			}
> +		}
> +		/* show GREEN on screen with colorred term */
> +		gvt_dbg_core("Save obj %s success with %d bytes\n",
> +			       node->name, n_img);
> +		n_img_actual_saved += n_img;
> +
> +		if (n_img_actual_saved >= MIGRATION_IMG_MAX_SIZE) {
> +			gvt_err("Image size overflow!!! data=%d MAX=%ld\n",
> +				n_img_actual_saved,
> +				MIGRATION_IMG_MAX_SIZE);
> +			/* Mark as invalid */
> +			n_img_actual_saved = INV;
> +			break;
> +		}
> +	}
> +	/* update the header with real image size */
> +	node = find_migration_obj(GVT_MIGRATION_HEAD);
> +	update_image_region_start_pos(node, n_img_actual_saved);
> +	node->ops->pre_save(node);
> +	return n_img_actual_saved;
> +}
> +
> +static int vgpu_restore(void *img)
> +{
> +	gvt_migration_obj_t *node;
> +	gvt_region_t region;
> +	int n_img_actual_recv = 0;
> +	u32 n_img_actual_size;
> +
> +	/* load image header at first to get real size */
> +	memcpy(&region, img, sizeof(gvt_region_t));
> +	if (region.type != GVT_MIGRATION_HEAD) {
> +		gvt_err("Invalid image. Doesn't start with image_head\n");
> +		return INV;
> +	}
> +
> +	n_img_actual_recv += sizeof(gvt_region_t);
> +	node = find_migration_obj(region.type);
> +	update_image_region_start_pos(node, n_img_actual_recv);
> +	n_img_actual_size = node->ops->pre_load(node, region.size);
> +	if (n_img_actual_size == INV) {
> +		gvt_err("Load img %s failed\n", node->name);
> +		return INV;
> +	}
> +
> +	if (n_img_actual_size >= MIGRATION_IMG_MAX_SIZE) {
> +		gvt_err("Invalid image. magic_id offset = 0x%x\n",
> +				n_img_actual_size);
> +		return INV;
> +	}
> +
> +	n_img_actual_recv += sizeof(gvt_image_header_t);
> +
> +	do {
> +		int n_img = INV;
> +		/* parse each region head to get type and size */
> +		memcpy(&region, img + n_img_actual_recv, sizeof(gvt_region_t));
> +		node = find_migration_obj(region.type);
> +		if (node == NULL)
> +			break;
> +		n_img_actual_recv += sizeof(gvt_region_t);
> +		update_image_region_start_pos(node, n_img_actual_recv);
> +
> +		if (node->ops->pre_load == NULL) {
> +			n_img = 0;
> +		} else {
> +			n_img = node->ops->pre_load(node, region.size);
> +			if (n_img == INV) {
> +				/* Error occurred. colored as RED */
> +				gvt_err("Load obj %s failed\n",
> +						node->name);
> +				n_img_actual_recv = INV;
> +				break;
> +			}
> +		}
> +		/* show GREEN on screen with colorred term */
> +		gvt_dbg_core("Load obj %s success with %d bytes.\n",
> +			       node->name, n_img);
> +		n_img_actual_recv += n_img;
> +	} while (n_img_actual_recv < MIGRATION_IMG_MAX_SIZE);
> +
> +	return n_img_actual_recv;
> +}
> +
> +int intel_gvt_save_restore(struct intel_vgpu *vgpu, char *buf,
> +		            size_t count, uint64_t off, bool restore)
> +{
> +	void *img_base;
> +	gvt_migration_obj_t *node;
> +	int ret = 0;
> +
> +	if (off != 0) {
> +		gvt_vgpu_err("Migration should start from the \
> +			     begining of the image\n");
> +		return -EFAULT;
> +	}
> +
> +	img_base = vzalloc(MIGRATION_IMG_MAX_SIZE);
> +	if (img_base == NULL) {
> +		gvt_vgpu_err("Unable to allocate size: %ld\n",
> +				MIGRATION_IMG_MAX_SIZE);
> +		return -EFAULT;
> +	}
> +
> +	FOR_EACH_OBJ(node, gvt_device_objs) {
> +		update_image_region_base(node, img_base);
> +		update_image_region_start_pos(node, INV);
> +		update_status_region_base(node, vgpu);
> +	}
> +
> +	if (restore) {
> +		if (copy_from_user(img_base + off, buf, count)) {
> +			ret = -EFAULT;
> +			goto exit;
> +		}
> +		vgpu->pv_notified = true;
> +		if (vgpu_restore(img_base) == INV) {
> +			ret = -EFAULT;
> +			goto exit;
> +		}
> +	} else {
> +		vgpu_save(img_base);
> +		if (copy_to_user(buf, img_base + off, count)) {
> +			ret = -EFAULT;
> +			goto exit;
> +		}
> +	}
> +
> +exit:
> +	vfree(img_base);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/i915/gvt/migrate.h b/drivers/gpu/drm/i915/gvt/migrate.h
> new file mode 100644
> index 0000000..5a81be4
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/gvt/migrate.h
> @@ -0,0 +1,82 @@
> +/*
> + * Copyright(c) 2011-2016 Intel Corporation. All rights reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice (including the next
> + * paragraph) shall be included in all copies or substantial portions of the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + */
> +
> +#ifndef __GVT_MIGRATE_H__
> +#define __GVT_MIGRATE_H__
> +
> +/* Assume 9MB is eough to descript VM kernel state */
> +#define MIGRATION_IMG_MAX_SIZE (9*1024UL*1024UL)
> +#define GVT_MMIO_SIZE (2*1024UL*1024UL)
> +#define GVT_MIGRATION_VERSION	0
> +
> +enum gvt_migration_type_t {
> +	GVT_MIGRATION_NONE,
> +	GVT_MIGRATION_HEAD,
> +	GVT_MIGRATION_CFG_SPACE,
> +	GVT_MIGRATION_VREG,
> +	GVT_MIGRATION_SREG,
> +	GVT_MIGRATION_GTT,
> +	GVT_MIGRATION_WORKLOAD,
> +};
> +
> +typedef struct gvt_pending_workload_t{
> +	int ring_id;
> +	struct intel_vgpu_elsp_dwords elsp_dwords;
> +} gvt_pending_workload_t;
> +
> +typedef struct gvt_region_t {
> +	enum gvt_migration_type_t type;
> +	u32 size;		/* obj size of bytes to read/write */
> +} gvt_region_t;
> +
> +typedef struct gvt_migration_obj_t {
> +	void *img;
> +	void *vgpu;
> +	u32 offset;
> +	gvt_region_t region;
> +	/* operation func defines how data save-restore */
> +	struct gvt_migration_operation_t *ops;
> +	char *name;
> +} gvt_migration_obj_t;
> +
> +typedef struct gvt_migration_operation_t {
> +	/* called during pre-copy stage, VM is still alive */
> +	int (*pre_copy)(const gvt_migration_obj_t *obj);
> +	/* called before when VM was paused,
> +	 * return bytes transferred
> +	 */
> +	int (*pre_save)(const gvt_migration_obj_t *obj);
> +	/* called before load the state of device */
> +	int (*pre_load)(const gvt_migration_obj_t *obj, u32 size);
> +	/* called after load the state of device, VM already alive */
> +	int (*post_load)(const gvt_migration_obj_t *obj, u32 size);
> +} gvt_migration_operation_t;
> +
> +typedef struct gvt_image_header_t {
> +	int version;
> +	int data_size;
> +	u64 crc_check;
> +	u64 global_data[64];
> +} gvt_image_header_t;
> +
> +#endif
> diff --git a/drivers/gpu/drm/i915/gvt/mmio.c b/drivers/gpu/drm/i915/gvt/mmio.c
> index 980ec89..0467e28 100644
> --- a/drivers/gpu/drm/i915/gvt/mmio.c
> +++ b/drivers/gpu/drm/i915/gvt/mmio.c
> @@ -50,6 +50,20 @@ int intel_vgpu_gpa_to_mmio_offset(struct intel_vgpu *vgpu, u64 gpa)
>  	return gpa - gttmmio_gpa;
>  }
>  
> +/**
> + * intel_vgpu_mmio_offset_to_GPA - translate a MMIO offset to GPA
> + * @vgpu: a vGPU
> + *
> + * Returns:
> + * Zero on success, negative error code if failed
> + */
> +int intel_vgpu_mmio_offset_to_gpa(struct intel_vgpu *vgpu, u64 offset)
> +{
> +	return offset + ((*(u64 *)(vgpu_cfg_space(vgpu) + PCI_BASE_ADDRESS_0)) &
> +			~GENMASK(3, 0));
> +}
> +
> +
>  #define reg_is_mmio(gvt, reg)  \
>  	(reg >= 0 && reg < gvt->device_info.mmio_size)
>  
> diff --git a/drivers/gpu/drm/i915/gvt/mmio.h b/drivers/gpu/drm/i915/gvt/mmio.h
> index 32cd64d..4198159 100644
> --- a/drivers/gpu/drm/i915/gvt/mmio.h
> +++ b/drivers/gpu/drm/i915/gvt/mmio.h
> @@ -82,6 +82,7 @@ void intel_vgpu_reset_mmio(struct intel_vgpu *vgpu, bool dmlr);
>  void intel_vgpu_clean_mmio(struct intel_vgpu *vgpu);
>  
>  int intel_vgpu_gpa_to_mmio_offset(struct intel_vgpu *vgpu, u64 gpa);
> +int intel_vgpu_mmio_offset_to_gpa(struct intel_vgpu *vgpu, u64 offset);
>  
>  int intel_vgpu_emulate_mmio_read(struct intel_vgpu *vgpu, u64 pa,
>  				void *p_data, unsigned int bytes);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 544cf93..ac19c05 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -436,7 +436,8 @@ enum {
>  	 * between described ranges are unimplemented.
>  	 */
>  	VFIO_PCI_VGA_REGION_INDEX,
> -	VFIO_PCI_NUM_REGIONS = 9 /* Fixed user ABI, region indexes >=9 use */
> +	VFIO_PCI_DEVICE_STATE_REGION_INDEX,
> +	VFIO_PCI_NUM_REGIONS = 10 /* Fixed user ABI, region indexes >=10 use */
>  				 /* device specific cap to define content. */
>  };
>  
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
