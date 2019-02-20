Received: from eggs.gnu.org ([209.51.188.92]:59979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwU7N-0003Qs-Fq
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwU7L-00059i-5W
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:49:05 -0500
Sender: Corey Minyard <tcminyard@gmail.com>
Date: Wed, 20 Feb 2019 07:36:08 -0600
From: Corey Minyard <minyard@acm.org>
Message-ID: <20190220133608.GB5504@minyard.net>
Reply-To: minyard@acm.org
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-24-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190220010232.18731-24-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 23/25] hw/ipmi: Assert outlen > outpos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Wed, Feb 20, 2019 at 02:02:30AM +0100, Philippe Mathieu-Daudé wrote:
> A througfull audit show that all time data is added to outbuf[],
> 'outlen' is incremented.  Then at creation and each time
> continue_send() returns it pass thru check_reset which resets
> 'outpos', thus we always have 'outlen >= outpos'.

Perhaps: "A thorough audit shows that outlen is always incremented
when data is always added to outbuf[].  Then at creation and each
time continus_send() returns it assures if outpos reaches outlen,
both values are reset to zero, except in the case of sending
a reset where a new command is added."

This is certainly the design intent, thank you for the thorough
audit.

> Also due to the check on entry, we know outlen != 0.
> We can then add an assertion on 'outlen > outpos', which will
> helps the next patch to safely convert 'outlen - outpos' as an

I was a little confused by "next patch", there is no following
patch in the series for this.  Maybe "next part of the patch"?

> unsigned type (size_t).
> 
> Make this assertion explicit by casting 'outlen - outpos' size_t.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Outside of the minor grammer issues, this looks good.  I have
noticed the inconsistent signed/unsigned usage in qemu and IMHO
it's likely to lead to very bad bugs at some point.  There have
been studies that show that unsigned values tend to be more
buggy in usage due to underflows, but for a length value that
will eventually be converted to an unsigned value, what is
here is better, I think.

Both outpos and outlen are unsigned, so the size_t() cast is
not really necessary, but I guess it makes it clear.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/ipmi/ipmi_bmc_extern.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index bf0b7ee0f5..ca61b04942 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -107,8 +107,9 @@ static void continue_send(IPMIBmcExtern *ibe)
>          goto check_reset;
>      }
>   send:
> +    assert(ibe->outlen > ibe->outpos);
>      ret = qemu_chr_fe_write(&ibe->chr, ibe->outbuf + ibe->outpos,
> -                            ibe->outlen - ibe->outpos);
> +                            (size_t)(ibe->outlen - ibe->outpos));
>      if (ret > 0) {
>          ibe->outpos += ret;
>      }
> -- 
> 2.20.1
> 
