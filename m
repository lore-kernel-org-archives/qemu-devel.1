Received: from eggs.gnu.org ([2001:4830:134:3::10]:41825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=245da84ed=Paul.Durrant@citrix.com>)
	id 1cptKp-0008Ub-AI
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=245da84ed=Paul.Durrant@citrix.com>)
	id 1cptKk-0005kW-Qg
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:10:39 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:10316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=245da84ed=Paul.Durrant@citrix.com>)
	id 1cptKk-0005kI-FW
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:10:34 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 20 Mar 2017 08:41:07 +0000
Message-ID: <a07cadee86b44356b5547198ee62c28e@AMSPEX02CL03.citrite.net>
References: <1489757419-8179-1-git-send-email-paul.durrant@citrix.com>
	<f8f4b60f-8407-7e56-4fac-70704f3b4c87@amsat.org>
In-Reply-To: <f8f4b60f-8407-7e56-4fac-70704f3b4c87@amsat.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen: use libxendevice model to restrict
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <f4bug@amsat.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=E9 [mailto:philippe.mathieu.daude@gmail.com]
> On Behalf Of Philippe Mathieu-Daud=E9
> Sent: 17 March 2017 21:21
> To: Paul Durrant <Paul.Durrant@citrix.com>; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org
> Cc: Anthony Perard <anthony.perard@citrix.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [Qemu-devel] [PATCH] xen: use libxendevice model to restrict
> operations
>=20
> Hi Paul,
>=20
> On 03/17/2017 10:30 AM, Paul Durrant wrote:
> > This patch adds a command-line option (-xen-domid-restrict) which will
> > use the new libxendevicemodel API to restrict devicemodel operations to
> > the specified domid.
> >
> > This patch also adds a tracepoint to allow successful enabling of the
> > restriction to be monitored.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> >
> > NOTE: This is already re-based on Juergen Gross's patch "xen: use 5 dig=
it
> >       xen versions" and so should not be applied until after that patch
> >       has been applied.
> > ---
> >  hw/xen/trace-events         |  1 +
> >  include/hw/xen/xen.h        |  1 +
> >  include/hw/xen/xen_common.h | 23 +++++++++++++++++++++++
> >  qemu-options.hx             |  6 ++++++
> >  vl.c                        |  8 ++++++++
> >  xen-hvm.c                   |  8 ++++++++
> >  6 files changed, 47 insertions(+)
> >
> > diff --git a/hw/xen/trace-events b/hw/xen/trace-events
> > index c4fb6f1..a5b5e8b 100644
> > --- a/hw/xen/trace-events
> > +++ b/hw/xen/trace-events
> > @@ -11,3 +11,4 @@ xen_map_portio_range(uint32_t id, uint64_t
> start_addr, uint64_t end_addr) "id: %
> >  xen_unmap_portio_range(uint32_t id, uint64_t start_addr, uint64_t
> end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
> >  xen_map_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "i=
d:
> %u bdf: %02x.%02x.%02x"
> >  xen_unmap_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) =
"id:
> %u bdf: %02x.%02x.%02x"
> > +xen_domid_restrict(void) ""
> > diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> > index 2b1733b..7efcdaa 100644
> > --- a/include/hw/xen/xen.h
> > +++ b/include/hw/xen/xen.h
> > @@ -21,6 +21,7 @@ enum xen_mode {
> >
> >  extern uint32_t xen_domid;
> >  extern enum xen_mode xen_mode;
> > +extern bool xen_domid_restrict;
> >
> >  extern bool xen_allowed;
> >
> > diff --git a/include/hw/xen/xen_common.h
> b/include/hw/xen/xen_common.h
> > index df098c7..5962bc4 100644
> > --- a/include/hw/xen/xen_common.h
> > +++ b/include/hw/xen/xen_common.h
> > @@ -152,6 +152,13 @@ static inline int xendevicemodel_set_mem_type(
> >      return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
> >  }
> >
> > +static inline int xendevicemodel_restrict(
> > +    xendevicemodel_handle *dmod, domid_t domid)
> > +{
> > +    errno =3D ENOTTY;
> > +    return -1;
> > +}
> > +
> >  #else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >=3D 40900 */
> >
> >  #include <xendevicemodel.h>
> > @@ -206,6 +213,22 @@ static inline int xen_modified_memory(domid_t
> domid, uint64_t first_pfn,
> >      return xendevicemodel_modified_memory(xen_dmod, domid,
> first_pfn, nr);
> >  }
> >
> > +static inline int xen_restrict(domid_t domid)
> > +{
> > +    int rc =3D xendevicemodel_restrict(xen_dmod, domid);
>=20
> might it be more useful to log the retcode?
>=20
>         trace_xen_domid_restrict(rc);
>=20
> > +
> > +    if (rc =3D=3D 0) {
> > +        trace_xen_domid_restrict();
>=20
> and drop the previous line.

Actually the retcode is pretty uninteresting but tracing errno would be a g=
ood idea so I think I'll do that.

Cheers,

  Paul

>=20
> > +        return 0;
> > +    }
> > +
> > +    if (errno =3D=3D ENOTTY) {
> > +        return 0;
> > +    }
> > +
> > +    return rc;
> > +}
> > +
> >  /* Xen 4.2 through 4.6 */
> >  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40701
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 99af8ed..4aab077 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3354,6 +3354,10 @@ DEF("xen-attach", 0,
> QEMU_OPTION_xen_attach,
> >      "-xen-attach     attach to existing xen domain\n"
> >      "                xend will use this when starting QEMU\n",
> >      QEMU_ARCH_ALL)
> > +DEF("xen-domid-restrict", 0, QEMU_OPTION_xen_domid_restrict,
> > +    "-xen-domid-restrict     restrict set of available xen operations\=
n"
> > +    "                        to specified domain id\n",
> > +    QEMU_ARCH_ALL)
> >  STEXI
> >  @item -xen-domid @var{id}
> >  @findex -xen-domid
> > @@ -3366,6 +3370,8 @@ Warning: should not be used when xend is in use
> (XEN only).
> >  @findex -xen-attach
> >  Attach to existing xen domain.
> >  xend will use this when starting QEMU (XEN only).
> > +@findex -xen-domid-restrict
> > +Restrict set of available xen operations to specified domain id (XEN o=
nly).
> >  ETEXI
> >
> >  DEF("no-reboot", 0, QEMU_OPTION_no_reboot, \
> > diff --git a/vl.c b/vl.c
> > index 0b4ed52..f46e070 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -205,6 +205,7 @@ static NotifierList machine_init_done_notifiers =3D
> >  bool xen_allowed;
> >  uint32_t xen_domid;
> >  enum xen_mode xen_mode =3D XEN_EMULATE;
> > +bool xen_domid_restrict;
> >
> >  static int has_defaults =3D 1;
> >  static int default_serial =3D 1;
> > @@ -3933,6 +3934,13 @@ int main(int argc, char **argv, char **envp)
> >                  }
> >                  xen_mode =3D XEN_ATTACH;
> >                  break;
> > +            case QEMU_OPTION_xen_domid_restrict:
> > +                if (!(xen_available())) {
> > +                    error_report("Option not supported for this target=
");
> > +                    exit(1);
> > +                }
> > +                xen_domid_restrict =3D true;
> > +                break;
> >              case QEMU_OPTION_trace:
> >                  g_free(trace_file);
> >                  trace_file =3D trace_opt_parse(optarg);
> > diff --git a/xen-hvm.c b/xen-hvm.c
> > index 4b928cf..335e263 100644
> > --- a/xen-hvm.c
> > +++ b/xen-hvm.c
> > @@ -1226,6 +1226,14 @@ void xen_hvm_init(PCMachineState *pcms,
> MemoryRegion **ram_memory)
> >          goto err;
> >      }
> >
> > +    if (xen_domid_restrict) {
> > +        rc =3D xen_restrict(xen_domid);
> > +        if (rc < 0) {
> > +            error_report("failed to restrict: error %d", errno);
> > +            goto err;
> > +        }
> > +    }
> > +
> >      xen_create_ioreq_server(xen_domid, &state->ioservid);
> >
> >      state->exit.notify =3D xen_exit_notifier;
> >
