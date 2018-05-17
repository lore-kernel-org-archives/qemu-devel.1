Received: from eggs.gnu.org ([2001:4830:134:3::10]:46447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJDnk-0002EB-1v
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJDnf-0003X1-4b
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:58:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fJDnf-0003Wp-0b
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:58:11 -0400
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
	<20180515123007.10164-2-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e40ca851-65db-36d8-938a-389e00c1fc57@redhat.com>
Date: Thu, 17 May 2018 09:58:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180515123007.10164-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 1/4] ovmf: add and link with
 Tcg2PhysicalPresenceLibNull when !TPM2_ENABLE
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
> This NULL library will let us call
> Tcg2PhysicalPresenceLibProcessRequest() unconditionally from
> BdsPlatform when building without TPM2_ENABLE.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  .../DxeTcg2PhysicalPresenceLib.c              | 26 ++++++++++++++
>  .../DxeTcg2PhysicalPresenceLib.inf            | 34 +++++++++++++++++++
>  OvmfPkg/OvmfPkgIa32.dsc                       |  2 ++
>  OvmfPkg/OvmfPkgIa32X64.dsc                    |  2 ++
>  OvmfPkg/OvmfPkgX64.dsc                        |  2 ++
>  5 files changed, 66 insertions(+)
>  create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2=
PhysicalPresenceLib.c
>  create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2=
PhysicalPresenceLib.inf
>=20
> diff --git a/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2Physica=
lPresenceLib.c b/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2Physi=
calPresenceLib.c
> new file mode 100644
> index 000000000000..0b8b98410315
> --- /dev/null
> +++ b/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2PhysicalPresen=
ceLib.c
> @@ -0,0 +1,26 @@
> +/** @file
> +  NULL Tcg2PhysicalPresenceLib library instance
> +
> +  Copyright (c) 2018, Red Hat, Inc.
> +  Copyright (c) 2013 - 2016, Intel Corporation. All rights reserved.<B=
R>
> +  This program and the accompanying materials
> +  are licensed and made available under the terms and conditions of th=
e BSD License
> +  which accompanies this distribution.  The full text of the license m=
ay be found at
> +  http://opensource.org/licenses/bsd-license.php
> +
> +  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS=
,
> +  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR=
 IMPLIED.
> +
> +**/
> +
> +#include "PiDxe.h"

(1) Can you drop this #include?

> +#include <Library/Tcg2PhysicalPresenceLib.h>
> +
> +VOID
> +EFIAPI
> +Tcg2PhysicalPresenceLibProcessRequest (
> +  IN      TPM2B_AUTH                     *PlatformAuth  OPTIONAL
> +  )
> +{
> +    return;
> +}

(2) Indentation.

Better yet: please replace the "return" statement with a comment:

  //
  // do nothing
  //

> diff --git a/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2Physica=
lPresenceLib.inf b/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2Phy=
sicalPresenceLib.inf
> new file mode 100644
> index 000000000000..e6f6239e1e00
> --- /dev/null
> +++ b/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/DxeTcg2PhysicalPresen=
ceLib.inf
> @@ -0,0 +1,34 @@
> +## @file
> +#  NULL Tcg2PhysicalPresenceLib library instance
> +#
> +#  In SecurityPkg, this library will check and execute TPM 1.2 request
> +#  from OS or BIOS. The request may ask for user confirmation before
> +#  execution. This Library will also lock TPM physical presence at
> +#  last.

(3) The approach on this comment is generally OK, but the specific text
originates from
"SecurityPkg/Library/DxeTcgPhysicalPresenceLib/DxeTcgPhysicalPresenceLib.=
inf".
I think we should update the comment from the TPM2 variant, namely
"SecurityPkg/Library/DxeTcg2PhysicalPresenceLib/DxeTcg2PhysicalPresenceLi=
b.inf".

Thus, I suggest the following comment:

"Under SecurityPkg, the corresponding library instance will check and
execute TPM 2.0 request from OS or BIOS; the request may ask for user
confirmation before execution. This Null instance implements a no-op
Tcg2PhysicalPresenceLibProcessRequest(), without user interaction."

> +#
> +# Copyright (C) 2018, Red Hat, Inc.
> +# Copyright (c) 2009 - 2015, Intel Corporation. All rights reserved.<B=
R>

(4) Same comment applies to the Intel copyright notice: from the TCG2
variant, this should come as

"Copyright (c) 2013 - 2016, Intel Corporation. All rights reserved.<BR>"

> +# This program and the accompanying materials
> +# are licensed and made available under the terms and conditions of th=
e BSD License
> +# which accompanies this distribution. The full text of the license ma=
y be found at
> +# http://opensource.org/licenses/bsd-license.php
> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS=
,
> +# WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR=
 IMPLIED.
> +#
> +##
> +
> +[Defines]
> +  INF_VERSION                    =3D 0x00010005
> +  BASE_NAME                      =3D DxeTcg2PhysicalPresenceLibNull
> +  FILE_GUID                      =3D 2A6BA243-DC22-42D8-9C3D-AE3728DC7=
AFA
> +  MODULE_TYPE                    =3D DXE_DRIVER
> +  VERSION_STRING                 =3D 1.0
> +  LIBRARY_CLASS                  =3D Tcg2PhysicalPresenceLib|DXE_DRIVE=
R DXE_RUNTIME_DRIVER DXE_SAL_DRIVER UEFI_APPLICATION UEFI_DRIVER
> +
> +[Sources]
> +  DxeTcg2PhysicalPresenceLib.c
> +
> +[Packages]
> +  MdePkg/MdePkg.dec
> +  MdeModulePkg/MdeModulePkg.dec

(5) I think you can drop "MdeModulePkg/MdeModulePkg.dec". (MdePkg.dec is
needed by all modules, and SecurityPkg.dec below is needed for the lib
class header; so those are OK).

> +  SecurityPkg/SecurityPkg.dec
> diff --git a/OvmfPkg/OvmfPkgIa32.dsc b/OvmfPkg/OvmfPkgIa32.dsc
> index 2d6c4c4615b6..6c361b73cd55 100644
> --- a/OvmfPkg/OvmfPkgIa32.dsc
> +++ b/OvmfPkg/OvmfPkgIa32.dsc
> @@ -208,6 +208,8 @@ [LibraryClasses]
>    Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
>    Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceL=
ib/DxeTcg2PhysicalPresenceLib.inf
>    Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendor=
LibNull.inf
> +!else
> +  Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/=
DxeTcg2PhysicalPresenceLib.inf
>  !endif
> =20
>  [LibraryClasses.common]
> diff --git a/OvmfPkg/OvmfPkgIa32X64.dsc b/OvmfPkg/OvmfPkgIa32X64.dsc
> index 43158c5f0627..62a6075a671d 100644
> --- a/OvmfPkg/OvmfPkgIa32X64.dsc
> +++ b/OvmfPkg/OvmfPkgIa32X64.dsc
> @@ -213,6 +213,8 @@ [LibraryClasses]
>    Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
>    Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceL=
ib/DxeTcg2PhysicalPresenceLib.inf
>    Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendor=
LibNull.inf
> +!else
> +  Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/=
DxeTcg2PhysicalPresenceLib.inf
>  !endif
> =20
>  [LibraryClasses.common]
> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index d1fdf7c307c2..cbab1aa328c6 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -213,6 +213,8 @@ [LibraryClasses]
>    Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
>    Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceL=
ib/DxeTcg2PhysicalPresenceLib.inf
>    Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendor=
LibNull.inf
> +!else
> +  Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/=
DxeTcg2PhysicalPresenceLib.inf
>  !endif
> =20
>  [LibraryClasses.common]
>=20

Thanks!
Laszlo
