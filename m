Received: from eggs.gnu.org ([2001:4830:134:3::10]:60981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cqN2J-0007xF-IY
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cqN2F-0003CQ-LG
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:53:31 -0400
Received: from mail.kernel.org ([198.145.29.136]:40744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cqN2F-0003CJ-AN
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:53:27 -0400
Date: Tue, 21 Mar 2017 09:53:13 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <072db16bacfd432b8eb7df09cb1eab7d@AMSPEX02CL03.citrite.net>
Message-ID: <alpine.DEB.2.10.1703210952090.18429@sstabellini-ThinkPad-X260>
References: <1490028748-3780-1-git-send-email-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1703201501320.11533@sstabellini-ThinkPad-X260>
	<072db16bacfd432b8eb7df09cb1eab7d@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] xen: use libxendevice model to restrict
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Ian Jackson <Ian.Jackson@citrix.com>

On Tue, 21 Mar 2017, Paul Durrant wrote:
> Fixing list address...
> 
> > -----Original Message-----
> > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > Sent: 20 March 2017 22:05
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: qemu-devel@lists.xenproject.org; Stefano Stabellini
> > <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>;
> > Paolo Bonzini <pbonzini@redhat.com>
> > Subject: Re: [PATCH v2] xen: use libxendevice model to restrict operations
> > 
> > On Mon, 20 Mar 2017, Paul Durrant wrote:
> > > This patch adds a command-line option (-xen-domid-restrict) which will
> > > use the new libxendevicemodel API to restrict devicemodel operations to
> > > the specified domid.
> > >
> > > This patch also adds a tracepoint to allow successful enabling of the
> > > restriction to be monitored.
> > >
> > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > ---
> > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > > Cc: Anthony Perard <anthony.perard@citrix.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > >
> > > NOTE: This is already re-based on Juergen Gross's patch "xen: use 5 digit
> > >       xen versions" and so should not be applied until after that patch
> > >       has been applied.
> > >
> > > v2:
> > >  - Log errno in tracepoint
> > > ---
> > >  hw/xen/trace-events         |  1 +
> > >  include/hw/xen/xen.h        |  1 +
> > >  include/hw/xen/xen_common.h | 20 ++++++++++++++++++++
> > >  qemu-options.hx             |  6 ++++++
> > >  vl.c                        |  8 ++++++++
> > >  xen-hvm.c                   |  8 ++++++++
> > >  6 files changed, 44 insertions(+)
> > >
> > > diff --git a/hw/xen/trace-events b/hw/xen/trace-events
> > > index c4fb6f1..5615dce 100644
> > > --- a/hw/xen/trace-events
> > > +++ b/hw/xen/trace-events
> > > @@ -11,3 +11,4 @@ xen_map_portio_range(uint32_t id, uint64_t
> > start_addr, uint64_t end_addr) "id: %
> > >  xen_unmap_portio_range(uint32_t id, uint64_t start_addr, uint64_t
> > end_addr) "id: %u start: %#"PRIx64" end: %#"PRIx64
> > >  xen_map_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id:
> > %u bdf: %02x.%02x.%02x"
> > >  xen_unmap_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id:
> > %u bdf: %02x.%02x.%02x"
> > > +xen_domid_restrict(int err) "err: %u"
> > > diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> > > index 2b1733b..7efcdaa 100644
> > > --- a/include/hw/xen/xen.h
> > > +++ b/include/hw/xen/xen.h
> > > @@ -21,6 +21,7 @@ enum xen_mode {
> > >
> > >  extern uint32_t xen_domid;
> > >  extern enum xen_mode xen_mode;
> > > +extern bool xen_domid_restrict;
> > >
> > >  extern bool xen_allowed;
> > >
> > > diff --git a/include/hw/xen/xen_common.h
> > b/include/hw/xen/xen_common.h
> > > index df098c7..4f3bd35 100644
> > > --- a/include/hw/xen/xen_common.h
> > > +++ b/include/hw/xen/xen_common.h
> > > @@ -152,6 +152,13 @@ static inline int xendevicemodel_set_mem_type(
> > >      return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
> > >  }
> > >
> > > +static inline int xendevicemodel_restrict(
> > > +    xendevicemodel_handle *dmod, domid_t domid)
> > > +{
> > > +    errno = ENOTTY;
> > > +    return -1;
> > > +}
> > > +
> > >  #else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
> > >
> > >  #include <xendevicemodel.h>
> > > @@ -206,6 +213,19 @@ static inline int xen_modified_memory(domid_t
> > domid, uint64_t first_pfn,
> > >      return xendevicemodel_modified_memory(xen_dmod, domid,
> > first_pfn, nr);
> > >  }
> > >
> > > +static inline int xen_restrict(domid_t domid)
> > > +{
> > > +    int rc = xendevicemodel_restrict(xen_dmod, domid);
> > > +
> > > +    trace_xen_domid_restrict(errno);
> > > +
> > > +    if (errno == ENOTTY) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    return rc;
> > > +}
> > > +
> > >  /* Xen 4.2 through 4.6 */
> > >  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40701
> > >
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 99af8ed..4aab077 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -3354,6 +3354,10 @@ DEF("xen-attach", 0,
> > QEMU_OPTION_xen_attach,
> > >      "-xen-attach     attach to existing xen domain\n"
> > >      "                xend will use this when starting QEMU\n",
> > >      QEMU_ARCH_ALL)
> > > +DEF("xen-domid-restrict", 0, QEMU_OPTION_xen_domid_restrict,
> > > +    "-xen-domid-restrict     restrict set of available xen operations\n"
> > > +    "                        to specified domain id\n",
> > > +    QEMU_ARCH_ALL)
> > 
> > Please make a note that the QEMU xenpv machine (backend provider for PV
> > guests) is completely unaffected.
> 
> Sure.
> 
> > 
> > Also, does this xendevicemodel_restrict operation restrict any of the
> > xenstore accesses?
> > 
> 
> Not yet. The intention is that it will (which is why I am not specific in the usage comment) but that facility is not available as yet. The other restriction that is also not yet implemented is foreign memory mapping, which will require a new call to be added to libxenforeignmemory.

That's something worth documenting. If it's all already written in a Xen
doc, then please add a link to it, otherwise, please add few words on
what this restriction does here.


> > 
> > >  STEXI
> > >  @item -xen-domid @var{id}
> > >  @findex -xen-domid
> > > @@ -3366,6 +3370,8 @@ Warning: should not be used when xend is in use
> > (XEN only).
> > >  @findex -xen-attach
> > >  Attach to existing xen domain.
> > >  xend will use this when starting QEMU (XEN only).
> > > +@findex -xen-domid-restrict
> > > +Restrict set of available xen operations to specified domain id (XEN only).
> > >  ETEXI
> > >  DEF("no-reboot", 0, QEMU_OPTION_no_reboot, \
> > > diff --git a/vl.c b/vl.c
> > > index 0b4ed52..f46e070 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -205,6 +205,7 @@ static NotifierList machine_init_done_notifiers =
> > >  bool xen_allowed;
> > >  uint32_t xen_domid;
> > >  enum xen_mode xen_mode = XEN_EMULATE;
> > > +bool xen_domid_restrict;
> > >
> > >  static int has_defaults = 1;
> > >  static int default_serial = 1;
> > > @@ -3933,6 +3934,13 @@ int main(int argc, char **argv, char **envp)
> > >                  }
> > >                  xen_mode = XEN_ATTACH;
> > >                  break;
> > > +            case QEMU_OPTION_xen_domid_restrict:
> > > +                if (!(xen_available())) {
> > > +                    error_report("Option not supported for this target");
> > > +                    exit(1);
> > > +                }
> > > +                xen_domid_restrict = true;
> > > +                break;
> > >              case QEMU_OPTION_trace:
> > >                  g_free(trace_file);
> > >                  trace_file = trace_opt_parse(optarg);
> > > diff --git a/xen-hvm.c b/xen-hvm.c
> > > index 4b928cf..335e263 100644
> > > --- a/xen-hvm.c
> > > +++ b/xen-hvm.c
> > > @@ -1226,6 +1226,14 @@ void xen_hvm_init(PCMachineState *pcms,
> > MemoryRegion **ram_memory)
> > >          goto err;
> > >      }
> > >
> > > +    if (xen_domid_restrict) {
> > > +        rc = xen_restrict(xen_domid);
> > > +        if (rc < 0) {
> > > +            error_report("failed to restrict: error %d", errno);
> > > +            goto err;
> > > +        }
> > > +    }
> > > +
> > >      xen_create_ioreq_server(xen_domid, &state->ioservid);
> > >
> > >      state->exit.notify = xen_exit_notifier;
> > > --
> > > 2.1.4
> > >
> 
