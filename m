Received: from eggs.gnu.org ([2001:4830:134:3::10]:40888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fddi2-0003kP-1g
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fddi1-0007Xi-7W
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:40:46 -0400
References: <1531409463-3843-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <93c705fe-e569-1e0e-3a10-8ef9f49745ba@redhat.com>
Date: Thu, 12 Jul 2018 17:40:35 +0200
MIME-Version: 1.0
In-Reply-To: <1531409463-3843-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Fix crashes with introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 12/07/2018 17:30, Thomas Huth wrote:
> As discovered recently, you can crash QEMU with a lot of devices
> that do not get the reference counting of child objects right.
> You just have to run 'device-list-properties' and call 'info qtree'
> afterwards.
> This patch series fixes a bunch of these problems in the ARM code.
> I did not fix all problems yet, since it is quite time consuming
> and I first want to get some feedback whether this is the right
> way to go or not.

Patches 1-3 look like the way to go to me.

(FWIW, this is indeed an instance of the bug that Eduardo envisioned:
you have a reference to the inner object, and it becomes invalid after
the outer object is freed.  However, in this case the reference is
unnecessary so this is the right fix).

Thanks,

Paolo

> Thomas Huth (5):
>   qom/object: Add a new function object_initialize_as_child()
>   hw/core/sysbus: Add a function for creating and attaching an object
>   hw/arm/bcm2836: Fix crash with device_add bcm2837 on unsupported
>     machines
>   hw/arm/armv7: Fix crash when introspecting the "iotkit" device
>   hw/cpu/a15mpcore: Fix introspection problem with the a15mpcore_priv
>     device
> 
>  hw/arm/armv7m.c       |  9 ++++---
>  hw/arm/bcm2836.c      | 19 +++++--------
>  hw/arm/iotkit.c       | 74 ++++++++++++++++++++++-----------------------------
>  hw/core/sysbus.c      |  8 ++++++
>  hw/cpu/a15mpcore.c    |  8 +++---
>  hw/intc/armv7m_nvic.c |  5 ++--
>  include/hw/sysbus.h   |  3 +++
>  include/qom/object.h  | 19 +++++++++++++
>  qom/object.c          | 14 ++++++++++
>  9 files changed, 93 insertions(+), 66 deletions(-)
> 
