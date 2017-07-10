Received: from eggs.gnu.org ([2001:4830:134:3::10]:43739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUWmj-0000uB-DA
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUWme-0004Aa-Eo
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:23:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUWme-00049O-5I
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:23:20 -0400
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-8-git-send-email-thuth@redhat.com>
	<20170707143736.08062610@dhcp-192-215.str.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <946e7983-15ad-08fe-41c5-6913113a3cd3@redhat.com>
Date: Mon, 10 Jul 2017 13:23:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170707143736.08062610@dhcp-192-215.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 7/8] pc-bios/s390-ccw: Add
 virtio-net driver code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On 07.07.2017 14:37, Cornelia Huck wrote:
> On Fri,  7 Jul 2017 12:27:03 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The driver provides the recv() and send() functions which will
>> be required by SLOF's libnet code for receiving and sending
>> packets.
[...]
>> +int virtio_net_init(void *mac_addr)
>> +{
>> +    VDev *vdev = virtio_get_device();
>> +    VRing *rxvq = &vdev->vrings[VQ_RX];
>> +    void *buf;
>> +    int i;
>> +
>> +    virtio_setup_ccw(vdev);
>> +
>> +    memcpy(mac_addr, vdev->config.net.mac, ETH_ALEN);
> 
> The mac address in the config space is only valid if the mac feature
> flag has been negotiated (although the field always exists).

QEMU seems to always set it ... but yes, let's better negotiate
VIRTIO_NET_F_MAC here.

>> +
>> +    for (i = 0; i < 64; i++) {
>> +        buf = malloc(ETH_MTU_SIZE + sizeof(VirtioNetHdr));
>> +        IPL_assert(buf != NULL, "Can not allocate memory for receive buffers");
>> +        vring_send_buf(rxvq, buf, ETH_MTU_SIZE + sizeof(VirtioNetHdr),
>> +                       VRING_DESC_F_WRITE);
>> +    }
>> +    vring_notify(rxvq);
>> +
>> +    return 0;
>> +}
>> +
>> +int send(int fd, const void *buf, int len, int flags)
>> +{
>> +    VirtioNetHdr tx_hdr;
>> +    VDev *vdev = virtio_get_device();
>> +    VRing *txvq = &vdev->vrings[VQ_TX];
>> +
>> +    /* Set up header - we do not use anything special, so simply clear it */
>> +    memset(&tx_hdr, 0, sizeof(tx_hdr));
>> +
>> +    vring_send_buf(txvq, &tx_hdr, sizeof(tx_hdr), VRING_DESC_F_NEXT);
>> +    vring_send_buf(txvq, (void *)buf, len, VRING_HIDDEN_IS_CHAIN);
>> +    while (!vr_poll(txvq)) {
>> +        yield();
>> +    }
>> +    if (drain_irqs(txvq->schid)) {
>> +        puts("send: drain irqs failed");
>> +        return -1;
> 
> Does the caller try again later? drain_irqs() errors may be transient.

Yes, the TFTP code retries to send packets after a certain amount of
time (since the packets could also be lost in the network somewhere).

>> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
>> index 09ab291..729d926 100644
>> --- a/pc-bios/s390-ccw/virtio.c
>> +++ b/pc-bios/s390-ccw/virtio.c
>> @@ -149,7 +149,7 @@ static void vring_init(VRing *vr, VqInfo *info)
>>      debug_print_addr("init vr", vr);
>>  }
>>  
>> -static bool vring_notify(VRing *vr)
>> +bool vring_notify(VRing *vr)
>>  {
>>      vr->cookie = virtio_notify(vr->schid, vr->id, vr->cookie);
>>      return vr->cookie >= 0;
>> @@ -188,7 +188,7 @@ ulong get_second(void)
>>      return (get_clock() >> 12) / 1000000;
>>  }
>>  
>> -static int vr_poll(VRing *vr)
>> +int vr_poll(VRing *vr)
>>  {
>>      if (vr->used->idx == vr->used_idx) {
>>          vring_notify(vr);
>> @@ -261,6 +261,11 @@ void virtio_setup_ccw(VDev *vdev)
>>      run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0);
>>  
>>      switch (vdev->senseid.cu_model) {
>> +    case VIRTIO_ID_NET:
>> +        vdev->nr_vqs = 3;
> 
> I think this should be 2, as you don't negotiate for the control vq.

OK.

>> +        vdev->cmd_vr_idx = 0;
>> +        cfg_size = sizeof(vdev->config.net);
>> +        break;
>>      case VIRTIO_ID_BLOCK:
>>          vdev->nr_vqs = 1;
>>          vdev->cmd_vr_idx = 0;
>> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
>> index d743919..d6af022 100644
>> --- a/pc-bios/s390-ccw/virtio.h
>> +++ b/pc-bios/s390-ccw/virtio.h
>> @@ -11,8 +11,6 @@
>>  #ifndef VIRTIO_H
>>  #define VIRTIO_H
>>  
>> -#include "s390-ccw.h"
>> -
>>  /* Status byte for guest to report progress, and synchronize features. */
>>  /* We have seen device and processed generic fields (VIRTIO_CONFIG_F_VIRTIO) */
>>  #define VIRTIO_CONFIG_S_ACKNOWLEDGE     1
>> @@ -254,6 +252,12 @@ struct ScsiDevice {
>>  };
>>  typedef struct ScsiDevice ScsiDevice;
>>  
>> +struct VirtioNetConfig {
>> +    uint8_t mac[6];
>> +    uint16_t status;
> 
> I don't think status exists if you don't negotiate the respective
> feature bit.

OK.

>> +};
>> +typedef struct VirtioNetConfig VirtioNetConfig;
>> +
>>  struct VDev {
>>      int nr_vqs;
>>      VRing *vrings;
>> @@ -266,6 +270,7 @@ struct VDev {
>>      union {
>>          VirtioBlkConfig blk;
>>          VirtioScsiConfig scsi;
>> +        VirtioNetConfig net;
>>      } config;
>>      ScsiDevice *scsi_device;
>>      bool is_cdrom;
>> @@ -291,10 +296,14 @@ struct VirtioCmd {
>>  };
>>  typedef struct VirtioCmd VirtioCmd;
>>  
>> +bool vring_notify(VRing *vr);
>>  int drain_irqs(SubChannelId schid);
>>  void vring_send_buf(VRing *vr, void *p, int len, int flags);
>> +int vr_poll(VRing *vr);
>>  int vring_wait_reply(void);
>>  int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
>>  void virtio_setup_ccw(VDev *vdev);
>>  
>> +int virtio_net_init(void *mac_addr);
>> +
>>  #endif /* VIRTIO_H */
> 

Thanks for the review!

 Thomas
