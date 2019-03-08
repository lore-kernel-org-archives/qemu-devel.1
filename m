Received: from eggs.gnu.org ([209.51.188.92]:58012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2B7S-0008G2-Ic
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 03:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2B7R-00044v-KM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 03:44:42 -0500
References: <20190307172401.29451-1-armbru@redhat.com>
	<20190307172401.29451-13-armbru@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bf28d85a-f024-3c4f-e7e3-546f6f02ba9c@redhat.com>
Date: Fri, 8 Mar 2019 09:44:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190307172401.29451-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/12] docs/interop/firmware.json:
 Prefer -machine to if=pflash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

On 03/07/19 18:24, Markus Armbruster wrote:
> The previous commit added a way to configure firmware with -blockdev
> rather than -drive if=pflash.  Document it as the preferred way.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/interop/firmware.json | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 28f9bc1591..db3cb38b6a 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -212,9 +212,13 @@
>  #
>  # @executable: Identifies the firmware executable. The firmware
>  #              executable may be shared by multiple virtual machine
> -#              definitions. The corresponding QEMU command line option
> -#              is "-drive
> -#              if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format".
> +#              definitions. The preferred corresponding QEMU command
> +#              line option is
> +#                  -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
> +#                  -machine pflash0=pflash0
> +#              or equivalent -blockdev.

If we used plural here ("options"), would that be an improvement?

  The preferred corresponding QEMU command line options are
    -drive ...
    -machine ...
  (or -blockdev equivalent to -drive).

> +#              With QEMU versions older than 4.0, you have to use

To make this easier to understand on first read, should we say

  ... you have to use the single option ...

?

(Maybe there is a better term than "single option" for the "-drive if=<not-NONE>" options, i.e. for those that configure both back-end and front-end.)

If the above over-explained things, I'd be fine with the current patch as well. I just got these ideas and wanted to run them by you.

Thanks!
Laszlo


> +#                  -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format
>  #
>  # @nvram-template: Identifies the NVRAM template compatible with
>  #                  @executable. Management software instantiates an
> @@ -225,9 +229,14 @@
>  #                  individual copies of it are. An NVRAM file is
>  #                  typically used for persistently storing the
>  #                  non-volatile UEFI variables of a virtual machine
> -#                  definition. The corresponding QEMU command line
> -#                  option is "-drive
> -#                  if=pflash,unit=1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format".
> +#                  definition. The preferred corresponding QEMU
> +#                  command line option is
> +#                      -drive if=none,id=pflash1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
> +#                      -machine pflash1=pflash1
> +#                  or equivalent -blockdev.
> +#                  With QEMU versions older than 4.0, you have to use
> +#                      -drive if=pflash,unit=1,readonly=off,file=FILENAME_OF_PRIVATE_NVRAM_FILE,format=@nvram-template.@format
> +#                  
>  #
>  # Since: 3.0
>  ##
> 
