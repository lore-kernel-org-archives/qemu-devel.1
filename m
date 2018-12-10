Received: from eggs.gnu.org ([2001:4830:134:3::10]:58427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gWLGw-0002bJ-FH
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gWLGr-00069u-Rx
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:06:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41710
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gWLGr-00069H-Lf
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:06:49 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBAD4hYn060621
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 08:06:48 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p9p757qba-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 08:06:48 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Mon, 10 Dec 2018 13:06:46 -0000
Date: Mon, 10 Dec 2018 14:06:42 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181210120436.30522-1-peter.maydell@linaro.org>
References: <20181210120436.30522-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181210140642.4f2f457c@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] hw/s390x/virtio-ccw.c: Don't
 take address of fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, 10 Dec 2018 12:04:36 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this. Avoid the bug by not using the
> "modify in place" byte swapping functions.
> 
> Patch produced with scripts/coccinelle/inplace-byteswaps.cocci
> (with a couple of long lines manually wrapped).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

I wonder if packed was a good idea in the first place. @Connie: Do you
have an opinion on this?

Regards,
Halil

> ---
> s390 also has some warnings in hw/s390x/css.c which are going to
> be harder to fix, relating to taking the address of the 'pmcw' and
> 'scsw' fields in the SCHUB struct...
> 
>  hw/s390x/virtio-ccw.c | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 212b3d3dead..c2b78c8e9b1 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -287,18 +287,18 @@ static int virtio_ccw_handle_set_vq(SubchDev *sch, CCW1 ccw, bool check_len,
>      }
>      if (is_legacy) {
>          ccw_dstream_read(&sch->cds, linfo);
> -        be64_to_cpus(&linfo.queue);
> -        be32_to_cpus(&linfo.align);
> -        be16_to_cpus(&linfo.index);
> -        be16_to_cpus(&linfo.num);
> +        linfo.queue = be64_to_cpu(linfo.queue);
> +        linfo.align = be32_to_cpu(linfo.align);
> +        linfo.index = be16_to_cpu(linfo.index);
> +        linfo.num = be16_to_cpu(linfo.num);
>          ret = virtio_ccw_set_vqs(sch, NULL, &linfo);
>      } else {
>          ccw_dstream_read(&sch->cds, info);
> -        be64_to_cpus(&info.desc);
> -        be16_to_cpus(&info.index);
> -        be16_to_cpus(&info.num);
> -        be64_to_cpus(&info.avail);
> -        be64_to_cpus(&info.used);
> +        info.desc = be64_to_cpu(info.desc);
> +        info.index = be16_to_cpu(info.index);
> +        info.num = be16_to_cpu(info.num);
> +        info.avail = be64_to_cpu(info.avail);
> +        info.used = be64_to_cpu(info.used);
>          ret = virtio_ccw_set_vqs(sch, &info, NULL);
>      }
>      sch->curr_status.scsw.count = 0;
> @@ -382,7 +382,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>                  features.features = 0;
>              }
>              ccw_dstream_rewind(&sch->cds);
> -            cpu_to_le32s(&features.features);
> +            features.features = cpu_to_le32(features.features);
>              ccw_dstream_write(&sch->cds, features.features);
>              sch->curr_status.scsw.count = ccw.count - sizeof(features);
>              ret = 0;
> @@ -403,7 +403,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              ret = -EFAULT;
>          } else {
>              ccw_dstream_read(&sch->cds, features);
> -            le32_to_cpus(&features.features);
> +            features.features = le32_to_cpu(features.features);
>              if (features.index == 0) {
>                  virtio_set_features(vdev,
>                                      (vdev->guest_features & 0xffffffff00000000ULL) |
> @@ -546,7 +546,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              ret = -EFAULT;
>          } else {
>              ccw_dstream_read(&sch->cds, indicators);
> -            be64_to_cpus(&indicators);
> +            indicators = be64_to_cpu(indicators);
>              dev->indicators = get_indicator(indicators, sizeof(uint64_t));
>              sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
>              ret = 0;
> @@ -567,7 +567,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              ret = -EFAULT;
>          } else {
>              ccw_dstream_read(&sch->cds, indicators);
> -            be64_to_cpus(&indicators);
> +            indicators = be64_to_cpu(indicators);
>              dev->indicators2 = get_indicator(indicators, sizeof(uint64_t));
>              sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
>              ret = 0;
> @@ -588,14 +588,14 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              ret = -EFAULT;
>          } else {
>              ccw_dstream_read(&sch->cds, vq_config.index);
> -            be16_to_cpus(&vq_config.index);
> +            vq_config.index = be16_to_cpu(vq_config.index);
>              if (vq_config.index >= VIRTIO_QUEUE_MAX) {
>                  ret = -EINVAL;
>                  break;
>              }
>              vq_config.num_max = virtio_queue_get_num(vdev,
>                                                       vq_config.index);
> -            cpu_to_be16s(&vq_config.num_max);
> +            vq_config.num_max = cpu_to_be16(vq_config.num_max);
>              ccw_dstream_write(&sch->cds, vq_config.num_max);
>              sch->curr_status.scsw.count = ccw.count - sizeof(vq_config);
>              ret = 0;
> @@ -621,9 +621,11 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              if (ccw_dstream_read(&sch->cds, thinint)) {
>                  ret = -EFAULT;
>              } else {
> -                be64_to_cpus(&thinint.ind_bit);
> -                be64_to_cpus(&thinint.summary_indicator);
> -                be64_to_cpus(&thinint.device_indicator);
> +                thinint.ind_bit = be64_to_cpu(thinint.ind_bit);
> +                thinint.summary_indicator =
> +                    be64_to_cpu(thinint.summary_indicator);
> +                thinint.device_indicator =
> +                    be64_to_cpu(thinint.device_indicator);
>  
>                  dev->summary_indicator =
>                      get_indicator(thinint.summary_indicator, sizeof(uint8_t));
> @@ -654,8 +656,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              break;
>          }
>          ccw_dstream_read_buf(&sch->cds, &revinfo, 4);
> -        be16_to_cpus(&revinfo.revision);
> -        be16_to_cpus(&revinfo.length);
> +        revinfo.revision = be16_to_cpu(revinfo.revision);
> +        revinfo.length = be16_to_cpu(revinfo.length);
>          if (ccw.count < len + revinfo.length ||
>              (check_len && ccw.count > len + revinfo.length)) {
>              ret = -EINVAL;
