Received: from eggs.gnu.org ([2001:4830:134:3::10]:43196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fL8FR-0004wt-Fo
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fL8FM-0001BE-3n
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:26:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fL8FL-0001B6-Uw
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:26:40 -0400
References: <20180518122304.31020-1-marcandre.lureau@redhat.com>
	<20180518122304.31020-4-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <92a15a53-49e2-76ea-848b-9aaaa43519c4@redhat.com>
Date: Tue, 22 May 2018 16:26:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180518122304.31020-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [edk2] [PATCH v3 3/4] OvmfPkg: add
 Tcg2PhysicalPresenceLibQemu
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

On 05/18/18 14:23, marcandre.lureau@redhat.com wrote:

> +/**
> +  Initializes QEMU PPI memory region.
> +
> +  @retval EFI_SUCCESS           Operation completed successfully.
> +  @retval EFI_PROTOCOL_ERROR    PPI address is invalid.
> +**/
> +STATIC
> +EFI_STATUS
> +QemuTpmInitPPI (
> +  VOID
> +  )
> +{
> +  EFI_STATUS                      Status;
> +  QEMU_FWCFG_TPM_CONFIG           Config;
> +  EFI_PHYSICAL_ADDRESS            PpiAddress64;
> +  EFI_GCD_MEMORY_SPACE_DESCRIPTOR Descriptor;
> +  int                             i;

(1) This should be "UINTN Idx".

> +
> +  if (mPpi != NULL) {
> +    return EFI_SUCCESS;
> +  }
> +
> +  Status = QemuTpmReadConfig (&Config);
> +  if (EFI_ERROR (Status)) {
> +    return Status;
> +  }
> +
> +  mPpi = (QEMU_TPM_PPI *)(UINTN)Config.PpiAddress;
> +  if (mPpi == NULL) {
> +    return EFI_PROTOCOL_ERROR;
> +  }
> +
> +  DEBUG ((DEBUG_INFO, "[TPM2PP] mPpi=%p version=%d\n", mPpi, Config.TpmVersion));
> +
> +  PpiAddress64 = (UINTN)mPpi;
> +  if ((PpiAddress64 & ~(UINT64)EFI_PAGE_MASK) !=
> +      ((PpiAddress64 + sizeof *mPpi - 1) & ~(UINT64)EFI_PAGE_MASK)) {
> +    DEBUG ((DEBUG_ERROR, "[TPM2PP] mPpi crosses a page boundary\n"));
> +    return EFI_PROTOCOL_ERROR;
> +  }
> +
> +  Status = gDS->GetMemorySpaceDescriptor (PpiAddress64, &Descriptor);
> +  if (Status != EFI_SUCCESS && Status != EFI_NOT_FOUND) {
> +    ASSERT_EFI_ERROR (Status);
> +    return EFI_PROTOCOL_ERROR;
> +  }
> +  if (Status == EFI_SUCCESS && (
> +        Descriptor.GcdMemoryType != EfiGcdMemoryTypeMemoryMappedIo &&
> +        Descriptor.GcdMemoryType != EfiGcdMemoryTypeNonExistent)) {
> +    DEBUG ((DEBUG_ERROR, "[TPM2PP] mPpi has an invalid memory type\n"));
> +    return EFI_PROTOCOL_ERROR;
> +  }

(2) In edk2 we generally don't compare EFI_STATUS variables against
EFI_SUCCESS, instead we write [!]EFI_ERROR (Status). Whether that's
easier or harder to understand is anyone's guess, but either way that's
the idiom.

(3) The indentation / parentheses around "Descriptor.GcdMemoryType"
aren't idiomatic.

(4) I think the new checks introduce a new logic bug in this patch -- if
we return EFI_PROTOCOL_ERROR, we should re-set mPpi to NULL. Otherwise
the next call to QemuTpmInitPPI() will succeed, using a bogus mPpi
value.

> +
> +  for (i = 0; i < sizeof (mPpi->Func); i++) {
> +    mPpi->Func[i] = 0;
> +  }

(5) Functionally this is OK, because mPpi->Func has UINT8 elements;
however we should really use ARRAY_SIZE() here.

> +  if (Config.TpmVersion == QEMU_TPM_VERSION_2) {
> +    mPpi->Func[TCG2_PHYSICAL_PRESENCE_NO_ACTION] = TPM_PPI_FLAGS;
> +    mPpi->Func[TCG2_PHYSICAL_PRESENCE_CLEAR] = TPM_PPI_FLAGS;
> +    mPpi->Func[TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR] = TPM_PPI_FLAGS;
> +    mPpi->Func[TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_2] = TPM_PPI_FLAGS;
> +    mPpi->Func[TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_3] = TPM_PPI_FLAGS;
> +    mPpi->Func[TCG2_PHYSICAL_PRESENCE_SET_PCR_BANKS] = TPM_PPI_FLAGS;
> +    mPpi->Func[TCG2_PHYSICAL_PRESENCE_CHANGE_EPS] = TPM_PPI_FLAGS;
> +    mPpi->Func[TCG2_PHYSICAL_PRESENCE_LOG_ALL_DIGESTS] = TPM_PPI_FLAGS;
> +    mPpi->Func[TCG2_PHYSICAL_PRESENCE_ENABLE_BLOCK_SID] = TPM_PPI_FLAGS;
> +    mPpi->Func[TCG2_PHYSICAL_PRESENCE_DISABLE_BLOCK_SID] = TPM_PPI_FLAGS;
> +  }
> +
> +  if (mPpi->In == 0) {
> +    mPpi->In = 1;
> +    mPpi->Request = TCG2_PHYSICAL_PRESENCE_NO_ACTION;
> +    mPpi->LastRequest = TCG2_PHYSICAL_PRESENCE_NO_ACTION;
> +    mPpi->NextStep = TCG2_PHYSICAL_PRESENCE_NO_ACTION;
> +  }
> +
> +  return EFI_SUCCESS;
> +}

Thus, I've squashed the following patch into yours, and build-tested it:

> diff --git a/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2PhysicalPresenceLib.c b/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2PhysicalPresenceLib.c
> index cc4046228ba3..52913f573676 100644
> --- a/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2PhysicalPresenceLib.c
> +++ b/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2PhysicalPresenceLib.c
> @@ -99,7 +99,7 @@ QemuTpmInitPPI (
>    QEMU_FWCFG_TPM_CONFIG           Config;
>    EFI_PHYSICAL_ADDRESS            PpiAddress64;
>    EFI_GCD_MEMORY_SPACE_DESCRIPTOR Descriptor;
> -  int                             i;
> +  UINTN                           Idx;
>
>    if (mPpi != NULL) {
>      return EFI_SUCCESS;
> @@ -121,23 +121,23 @@ QemuTpmInitPPI (
>    if ((PpiAddress64 & ~(UINT64)EFI_PAGE_MASK) !=
>        ((PpiAddress64 + sizeof *mPpi - 1) & ~(UINT64)EFI_PAGE_MASK)) {
>      DEBUG ((DEBUG_ERROR, "[TPM2PP] mPpi crosses a page boundary\n"));
> -    return EFI_PROTOCOL_ERROR;
> +    goto InvalidPpiAddress;
>    }
>
>    Status = gDS->GetMemorySpaceDescriptor (PpiAddress64, &Descriptor);
> -  if (Status != EFI_SUCCESS && Status != EFI_NOT_FOUND) {
> +  if (EFI_ERROR (Status) && Status != EFI_NOT_FOUND) {
>      ASSERT_EFI_ERROR (Status);
> -    return EFI_PROTOCOL_ERROR;
> +    goto InvalidPpiAddress;
>    }
> -  if (Status == EFI_SUCCESS && (
> -        Descriptor.GcdMemoryType != EfiGcdMemoryTypeMemoryMappedIo &&
> -        Descriptor.GcdMemoryType != EfiGcdMemoryTypeNonExistent)) {
> +  if (!EFI_ERROR (Status) &&
> +      (Descriptor.GcdMemoryType != EfiGcdMemoryTypeMemoryMappedIo &&
> +       Descriptor.GcdMemoryType != EfiGcdMemoryTypeNonExistent)) {
>      DEBUG ((DEBUG_ERROR, "[TPM2PP] mPpi has an invalid memory type\n"));
> -    return EFI_PROTOCOL_ERROR;
> +    goto InvalidPpiAddress;
>    }
>
> -  for (i = 0; i < sizeof (mPpi->Func); i++) {
> -    mPpi->Func[i] = 0;
> +  for (Idx = 0; Idx < ARRAY_SIZE (mPpi->Func); Idx++) {
> +    mPpi->Func[Idx] = 0;
>    }
>    if (Config.TpmVersion == QEMU_TPM_VERSION_2) {
>      mPpi->Func[TCG2_PHYSICAL_PRESENCE_NO_ACTION] = TPM_PPI_FLAGS;
> @@ -160,6 +160,10 @@ QemuTpmInitPPI (
>    }
>
>    return EFI_SUCCESS;
> +
> +InvalidPpiAddress:
> +  mPpi = NULL;
> +  return EFI_PROTOCOL_ERROR;
>  }

With that:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
