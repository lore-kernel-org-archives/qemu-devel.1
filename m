Received: from eggs.gnu.org ([2001:4830:134:3::10]:36048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gWiqy-00017n-NT
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gWiqt-00074R-KR
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:17:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gWiqt-00073q-7k
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:17:35 -0500
Date: Tue, 11 Dec 2018 14:17:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181211141732.GB23460@stefanha-x1.localdomain>
References: <1544049446-6359-1-git-send-email-liam.merwick@oracle.com>
	<1544049446-6359-3-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <1544049446-6359-3-git-send-email-liam.merwick@oracle.com>
Subject: Re: [Qemu-devel] [RFC 2/3] pc: Read PVH entry point from ELF note
 in kernel binary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, maran.wilson@oracle.com


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 10:37:25PM +0000, Liam Merwick wrote:
> From: Liam Merwick <Liam.Merwick@oracle.com>
>=20
> Add support to read the PVH Entry address from an ELF note in the
> uncompressed kernel binary (as defined by the x86/HVM direct boot ABI).
> This 32-bit entry point will be used by QEMU to load the kernel in the
> guest and jump into the kernel entry point.
>=20
> For now, a call to this function is added in pc_memory_init() to read the
> address - a future patch will use the entry point.
>=20
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>  hw/i386/pc.c  | 272 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  include/elf.h |  10 +++
>  2 files changed, 281 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f095725dbab2..056aa46d99b9 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -109,6 +109,9 @@ static struct e820_entry *e820_table;
>  static unsigned e820_entries;
>  struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
> =20
> +/* Physical Address of PVH entry point read from kernel ELF NOTE */
> +static size_t pvh_start_addr;
> +
>  void gsi_handler(void *opaque, int n, int level)
>  {
>      GSIState *s =3D opaque;
> @@ -834,6 +837,267 @@ struct setup_data {
>      uint8_t data[0];
>  } __attribute__((packed));
> =20
> +/*
> + * Search through the ELF Notes for an entry with the given
> + * ELF Note type
> + */
> +static void *get_elf_note_type(void *ehdr, void *phdr, bool elf_is64,
> +    size_t elf_note_type)

Generic ELF code.  Can you put it in hw/core/loader.c?

> +{
> +    void *nhdr =3D NULL;
> +    size_t nhdr_size =3D elf_is64 ? sizeof(Elf64_Nhdr) : sizeof(Elf32_Nh=
dr);
> +    size_t elf_note_entry_sz =3D 0;
> +    size_t phdr_off;
> +    size_t phdr_align;
> +    size_t phdr_memsz;
> +    size_t nhdr_namesz;
> +    size_t nhdr_descsz;
> +    size_t note_type;

The macro tricks used by hw/core/loader.c are nasty, but I think they
get the types right.  Here the Elf64 on 32-bit host case is definitely
broken due to using size_t.  Perhaps 64-on-32 isn't supported, but
getting the types right is worth discussing.

> +
> +    phdr_off =3D elf_is64 ?
> +        ((Elf64_Phdr *)phdr)->p_offset : ((Elf32_Phdr *)phdr)->p_offset;
> +    phdr_align =3D elf_is64 ?
> +        ((Elf64_Phdr *)phdr)->p_align : ((Elf32_Phdr *)phdr)->p_align;
> +    phdr_memsz =3D elf_is64 ?
> +        ((Elf64_Phdr *)phdr)->p_memsz : ((Elf32_Phdr *)phdr)->p_memsz;
> +
> +    nhdr =3D ehdr + phdr_off;

The ELF file is untrusted.  All inputs must be validated.  phdr_off
could be an bogus/malicious value.

> +    note_type =3D elf_is64 ?
> +        ((Elf64_Nhdr *)nhdr)->n_type : ((Elf32_Nhdr *)nhdr)->n_type;
> +    nhdr_namesz =3D elf_is64 ?
> +        ((Elf64_Nhdr *)nhdr)->n_namesz : ((Elf32_Nhdr *)nhdr)->n_namesz;
> +    nhdr_descsz =3D elf_is64 ?
> +        ((Elf64_Nhdr *)nhdr)->n_descsz : ((Elf32_Nhdr *)nhdr)->n_descsz;
> +
> +    while (note_type !=3D elf_note_type) {
> +        elf_note_entry_sz =3D nhdr_size +
> +            QEMU_ALIGN_UP(nhdr_namesz, phdr_align) +
> +            QEMU_ALIGN_UP(nhdr_descsz, phdr_align);
> +
> +        /*
> +         * Verify that we haven't exceeded the end of the ELF Note secti=
on.
> +         * If we have, then there is no note of the given type present
> +         * in the ELF Notes.
> +         */
> +        if (phdr_off + phdr_memsz < ((nhdr - ehdr) + elf_note_entry_sz))=
 {
> +            error_report("Note type (0x%lx) not found in ELF Note sectio=
n",
> +                elf_note_type);
> +            return NULL;
> +        }
> +
> +        /* skip to the next ELF Note entry */
> +        nhdr +=3D elf_note_entry_sz;
> +        note_type =3D elf_is64 ?
> +            ((Elf64_Nhdr *)nhdr)->n_type : ((Elf32_Nhdr *)nhdr)->n_type;
> +        nhdr_namesz =3D elf_is64 ?
> +            ((Elf64_Nhdr *)nhdr)->n_namesz : ((Elf32_Nhdr *)nhdr)->n_nam=
esz;
> +        nhdr_descsz =3D elf_is64 ?
> +            ((Elf64_Nhdr *)nhdr)->n_descsz : ((Elf32_Nhdr *)nhdr)->n_des=
csz;
> +    }
> +
> +    return nhdr;
> +}
> +
> +/*
> + * The entry point into the kernel for PVH boot is different from
> + * the native entry point.  The PVH entry is defined by the x86/HVM
> + * direct boot ABI and is available in an ELFNOTE in the kernel binary.
> + * This function reads the ELF headers of the binary specified on the
> + * command line by -kernel (path contained in 'filename') and discovers
> + * the PVH entry address from the appropriate ELF Note.
> + *
> + * The address of the PVH entry point is saved to the 'pvh_start_addr'
> + * global variable. The ELF class of the binary is returned via 'elfclas=
s'
> + * (although the entry point is 32-bit, the kernel binary can be either
> + * 32-bit or 64-bit).
> + */
> +static bool read_pvh_start_addr_elf_note(const char *filename,
> +    unsigned char *elfclass)
> +{

Can this be integrated into ELF loading?  For example, could the elf
loader take a function pointer to perform additional logic (e.g.
extracting the PVH entry point)?  That avoids reparsing the input file.

> +    void *ehdr =3D NULL; /* Cast to Elf64_Ehdr or Elf32_Ehdr */
> +    void *phdr =3D NULL; /* Cast to Elf64_Phdr or Elf32_Phdr */
> +    void *nhdr =3D NULL; /* Cast to Elf64_Nhdr or Elf32_Nhdr */
> +    struct stat statbuf;
> +    size_t ehdr_size;
> +    size_t phdr_size;
> +    size_t nhdr_size;
> +    size_t elf_note_data_addr;
> +    /* Ehdr fields */
> +    size_t ehdr_poff;
> +    /* Phdr fields */
> +    size_t phdr_off;
> +    size_t phdr_align;
> +    size_t phdr_memsz;
> +    size_t phdr_type;
> +    /* Nhdr fields */
> +    size_t nhdr_namesz;
> +    size_t nhdr_descsz;
> +    bool elf_is64;
> +    FILE *file;
> +    union {
> +        Elf32_Ehdr h32;
> +        Elf64_Ehdr h64;
> +    } elf_header;
> +    Error *err =3D NULL;
> +
> +    pvh_start_addr =3D 0;
> +
> +    if (filename =3D=3D NULL) {
> +        return false;
> +    }
> +
> +    file =3D fopen(filename, "rb");
> +    if (file =3D=3D NULL) {
> +        error_report("fopen(%s) failed", filename);
> +        return false;
> +    }
> +
> +    if (fstat(fileno(file), &statbuf) < 0) {
> +        error_report("fstat() failed on file (%s)", filename);
> +        return false;
> +    }
> +
> +    load_elf_hdr(filename, &elf_header, &elf_is64, &err);
> +    if (err) {
> +        error_free(err);
> +        fclose(file);
> +        return false;
> +    }
> +
> +    *elfclass =3D elf_is64 ?
> +        elf_header.h64.e_ident[EI_CLASS] : elf_header.h32.e_ident[EI_CLA=
SS];
> +    if (*elfclass =3D=3D ELFCLASSNONE) {
> +        error_report("kernel binary (%s) is ELFCLASSNONE", filename);
> +        fclose(file);
> +        return false;
> +    }
> +
> +    ehdr_size =3D elf_is64 ? sizeof(Elf64_Ehdr) : sizeof(Elf32_Ehdr);
> +    phdr_size =3D elf_is64 ? sizeof(Elf64_Phdr) : sizeof(Elf32_Phdr);
> +    nhdr_size =3D elf_is64 ? sizeof(Elf64_Nhdr) : sizeof(Elf32_Nhdr);
> +
> +    /* We have already validated the ELF header when calling elf_load_hd=
r() */
> +
> +    ehdr =3D mmap(0, statbuf.st_size,
> +        PROT_READ | PROT_WRITE, MAP_PRIVATE, fileno(file), 0);
> +    if (ehdr =3D=3D MAP_FAILED) {
> +        error_report("Failed to mmap kernel binary (%s)", filename);
> +        goto done;
> +    }
> +
> +    /*
> +     * Search through the program execution header for the
> +     * ELF Note section.
> +     */
> +
> +    ehdr_poff =3D elf_is64 ?
> +        ((Elf64_Ehdr *)(ehdr))->e_phoff : ((Elf32_Ehdr *)(ehdr))->e_phof=
f;
> +    if (statbuf.st_size < (ehdr_size + ehdr_poff)) {
> +        error_report("ELF NOTE section exceeds file (%s) size",
> +            filename);
> +        goto done;
> +    }
> +
> +    phdr =3D ehdr + ehdr_poff;
> +    phdr_type =3D elf_is64 ?
> +        ((Elf64_Phdr *)phdr)->p_type : ((Elf32_Phdr *)phdr)->p_type;
> +    while (phdr !=3D NULL && phdr_type !=3D PT_NOTE) {
> +        if (statbuf.st_size < ((phdr - ehdr) + phdr_size)) {
> +            error_report("ELF Program headers in file (%s) too short",
> +                filename);
> +            goto done;
> +        }
> +        phdr +=3D phdr_size;
> +        phdr_type =3D elf_is64 ?
> +            ((Elf64_Phdr *)phdr)->p_type : ((Elf32_Phdr *)phdr)->p_type;
> +    }
> +
> +    phdr_off =3D elf_is64 ?
> +        ((Elf64_Phdr *)phdr)->p_offset : ((Elf32_Phdr *)phdr)->p_offset;
> +    phdr_align =3D elf_is64 ?
> +        ((Elf64_Phdr *)phdr)->p_align : ((Elf32_Phdr *)phdr)->p_align;
> +    phdr_memsz =3D elf_is64 ?
> +        ((Elf64_Phdr *)phdr)->p_memsz : ((Elf32_Phdr *)phdr)->p_memsz;
> +
> +    /*
> +     * check that the start of the ELF Note section is within the bounds
> +     * of the kernel ELF binary
> +     */
> +    if (statbuf.st_size < (ehdr_poff + phdr_size + phdr_off)) {
> +        error_report("Start of ELF note section outside of file (%s) bou=
nds",
> +            filename);
> +        goto done;
> +    }
> +    /*
> +     * check that the end of the ELF Note section is within the bounds
> +     * of the kernel ELF binary
> +     */
> +    if (statbuf.st_size < (phdr_off + phdr_memsz)) {
> +        error_report("End of ELF note section outside of file (%s) bound=
s",
> +            filename);
> +        goto done;
> +    }
> +
> +    /*
> +     * Search through the ELF Notes for an entry with the
> +     * Physical Address (PA) of the PVH entry point.
> +     */
> +    nhdr =3D get_elf_note_type(ehdr, phdr, elf_is64, XEN_ELFNOTE_PHYS32_=
ENTRY);
> +    if (nhdr =3D=3D NULL) {
> +        error_report("No PVH Entry details in kernel (%s) ELF Note secti=
on",
> +            filename);
> +        goto done;
> +    }
> +
> +    /*
> +     * Verify that the returned ELF Note header doesn't exceed the
> +     * end of the kernel file
> +     */
> +    if (statbuf.st_size < ((nhdr - ehdr))) {
> +        error_report("ELF Nhdr offset (0x%lx) exceeds file (%s) bounds (=
%ld)",
> +            (nhdr - ehdr), filename, statbuf.st_size);
> +        goto done;
> +    }
> +
> +    nhdr_namesz =3D elf_is64 ?
> +        ((Elf64_Nhdr *)nhdr)->n_namesz : ((Elf32_Nhdr *)nhdr)->n_namesz;
> +    nhdr_descsz =3D elf_is64 ?
> +        ((Elf64_Nhdr *)nhdr)->n_descsz : ((Elf32_Nhdr *)nhdr)->n_descsz;
> +
> +    /*
> +     * Verify that the ELF Note contents don't exceed the end of the
> +     * kernel file
> +     */
> +    if (statbuf.st_size < ((nhdr - ehdr)) + nhdr_size +
> +        QEMU_ALIGN_UP(nhdr_namesz, phdr_align) +
> +        QEMU_ALIGN_UP(nhdr_descsz, phdr_align)) {
> +        error_report("ELF Nhdr contents (0x%lx) exceeds file bounds (%ld=
)",
> +            (nhdr - ehdr) + nhdr_size + QEMU_ALIGN_UP(nhdr_namesz, phdr_=
align) +
> +            QEMU_ALIGN_UP(nhdr_descsz, phdr_align), statbuf.st_size);
> +        goto done;
> +    }
> +
> +    elf_note_data_addr =3D
> +        (size_t)nhdr + nhdr_size + QEMU_ALIGN_UP(nhdr_namesz, phdr_align=
);
> +
> +    pvh_start_addr =3D *(size_t *)elf_note_data_addr;
> +
> +    /*
> +     * Verify that the PVH Entry point address does not exceed the
> +     * bounds of the kernel file.
> +     */
> +    if (statbuf.st_size < pvh_start_addr) {
> +        error_report("PVH ELF note addr (0x%lx) exceeds file (%s) bounds=
 (%ld)",
> +            (elf_note_data_addr - (size_t)ehdr), filename, statbuf.st_si=
ze);
> +        pvh_start_addr =3D 0;
> +        goto done;
> +    }
> +
> +done:
> +    (void) munmap(ehdr, statbuf.st_size);
> +    return pvh_start_addr !=3D 0;
> +}
> +
>  static void load_linux(PCMachineState *pcms,
>                         FWCfgState *fw_cfg)
>  {
> @@ -1334,9 +1598,11 @@ void pc_memory_init(PCMachineState *pcms,
>      int linux_boot, i;
>      MemoryRegion *ram, *option_rom_mr;
>      MemoryRegion *ram_below_4g, *ram_above_4g;
> -    FWCfgState *fw_cfg;
> +    FWCfgState *fw_cfg =3D NULL;
> +    unsigned char class =3D ELFCLASSNONE;
>      MachineState *machine =3D MACHINE(pcms);
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> +    const char *kernel_filename =3D machine->kernel_filename;
> =20
>      assert(machine->ram_size =3D=3D pcms->below_4g_mem_size +
>                                  pcms->above_4g_mem_size);
> @@ -1418,6 +1684,10 @@ void pc_memory_init(PCMachineState *pcms,
>                                      &machine->device_memory->mr);
>      }
> =20
> +    if (linux_boot) {
> +        read_pvh_start_addr_elf_note(kernel_filename, &class);
> +    }
> +
>      /* Initialize PC system firmware */
>      pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
> =20
> diff --git a/include/elf.h b/include/elf.h
> index c151164b63da..1f82c7a7124b 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -1585,6 +1585,16 @@ typedef struct elf64_shdr {
>  #define NT_ARM_HW_WATCH 0x403           /* ARM hardware watchpoint regis=
ters */
>  #define NT_ARM_SYSTEM_CALL      0x404   /* ARM system call number */
> =20
> +/*
> + * Physical entry point into the kernel.
> + *
> + * 32bit entry point into the kernel. When requested to launch the
> + * guest kernel, use this entry point to launch the guest in 32-bit
> + * protected mode with paging disabled.
> + *
> + * [ Corresponding definition in Linux kernel: include/xen/interface/elf=
note.h ]
> + */
> +#define XEN_ELFNOTE_PHYS32_ENTRY    18  /* 0x12 */
> =20
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {
> --=20
> 1.8.3.1
>=20

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcD8b8AAoJEJykq7OBq3PIF4kIAIr6zrp7Bdvs03IMDjuwvLxO
LX4kOdKogu7o+jQ/T/lrDS4YLccPBdlUII54jRGe5sPYtVN9eINBs8QpW+12O3Gc
6Dz5by+RQBj278Um6bphg9aNlfGeJcXeODq2WHrfV953mQUlzss4gd76dxZaDlHy
EeQxGsXJDHHUyzdwhDUOdic50vUIvN8GcdY0l/F/p9ponR3vSYGmOyGcOIBrOatz
9PadTd+ZqR5qTTm4/kHIXkMXwAgnKUlLPBVAq2z50CUmVgurFykl+inNJt0raKBO
OGad4hVjGKto3NJgg6Jo7TRknq0v/LZerKWTQn4IxqfZL6ml3CMI550f+2SNe3A=
=Beil
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
