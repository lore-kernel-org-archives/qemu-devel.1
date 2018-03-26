Received: from eggs.gnu.org ([2001:4830:134:3::10]:37428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Y0p-0006Oy-S3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Y0m-0006Nz-Nj
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:42:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0Y0m-0006Nm-I4
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:42:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D34F82EE70F
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 19:42:28 +0000 (UTC)
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-3-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <93e6b7be-bec8-1a6d-b0e8-fada31c58ca6@redhat.com>
Date: Mon, 26 Mar 2018 14:42:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/8] qmp: cleanup qmp queues
 properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/26/2018 01:38 AM, Peter Xu wrote:
> Marc-Andr=C3=A9 Lureau reported that we can have this happen:
>=20
> 1. client1 connects, send command C1
> 2. client1 disconnects before getting response for C1
> 3. client2 connects, who might receive response of C1
>=20
> However client2 should not receive remaining responses for client1.
>=20
> Basically, we should clean up the request/response queue elements when:
>=20
> - before a session established

Why here? [1]

> - after a session is closed
> - before destroying the queues
>=20
> Some helpers are introduced to achieve that.  We need to make sure we'r=
e
> with the lock when operating on those queues.
>=20

It would also be helpful to mention that the patch includes code motion=20
to declare struct QMPRequest earlier in the file.

> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   monitor.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++-------=
---------
>   1 file changed, 59 insertions(+), 20 deletions(-)
>=20

> +static void qmp_request_free(QMPRequest *req)
> +{
> +    qobject_decref(req->id);
> +    qobject_decref(req->req);
> +    g_free(req);
> +}
> +
> +static void qmp_response_free(QObject *obj)
> +{
> +    qobject_decref(obj);
> +}

Why do we need this function?  Unless you plan to add to it in later=20
patches, I'd rather just inline things and directly call=20
qobject_decref() at the callsites...

> +
> +/* Must with the mon->qmp.qmp_queue_lock held */
> +static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
> +{
> +    while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
> +        qmp_request_free(g_queue_pop_head(mon->qmp.qmp_requests));
> +    }
> +}
> +
> +/* Must with the mon->qmp.qmp_queue_lock held */
> +static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
> +{
> +    while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
> +        qmp_response_free(g_queue_pop_head(mon->qmp.qmp_responses));

...here,

> +    }
> +}
> +
> +static void monitor_qmp_cleanup_queues(Monitor *mon)
> +{
> +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> +    monitor_qmp_cleanup_req_queue_locked(mon);
> +    monitor_qmp_cleanup_resp_queue_locked(mon);
> +    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +}
> +
> +
>   static void monitor_flush_locked(Monitor *mon);
>  =20
>   static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond=
,
> @@ -497,7 +550,7 @@ static void monitor_qmp_bh_responder(void *opaque)
>               break;
>           }
>           monitor_json_emitter_raw(response.mon, response.data);
> -        qobject_decref(response.data);
> +        qmp_response_free(response.data);

and here.

> @@ -4327,6 +4364,7 @@ static void monitor_qmp_event(void *opaque, int e=
vent)
>  =20
>       switch (event) {
>       case CHR_EVENT_OPENED:
> +        monitor_qmp_cleanup_queues(mon);

[1] How would something be queued to need cleanup at this point, if we=20
already start with a clean queue before the first monitor, and if all=20
monitor close actions clean the queue?

>           mon->qmp.commands =3D &qmp_cap_negotiation_commands;
>           monitor_qmp_caps_reset(mon);
>           data =3D get_qmp_greeting(mon);
> @@ -4335,6 +4373,7 @@ static void monitor_qmp_event(void *opaque, int e=
vent)
>           mon_refcount++;
>           break;
>       case CHR_EVENT_CLOSED:
> +        monitor_qmp_cleanup_queues(mon);
>           json_message_parser_destroy(&mon->qmp.parser);
>           json_message_parser_init(&mon->qmp.parser, handle_qmp_command=
);
>           mon_refcount--;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
