Received: from eggs.gnu.org ([2001:4830:134:3::10]:34543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLaR-00039j-LE
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLaO-0000vl-GE
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:39:59 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:46149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLaO-0000vT-CL
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:39:56 -0400
Received: by mail-qk0-x241.google.com with SMTP id s70so22753858qks.13
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 07:39:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e4a428b1-0bf8-f4e2-232c-27b3c5272e73@amsat.org>
Date: Wed, 25 Apr 2018 11:39:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/13] vl.c: Provide accessor function
 serial_hd() for serial_hds[] array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 04/20/2018 11:52 AM, Peter Maydell wrote:
> Provide an accessor function serial_hd() to return the Chardev
> (if any) associated with the numbered serial port. This will
> be used to replace direct accesses to the serial_hds[] array,
> so that calling code doesn't need to care about the size of
> that array.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/sysemu/sysemu.h | 3 +++
>  vl.c                    | 9 +++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 2b42151c63..bd5b55c514 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -163,6 +163,9 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
>  
>  extern Chardev *serial_hds[MAX_SERIAL_PORTS];
>  
> +/* Return the Chardev for serial port i, or NULL if none */
> +Chardev *serial_hd(int i);
> +
>  /* parallel ports */
>  
>  #define MAX_PARALLEL_PORTS 3
> diff --git a/vl.c b/vl.c
> index fce1fd12d8..6daf026da6 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2516,6 +2516,15 @@ static int serial_parse(const char *devname)
>      return 0;
>  }
>  
> +Chardev *serial_hd(int i)
> +{
> +    assert(i >= 0);
> +    if (i < ARRAY_SIZE(serial_hds)) {
> +        return serial_hds[i];
> +    }
> +    return NULL;
> +}
> +
>  static int parallel_parse(const char *devname)
>  {
>      static int index = 0;
> 
