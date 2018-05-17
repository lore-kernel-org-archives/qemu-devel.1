Received: from eggs.gnu.org ([2001:4830:134:3::10]:48383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJE00-0000N1-32
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJDzw-0001a6-0t
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:10:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fJDzv-0001a0-SR
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:10:51 -0400
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
	<20180515123007.10164-3-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <48283244-9534-24b8-263f-47d5fa9ff675@redhat.com>
Date: Thu, 17 May 2018 10:10:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180515123007.10164-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 2/4] ovmf: add QemuTpm.h header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 05/15/18 14:30, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Add some common macros and type definitions corresponding to the QEMU
> TPM interface.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/Include/IndustryStandard/QemuTpm.h | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 OvmfPkg/Include/IndustryStandard/QemuTpm.h
>=20
> diff --git a/OvmfPkg/Include/IndustryStandard/QemuTpm.h b/OvmfPkg/Inclu=
de/IndustryStandard/QemuTpm.h
> new file mode 100644
> index 000000000000..054cf79374b5
> --- /dev/null
> +++ b/OvmfPkg/Include/IndustryStandard/QemuTpm.h
> @@ -0,0 +1,67 @@
> +/** @file
> +  Macro and type definitions corresponding to the QEMU TPM interface.
> +
> +  Refer to "docs/specs/tpm.txt" in the QEMU source directory.
> +
> +  Copyright (C) 2018, Red Hat, Inc.
> +  Copyright (c) 2018, IBM Corporation. All rights reserved.<BR>
> +
> +  This program and the accompanying materials are licensed and made av=
ailable
> +  under the terms and conditions of the BSD License which accompanies =
this
> +  distribution. The full text of the license may be found at
> +  http://opensource.org/licenses/bsd-license.php
> +
> +  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS=
, WITHOUT
> +  WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED=
.
> +**/
> +
> +#ifndef __QEMU_TPM_H__
> +#define __QEMU_TPM_H__
> +
> +#include <Base.h>
> +
> +/* whether function is blocked by BIOS settings; bits 0, 1, 2 */
> +#define QEMU_TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
> +#define QEMU_TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
> +#define QEMU_TPM_PPI_FUNC_BLOCKED             (2 << 0)
> +#define QEMU_TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
> +#define QEMU_TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
> +#define QEMU_TPM_PPI_FUNC_MASK                (7 << 0)
> +
> +//
> +// The following structure is shared between firmware and ACPI.
> +//
> +#pragma pack (1)
> +typedef struct {
> +  UINT8 Func[256];           /* func */
> +  UINT8 In;                  /* ppin */
> +  UINT32 Ip;                 /* ppip */
> +  UINT32 Response;           /* pprp */
> +  UINT32 Request;            /* pprq */
> +  UINT32 RequestParameter;   /* pprm */
> +  UINT32 LastRequest;        /* lppr */
> +  UINT32 FRet;               /* fret */
> +  UINT8 Res1[0x40];          /* res1 */
> +  UINT8 NextStep;            /* next_step */
> +} QEMU_TPM_PPI;
> +#pragma pack ()
> +
> +//
> +// The following structure is for the fw_cfg etc/tpm/config file.
> +//
> +#pragma pack (1)
> +typedef struct {
> +  UINT32 PpiAddress;
> +  UINT8 TpmVersion;
> +  UINT8 PpiVersion;
> +} QEMU_FWCFG_TPM_CONFIG;
> +#pragma pack ()
> +
> +#define QEMU_TPM_VERSION_UNSPEC    0
> +#define QEMU_TPM_VERSION_1_2       1
> +#define QEMU_TPM_VERSION_2         2
> +
> +#define QEMU_TPM_PPI_VERSION_NONE  0
> +#define QEMU_TPM_PPI_VERSION_1_30  1
> +
> +#endif
>=20

(1) Please update the subject line as discussed earlier; for example:

OvmfPkg/IndustryStandard: add QemuTpm.h header

(2) Please convert the file to CRLF.

(3) Please use the "// ..." comment style near the fields of QEMU_TPM_PPI=
.

(4) Please align the member identifiers in each of QEMU_TPM_PPI and
QEMU_FWCFG_TPM_CONFIG -- in practice this means inserting another space
char after each "UINT8" type name.

With those changes:

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
