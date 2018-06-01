Received: from eggs.gnu.org ([2001:4830:134:3::10]:56636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOo4m-0000sV-IT
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOo4i-0005UF-Hh
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:42:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fOo4i-0005Oz-CD
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:42:52 -0400
Date: Fri, 1 Jun 2018 18:42:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180601174242.GD2531@work-vm>
References: <CAFEAcA8Khsu3HTPbsJW-gBvbzrzJkb=z3tpmELwGyw3rQObJFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Khsu3HTPbsJW-gBvbzrzJkb=z3tpmELwGyw3rQObJFA@mail.gmail.com>
Subject: Re: [Qemu-devel] unique (or otherwise) RAM block names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
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

For device we also have a nmumerical 'instance_id' parameter that
some odd setups use.

> How can we make this work (preferably without breaking migration
> compat for existing devices) ?
> 
> (Sysbus isn't the only bus that doesn't implement get_dev_path,
> it's just the first one I found.)

My preference would be that for new machine types we should
define get_dev_path on the busses that are missing it.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
