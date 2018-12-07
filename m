Received: from eggs.gnu.org ([2001:4830:134:3::10]:33705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gVJgy-000802-CO
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gVJgo-0007Ky-6n
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:13:32 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gVJgm-0007H8-GR
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:13:20 -0500
Received: by mail-ot1-x343.google.com with SMTP id e12so4450845otl.5
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 09:13:20 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181207165103.3992-1-philmd@redhat.com>
	<20181207165103.3992-4-philmd@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <83bb467c-6d0f-f97b-5ae2-a1ec99f6aa47@acm.org>
Date: Fri, 7 Dec 2018 11:13:16 -0600
MIME-Version: 1.0
In-Reply-To: <20181207165103.3992-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/smbios: Remove "smbios_ipmi.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 12/7/18 10:51 AM, Philippe Mathieu-Daudé wrote:
> This header only declare a single function: smbios_build_type_38_table().
> We already have a header that declares such functions: "smbios_build.h".
> Move the declaration and remove the header.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

The two IPMI changes look good to me, a definite improvement. I'm not
sure of the value of having two separate patches, as a single patch would
not be any bigger than the second patch and I don't see any clarity two
patches bring.  But fine either way.

Reviewed-by: Corey Minyard <cminyard@mvista.com>


> ---
>   hw/smbios/smbios.c              |  1 -
>   hw/smbios/smbios_build.h        |  4 ++++
>   hw/smbios/smbios_ipmi.h         | 15 ---------------
>   hw/smbios/smbios_type_38-stub.c |  2 +-
>   hw/smbios/smbios_type_38.c      |  1 -
>   5 files changed, 5 insertions(+), 18 deletions(-)
>   delete mode 100644 hw/smbios/smbios_ipmi.h
>
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 30bd4731cf..9d737642cb 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -28,7 +28,6 @@
>   #include "hw/loader.h"
>   #include "exec/cpu-common.h"
>   #include "smbios_build.h"
> -#include "smbios_ipmi.h"
>   
>   /* legacy structures and constants for <= 2.0 machines */
>   struct smbios_header {
> diff --git a/hw/smbios/smbios_build.h b/hw/smbios/smbios_build.h
> index 93b360d520..56b5a1e3f3 100644
> --- a/hw/smbios/smbios_build.h
> +++ b/hw/smbios/smbios_build.h
> @@ -3,6 +3,7 @@
>    *
>    * Copyright (C) 2009 Hewlett-Packard Development Company, L.P.
>    * Copyright (C) 2013 Red Hat, Inc.
> + * Copyright (c) 2015,2016 Corey Minyard, MontaVista Software, LLC
>    *
>    * Authors:
>    *  Alex Williamson <alex.williamson@hp.com>
> @@ -96,4 +97,7 @@ extern unsigned smbios_table_cnt;
>           smbios_table_cnt++;                                               \
>       } while (0)
>   
> +/* IPMI SMBIOS firmware handling */
> +void smbios_build_type_38_table(void);
> +
>   #endif /* QEMU_SMBIOS_BUILD_H */
> diff --git a/hw/smbios/smbios_ipmi.h b/hw/smbios/smbios_ipmi.h
> deleted file mode 100644
> index 1c9aae38f2..0000000000
> --- a/hw/smbios/smbios_ipmi.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/*
> - * IPMI SMBIOS firmware handling
> - *
> - * Copyright (c) 2015,2016 Corey Minyard, MontaVista Software, LLC
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - * See the COPYING file in the top-level directory.
> - */
> -
> -#ifndef QEMU_SMBIOS_IPMI_H
> -#define QEMU_SMBIOS_IPMI_H
> -
> -void smbios_build_type_38_table(void);
> -
> -#endif /* QEMU_SMBIOS_IPMI_H */
> diff --git a/hw/smbios/smbios_type_38-stub.c b/hw/smbios/smbios_type_38-stub.c
> index fc4516bc8a..14b53d004b 100644
> --- a/hw/smbios/smbios_type_38-stub.c
> +++ b/hw/smbios/smbios_type_38-stub.c
> @@ -8,7 +8,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "smbios_ipmi.h"
> +#include "smbios_build.h"
>   
>   void smbios_build_type_38_table(void)
>   {
> diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
> index d84e87d608..a1ad28d059 100644
> --- a/hw/smbios/smbios_type_38.c
> +++ b/hw/smbios/smbios_type_38.c
> @@ -12,7 +12,6 @@
>   #include "hw/smbios/smbios.h"
>   #include "qemu/error-report.h"
>   #include "smbios_build.h"
> -#include "smbios_ipmi.h"
>   
>   /* SMBIOS type 38 - IPMI */
>   struct smbios_type_38 {
