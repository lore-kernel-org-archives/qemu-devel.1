Received: from eggs.gnu.org ([2001:4830:134:3::10]:48021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCNa3-0004Pd-3g
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCNa1-0002pF-NX
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:27:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCNa1-0002p0-Ed
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:27:33 -0500
Date: Wed, 8 Nov 2017 10:27:26 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108102726.GM12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-2-f4bug@amsat.org>
	<0f594637-3668-91b1-76e4-5964dcdae84b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f594637-3668-91b1-76e4-5964dcdae84b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] machine: add a deprecated_reason
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, Nov 08, 2017 at 11:23:53AM +0100, Thomas Huth wrote:
> On 08.11.2017 03:28, Philippe Mathieu-Daud=C3=A9 wrote:
> > If a machine has the deprecated_reason property set:
> > - it won't get listed anymore by the "-M help" command,
> > - a warning will be displayed if the machine is used.
> >=20
> > Example:
> >   $ ppc-softmmu/qemu-system-ppc -M prep
> >   qemu-system-ppc: -M prep: warning: The PowerPC PREP platform machin=
e is deprecated (Obsoleted by the "40p" machine)
> >   [machine starting ...]
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  include/hw/boards.h | 1 +
> >  vl.c                | 7 +++++++
> >  2 files changed, 8 insertions(+)
> >=20
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 191a5b3cd8..4d5c180968 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -182,6 +182,7 @@ struct MachineClass {
> >      const char *default_boot_order;
> >      const char *default_display;
> >      GArray *compat_props;
> > +    const char *deprecated_reason;
> >      const char *hw_version;
> >      ram_addr_t default_ram_size;
> >      const char *default_cpu_type;
> > diff --git a/vl.c b/vl.c
> > index ec299099ff..9ed4648af2 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2742,6 +2742,10 @@ static gint machine_class_cmp(gconstpointer a,=
 gconstpointer b)
> >      }
> >      if (mc) {
> >          g_slist_free(machines);
> > +        if (mc->deprecated_reason) {
> > +            warn_report("The %s machine is deprecated (%s)",
> > +                        mc->desc, mc->deprecated_reason);
> > +        }
>=20
> Just cosmetic, but maybe rather put that into select_machine() instead?
>=20
> >          return mc;
> >      }
> >      if (name && !is_help_option(name)) {
> > @@ -2752,6 +2756,9 @@ static gint machine_class_cmp(gconstpointer a, =
gconstpointer b)
> >          machines =3D g_slist_sort(machines, machine_class_cmp);
> >          for (el =3D machines; el; el =3D el->next) {
> >              MachineClass *mc =3D el->data;
> > +            if (mc->deprecated_reason) {
> > +                continue;
> > +            }
>=20
> Not sure, but maybe it would be more user-friendly to still list the
> machine, but add a "(deprecated)" string at the end?

Yeah, as long as it still exists, it should be visible.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
