Received: from eggs.gnu.org ([2001:4830:134:3::10]:35149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmlN5-0000zF-1l
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fmlN0-0004vk-4I
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:40:51 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com
	([104.47.34.116]:30784
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fmlMz-0004tf-Mz
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 15:40:46 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 6 Aug 2018 19:40:40 +0000
Message-ID: <BN7PR08MB4868A5017093BCE115D9C9F0C6200@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1533574847-19294-57-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-57-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 56/80] mips_malta: Add basic nanoMIPS
 boot code for MIPS' Malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 6, 2018 7:00 PM
> Subject: [PATCH v7 56/80] mips_malta: Add basic nanoMIPS boot code for MI=
PS' Malta
>=20
> From: Matthew Fortune <matthew.fortune@mips.com>
>=20
> Added very very basic nanoMIPS boot code but this is hacked in
> unconditionally currently.
>=20
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  hw/mips/mips_malta.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 69 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>=20
> @@ -813,10 +865,16 @@ static int64_t load_kernel (void)
>                             NULL, (uint64_t *)&kernel_entry, NULL,
>                             (uint64_t *)&kernel_high, big_endian, EM_MIPS=
, 1, 0);
>      if (kernel_size < 0) {
> -        error_report("could not load kernel '%s': %s",
> -                     loaderparams.kernel_filename,
> -                     load_elf_strerror(kernel_size));
> -        exit(1);
> +        kernel_size =3D load_elf(loaderparams.kernel_filename,
> +                    cpu_mips_kseg0_to_phys, NULL,
> +                    (uint64_t *)&kernel_entry, NULL,
> +                    (uint64_t *)&kernel_high, big_endian, EM_NANOMIPS, 1=
, 0);
> +        if (kernel_size < 0) {
> +            error_report("could not load kernel '%s': %s",
> +                         loaderparams.kernel_filename,
> +                         load_elf_strerror(kernel_size));
> +            exit(1);
> +        }
>      }
>=20

Instead of invoking load_elf() twice, in load_elf32 (aka glue(load_elf, SZ)=
), there should be something like this:

        case EM_MIPS:
        case EM_NANOMIPS:
            if ((ehdr.e_machine !=3D EM_MIPS) &&
                (ehdr.e_machine !=3D EM_NANOMIPS)) {
                    ret =3D ELF_LOAD_WRONG_ARCH;
                    goto fail;
                }
            }
            break;

In any case, Malta board should work with both EM_MIPS and EM_NANOMIPS. Ple=
ase make sure both cases are well understood and tested.
