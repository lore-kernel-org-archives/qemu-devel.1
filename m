Received: from eggs.gnu.org ([209.51.188.92]:44274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h308r-0006LX-PA
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 11:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h308r-00066e-2Y
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 11:13:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h308q-00066A-SE
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 11:13:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id x10so1934880wmg.2
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 08:13:32 -0700 (PDT)
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309004826.9027-6-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <914ec32f-0543-374d-6fcf-71a89b8d87e8@redhat.com>
Date: Sun, 10 Mar 2019 16:13:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190309004826.9027-6-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/10] roms/edk2-funcs.sh: add the
 qemu_edk2_get_thread_count() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

On 3/9/19 1:48 AM, Laszlo Ersek wrote:
> The edk2 "build" utility natively supports building modules (that is, INF
> files) in parallel. The feature is not useful when building a single
> module (with the "-m" option), but it is useful for platform firmware
> builds (which include many modules). Add a function that determines the
> "-n" option argument for "build", from the MAKEFLAGS variable (i.e. based
> on the presence of a make job server).
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  roms/edk2-funcs.sh | 25 ++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
> index 22a5dc8f6ab6..7fc62f074c59 100644
> --- a/roms/edk2-funcs.sh
> +++ b/roms/edk2-funcs.sh
> @@ -226,3 +226,28 @@ qemu_edk2_set_cross_env()
>  
>    eval "export $cross_prefix_var=\$cross_prefix"
>  }
> +
> +
> +# Determine the "-n" option argument (that is, the number of modules to build
> +# in parallel) for the edk2 "build" utility. Print the result to the standard
> +# output.
> +#
> +# Parameters:
> +#   $1: the value of the MAKEFLAGS variable
> +qemu_edk2_get_thread_count()
> +{
> +  local makeflags="$1"
> +
> +  if [[ "$makeflags" == *--jobserver-auth=* ]] ||
> +     [[ "$makeflags" == *--jobserver-fds=* ]]; then
> +    # If there is a job server, allow the edk2 "build" utility to parallelize
> +    # as many module builds as there are logical CPUs in the system. The "make"
> +    # instances forked by "build" are supposed to limit themselves through the
> +    # job server. The zero value below causes the edk2 "build" utility to fetch
> +    # the logical CPU count with Python's multiprocessing.cpu_count() method.
> +    printf '0\n'

Nice, it works smoothly :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +  else
> +    # Build a single module at a time.
> +    printf '1\n'
> +  fi
> +}
> 
