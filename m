Received: from eggs.gnu.org ([2001:4830:134:3::10]:35051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ebSff-0001bZ-JZ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ebSfc-0000mC-GY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:57:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ebSfc-0000ll-6z
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:57:00 -0500
References: <20180112145658.17121-1-maxime.coquelin@redhat.com>
	<20180112145658.17121-3-maxime.coquelin@redhat.com>
	<20180116050246-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <b1b27d43-b2d0-3a1e-18cc-92cd2dab95a9@redhat.com>
Date: Tue, 16 Jan 2018 15:56:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180116050246-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] vhost-user: specify and implement
 VHOST_USER_SET_QUEUE_NUM request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, mlureau@redhat.com, zhengxiang9@huawei.com, lersek@redhat.com, pbonzini@redhat.com



On 01/16/2018 04:05 AM, Michael S. Tsirkin wrote:
> On Fri, Jan 12, 2018 at 03:56:56PM +0100, Maxime Coquelin wrote:
>> When the slave cannot add queues dynamically,
> 
> 
> Could you please clarify the motivation a bit
> Why is it such a big deal to resize the queue array?
> We know no queues are used before all of them are initialized,
> so you don't need to worry about synchronizing with threads
> processing the queues at the same time.

The problem is to know how many queues to wait for being initialized.
We need this information in DPDK to start the "vhost device".

Before the guest driver is initialized, the slave receives from QEMU
VHOST_USER_SET_VRING_CALL and VHOST_USER_SET_VRING_ENABLE for all queues
declared in QEMU. In DPDK, queues metadata is allocated each time a
message targets a new vring index, and vring count is incremented
accordingly.

Currently, it seems to work, because QEMU calls vhost_virtqueue_start()
for all queues, even ones not configured by the guest.

But with patch "[PATCH] vhost: fix corrupting GPA 0 when using
uninitialized queues" from Zheng Xiang, QEMU will not more send
_SET_VRING_ADDR and _SET_VRING_KICK for un-configured queues, but
the backend will wait forever for these messages to start the device.

I pasted below a log of messages received by the slave, so you can make
an idea of the sequence.

>> it needs to know for
>> how many queues to wait to be initialized.
>>
>> This patch introduce new vhost-user protocol feature & request for
>> the master to send the number of queue pairs allocated by the
>> driver.
> 
> Assuming we can fix the previous message, I think specifying
> the # of queues would be better.

Thanks,
Maxime


EAL: Detected 4 lcore(s)
EAL: No free hugepages reported in hugepages-1048576kB
EAL: Probing VFIO support...
EAL: PCI device 0000:00:1f.6 on NUMA socket -1
EAL:   Invalid NUMA socket, default to 0
EAL:   probe driver: 8086:156f net_e1000_em
PMD: Initializing pmd_vhost for net_vhost0
PMD: Creating VHOST-USER backend on numa socket 0
VHOST_CONFIG: vhost-user server: socket created, fd: 13
VHOST_CONFIG: bind to /tmp/vhost-user2
Interactive-mode selected
testpmd: create a new mbuf pool <mbuf_pool_socket_0>: n=155456, 
size=2176, socket=0

Warning! Cannot handle an odd number of ports with the current port 
topology. Configuration must be changed to have an even number of ports, 
or relaunch application with --port-topology=chained

Configuring Port 0 (socket 0)
Port 0: 56:48:4F:53:54:00
Checking link statuses...
Done
testpmd> VHOST_CONFIG: new vhost user connection is 15
VHOST_CONFIG: new device, handle is 0
VHOST_CONFIG: read message VHOST_USER_GET_FEATURES
VHOST_CONFIG: read message VHOST_USER_GET_PROTOCOL_FEATURES
VHOST_CONFIG: read message VHOST_USER_SET_PROTOCOL_FEATURES
VHOST_CONFIG: read message VHOST_USER_GET_QUEUE_NUM
VHOST_CONFIG: read message VHOST_USER_SET_SLAVE_REQ_FD
VHOST_CONFIG: read message VHOST_USER_SET_OWNER
VHOST_CONFIG: read message VHOST_USER_GET_FEATURES
VHOST_CONFIG: read message VHOST_USER_SET_VRING_CALL
VHOST_CONFIG: vring call idx:0 file:17
VHOST_CONFIG: read message VHOST_USER_SET_VRING_CALL
VHOST_CONFIG: vring call idx:1 file:18
VHOST_CONFIG: read message VHOST_USER_GET_FEATURES
VHOST_CONFIG: read message VHOST_USER_GET_PROTOCOL_FEATURES
VHOST_CONFIG: read message VHOST_USER_SET_PROTOCOL_FEATURES
VHOST_CONFIG: read message VHOST_USER_SET_SLAVE_REQ_FD
VHOST_CONFIG: read message VHOST_USER_GET_FEATURES
VHOST_CONFIG: read message VHOST_USER_SET_VRING_CALL
VHOST_CONFIG: vring call idx:2 file:20
VHOST_CONFIG: read message VHOST_USER_SET_VRING_CALL
VHOST_CONFIG: vring call idx:3 file:21
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 1 to qp idx: 0
PMD: vring0 is enabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 1 to qp idx: 1
PMD: vring1 is enabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 0 to qp idx: 2
PMD: vring2 is disabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 0 to qp idx: 3
PMD: vring3 is disabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 1 to qp idx: 0
PMD: vring0 is enabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 1 to qp idx: 1
PMD: vring1 is enabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 0 to qp idx: 2
PMD: vring2 is disabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 0 to qp idx: 3
PMD: vring3 is disabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_FEATURES
VHOST_CONFIG: read message VHOST_USER_SET_MEM_TABLE
VHOST_CONFIG: guest memory region 0, size: 0x80000000
	 guest physical addr: 0x100000000
	 guest virtual  addr: 0x7f9cae200000
	 host  virtual  addr: 0x7f633da00000
	 mmap addr : 0x7f62bda00000
	 mmap size : 0x100000000
	 mmap align: 0x200000
	 mmap off  : 0x80000000
VHOST_CONFIG: guest memory region 1, size: 0xa0000
	 guest physical addr: 0x0
	 guest virtual  addr: 0x7f9c2e200000
	 host  virtual  addr: 0x7f64bda00000
	 mmap addr : 0x7f64bda00000
	 mmap size : 0x200000
	 mmap align: 0x200000
	 mmap off  : 0x0
VHOST_CONFIG: guest memory region 2, size: 0x7ff40000
	 guest physical addr: 0xc0000
	 guest virtual  addr: 0x7f9c2e2c0000
	 host  virtual  addr: 0x7f64380c0000
	 mmap addr : 0x7f6438000000
	 mmap size : 0x80000000
	 mmap align: 0x200000
	 mmap off  : 0xc0000
VHOST_CONFIG: read message VHOST_USER_SET_VRING_NUM
VHOST_CONFIG: read message VHOST_USER_SET_VRING_BASE
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ADDR
VHOST_CONFIG: read message VHOST_USER_SET_VRING_KICK
VHOST_CONFIG: vring kick idx:0 file:25
VHOST_CONFIG: read message VHOST_USER_SET_VRING_CALL
VHOST_CONFIG: vring call idx:0 file:26
VHOST_CONFIG: read message VHOST_USER_SET_VRING_NUM
VHOST_CONFIG: read message VHOST_USER_SET_VRING_BASE
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ADDR
VHOST_CONFIG: read message VHOST_USER_SET_VRING_KICK
VHOST_CONFIG: vring kick idx:1 file:17
VHOST_CONFIG: read message VHOST_USER_SET_VRING_CALL
VHOST_CONFIG: vring call idx:1 file:27
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 1 to qp idx: 0
PMD: vring0 is enabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 1 to qp idx: 1
PMD: vring1 is enabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_FEATURES
VHOST_CONFIG: read message VHOST_USER_SET_VRING_NUM
VHOST_CONFIG: read message VHOST_USER_SET_VRING_BASE
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ADDR
VHOST_CONFIG: read message VHOST_USER_SET_VRING_KICK
VHOST_CONFIG: vring kick idx:2 file:18
VHOST_CONFIG: read message VHOST_USER_SET_VRING_CALL
VHOST_CONFIG: vring call idx:2 file:28
VHOST_CONFIG: read message VHOST_USER_SET_VRING_NUM
VHOST_CONFIG: read message VHOST_USER_SET_VRING_BASE
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ADDR
VHOST_CONFIG: read message VHOST_USER_SET_VRING_KICK
VHOST_CONFIG: vring kick idx:3 file:20
VHOST_CONFIG: virtio is now ready for processing.
PMD: New connection established

Port 0: LSC event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_CALL
VHOST_CONFIG: vring call idx:3 file:29
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 1 to qp idx: 0
PMD: vring0 is enabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 1 to qp idx: 1
PMD: vring1 is enabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 1 to qp idx: 2
PMD: vring2 is enabled

Port 0: Queue state event
VHOST_CONFIG: read message VHOST_USER_SET_VRING_ENABLE
VHOST_CONFIG: set queue enable: 1 to qp idx: 3
PMD: vring3 is enabled

Port 0: Queue state event
