Received: from eggs.gnu.org ([2001:4830:134:3::10]:50024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNQLs-0004av-8e
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNQLp-0007QE-3G
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:43:08 -0500
References: <20181115215449.1300769-1-eblake@redhat.com>
	<b600b483-0e46-5c2e-f52b-2f330ebaa5a7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e772baf5-80eb-3690-1782-cb2d69302fe3@redhat.com>
Date: Thu, 15 Nov 2018 16:43:02 -0600
MIME-Version: 1.0
In-Reply-To: <b600b483-0e46-5c2e-f52b-2f330ebaa5a7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: Reduce Makefile boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com, xiezhide@huawei.com, Paolo Bonzini <pbonzini@redhat.com>

On 11/15/18 4:37 PM, Eric Blake wrote:
> I'm trying to do the same thing to Makefile.objs, but when I use:
>=20
> common-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.o)
>=20
> or the longer $(patsubst %,qapi,qapi-commands-%.o,$(QAPI_MODULES))
>=20
> both before and after the change, 'make print-common-obj-y | grep qapi'=
=20
> returns identical content, but after the change, the linker fails with:
>=20

>=20
> So something about variable expansions is NOT playing nicely with our
>=20
> dummy :=3D $(call unnest-vars,, \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 stub-obj-y \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 chardev-obj-y \
> ...
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 common-obj-y \

Aha - the problem is that $(QAPI_MODULES) is empty at the time=20
unnest-vars tries to slurp in Makefile.objs, while it was non-empty at=20
the time that Makefile directly includes it. Moving the definition of=20
QAPI_MODULES into Makefile.objs solves that. v2 coming up.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
