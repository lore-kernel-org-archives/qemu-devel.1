Received: from eggs.gnu.org ([209.51.188.92]:45286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwUUv-0008Tb-TX
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwUUo-0000Zp-4V
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:13:24 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwUUo-0000Zf-0q
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:13:18 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so27770213qta.7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 08:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-24-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-24-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 14:36:05 +0100
Message-ID: <CAMxuvazeeB6oWe61kLOH_0o3DO7sJ8EDhBYMggMNexwVnsW-AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 23/25] hw/ipmi: Assert outlen > outpos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Hi

On Wed, Feb 20, 2019 at 2:08 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> A througfull audit show that all time data is added to outbuf[],

througfull? :) thorough?

> 'outlen' is incremented. Then at creation and each time
> continue_send() returns it pass thru check_reset which resets
> 'outpos', thus we always have 'outlen >=3D outpos'.
> Also due to the check on entry, we know outlen !=3D 0.
> We can then add an assertion on 'outlen > outpos', which will

hmm, I think you could assert 'outlen >=3D outpos' only. I don't buy
your argument about 'outlen > outpos' (because outlen !=3D 0?)

> helps the next patch to safely convert 'outlen - outpos' as an
> unsigned type (size_t).
>
> Make this assertion explicit by casting 'outlen - outpos' size_t.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
>      ret =3D qemu_chr_fe_write(&ibe->chr, ibe->outbuf + ibe->outpos,
> -                            ibe->outlen - ibe->outpos);
> +                            (size_t)(ibe->outlen - ibe->outpos));
>      if (ret > 0) {
>          ibe->outpos +=3D ret;
>      }
> --
> 2.20.1
>
