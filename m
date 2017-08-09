Received: from eggs.gnu.org ([2001:4830:134:3::10]:54588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfMvz-0004p3-7M
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfMvu-0008Rf-Tv
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:05:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfMvu-0008Qu-KF
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 05:05:42 -0400
Date: Wed, 9 Aug 2017 11:05:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170809110520.1fd23ddc.cohuck@redhat.com>
In-Reply-To: <1502254778-14637-2-git-send-email-thuth@redhat.com>
References: <1502254778-14637-1-git-send-email-thuth@redhat.com>
	<1502254778-14637-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/boot-sector: Do not overwrite
 the x86 buffer on other architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

On Wed,  9 Aug 2017 06:59:37 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Re-using the boot_sector code buffer from x86 for other architectures
> is not very nice, especially if we add more architectures later. It's
> also ugly that the test uses a huge pre-initialized array - the size
> of the executable is very huge due to this array. So let's use a
> separate buffer for each architecture instead, allocated from the heap,
> so that we really just use the memory that we need.
> 
> Suggested-by: Michael Tsirkin <mst@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/boot-sector.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/boot-sector.c b/tests/boot-sector.c
> index e3880f4..4ea1373 100644
> --- a/tests/boot-sector.c
> +++ b/tests/boot-sector.c
> @@ -21,13 +21,12 @@
>  #define SIGNATURE 0xdead
>  #define SIGNATURE_OFFSET 0x10
>  #define BOOT_SECTOR_ADDRESS 0x7c00
> +#define SIGNATURE_ADDR (BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET)

Do you want to use this new #define in boot_sector_test() as well?

>  
> -/* Boot sector code: write SIGNATURE into memory,
> +/* x86 boot sector code: write SIGNATURE into memory,
>   * then halt.
> - * Q35 machine requires a minimum 0x7e000 bytes disk.
> - * (bug or feature?)
>   */
> -static uint8_t boot_sector[0x7e000] = {
> +static uint8_t x86_boot_sector[512] = {
>      /* The first sector will be placed at RAM address 00007C00, and
>       * the BIOS transfers control to 00007C00
>       */
> @@ -50,8 +49,8 @@ static uint8_t boot_sector[0x7e000] = {
>      [0x07] = HIGH(SIGNATURE),
>      /* 7c08:  mov %ax,0x7c10 */
>      [0x08] = 0xa3,
> -    [0x09] = LOW(BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET),
> -    [0x0a] = HIGH(BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET),
> +    [0x09] = LOW(SIGNATURE_ADDR),
> +    [0x0a] = HIGH(SIGNATURE_ADDR),
>  
>      /* 7c0b cli */
>      [0x0b] = 0xfa,
> @@ -72,7 +71,9 @@ static uint8_t boot_sector[0x7e000] = {
>  int boot_sector_init(char *fname)
>  {
>      int fd, ret;
> -    size_t len = sizeof boot_sector;
> +    size_t len;
> +    char *boot_code;
> +    const char *arch = qtest_get_arch();
>  
>      fd = mkstemp(fname);
>      if (fd < 0) {
> @@ -80,16 +81,26 @@ int boot_sector_init(char *fname)
>          return 1;
>      }
>  
> -    /* For Open Firmware based system, we can use a Forth script instead */
> -    if (strcmp(qtest_get_arch(), "ppc64") == 0) {
> -        len = sprintf((char *)boot_sector, "\\ Bootscript\n%x %x c! %x %x c!\n",
> -                LOW(SIGNATURE), BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET,
> -                HIGH(SIGNATURE), BOOT_SECTOR_ADDRESS + SIGNATURE_OFFSET + 1);
> +    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
> +        /* Q35 requires a minimum 0x7e000 bytes disk (bug or feature?) */
> +        len = 0x7e000;

Use the maximum of (0x7e000, sizeof(x86_boot_sector))? (Not that it is
likely that the boot sector will ever grow, but I think it is cleaner.)

> +        boot_code = g_malloc(len);

Would g_malloc_0() be better?

> +        memcpy(boot_code, x86_boot_sector, sizeof x86_boot_sector);

sizeof(x86_boot_sector)?

> +    } else if (g_str_equal(arch, "ppc64")) {
> +        /* For Open Firmware based system, use a Forth script */
> +        boot_code = g_strdup_printf("\\ Bootscript\n%x %x c! %x %x c!\n",
> +                                    LOW(SIGNATURE), SIGNATURE_ADDR,
> +                                    HIGH(SIGNATURE), SIGNATURE_ADDR + 1);
> +        len = strlen(boot_code);
> +    } else {
> +        g_assert_not_reached();
>      }
>  
> -    ret = write(fd, boot_sector, len);
> +    ret = write(fd, boot_code, len);
>      close(fd);
>  
> +    g_free(boot_code);
> +
>      if (ret != len) {
>          fprintf(stderr, "Could not write \"%s\"", fname);
>          return 1;

This makes the code much nicer :)
