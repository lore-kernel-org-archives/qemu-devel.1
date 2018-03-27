Received: from eggs.gnu.org ([2001:4830:134:3::10]:53830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0eO8-0004U7-HY
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0eO5-0006yX-2u
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:31:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0eO4-0006yP-U6
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:31:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A128722C5
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 02:30:58 +0000 (UTC)
Date: Tue, 27 Mar 2018 10:30:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327023050.GG17789@xz-mi>
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-3-peterx@redhat.com>
	<93e6b7be-bec8-1a6d-b0e8-fada31c58ca6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93e6b7be-bec8-1a6d-b0e8-fada31c58ca6@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Mar 26, 2018 at 02:42:23PM -0500, Eric Blake wrote:
> On 03/26/2018 01:38 AM, Peter Xu wrote:
> > Marc-Andr=C3=A9 Lureau reported that we can have this happen:
> >=20
> > 1. client1 connects, send command C1
> > 2. client1 disconnects before getting response for C1
> > 3. client2 connects, who might receive response of C1
> >=20
> > However client2 should not receive remaining responses for client1.
> >=20
> > Basically, we should clean up the request/response queue elements whe=
n:
> >=20
> > - before a session established
>=20
> Why here? [1]

Yes it can be omitted. We can do it either here or closing, the only
difference should be that when added here there's more possibility
that the pending commands (requests from disconnected clients) be
executed rather than dropped.

Here I did the cleanup on both places.  Drop any of them would be fine
too.

>=20
> > - after a session is closed
> > - before destroying the queues
> >=20
> > Some helpers are introduced to achieve that.  We need to make sure we=
're
> > with the lock when operating on those queues.
> >=20
>=20
> It would also be helpful to mention that the patch includes code motion=
 to
> declare struct QMPRequest earlier in the file.
>=20
> > Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   monitor.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++-----=
-----------
> >   1 file changed, 59 insertions(+), 20 deletions(-)
> >=20
>=20
> > +static void qmp_request_free(QMPRequest *req)
> > +{
> > +    qobject_decref(req->id);
> > +    qobject_decref(req->req);
> > +    g_free(req);
> > +}
> > +
> > +static void qmp_response_free(QObject *obj)
> > +{
> > +    qobject_decref(obj);
> > +}
>=20
> Why do we need this function?  Unless you plan to add to it in later
> patches, I'd rather just inline things and directly call qobject_decref=
() at
> the callsites...

Yes we can omit that.

>=20
> > +
> > +/* Must with the mon->qmp.qmp_queue_lock held */
> > +static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
> > +{
> > +    while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
> > +        qmp_request_free(g_queue_pop_head(mon->qmp.qmp_requests));
> > +    }
> > +}
> > +
> > +/* Must with the mon->qmp.qmp_queue_lock held */
> > +static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
> > +{
> > +    while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
> > +        qmp_response_free(g_queue_pop_head(mon->qmp.qmp_responses));
>=20
> ...here,
>=20
> > +    }
> > +}
> > +
> > +static void monitor_qmp_cleanup_queues(Monitor *mon)
> > +{
> > +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> > +    monitor_qmp_cleanup_req_queue_locked(mon);
> > +    monitor_qmp_cleanup_resp_queue_locked(mon);
> > +    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> > +}
> > +
> > +
> >   static void monitor_flush_locked(Monitor *mon);
> >   static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition co=
nd,
> > @@ -497,7 +550,7 @@ static void monitor_qmp_bh_responder(void *opaque=
)
> >               break;
> >           }
> >           monitor_json_emitter_raw(response.mon, response.data);
> > -        qobject_decref(response.data);
> > +        qmp_response_free(response.data);
>=20
> and here.
>=20
> > @@ -4327,6 +4364,7 @@ static void monitor_qmp_event(void *opaque, int=
 event)
> >       switch (event) {
> >       case CHR_EVENT_OPENED:
> > +        monitor_qmp_cleanup_queues(mon);
>=20
> [1] How would something be queued to need cleanup at this point, if we
> already start with a clean queue before the first monitor, and if all
> monitor close actions clean the queue?

(answered above)

Thanks,

--=20
Peter Xu
