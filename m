Received: from eggs.gnu.org ([2001:4830:134:3::10]:59695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gCkNQ-000696-Qq
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gCkNK-00043b-D3
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:52:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gCkNG-0003lT-KP
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:52:28 -0400
Date: Wed, 17 Oct 2018 12:52:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181017115211.GE2530@work-vm>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-7-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181005154910.3099-7-alex.bennee@linaro.org>
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
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

* Alex Benn=E9e (alex.bennee@linaro.org) wrote:
> Now we have counts for each trace point we can expose them in the
> monitor when the user queries what trace points are available.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor.c       | 5 +++--
>  qapi/trace.json | 3 ++-
>  trace/qmp.c     | 1 +
>  3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index c4677b502b..d8229cd2b0 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1421,9 +1421,10 @@ static void hmp_info_trace_events(Monitor *mon, =
const QDict *qdict)
>      }
> =20
>      for (elem =3D events; elem !=3D NULL; elem =3D elem->next) {
> -        monitor_printf(mon, "%s : state %u\n",
> +        monitor_printf(mon, "%s : state %u count %" PRIu64 "\n",
>                         elem->value->name,
> -                       elem->value->state =3D=3D TRACE_EVENT_STATE_ENA=
BLED ? 1 : 0);
> +                       elem->value->state =3D=3D TRACE_EVENT_STATE_ENA=
BLED ? 1 : 0,
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
>  #
>  # An event is per-vCPU if it has the "vcpu" property in the "trace-eve=
nts"
>  # files.
> @@ -40,7 +41,7 @@
>  # Since: 2.2
>  ##
>  { 'struct': 'TraceEventInfo',
> -  'data': {'name': 'str', 'state': 'TraceEventState', 'vcpu': 'bool'} =
}
> +  'data': {'name': 'str', 'state': 'TraceEventState', 'vcpu': 'bool', =
'count': 'int' } }
> =20
>  ##
>  # @trace-event-get-state:
> diff --git a/trace/qmp.c b/trace/qmp.c
> index ea99b00956..cce8198091 100644
> --- a/trace/qmp.c
> +++ b/trace/qmp.c
> @@ -102,6 +102,7 @@ TraceEventInfoList *qmp_trace_event_get_state(const=
 char *name,
>          elem->value =3D g_new(TraceEventInfo, 1);
>          elem->value->vcpu =3D is_vcpu;
>          elem->value->name =3D g_strdup(trace_event_get_name(ev));
> +        elem->value->count =3D ev->count;
> =20
>          if (!trace_event_get_state_static(ev)) {
>              elem->value->state =3D TRACE_EVENT_STATE_UNAVAILABLE;
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
