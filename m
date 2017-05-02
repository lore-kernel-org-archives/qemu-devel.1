Received: from eggs.gnu.org ([2001:4830:134:3::10]:54061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5Z77-0007M5-Hp
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5Z73-0003bw-Hg
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5Z73-0003b9-Bc
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:49:13 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493692691-30801-1-git-send-email-lu.zhipeng@zte.com.cn>
Date: Tue, 02 May 2017 16:49:05 +0200
In-Reply-To: <1493692691-30801-1-git-send-email-lu.zhipeng@zte.com.cn>
	(ZhiPeng Lu's message of "Tue, 2 May 2017 10:38:11 +0800")
Message-ID: <8737cngvq6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hmp: add 'info virtio-pci-status id'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Cc: dgilbert@redhat.com, mst@redhat.com, marcel@redhat.com, qemu-devel@nongnu.org

ZhiPeng Lu <lu.zhipeng@zte.com.cn> writes:

> Add command to  query a virtio pci device status.
> we can get id of the virtio pci device by 'info pci' command.
> HMP Test case:
>     ==============
>     virsh # qemu-monitor-command --hmp 3 info pci
>       Bus  0, device   3, function 0:
>         Ethernet controller: PCI device 1af4:1000
>           IRQ 11.
>           BAR0: I/O at 0xc000 [0xc03f].
>           BAR1: 32 bit memory at 0xfebd1000 [0xfebd1fff].
>           BAR4: 64 bit prefetchable memory at 0xfe000000 [0xfe003fff].
>           BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
>           id "net0"
>       Bus  0, device   4, function 0:
>         USB controller: PCI device 8086:24cd
>           IRQ 11.
>           BAR0: 32 bit memory at 0xfebd2000 [0xfebd2fff].
>           id "usb"
>     virsh # qemu-monitor-command 3  --hmp "info virtio-pci-status net0"
>     status=15
>
>     virsh # qemu-monitor-command 3  --hmp "info virtio-pci-status usb"
>     the 'info virtio_pci_status' command only supports virtio pci devices
>
> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> ---
>  hmp-commands-info.hx    | 14 ++++++++++++++
>  hw/pci/pci-stub.c       |  6 ++++++
>  hw/virtio/virtio-pci.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/sysemu.h |  1 +
>  4 files changed, 68 insertions(+)

You implemented this just for HMP.

In general, functionality available in HMP should also available in QMP.
Exceptions include functionality that makes no sense in QMP, or is of
use only for human users.  If you think your command is an exception,
please explain why in the commit message.

If it isn't, you need to implement it for QMP (including suitable test
cases), then rewrite the HMP version to reuse either the QMP command or
a common core.

Example for "makes no sense in QMP": setting the current CPU[1], because
a QMP monitor doesn't have a current CPU.

Examples for "is of use only for human users": HMP command "help", the
integrated pocket calculator[2].


[1] For reasons lost in time, we added QMP command "cpu" anyway, it just
does nothing.

[2] I doubt that one is of much use to humans, either.
