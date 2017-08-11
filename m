Received: from eggs.gnu.org ([2001:4830:134:3::10]:55045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dg71b-00036W-J1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dg71Y-0005k5-CN
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:18:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dg71Y-0005jd-2u
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:18:36 -0400
References: <1502407863-23182-1-git-send-email-zuban32s@gmail.com>
	<1502407863-23182-5-git-send-email-zuban32s@gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dfd69208-f498-7156-a901-4275fec72e2b@redhat.com>
Date: Fri, 11 Aug 2017 12:11:11 +0200
MIME-Version: 1.0
In-Reply-To: <1502407863-23182-5-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/4] docs: update documentation
 considering PCIE-PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, seabios@seabios.org, mst@redhat.com

On 08/11/17 01:31, Aleksandr Bezzubikov wrote:

> +PCIE-PCI bridge hot-plug
> +=======================
> +Guest OSes require extra efforts to enable PCIE-PCI bridge hot-plug.
> +Motivation - now on init any PCI Express root port which doesn't have
> +any device plugged in, has no free buses reserved to provide any of them
> +to a hot-plugged devices in future.
> +
> +To solve this problem we reserve additional buses on a firmware level.
> +Currently only SeaBIOS is supported.
> +The way of bus number to reserve delivery is special
> +Red Hat vendor-specific PCI capability, added to the root port
> +that is planned to have PCIE-PCI bridge hot-plugged in.
> +
> +Capability layout (defined in include/hw/pci/pci_bridge.h):
> +
> +    uint8_t id;     Standard PCI capability header field
> +    uint8_t next;   Standard PCI capability header field
> +    uint8_t len;    Standard PCI vendor-specific capability header field
> +
> +    uint8_t type;   Red Hat vendor-specific capability type
> +                    List of currently existing types:
> +                        RESOURCE_RESERVE = 1
> +
> +
> +    uint32_t bus_res;   Minimum number of buses to reserve
> +
> +    uint64_t io;           IO space to reserve
> +    uint32_t mem           Non-prefetchable memory to reserve
> +
> +    This two fields are mutually exclusive:

[*] mark this

> +    uint32_t mem_pref_32;  Prefetchable memory to reserve (32-bit MMIO)
> +    uint64_t mem_pref_64;  Prefetchable memory to reserve (64-bit MMIO)
> +
> +If any reservation field is -1 then this kind of reservation is not
> +needed and must be ignored by firmware.
> +
> +mem_pref_* fields mutual exclusiveness means they cannot be -1 both.

Please drop the last sentence; it is perfectly possible that a bridge
doesn't need either 32-bit or 64-bit prefetchable MMIO reservation.
"Mutually exclusive" usually means "at most one", not "exactly one".
(E.g., think of the "mutex" construct -- in the critical section being
protected by the mutex, there can be Thread 1, Thread 2, or none of them.)

So, beyond dropping the last sentence, I suggest to replace the one
marked with [*] with the following, for clarity:

    At most one of the following two fields may be set to a value
    different from -1:

With this update, for this patch:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
