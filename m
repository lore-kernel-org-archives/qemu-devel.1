Received: from eggs.gnu.org ([2001:4830:134:3::10]:34914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1ysO-0002sI-Bk
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1ysL-0005up-5f
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:03:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1ysK-0005uc-Sf
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:03:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AI2DnN046532
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:03:25 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgyvn4a97-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:03:24 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 14:03:23 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-19-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 14:03:22 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-19-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c28b1acd-ad34-29d1-88e6-48cf3419bbab@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/42] tpm-tis: remove tpm_tis.h header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com

On 10/09/2017 06:55 PM, Marc-Andr=C3=A9 Lureau wrote:
> The definitions are now private to TIS implementation.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


With that stray locty_number, introduced in previous patch, removed:

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_tis.h         | 94 ---------------------------------------=
---------
>   hw/tpm/tpm_passthrough.c |  1 -
>   hw/tpm/tpm_tis.c         | 72 ++++++++++++++++++++++++++++++++++++-
>   3 files changed, 71 insertions(+), 96 deletions(-)
>   delete mode 100644 hw/tpm/tpm_tis.h
>
> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> deleted file mode 100644
> index 30e35eef64..0000000000
> --- a/hw/tpm/tpm_tis.h
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -/*
> - * tpm_tis.h - QEMU's TPM TIS interface emulator
> - *
> - * Copyright (C) 2006, 2010-2013 IBM Corporation
> - *
> - * Authors:
> - *  Stefan Berger <stefanb@us.ibm.com>
> - *  David Safford <safford@us.ibm.com>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> - * See the COPYING file in the top-level directory.
> - *
> - * Implementation of the TIS interface according to specs found at
> - * http://www.trustedcomputinggroup.org
> - *
> - */
> -#ifndef TPM_TPM_TIS_H
> -#define TPM_TPM_TIS_H
> -
> -#include "hw/isa/isa.h"
> -#include "hw/acpi/tpm.h"
> -#include "qemu-common.h"
> -
> -#define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
> -#define TPM_TIS_LOCALITY_SHIFT      12
> -#define TPM_TIS_NO_LOCALITY         0xff
> -
> -#define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
> -
> -#define TPM_TIS_BUFFER_MAX          4096
> -
> -typedef enum {
> -    TPM_TIS_STATE_IDLE =3D 0,
> -    TPM_TIS_STATE_READY,
> -    TPM_TIS_STATE_COMPLETION,
> -    TPM_TIS_STATE_EXECUTION,
> -    TPM_TIS_STATE_RECEPTION,
> -} TPMTISState;
> -
> -typedef struct TPMSizedBuffer {
> -    uint32_t size;
> -    uint8_t  *buffer;
> -} TPMSizedBuffer;
> -
> -/* locality data  -- all fields are persisted */
> -typedef struct TPMLocality {
> -    TPMTISState state;
> -    uint8_t access;
> -    uint32_t sts;
> -    uint32_t iface_id;
> -    uint32_t inte;
> -    uint32_t ints;
> -
> -    uint16_t w_offset;
> -    uint16_t r_offset;
> -    TPMSizedBuffer w_buffer;
> -    TPMSizedBuffer r_buffer;
> -} TPMLocality;
> -
> -typedef struct TPMTISEmuState {
> -    QEMUBH *bh;
> -    uint32_t offset;
> -    uint8_t buf[TPM_TIS_BUFFER_MAX];
> -
> -    uint8_t active_locty;
> -    uint8_t aborting_locty;
> -    uint8_t next_locty;
> -
> -    TPMLocality loc[TPM_TIS_NUM_LOCALITIES];
> -
> -    qemu_irq irq;
> -    uint32_t irq_num;
> -} TPMTISEmuState;
> -
> -/* overall state of the TPM interface */
> -struct TPMState {
> -    ISADevice busdev;
> -    MemoryRegion mmio;
> -
> -    union {
> -        TPMTISEmuState tis;
> -    } s;
> -
> -    uint8_t     locty_number;
> -    TPMBackendCmd cmd;
> -
> -    char *backend;
> -    TPMBackend *be_driver;
> -    TPMVersion be_tpm_version;
> -};
> -
> -#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> -
> -#endif /* TPM_TPM_TIS_H */
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 93d72b8e9e..4274164a61 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -31,7 +31,6 @@
>   #include "hw/hw.h"
>   #include "hw/i386/pc.h"
>   #include "qapi/clone-visitor.h"
> -#include "tpm_tis.h"
>   #include "tpm_util.h"
>
>   #define DEBUG_TPM 0
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index ad2845622e..73cda41dc6 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -23,6 +23,7 @@
>    */
>
>   #include "qemu/osdep.h"
> +#include "hw/isa/isa.h"
>   #include "sysemu/tpm_backend.h"
>   #include "tpm_int.h"
>   #include "sysemu/block-backend.h"
> @@ -30,10 +31,79 @@
>   #include "hw/hw.h"
>   #include "hw/i386/pc.h"
>   #include "hw/pci/pci_ids.h"
> -#include "tpm_tis.h"
>   #include "qapi/error.h"
>   #include "qemu-common.h"
>   #include "qemu/main-loop.h"
> +#include "hw/acpi/tpm.h"
> +
> +#define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
> +#define TPM_TIS_LOCALITY_SHIFT      12
> +#define TPM_TIS_NO_LOCALITY         0xff
> +
> +#define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
> +
> +#define TPM_TIS_BUFFER_MAX          4096
> +
> +typedef enum {
> +    TPM_TIS_STATE_IDLE =3D 0,
> +    TPM_TIS_STATE_READY,
> +    TPM_TIS_STATE_COMPLETION,
> +    TPM_TIS_STATE_EXECUTION,
> +    TPM_TIS_STATE_RECEPTION,
> +} TPMTISState;
> +
> +typedef struct TPMSizedBuffer {
> +    uint32_t size;
> +    uint8_t  *buffer;
> +} TPMSizedBuffer;
> +
> +/* locality data  -- all fields are persisted */
> +typedef struct TPMLocality {
> +    TPMTISState state;
> +    uint8_t access;
> +    uint32_t sts;
> +    uint32_t iface_id;
> +    uint32_t inte;
> +    uint32_t ints;
> +
> +    uint16_t w_offset;
> +    uint16_t r_offset;
> +    TPMSizedBuffer w_buffer;
> +    TPMSizedBuffer r_buffer;
> +} TPMLocality;
> +
> +typedef struct TPMTISEmuState {
> +    QEMUBH *bh;
> +    uint32_t offset;
> +    uint8_t buf[TPM_TIS_BUFFER_MAX];
> +
> +    uint8_t active_locty;
> +    uint8_t aborting_locty;
> +    uint8_t next_locty;
> +
> +    TPMLocality loc[TPM_TIS_NUM_LOCALITIES];
> +
> +    qemu_irq irq;
> +    uint32_t irq_num;
> +} TPMTISEmuState;
> +
> +struct TPMState {
> +    ISADevice busdev;
> +    MemoryRegion mmio;
> +
> +    union {
> +        TPMTISEmuState tis;
> +    } s;
> +
> +    uint8_t     locty_number;
> +    TPMBackendCmd cmd;
> +
> +    char *backend;
> +    TPMBackend *be_driver;
> +    TPMVersion be_tpm_version;
> +};
> +
> +#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
>
>   #define DEBUG_TIS 0
>
