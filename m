Received: from eggs.gnu.org ([209.51.188.92]:51355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gtnbV-0002GE-21
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gtnbT-0004dQ-Lk
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:01:04 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gtnbP-0004Ui-K6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:01:01 -0500
Received: by mail-pl1-x644.google.com with SMTP id bj4so667573plb.7
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 22:00:55 -0800 (PST)
References: <20190201004012.13237-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b799d329-3336-715f-bf03-776856ecb1bf@ozlabs.ru>
Date: Wed, 13 Feb 2019 17:00:50 +1100
MIME-Version: 1.0
In-Reply-To: <20190201004012.13237-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] spapr/rtas: Force big endian compile
 for rtas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>



On 01/02/2019 11:40, Alexey Kardashevskiy wrote:
> At the moment the rtas's Makefile uses generic QEMU rules which means
> that when QEMU is compiled on a little endian system, the spapr-rtas.bin
> is compiled as little endian too which is incorrect as it is always
> executed in big endian mode.
> 
> This enforces -mbig by defining %.o:%.S rule as spapr-rtas.bin is
> a standalone guest binary which should not depend on QEMU flags anyway.

Bag? Good? Useless? :)


> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  pc-bios/spapr-rtas/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/spapr-rtas/Makefile b/pc-bios/spapr-rtas/Makefile
> index f26dd42..4b9bb12 100644
> --- a/pc-bios/spapr-rtas/Makefile
> +++ b/pc-bios/spapr-rtas/Makefile
> @@ -14,8 +14,11 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/spapr-rtas)
>  
>  build-all: spapr-rtas.bin
>  
> +%.o: %.S
> +	$(call quiet-command,$(CCAS) -mbig -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
> +
>  %.img: %.o
> -	$(call quiet-command,$(CC) -nostdlib -o $@ $<,"Building","$(TARGET_DIR)$@")
> +	$(call quiet-command,$(CC) -nostdlib -mbig -o $@ $<,"Building","$(TARGET_DIR)$@")
>  
>  %.bin: %.img
>  	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"Building","$(TARGET_DIR)$@")
> 

-- 
Alexey
