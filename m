Received: from eggs.gnu.org ([2001:4830:134:3::10]:59763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPryP-0008Hi-6g
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPryO-00016k-CZ
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:37:01 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPryO-00015v-5e
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:37:00 -0500
Received: by mail-oi1-x243.google.com with SMTP id p82-v6so7876895oih.11
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 08:37:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181122112947.7586-4-peter.maydell@linaro.org>
References: <20181122112947.7586-1-peter.maydell@linaro.org>
	<20181122112947.7586-4-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 16:36:38 +0000
Message-ID: <CAFEAcA8ovgeDpStmvpEUg16SjwLoAZdyNHLL1rjsnPV7YRV2SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0 3/3] elf_ops.h: Use
 address_space_write() to write memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 22 November 2018 at 11:29, Peter Maydell <peter.maydell@linaro.org> wrote:
> Currently the load_elf function in elf_ops.h uses
> cpu_physical_memory_write() to write the ELF file to
> memory if it is not handling it as a ROM blob. This
> means we ignore the AddressSpace that the function
> is passed to define where it should be loaded.
> Use address_space_write() instead.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/elf_ops.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 81cecaf27e2..793dcb85c2b 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -482,7 +482,8 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>                      rom_add_elf_program(label, data, file_size, mem_size,
>                                          addr, as);
>                  } else {
> -                    cpu_physical_memory_write(addr, data, file_size);
> +                    address_space_write(as, addr, MEMTXATTRS_UNSPECIFIED,
> +                                        data, file_size);
>                      g_free(data);
>                  }
>              }
> --

This turns out to have a bug which my testing somehow missed.
The 'as' argument to this function can be NULL, which means that
it should use address_space_memory, so we need to handle that.
(The other side of the if() doesn't need to special case NULL
because rom_add_elf_program() and the other loader.c code handle
NULL later on.)

thanks
-- PMM
