Received: from eggs.gnu.org ([209.51.188.92]:54231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1D8-0003PH-Hf
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:55:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1Cs-0001wk-LY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:55:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gm1Cm-0001qj-Bl
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:55:24 -0500
Date: Tue, 22 Jan 2019 18:55:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122185515.GD13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190122181822.1505-1-peter.maydell@linaro.org>
	<20190122181822.1505-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122181822.1505-3-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] slirp: Don't mark struct ipq or struct
 ipasfrag as packed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, patches@linaro.org

On Tue, Jan 22, 2019 at 06:18:22PM +0000, Peter Maydell wrote:
> There is no reason to mark the struct ipq and struct ipasfrag as
> packed: they are naturally aligned anyway, and are not representing
> any on-the-wire packet format.  Indeed they vary in size depending on
> the size of pointers on the host system, because the 'struct qlink'
> members include 'void *' fields.
> 
> Dropping the 'packed' annotation fixes clang -Waddress-of-packed-member
> warnings and probably lets the compiler generate better code too.
> 
> The only thing we do care about in the layout of the struct is
> that the frag_link matches up with the ipf_link of the struct
> ipasfrag, as documented in the comment on that struct; assert
> at build time that this is the case.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  slirp/ip.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/slirp/ip.h b/slirp/ip.h
> index 243b6c8b249..20614f3b53e 100644
> --- a/slirp/ip.h
> +++ b/slirp/ip.h

Just here there's a misleading comment

  * size 28 bytes

that should be purged

> @@ -217,7 +217,7 @@ struct ipq {
>  	uint8_t	ipq_p;			/* protocol of this fragment */
>  	uint16_t	ipq_id;			/* sequence id for reassembly */
>  	struct	in_addr ipq_src,ipq_dst;
> -} QEMU_PACKED;
> +};
>  
>  /*
>   * Ip header, when holding a fragment.
> @@ -227,7 +227,10 @@ struct ipq {
>  struct	ipasfrag {
>  	struct qlink ipf_link;
>  	struct ip ipf_ip;
> -} QEMU_PACKED;
> +};
> +
> +QEMU_BUILD_BUG_ON(offsetof(struct ipq, frag_link) !=
> +                  offsetof(struct ipasfrag, ipf_link));
>  
>  #define ipf_off      ipf_ip.ip_off
>  #define ipf_tos      ipf_ip.ip_tos


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
