Received: from eggs.gnu.org ([2001:4830:134:3::10]:35966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLeM-0006dM-Vv
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLeJ-00034j-Rp
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:44:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBLeJ-00034J-Mi
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:43:59 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-7-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9805c915-6209-593e-9a27-c8596a232874@redhat.com>
Date: Wed, 25 Apr 2018 16:43:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

On 20.04.2018 16:52, Peter Maydell wrote:
> Provide an accessor function serial_hd() to return the Chardev
> (if any) associated with the numbered serial port. This will
> be used to replace direct accesses to the serial_hds[] array,
> so that calling code doesn't need to care about the size of
> that array.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
