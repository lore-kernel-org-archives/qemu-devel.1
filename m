Received: from eggs.gnu.org ([2001:4830:134:3::10]:37648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPxUW-0003jV-Ox
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPxSS-0007kp-83
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:28:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPxSS-0007ev-1X
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 17:28:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so10202506wmc.5
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 14:28:23 -0800 (PST)
References: <20181122172653.3413-1-peter.maydell@linaro.org>
	<20181122172653.3413-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f37b5789-06c9-9aed-2fb6-6c67b7d892f0@redhat.com>
Date: Thu, 22 Nov 2018 23:28:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181122172653.3413-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 3/3] elf_ops.h: Use
 address_space_write() to write memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, patches@linaro.org

On 22/11/18 18:26, Peter Maydell wrote:
> Currently the load_elf function in elf_ops.h uses
> cpu_physical_memory_write() to write the ELF file to
> memory if it is not handling it as a ROM blob. This
> means we ignore the AddressSpace that the function
> is passed to define where it should be loaded.
> Use address_space_write() instead.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: handle NULL as

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/elf_ops.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 81cecaf27e2..74679ff8da3 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -482,7 +482,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,
>                      rom_add_elf_program(label, data, file_size, mem_size,
>                                          addr, as);
>                  } else {
> -                    cpu_physical_memory_write(addr, data, file_size);
> +                    address_space_write(as ? as : &address_space_memory,
> +                                        addr, MEMTXATTRS_UNSPECIFIED,
> +                                        data, file_size);
>                      g_free(data);
>                  }
>              }
> 
