Received: from eggs.gnu.org ([209.51.188.92]:44464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hJwDI-0006O4-QV
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hJwDH-0000eY-Oy
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:28:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hJwDH-0000dK-GW
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:28:07 -0400
References: <20190425200051.19906-1-ehabkost@redhat.com>
	<20190425200051.19906-4-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bbdf7fb5-8f68-582b-2c57-5cf0a522237d@redhat.com>
Date: Fri, 26 Apr 2019 10:27:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190425200051.19906-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] qdev: Don't compile hotplug code in
 user-mode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Like Xu <like.xu@linux.intel.com>

On 25/04/19 22:00, Eduardo Habkost wrote:
> diff --git a/hw/core/qdev-hotplug-stubs.c b/hw/core/qdev-hotplug-stubs.c
> new file mode 100644
> index 0000000000..c710f23388
> --- /dev/null
> +++ b/hw/core/qdev-hotplug-stubs.c
> @@ -0,0 +1,44 @@
> +/*
> + * qdev hotplug handler stubs (for user-mode emulation and unit tests)

Can you explain the issue with unit tests in the commit message?

> + *  Copyright (c) 2019 Red Hat Inc
> + *
> + * Authors:
> + *  Eduardo Habkost <ehabkost@redhat.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev-core.h"
> +#include "hw/hotplug.h"
> +
> +HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
> +{
> +    return NULL;
> +}
> +
> +void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
> +                              DeviceState *plugged_dev,
> +                              Error **errp)
> +{
> +    assert(plug_handler == NULL);
> +}
> +
> +void hotplug_handler_plug(HotplugHandler *plug_handler,
> +                          DeviceState *plugged_dev,
> +                          Error **errp)
> +{
> +    assert(plug_handler == NULL);
> +}

Would it work if you instead make these functions (and the others in
hw/core/hotplug.c) inlines in include/hw/hotplug.h?

Then all that remains is qdev_get_hotplug_handler.

Paolo
