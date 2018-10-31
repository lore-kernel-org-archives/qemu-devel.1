Received: from eggs.gnu.org ([2001:4830:134:3::10]:35834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gHlkO-0006ea-J9
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 04:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gHlkN-00036l-RN
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 04:21:04 -0400
Received: from ssl.serverraum.org ([2a01:4f8:151:8464::1:2]:54413)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1gHlkN-00031L-Iw
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 04:21:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Oct 2018 09:20:57 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20181030170032.1844-1-peter.maydell@linaro.org>
References: <20181030170032.1844-1-peter.maydell@linaro.org>
Message-ID: <d3a69de8bd0a6e821a3539f85da80699@walle.cc>
Subject: Re: [Qemu-devel] [PATCH for-3.1] milkymist: Check for failure
 trying to load BIOS image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org

Am 2018-10-30 18:00, schrieb Peter Maydell:
> Check the return value from load_image_targphys(), which tells us
> whether our attempt to load the BIOS image into RAM failed.
> (Spotted by Coverity, CID 1190305.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Michael Walle <michael@walle.cc>

Will you put it in your queue, Peter?

-michael

> ---
>  hw/lm32/milkymist.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 321f184595e..63c6894c955 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -138,7 +138,10 @@ milkymist_init(MachineState *machine)
>      bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> 
>      if (bios_filename) {
> -        load_image_targphys(bios_filename, BIOS_OFFSET, BIOS_SIZE);
> +        if (load_image_targphys(bios_filename, BIOS_OFFSET, BIOS_SIZE) 
> < 0) {
> +            error_report("could not load bios '%s'", bios_filename);
> +            exit(1);
> +        }
>      }
> 
>      reset_info->bootstrap_pc = BIOS_OFFSET;
