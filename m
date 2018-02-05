Received: from eggs.gnu.org ([2001:4830:134:3::10]:36211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eij5l-0004fS-Gf
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eij5i-0006Vw-Fi
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:54:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eij5i-0006UE-A2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:53:58 -0500
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
Date: Mon, 5 Feb 2018 16:53:47 +0100
MIME-Version: 1.0
In-Reply-To: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jianfeng Tan <jianfeng.tan@intel.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On 05/02/2018 15:58, Jianfeng Tan wrote:
> Here are some options to fix this:
>=20
> 1. When we do ram name comparison, we truncate the prefix as this patch=
 shows.
> It cannot cover the corner case: the source VM could have two ram block=
s
> with name of "pc.ram" and "/object/pc.ram".

That shouldn't happen ("pc.ram" exists even in the "-numa
node,memdev=3D..." case, but it has no RAM block).

>      RAMBLOCK_FOREACH(block) {
> -        if (!strcmp(name, block->idstr)) {
> +        name2 =3D strdup(block->idstr);
> +	id2 =3D basename(name2);
> +        if (!strcmp(id1, id2)) {
> +            free(name1);
> +	    free(name2);
>              return block;
>          }
> +	free(name2);

Instead of this, perhaps just skip "/object/" in both id1 and
block->idstr?  This also removes the need for strdup/free.

However, note that

  -m xG -numa node,memdev=3Dpc.ram \
  -object memory-backend-file,id=3Dpc.ram,...

works for both vhost-kernel and vhost-user, so I'd rather consider this
a configuration problem and not do anything.

Thanks,

Paolo

>      }
> =20
> +    free(name1);
>      return NULL;
>  }
> =20
>=20
