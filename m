Received: from eggs.gnu.org ([2001:4830:134:3::10]:42024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cb7zs-0002K8-40
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cb7zp-0008WI-2l
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:48:00 -0500
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<900ea185630c17f315c4984b2a595b2d3fba7c9a.1486436186.git.sam.bobroff@au1.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <981353e3-1ca7-6fcb-ef5e-86b9a335b6ed@redhat.com>
Date: Tue, 7 Feb 2017 16:47:53 +0100
MIME-Version: 1.0
In-Reply-To: <900ea185630c17f315c4984b2a595b2d3fba7c9a.1486436186.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 1/9] spapr: fix off-by-one
 error in spapr_ovec_populate_dt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 07.02.2017 03:56, Sam Bobroff wrote:
> The last byte of the option vector was missing due to an off-by-one
> error. Without this fix, client architecture support negotiation will
> fail because the last byte of option vector 5, which contains the MMU
> support, will be missed.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  hw/ppc/spapr_ovec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 4f4c090a29..18dbc4a9ac 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -251,7 +251,7 @@ int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
>          }
>      }
>  
> -    return fdt_setprop(fdt, fdt_offset, name, vec, vec_len);
> +    return fdt_setprop(fdt, fdt_offset, name, vec, vec_len + 1);
>  }

It took a while 'til I understood the encoding / length calculation of
the property here, but I think you're right. According to LoPAPR the
total length of the property is n+2 where n is the value of the first
byte. Since n is vec_len-1 in the QEMU code, vec_len+1 is the right
value for the property length.

Reviewed-by: Thomas Huth <thuth@redhat.com>
