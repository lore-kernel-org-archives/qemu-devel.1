Received: from eggs.gnu.org ([2001:4830:134:3::10]:48010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9V1D-0006UJ-Ik
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9V10-0005RL-NV
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:52:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9V10-0005Pv-Cm
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:52:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-7-alex.bennee@linaro.org>
Date: Mon, 08 Oct 2018 14:51:56 +0200
In-Reply-To: <20181005154910.3099-7-alex.bennee@linaro.org> ("Alex
	=?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Fri, 5 Oct 2018 16:48:55 +0100")
Message-ID: <87efd04n4j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 06/21] trace: show trace point counts
 in the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Now we have counts for each trace point we can expose them in the
> monitor when the user queries what trace points are available.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  monitor.c       | 5 +++--
>  qapi/trace.json | 3 ++-
>  trace/qmp.c     | 1 +
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index c4677b502b..d8229cd2b0 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1421,9 +1421,10 @@ static void hmp_info_trace_events(Monitor *mon, co=
nst QDict *qdict)
>      }
>=20=20
>      for (elem =3D events; elem !=3D NULL; elem =3D elem->next) {
> -        monitor_printf(mon, "%s : state %u\n",
> +        monitor_printf(mon, "%s : state %u count %" PRIu64 "\n",
>                         elem->value->name,
> -                       elem->value->state =3D=3D TRACE_EVENT_STATE_ENABL=
ED ? 1 : 0);
> +                       elem->value->state =3D=3D TRACE_EVENT_STATE_ENABL=
ED ? 1 : 0,
> +                       elem->value->count);
>      }
>      qapi_free_TraceEventInfoList(events);
>  }
> diff --git a/qapi/trace.json b/qapi/trace.json
> index 799b254a18..b9184b0d18 100644
> --- a/qapi/trace.json
> +++ b/qapi/trace.json
> @@ -33,6 +33,7 @@
>  # @name: Event name.
>  # @state: Tracing state.
>  # @vcpu: Whether this is a per-vCPU event (since 2.7).
> +# @count: Current hits on trace-point (since 3.1).

Suggest something like "Number of hits".

>  #
>  # An event is per-vCPU if it has the "vcpu" property in the "trace-event=
s"
>  # files.
> @@ -40,7 +41,7 @@
>  # Since: 2.2
>  ##
>  { 'struct': 'TraceEventInfo',
> -  'data': {'name': 'str', 'state': 'TraceEventState', 'vcpu': 'bool'} }
> +  'data': {'name': 'str', 'state': 'TraceEventState', 'vcpu': 'bool', 'c=
ount': 'int' } }
>=20=20
>  ##
>  # @trace-event-get-state:
> diff --git a/trace/qmp.c b/trace/qmp.c
> index ea99b00956..cce8198091 100644
> --- a/trace/qmp.c
> +++ b/trace/qmp.c
> @@ -102,6 +102,7 @@ TraceEventInfoList *qmp_trace_event_get_state(const c=
har *name,
>          elem->value =3D g_new(TraceEventInfo, 1);
>          elem->value->vcpu =3D is_vcpu;
>          elem->value->name =3D g_strdup(trace_event_get_name(ev));
> +        elem->value->count =3D ev->count;

I suspect this converts from uint64_t to int64_t.  Change the type to
'uint64' in the QAPI schema?

>=20=20
>          if (!trace_event_get_state_static(ev)) {
>              elem->value->state =3D TRACE_EVENT_STATE_UNAVAILABLE;
