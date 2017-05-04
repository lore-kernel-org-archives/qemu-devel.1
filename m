Received: from eggs.gnu.org ([2001:4830:134:3::10]:32961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1d6KFm-0002sf-Ob
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1d6KFh-0006ur-OD
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:09:22 -0400
Message-ID: <1493917751.4214.12.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 04 May 2017 19:09:11 +0200
In-Reply-To: <20170427072843.8089-3-david@gibson.dropbear.id.au>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 2/4] pseries: Move CPU compatibility
 property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Cc: agraf@suse.de, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Thu, 2017-04-27 at 17:28 +1000, David Gibson wrote:
> @@ -2480,6 +2480,10 @@ static void spapr_machine_initfn(Object *obj)
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0" place of standard EPOW events when possible"
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0" (required for memory hot-unplug support)",
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0NULL);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0object_property_add(obj, "max-cpu-compat", "st=
r",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p=
pc_compat_prop_get, ppc_compat_prop_set,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0N=
ULL, &spapr->max_compat_pvr, &error_fatal);

I'm not familiar with QEMU's object system, but shouldn't
you be using object_property_add_str() instead? It looks
like you're doing more than the straightforward wrapper
would do, so maybe that's just not possible.


In any case, all other string properties look like

=C2=A0 pseries-2.10.kvm-type=3Dstring

whereas this one ends up looking like

=C2=A0 pseries-2.10.max-cpu-compat=3Dstr

which I think should be fixed - object_property_add_str()
passes "string" instead of "str" to object_property_add().

You should also add a sensible description for the property,
preferably spelling out all the accepted values.


Speaking of properties...

=C2=A0 $ qemu-system-ppc64 -cpu host,compat=3Dwhatever
=C2=A0 Segmentation fault

You might want to look into that ;)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
