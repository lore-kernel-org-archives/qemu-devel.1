Received: from eggs.gnu.org ([2001:4830:134:3::10]:34360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4az9-0007Od-Vm
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4az5-0001w8-7g
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:37:04 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4az5-0001w4-39
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:36:59 -0400
Received: by mail-qk0-x243.google.com with SMTP id h123so195998qke.2
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 15:36:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170429124715.5xrpapuedv6nnpnd@var.youpi.perso.aquilenet.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <46621872-bf1a-cdf5-6174-f8ba1a83f8c0@amsat.org>
Date: Sat, 29 Apr 2017 19:36:55 -0300
MIME-Version: 1.0
In-Reply-To: <20170429124715.5xrpapuedv6nnpnd@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: fix pinging the virtual ipv4 DNS
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 04/29/2017 09:47 AM, Samuel Thibault wrote:
> so that people do not think it is not working at least basically.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
> diff --git a/slirp/ip_icmp.c b/slirp/ip_icmp.c
> index 5ffc7a683d..0b667a429a 100644
> --- a/slirp/ip_icmp.c
> +++ b/slirp/ip_icmp.c
> @@ -152,8 +152,9 @@ icmp_input(struct mbuf *m, int hlen)
>    switch (icp->icmp_type) {
>    case ICMP_ECHO:
>      ip->ip_len += hlen;	             /* since ip_input subtracts this */
> -    if (ip->ip_dst.s_addr == slirp->vhost_addr.s_addr) {
> -      icmp_reflect(m);
> +    if (ip->ip_dst.s_addr == slirp->vhost_addr.s_addr ||
> +        ip->ip_dst.s_addr == slirp->vnameserver_addr.s_addr) {
> +        icmp_reflect(m);
>      } else if (slirp->restricted) {
>          goto freeit;
>      } else {
>
