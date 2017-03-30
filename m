Received: from eggs.gnu.org ([2001:4830:134:3::10]:56352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1ctZmM-00006b-ND
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1ctZmJ-0002xD-7o
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:06:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1ctZmI-0002wA-Uo
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFD9C7AEA7
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 13:06:13 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1490818790-3100-1-git-send-email-vyasevic@redhat.com>
	<20170330082419.GA2585@work-vm>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <161e7bfe-2d0a-d69f-44ac-94fb62db1b4a@redhat.com>
Date: Thu, 30 Mar 2017 09:06:06 -0400
MIME-Version: 1.0
In-Reply-To: <20170330082419.GA2585@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-net: consolidate guest announcement
 with qemu_announce_self
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, gveitmic@redhat.com, mst@redhat.com, Jason Wang <jasowang@redhat.com>

On 03/30/2017 04:24 AM, Dr. David Alan Gilbert wrote:
> * Vladislav Yasevich (vyasevic@redhat.com) wrote:
>> virtio announcements seem to run on its own timer with it's own
>> repetition loop and are invoked separately from qemu_announce_self.
>> This patch consolidates announcements into a single location and
>> allows other nics to provide it's own announcement capabilities, if
>> necessary.
>>
>> This is also usefull in support of exposing qemu_announce_self through
>> qmp/hmp.
>>
>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
>> ---
>>  hw/net/virtio-net.c            | 30 ++++++++----------------------
>>  include/hw/virtio/virtio-net.h |  2 --
>>  include/net/net.h              |  2 ++
>>  migration/savevm.c             |  6 ++++++
>>  4 files changed, 16 insertions(+), 24 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index c321680..6e9ce4f 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -110,14 +110,16 @@ static bool virtio_net_started(VirtIONet *n, uint8_t status)
>>          (n->status & VIRTIO_NET_S_LINK_UP) && vdev->vm_running;
>>  }
>>  
>> -static void virtio_net_announce_timer(void *opaque)
>> +static void virtio_net_announce(NetClientState *nc)
>>  {
>> -    VirtIONet *n = opaque;
>> +    VirtIONet *n = qemu_get_nic_opaque(nc);
>>      VirtIODevice *vdev = VIRTIO_DEVICE(n);
>>  
>> -    n->announce_counter--;
>> -    n->status |= VIRTIO_NET_S_ANNOUNCE;
>> -    virtio_notify_config(vdev);
>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_GUEST_ANNOUNCE) &&
>> +        virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
>> +            n->status |= VIRTIO_NET_S_ANNOUNCE;
>> +            virtio_notify_config(vdev);
>> +    }
>>  }
>>  
>>  static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
>> @@ -427,8 +429,6 @@ static void virtio_net_reset(VirtIODevice *vdev)
>>      n->nobcast = 0;
>>      /* multiqueue is disabled by default */
>>      n->curr_queues = 1;
>> -    timer_del(n->announce_timer);
>> -    n->announce_counter = 0;
>>      n->status &= ~VIRTIO_NET_S_ANNOUNCE;
>>  
>>      /* Flush any MAC and VLAN filter table state */
>> @@ -868,11 +868,6 @@ static int virtio_net_handle_announce(VirtIONet *n, uint8_t cmd,
>>      if (cmd == VIRTIO_NET_CTRL_ANNOUNCE_ACK &&
>>          n->status & VIRTIO_NET_S_ANNOUNCE) {
>>          n->status &= ~VIRTIO_NET_S_ANNOUNCE;
>> -        if (n->announce_counter) {
>> -            timer_mod(n->announce_timer,
>> -                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
>> -                      self_announce_delay(n->announce_counter));
>> -        }
>>          return VIRTIO_NET_OK;
>>      } else {
>>          return VIRTIO_NET_ERR;
>> @@ -1609,12 +1604,6 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
>>          qemu_get_subqueue(n->nic, i)->link_down = link_down;
>>      }
>>  
>> -    if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_GUEST_ANNOUNCE) &&
>> -        virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
>> -        n->announce_counter = SELF_ANNOUNCE_ROUNDS;
>> -        timer_mod(n->announce_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL));
>> -    }
>> -
>>      return 0;
>>  }
>>  
>> @@ -1829,6 +1818,7 @@ static NetClientInfo net_virtio_info = {
>>      .receive = virtio_net_receive,
>>      .link_status_changed = virtio_net_set_link_status,
>>      .query_rx_filter = virtio_net_query_rxfilter,
>> +    .announce = virtio_net_announce,
>>  };
>>  
>>  static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int idx)
>> @@ -1934,8 +1924,6 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>>      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>>      n->status = VIRTIO_NET_S_LINK_UP;
>> -    n->announce_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>> -                                     virtio_net_announce_timer, n);
>>  
>>      if (n->netclient_type) {
>>          /*
>> @@ -1997,8 +1985,6 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
>>          virtio_net_del_queue(n, i);
>>      }
>>  
>> -    timer_del(n->announce_timer);
>> -    timer_free(n->announce_timer);
>>      g_free(n->vqs);
>>      qemu_del_nic(n->nic);
>>      virtio_cleanup(vdev);
>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
>> index 1eec9a2..0c597f4 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -94,8 +94,6 @@ typedef struct VirtIONet {
>>      char *netclient_name;
>>      char *netclient_type;
>>      uint64_t curr_guest_offloads;
>> -    QEMUTimer *announce_timer;
>> -    int announce_counter;
>>      bool needs_vnet_hdr_swap;
>>  } VirtIONet;
>>  
>> diff --git a/include/net/net.h b/include/net/net.h
>> index 99b28d5..598f523 100644
>> --- a/include/net/net.h
>> +++ b/include/net/net.h
>> @@ -64,6 +64,7 @@ typedef int (SetVnetLE)(NetClientState *, bool);
>>  typedef int (SetVnetBE)(NetClientState *, bool);
>>  typedef struct SocketReadState SocketReadState;
>>  typedef void (SocketReadStateFinalize)(SocketReadState *rs);
>> +typedef void (NetAnnounce)(NetClientState *);
>>  
>>  typedef struct NetClientInfo {
>>      NetClientDriver type;
>> @@ -84,6 +85,7 @@ typedef struct NetClientInfo {
>>      SetVnetHdrLen *set_vnet_hdr_len;
>>      SetVnetLE *set_vnet_le;
>>      SetVnetBE *set_vnet_be;
>> +    NetAnnounce *announce;
>>  } NetClientInfo;
>>  
>>  struct NetClientState {
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 3b19a4a..5c1d8dc 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -113,9 +113,15 @@ static void qemu_announce_self_iter(NICState *nic, void *opaque)
>>      int len;
>>  
>>      trace_qemu_announce_self_iter(qemu_ether_ntoa(&nic->conf->macaddr));
>> +
>>      len = announce_self_create(buf, nic->conf->macaddr.a);
>>  
>>      qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
>> +
>> +    /* if the NIC provides it's own announcement support, use it as well */
>> +    if (nic->ncs->info->announce) {
>> +        nic->ncs->info->announce(nic->ncs);
>> +    }
>>  }
> 
> Combining them doesn't necessarily seem like a bad thing; but
> it does change the timing quite a bit - at the moment the QEMU RARPs
> are sent at the end of migration, while the Virtio ARPs are sent
> when the guest starts running which is quite a bit later.
> 
> In many ways the 'when the guest starts' is better, given that libvirt
> etc has had a chance to reconfigure the networking,  but I'm not that
> sure if it's safe to move the existing one - I had considered *adding*
> another shot of the current mechanism after the guest is started.
> 

Yes, the timing of things have been giving me some issues, but I wanted to post
this patch to get some comments just like this one..

I've wondered why they qemu one happens before the guest starts running.

> I certainly think it's wrong to do the virtio announce at the earlier
> point.
>

I see.

> See also Germano's thread of being able to retrigger the announce
> at arbitrary points, and the series I posted a couple of days ago
> to extend the length/timing of the announce.
> 

That's kind of what prompted me to do try this.  The issue with just
exposing qemu_announce_self() is that RARPS just aren't enough in
some cases (vlans, multicast).  This attempts to add the callback
like Jason mentioned, but then we get timer interactions between the
virtio-net timers and qemu one.

-vlad

> Dave
> 
>> -- 
>> 2.7.4
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
