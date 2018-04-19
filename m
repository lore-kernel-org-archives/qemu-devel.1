Received: from eggs.gnu.org ([2001:4830:134:3::10]:52538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f9Boj-0008Bo-6E
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f9Bog-0000Uq-1i
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:49:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49412
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f9Bof-0000Sk-Q2
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:49:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3JFei3o119932
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 11:49:44 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2heuwcyrm0-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 11:49:43 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 19 Apr 2018 16:49:42 +0100
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-3-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 19 Apr 2018 17:49:37 +0200
MIME-Version: 1.0
In-Reply-To: <1524054707-20663-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0be89209-6ee5-2f12-fae2-21709fcf6f8a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2.13 2/4] pc-bios/s390-ccw/net: Stop
 virtio-net device before jumping into the OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

On 04/18/2018 02:31 PM, Thomas Huth wrote:
> The virtio-net receive buffers are filled asynchronously, so we should
> make sure to properly shut down the virtio-net device before we jump into
> the loaded kernel. Otherwise an incoming packet could destroy memory of
> the OS kernel if it did not re-initialize the virtio-net device fast
> enough yet.
> 

The normal bios does a full subsystem reset before we enter the OS.
(see jump_to_IPL_code the diag 308). That should reset all virtio 
devices on the qemu level. Shouldnt we rather do the same for
the net bios?



> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/netmain.c    |  1 +
>  pc-bios/s390-ccw/virtio-net.c |  8 ++++++++
>  pc-bios/s390-ccw/virtio.c     | 19 ++++++++++++++-----
>  pc-bios/s390-ccw/virtio.h     |  3 +++
>  4 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index ebdc440..e11ed4e 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -273,6 +273,7 @@ static void net_uninit(filename_ip_t *fn_ip)
>      if (ip_version == 4) {
>          dhcp_send_release(fn_ip->fd);
>      }
> +    virtio_net_uninit();
>  }
> 
>  void panic(const char *string)
> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
> index ff7f4da..339fe53 100644
> --- a/pc-bios/s390-ccw/virtio-net.c
> +++ b/pc-bios/s390-ccw/virtio-net.c
> @@ -67,6 +67,14 @@ int virtio_net_init(void *mac_addr)
>      return 0;
>  }
> 
> +void virtio_net_uninit(void)
> +{
> +    VDev *vdev = virtio_get_device();
> +
> +    virtio_status_set(vdev, VIRTIO_CONFIG_S_FAILED);
> +    virtio_reset_dev(vdev);
> +}
> +
>  int send(int fd, const void *buf, int len, int flags)
>  {
>      VirtioNetHdr tx_hdr;
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index cdb66f4..1d15b03 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -248,10 +248,21 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
>      return 0;
>  }
> 
> +void virtio_status_set(VDev *vdev, uint8_t status)
> +{
> +    IPL_assert(
> +        run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status)) == 0,
> +        "Could not write status to host");
> +}
> +
> +void virtio_reset_dev(VDev *vdev)
> +{
> +    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0);
> +}
> +
>  void virtio_setup_ccw(VDev *vdev)
>  {
>      int i, rc, cfg_size = 0;
> -    unsigned char status = VIRTIO_CONFIG_S_DRIVER_OK;
>      struct VirtioFeatureDesc {
>          uint32_t features;
>          uint8_t index;
> @@ -263,7 +274,7 @@ void virtio_setup_ccw(VDev *vdev)
>      vdev->config.blk.blk_size = 0; /* mark "illegal" - setup started... */
>      vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
> 
> -    run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0);
> +    virtio_reset_dev(vdev);
> 
>      switch (vdev->senseid.cu_model) {
>      case VIRTIO_ID_NET:
> @@ -320,9 +331,7 @@ void virtio_setup_ccw(VDev *vdev)
>          IPL_assert(run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info)) == 0,
>                     "Cannot set VQ info");
>      }
> -    IPL_assert(
> -        run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status)) == 0,
> -        "Could not write status to host");
> +    virtio_status_set(vdev, VIRTIO_CONFIG_S_DRIVER_OK);
>  }
> 
>  bool virtio_is_supported(SubChannelId schid)
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index 19fceb6..c2479be 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -277,8 +277,11 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags);
>  int vr_poll(VRing *vr);
>  int vring_wait_reply(void);
>  int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
> +void virtio_status_set(VDev *vdev, uint8_t status);
> +void virtio_reset_dev(VDev *vdev);
>  void virtio_setup_ccw(VDev *vdev);
> 
>  int virtio_net_init(void *mac_addr);
> +void virtio_net_uninit(void);
> 
>  #endif /* VIRTIO_H */
> 
