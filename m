Received: from eggs.gnu.org ([2001:4830:134:3::10]:32860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fssh6-0003W0-MG
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fssXM-0007bG-KB
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:32:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40392 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fssXM-0007as-E3
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:32:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0146D7A7E7
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 16:32:44 +0000 (UTC)
References: <1535035877-219196-1-git-send-email-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb74bf2d-6973-9c2d-d799-8d16561c0265@redhat.com>
Date: Thu, 23 Aug 2018 18:32:41 +0200
MIME-Version: 1.0
In-Reply-To: <1535035877-219196-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl.c: make sure maxcpus matches topology
 to prevent migration failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, dgilbert@redhat.com

On 23/08/2018 16:51, Igor Mammedov wrote:
> Topology (threads*cores*sockets) must match maxcpus to be valid,
> otherwise we could start QEMU with invalid topology that throws
> a error on migration destination side, that should not be reachable:
> Source:
>   -smp 8,maxcpus=3D64,cores=3D1,threads=3D8,sockets=3D1
> // hotplug cpus upto maxcpus
> Destination:
>   -smp 64,maxcpus=3D64,cores=3D1,threads=3D8,sockets=3D1
>   qemu: cpu topology: sockets (1) * cores (1) * threads (8) < smp_cpus =
(64)

The destination should have sockets=3D8, shouldn't it?

It seems to me that, at startup, you should have cpus =3D s*t*c and cpus
<=3D maxcpus.  Currently we check cpus <=3D s*t*c <=3D maxcpus, which doe=
sn't
make much sense.

Paolo

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  vl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index 16b913f..2b35e0c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1238,10 +1238,10 @@ static void smp_parse(QemuOpts *opts)
>              exit(1);
>          }
> =20
> -        if (sockets * cores * threads > max_cpus) {
> +        if (sockets * cores * threads !=3D max_cpus) {
>              error_report("cpu topology: "
> -                         "sockets (%u) * cores (%u) * threads (%u) > "
> -                         "maxcpus (%u)",
> +                         "sockets (%u) * cores (%u) * threads (%u) not=
 equal to"
> +                         " maxcpus (%u)",
>                           sockets, cores, threads, max_cpus);
>              exit(1);
>          }
>=20
