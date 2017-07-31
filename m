Received: from eggs.gnu.org ([2001:4830:134:3::10]:44749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dcCKi-00051e-6B
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dcCKd-00087o-3c
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:10:12 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:42158)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dcCKc-00085U-IK
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:10:07 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170731140718.22010-1-stefanha@redhat.com>
	<20170731140718.22010-3-stefanha@redhat.com>
Date: Mon, 31 Jul 2017 18:09:56 +0300
In-Reply-To: <20170731140718.22010-3-stefanha@redhat.com> (Stefan Hajnoczi's
	message of "Mon, 31 Jul 2017 15:07:18 +0100")
Message-ID: <87d18g3anv.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] trace: add
 trace_event_get_state_backends()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, "Daniel P. Berrange" <berrange@redhat.com>

Stefan Hajnoczi writes:

> Code that checks dstate is unaware of SystemTap and LTTng UST dstate, so
> the following trace event will not fire when solely enabled by SystemTap
> or LTTng UST:

>   if (trace_event_get_state(TRACE_MY_EVENT)) {
>       str =3D g_strdup_printf("Expensive string to generate ...",
>                             ...);
>       trace_my_event(str);
>       g_free(str);
>   }

I believe this should be trace_event_get_state_backends(). Same applies to =
the
cover letter.

Cheers,
  Lluis

> Add trace_event_get_state_backends() to fetch backend dstate.  Those
> backends that use QEMU dstate fetch it as part of
> generate_h_backend_dstate().

> Update existing trace_event_get_state() callers to use
> trace_event_get_state_backends() instead.

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Use _backends() postfix to clarify function purpose [Llu=C3=ADs]
> ---
>  docs/devel/tracing.txt |  2 +-
>  trace/control.h        | 18 +++++++++++++++++-
>  hw/usb/hcd-ohci.c      | 13 +++++--------
>  net/colo-compare.c     | 11 ++++++-----
>  net/filter-rewriter.c  |  4 ++--
>  5 files changed, 31 insertions(+), 17 deletions(-)

> diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
> index 5768a0b7a2..07abbb345c 100644
> --- a/docs/devel/tracing.txt
> +++ b/docs/devel/tracing.txt
> @@ -353,7 +353,7 @@ guard such computations and avoid its compilation whe=
n the event is disabled:
>      }
=20
>  You can check both if the event has been disabled and is dynamically ena=
bled at
> -the same time using the 'trace_event_get_state' routine (see header
> +the same time using the 'trace_event_get_state_backends' routine (see he=
ader
>  "trace/control.h" for more information).
=20
>  =3D=3D=3D "tcg" =3D=3D=3D
> diff --git a/trace/control.h b/trace/control.h
> index b931824d60..1903e22975 100644
> --- a/trace/control.h
> +++ b/trace/control.h
> @@ -96,7 +96,7 @@ static const char * trace_event_get_name(TraceEvent *ev=
);
>   * trace_event_get_state:
>   * @id: Event identifier name.
>   *
> - * Get the tracing state of an event (both static and dynamic).
> + * Get the tracing state of an event, both static and the QEMU dynamic s=
tate.
>   *
>   * If the event has the disabled property, the check will have no perfor=
mance
>   * impact.
> @@ -105,6 +105,22 @@ static const char * trace_event_get_name(TraceEvent =
*ev);
>      ((id ##_ENABLED) && trace_event_get_state_dynamic_by_id(id))
=20
>  /**
> + * trace_event_get_state_backends:
> + * @id: Event identifier name.
> + *
> + * Get the tracing state of an event, both static and dynamic state from=
 all
> + * compiled-in backends.
> + *
> + * If the event has the disabled property, the check will have no perfor=
mance
> + * impact.
> + *
> + * Returns: true if at least one backend has the event enabled and the e=
vent
> + * does not have the disabled property.
> + */
> +#define trace_event_get_state_backends(id)              \
> +    ((id ##_ENABLED) && id ##_BACKEND_DSTATE())
> +
> +/**
>   * trace_event_get_vcpu_state:
>   * @vcpu: Target vCPU.
>   * @id: Event identifier name.
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 3ada35e954..267982e160 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -936,16 +936,18 @@ static int ohci_service_iso_td(OHCIState *ohci, str=
uct ohci_ed *ed,
>      return 1;
>  }
=20
> -#ifdef trace_event_get_state
>  static void ohci_td_pkt(const char *msg, const uint8_t *buf, size_t len)
>  {
> -    bool print16 =3D !!trace_event_get_state(TRACE_USB_OHCI_TD_PKT_SHORT=
);
> -    bool printall =3D !!trace_event_get_state(TRACE_USB_OHCI_TD_PKT_FULL=
);
> +    bool print16;
> +    bool printall;
>      const int width =3D 16;
>      int i;
>      char tmp[3 * width + 1];
>      char *p =3D tmp;
=20
> +    print16 =3D !!trace_event_get_state_backends(TRACE_USB_OHCI_TD_PKT_S=
HORT);
> +    printall =3D !!trace_event_get_state_backends(TRACE_USB_OHCI_TD_PKT_=
FULL);
> +
>      if (!printall && !print16) {
>          return;
>      }
> @@ -967,11 +969,6 @@ static void ohci_td_pkt(const char *msg, const uint8=
_t *buf, size_t len)
>          p +=3D sprintf(p, " %.2x", buf[i]);
>      }
>  }
> -#else
> -static void ohci_td_pkt(const char *msg, const uint8_t *buf, size_t len)
> -{
> -}
> -#endif
=20
>  /* Service a transport descriptor.
>     Returns nonzero to terminate processing of this endpoint.  */
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index ca67c68615..5fe8e3fad9 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -188,7 +188,7 @@ static int packet_enqueue(CompareState *s, int mode)
>   */
>  static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int of=
fset)
>  {
> -    if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
> +    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
>          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[=
20];
=20
>          strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
> @@ -274,7 +274,8 @@ static int colo_packet_compare_tcp(Packet *spkt, Pack=
et *ppkt)
>          res =3D -1;
>      }
=20
> -    if (res !=3D 0 && trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPAR=
E)) {
> +    if (res !=3D 0 &&
> +        trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
>          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[=
20];
=20
>          strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
> @@ -334,7 +335,7 @@ static int colo_packet_compare_udp(Packet *spkt, Pack=
et *ppkt)
>      if (ret) {
>          trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size=
);
>          trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->si=
ze);
> -        if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
> +        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE=
)) {
>              qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri p=
kt",
ppkt-> size);
>              qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec p=
kt",
> @@ -371,7 +372,7 @@ static int colo_packet_compare_icmp(Packet *spkt, Pac=
ket *ppkt)
ppkt-> size);
>          trace_colo_compare_icmp_miscompare("Secondary pkt size",
spkt-> size);
> -        if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
> +        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE=
)) {
>              qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri p=
kt",
ppkt-> size);
>              qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec p=
kt",
> @@ -390,7 +391,7 @@ static int colo_packet_compare_icmp(Packet *spkt, Pac=
ket *ppkt)
>  static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
>  {
>      trace_colo_compare_main("compare other");
> -    if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
> +    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
>          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[=
20];
=20
>          strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index 55a6cf56fd..98120095de 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -69,7 +69,7 @@ static int handle_primary_tcp_pkt(NetFilterState *nf,
>      struct tcphdr *tcp_pkt;
=20
>      tcp_pkt =3D (struct tcphdr *)pkt->transport_header;
> -    if (trace_event_get_state(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
> +    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)=
) {
>          trace_colo_filter_rewriter_pkt_info(__func__,
>                      inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_ds=
t),
>                      ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
> @@ -115,7 +115,7 @@ static int handle_secondary_tcp_pkt(NetFilterState *n=
f,
=20
>      tcp_pkt =3D (struct tcphdr *)pkt->transport_header;
=20
> -    if (trace_event_get_state(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
> +    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)=
) {
>          trace_colo_filter_rewriter_pkt_info(__func__,
>                      inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_ds=
t),
>                      ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
> --=20
> 2.13.3
