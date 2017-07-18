Received: from eggs.gnu.org ([2001:4830:134:3::10]:35964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dXTf4-0003RA-Sz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dXTf2-0005P4-8c
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:39:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dXTf1-0005OS-Up
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:39:40 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6IEaRSJ114355
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 10:39:38 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsh23vn5d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 10:39:38 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 08:39:37 -0600
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-9-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 10:39:33 -0400
MIME-Version: 1.0
In-Reply-To: <1500367747-8992-9-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <a15251e3-de79-dcf3-3db9-83dd4f5980bb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

On 07/18/2017 04:49 AM, Amarnath Valluri wrote:
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 64cecc3..41f0b7a 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,2 +1,3 @@
>   common-obj-$(CONFIG_TPM_TIS) += tpm_tis.o
>   common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o tpm_util.o
> +common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o tpm_util.o
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> new file mode 100644
> index 0000000..c90914c
> --- /dev/null
> +++ b/hw/tpm/tpm_emulator.c
> @@ -0,0 +1,973 @@
> +/*
> + *  emulator TPM driver
> + *
> + *  Copyright (c) 2017 Intel Corporation
> + *  Author: Amarnath Valluri <amarnath.valluri@intel.com>
> + *
> + *  Copyright (c) 2010 - 2013 IBM Corporation
> + *  Authors:
> + *    Stefan Berger <stefanb@us.ibm.com>
> + *
> + *  Copyright (C) 2011 IAIK, Graz University of Technology
> + *    Author: Andreas Niederl
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
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/sockets.h"
> +#include "io/channel-socket.h"
> +#include "sysemu/tpm_backend.h"
> +#include "tpm_int.h"
> +#include "hw/hw.h"
> +#include "hw/i386/pc.h"
> +#include "tpm_util.h"
> +#include "tpm_ioctl.h"
> +#include "migration/migration.h"

Missing: migration/blocker.h


     Stefan
