Received: from eggs.gnu.org ([2001:4830:134:3::10]:35520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHXQ6-0000fZ-1F
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHXQ2-0000OH-1U
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:03:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHXQ1-0000Mh-Q0
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:03:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id v24-v6so2700267wmh.3
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 10:03:04 -0700 (PDT)
References: <20181030170032.1844-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ab3dc53d-9711-55f3-36ac-595f2c4cb86a@redhat.com>
Date: Tue, 30 Oct 2018 18:03:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181030170032.1844-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Walle <michael@walle.cc>, patches@linaro.org

On 30/10/18 18:00, Peter Maydell wrote:
> Check the return value from load_image_targphys(), which tells us
> whether our attempt to load the BIOS image into RAM failed.
> (Spotted by Coverity, CID 1190305.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/lm32/milkymist.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 321f184595e..63c6894c955 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -138,7 +138,10 @@ milkymist_init(MachineState *machine)
>       bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>   
>       if (bios_filename) {
> -        load_image_targphys(bios_filename, BIOS_OFFSET, BIOS_SIZE);
> +        if (load_image_targphys(bios_filename, BIOS_OFFSET, BIOS_SIZE) < 0) {
> +            error_report("could not load bios '%s'", bios_filename);
> +            exit(1);
> +        }
>       }
>   
>       reset_info->bootstrap_pc = BIOS_OFFSET;
> 
