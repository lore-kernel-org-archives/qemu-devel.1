Received: from eggs.gnu.org ([2001:4830:134:3::10]:37430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chVU7-00011z-HR
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chVU4-0000Df-Bz
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:05:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1chVU4-0000DS-3S
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:05:32 -0500
References: <20170223122025.10420-1-cornelia.huck@de.ibm.com>
	<20170223122025.10420-2-cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <64a9099a-717d-230c-fa58-5757186f5791@redhat.com>
Date: Sat, 25 Feb 2017 07:05:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170223122025.10420-2-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/5] elf-loader: Allow late loading of
 elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Farhan Ali <alifm@linux.vnet.ibm.com>, agraf@suse.de, borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com

On 23.02.2017 13:20, Cornelia Huck wrote:
> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>=20
> The current QEMU ROM infrastructure rejects late loading of ROMs.
> And ELFs are currently loaded as ROM, this prevents delayed loading
> of ELFs. So when loading ELF, allow the user to specify if ELF should
> be loaded as ROM or not.
>=20
> If an ELF is not loaded as ROM, then they are not restored on a
> guest reboot/reset and so its upto the user to handle the reloading.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/core/loader.c     | 17 +++++++++++++++--
>  include/hw/elf_ops.h | 13 +++++++++----
>  include/hw/loader.h  | 13 ++++++++++++-
>  3 files changed, 36 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index ee5abd6eb7..9d1af1f6f3 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -435,6 +435,19 @@ int load_elf_as(const char *filename,
>                  uint64_t *highaddr, int big_endian, int elf_machine,
>                  int clear_lsb, int data_swab, AddressSpace *as)
>  {
> +    return load_elf_ram(filename, translate_fn, translate_opaque,
> +                        pentry, lowaddr, highaddr, big_endian, elf_mac=
hine,
> +                        clear_lsb, data_swab, as, true);
> +}
> +
> +/* return < 0 if error, otherwise the number of bytes loaded in memory=
 */
> +int load_elf_ram(const char *filename,
> +                 uint64_t (*translate_fn)(void *, uint64_t),
> +                 void *translate_opaque, uint64_t *pentry, uint64_t *l=
owaddr,
> +                 uint64_t *highaddr, int big_endian, int elf_machine,
> +                 int clear_lsb, int data_swab, AddressSpace *as,
> +                 bool load_rom)
> +{
>      int fd, data_order, target_data_order, must_swab, ret =3D ELF_LOAD=
_FAILED;
>      uint8_t e_ident[EI_NIDENT];

<bikeshedpaintingsofeelfreetoignoreme>

The patch looks basically fine to me, but I think it's a little bit
confusing to have a function called load_elf_ram() which can also be
used to load ROMs with a load_rom=3D1 parameter. If I read
"load_elf_ram()", I'd expect a function that can only read ELFs to RAM.
So what about adding the "load_rom" parameter to load_elf_as() instead
and then making load_elf_ram() a wrapper function to that one with
load_rom=3D0 ? AFAICS there is only one additional caller to load_elf_as
(in the generic-loader), so the additional effort here should be OK, I
think.

</bikeshedpaintingsofeelfreetoignoreme>

 Thomas
