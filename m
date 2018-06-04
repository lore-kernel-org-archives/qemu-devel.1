Received: from eggs.gnu.org ([2001:4830:134:3::10]:56791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fPouU-00022G-TO
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fPouP-0004VL-6i
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:48:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fPouP-0004SY-1A
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:48:25 -0400
References: <CAFEAcA8Khsu3HTPbsJW-gBvbzrzJkb=z3tpmELwGyw3rQObJFA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3e70445d-dc3c-0cf0-af56-934600f0511d@redhat.com>
Date: Mon, 4 Jun 2018 14:48:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Khsu3HTPbsJW-gBvbzrzJkb=z3tpmELwGyw3rQObJFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] unique (or otherwise) RAM block names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 06/01/18 19:34, Peter Maydell wrote:
> I was going through trying to fix up various devices that currently
> fail to register RAM blocks for migration, or register the RAM
> block globally rather than locally, and I ran into something
> unexpected.
> 
> We name RAM blocks in qemu_ram_set_idstr() like this:
>   * if the user passed a device pointer, then call qdev_get_dev_path(),
>     and if that returns non-NULL, use "path/name"
>   * otherwise, use "name"
> 
> Unfortunately, it turns out that there's no guarantee that
> qdev_get_dev_path() will return anything useful. If the device
> isn't on a bus, or the bus's class doesn't implement the get_dev_path
> method, then it'll return NULL.
> 
> In particular, this means that if you create what you expect to
> be a local-to-this-device RAM memory region in a SysBusDevice,
> then (because SysBus doesn't implement get_dev_path), there is
> no per-device qualification added to the region name, and so the
> code silently creates a globally-namespaced RAM region.
> Trying to create multiple instances of the device therefore fails.
> 
> How can we make this work (preferably without breaking migration
> compat for existing devices) ?
> 
> (Sysbus isn't the only bus that doesn't implement get_dev_path,
> it's just the first one I found.)

Related: commit f58b39d2d5b6 ("virtio-mmio: format transport base
address in BusClass.get_dev_path", 2016-07-14).

Thanks
Laszlo
