Received: from eggs.gnu.org ([2001:4830:134:3::10]:52158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2479a8bc7=Paul.Durrant@citrix.com>)
	id 1cqcT8-0004ap-E3
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2479a8bc7=Paul.Durrant@citrix.com>)
	id 1cqcT5-0001H6-6f
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:22:14 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:1959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2479a8bc7=Paul.Durrant@citrix.com>)
	id 1cqcT4-0001GI-R3
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:22:11 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 22 Mar 2017 09:22:07 +0000
Message-ID: <d43dda6caa16440781a6a41e06282b8d@AMSPEX02CL03.citrite.net>
References: <1490120877-3731-1-git-send-email-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1703211158040.11679@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1703211158040.11679@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] xen: use libxendevice model to restrict
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Anthony
	Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 21 March 2017 18:59
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano
> Stabellini <sstabellini@kernel.org>; Anthony Perard
> <anthony.perard@citrix.com>; Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v3] xen: use libxendevice model to restrict operation=
s
>=20
> On Tue, 21 Mar 2017, Paul Durrant wrote:
> > This patch adds a command-line option (-xen-domid-restrict) which will
> > use the new libxendevicemodel API to restrict devicemodel [1] operation=
s
> > to the specified domid. (Such operations are not applicable to the xenp=
v
> > machine type).
> >
> > This patch also adds a tracepoint to allow successful enabling of the
> > restriction to be monitored.
> >
> > [1] I.e. operations issued by libxendevicemodel. Operation issued by ot=
her
> >     xen libraries (e.g. libxenforeignmemory) are currently still unrest=
ricted
> >     but this will be rectified by subsequent patches.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>=20
> In file included from qemu-options-wrapper.h:32:0,
>                  from qemu-options.h:33,
>                  from os-posix.c:36:
> qemu-options.def:698:1: error: missing terminating " character [-Werror]
> cc1: all warnings being treated as errors
> make: *** [os-posix.o] Error 1
> make: *** Waiting for unfinished jobs....
>=20
> You are missing a \"

So I am. I'll send v4.

  Paul

>=20
>=20
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> >
> > NOTE: This is already re-based on Juergen Gross's patch "xen: use 5 dig=
it
> >       xen versions" and so should not be applied until after that patch
> >       has been applied.
> >
> > v2:
> >  - Log errno in tracepoint
> > ---
> >  hw/xen/trace-events         |  1 +
> >  include/hw/xen/xen.h        |  1 +
> >  include/hw/xen/xen_common.h | 20 ++++++++++++++++++++
> >  qemu-options.hx             |  7 +++++++
> >  vl.c                        |  8 ++++++++
> >  xen-hvm.c                   |  8 ++++++++
> >  6 files changed, 45 insertions(+)
> >
> > diff --git a/hw/xen/trace-events b/hw/xen/trace-events
> > index c4fb6f1..5615dce 100644
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
> > +xen_domid_restrict(int err) "err: %u"
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
> > index df098c7..4f3bd35 100644
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
> > @@ -206,6 +213,19 @@ static inline int xen_modified_memory(domid_t
> domid, uint64_t first_pfn,
> >      return xendevicemodel_modified_memory(xen_dmod, domid,
> first_pfn, nr);
> >  }
> >
> > +static inline int xen_restrict(domid_t domid)
> > +{
> > +    int rc =3D xendevicemodel_restrict(xen_dmod, domid);
> > +
> > +    trace_xen_domid_restrict(errno);
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
> > index 99af8ed..d380f7d 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3354,6 +3354,11 @@ DEF("xen-attach", 0,
> QEMU_OPTION_xen_attach,
> >      "-xen-attach     attach to existing xen domain\n"
> >      "                xend will use this when starting QEMU\n",
> >      QEMU_ARCH_ALL)
> > +DEF("xen-domid-restrict", 0, QEMU_OPTION_xen_domid_restrict,
> > +    "-xen-domid-restrict     restrict set of available xen operations\=
n"
> > +    "                        to specified domain id. (Does not affect\=
n
> > +    "                        xenpv machine type).\n",
> > +    QEMU_ARCH_ALL)
> >  STEXI
> >  @item -xen-domid @var{id}
> >  @findex -xen-domid
> > @@ -3366,6 +3371,8 @@ Warning: should not be used when xend is in use
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
> > --
> > 2.1.4
> >
