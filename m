Received: from eggs.gnu.org ([2001:4830:134:3::10]:43641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d0T8u-0000OA-D5
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d0T8t-00031r-MT
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:26:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170414083717.13641-1-lvivier@redhat.com>
	<20170414083717.13641-4-lvivier@redhat.com>
Date: Tue, 18 Apr 2017 15:25:55 +0200
In-Reply-To: <20170414083717.13641-4-lvivier@redhat.com> (Laurent Vivier's
	message of "Fri, 14 Apr 2017 10:37:16 +0200")
Message-ID: <87lgqx3l0c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/4] versatile: remove
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Antony Pavlov <antonynpavlov@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

Laurent Vivier <lvivier@redhat.com> writes:

> cannot_destroy_with_object_finalize_yet was added by 4c315c2
> ("qdev: Protect device-list-properties against broken devices")
> because "realview_pci" and "versatile_pci" were hanging
> during "device-list-properties" cleanup (an infinite loop in
> bus_unparent()).
>
> We have this problem because the child is not removed from
> the list of the PCI bus child because it has no defined parent:

s/child/children/

> qdev_set_parent_bus() set the device parent_bus pointer to bus, and
> adds the device in the bus children list, but doesn't update the
> device parent pointer.
>
> To fix the problem, move all the involved parts to the realize function.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

The devices aren't unpluggable.  There is no unrealize().  How work
needs to be spread between init and realize isn't obvious to me in
general.  I can see this work done both in init and in realize.  I
figure the move is okay.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
