Received: from eggs.gnu.org ([2001:4830:134:3::10]:51661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV8NI-0000Ao-Uk
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 00:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV8NF-0006rC-N9
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 00:36:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fV8NF-0006qd-ER
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 00:36:09 -0400
Date: Tue, 19 Jun 2018 12:35:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180619043551.GF16790@xz-mi>
References: <20180615014249.22730-1-peterx@redhat.com>
	<20180615014249.22730-3-peterx@redhat.com>
	<87zhzwbhah.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zhzwbhah.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] monitor: flush qmp responses when
 CLOSED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Jun 15, 2018 at 10:11:34AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Previously we clean up the queues when we got CLOSED event.  It was used
> > to make sure we won't send leftover replies/events of a old client to a
> > new client.  Now this patch does an extra operation to flush the
> > response queue before cleaning up.
> >
> > In most cases, a QMP session will be based on a bidirectional channel (a
> > TCP port, for example, we read/write to the same socket handle), so in
> > port and out port of the backend chardev are fundamentally the same
> > port. In these cases, it does not really matter much on whether we'll
> > flush the response queue since flushing should possibly fail
> 
> s/should possibly fail anyways/will fail anyway/
> 
> > anyways (just imagine to write to a socket that has already closed).
> > However there can be cases where in & out ports of the QMP monitor's
> > backend chardev are separated.  One true example:
> 
> Suggest to drop "true", or say "Here's an example".
> 
> >   cat $QMP_COMMANDS | qemu -qmp stdio ... | filter_commands
> >
> > In this case, the backend is fd-typed, and it is connected to stdio
> > where in port is stdin and out port is stdout.  Now if we drop all the
> > events on the response queue then filter_command process might miss some
> > events that it might expect.  The thing is that, when stdin closes,
> > stdout might still be there alive!
> >
> > In practice, I encountered a very strange SHUTDOWN event missing when
> 
> The event isn't strange, its missing is (sort of).  Suggest to drop
> "very strange".
> 
> > running test with iotest 087 with Out-Of-Band enabled. One condition
> > could be this (after "quit" command is executed and QEMU quits the main
> > loop):
> 
> "could be" suggests this may or may not demonstrate the loss of the
> event.  Misleading.  "Here's one of the ways this can happen" would be
> clearer.
> 
> >
> > 1. [main thread] QEMU queues one SHUTDOWN event into response queue
> 
> s/one/a/
> 
> >
> > 2. "cat" terminates (to distinguish it from the animal, I quote it).
> >    Logically it can terminate even earlier, but let's just assume it's
> >    here.
> 
> Suggest to drop the second sentence.  You're describing one way for the
> bug to bite here, not all possible ways.
> 
> >
> > 3. [monitor iothread] QEMU reads EOF from stdin, which connects to the
> >    "cat" process
> 
> Suggest "QEMU's monitor iothread reads".
> 
> Suggest to drop ", which connects...", because that should be obvious.
> 
> > 4. [monitor iothread] QEMU calls the CLOSED event hook for the monitor,
> 
> "QEMU's monitor iothread" again.
> 
> >    which will clean up the response queue of the monitor, then the
> >    SHUTDOWN event is dropped
> 
> Suggest to say "destroy" instead of "clean up", to make perfectly clear
> that we're throwing away the queue.
> >
> > 5. [main thread] clean up the monitors in monitor_cleanup(), when
> 
> "QEMU's main thread cleans up the monitors in monitor_cleanup().  When"
> 
> >    trying to flush pending responses, it sees nothing.  SHUTDOWN is
> >    lost forever
> 
> Missing a period.
> 
> > Note that before the monitor iothread was introduced, step [4]/[5] could
> > never happen since the main loop was the only place to detect the EOF
> > event of stdin and run the CLOSED event hooks.  Now things can happen in
> > parallel in the iothread.
> >
> > Without this patch, iotest 087 will have ~10% chance to miss the
> > SHUTDOWN event and fail when with Out-Of-Band enabled:
> >
> > 087 8s ... - output mismatch (see 087.out.bad)
> > --- /home/peterx/git/qemu/tests/qemu-iotests/087.out    2018-06-01 18:44:22.378982462 +0800
> > +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/087.out.bad    2018-06-01 18:53:44.267840928 +0800
> > @@ -8,7 +8,6 @@
> >  {"return": {}}
> >  {"error": {"class": "GenericError", "desc": "'node-name' must be specified for the root node"}}
> >  {"return": {}}
> > -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
> >
> >  === Duplicate ID ===
> > @@ -53,7 +52,6 @@
> >  {"return": {}}
> >  {"return": {}}
> >  {"return": {}}
> > -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
> 
> Suggest to indent the quoted diff a bit, so make it more obviously not
> part of the patch.  In fact, git-am chokes on it for me.
> 
> > This patch fixes the problem.
> >
> > Fixes: 6d2d563f8c ("qmp: cleanup qmp queues properly", 2018-03-27)
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Don't let my nitpicking deceive you; this is a really nice commit
> message.

Thanks.  I'll apply all the suggestions until here in my next post.

> 
> One more suggestion.  Your first paragraph describes the solution.  I
> like to start with the problem instead.  More so when the problem
> description is long, as it is here, because by the time I'm done reading
> the problem, I'm prone to have forgotten the solution, and go "okay, and
> how's the patch addressing the problem?"  But please use your judgement.

Yes, talking about the problem first makes sense.  But I'll try to
make it even easier for readers: I'll summarize the problem and
solution first, then I'll keep the rest of the commit message as
detailed description of the problem.  So I'll rewrite my first
paragraph as:

  Previously we clean up the queues when we got CLOSED event.  It was
  used to make sure we won't send leftover replies/events of a old
  client to a new client which makes perfect sense. However this will
  also drop the replies/events even if the output port of the previous
  chardev backend is still open, which can lead to missing of the last
  replies/events.  Now this patch does an extra operation to flush the
  response queue before cleaning up.

Hope this works.

> 
> > ---
> >  monitor.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 6d0cec552e..e59d4f09ac 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -512,20 +512,39 @@ struct QMPResponse {
> >  };
> >  typedef struct QMPResponse QMPResponse;
> >  
> > +static QObject *monitor_qmp_response_pop_one(Monitor *mon)
> > +{
> > +    QObject *data;
> > +
> > +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> > +    data = g_queue_pop_head(mon->qmp.qmp_responses);
> > +    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> > +
> > +    return data;
> > +}
> 
> Note for later: returns null only when the queue is empty (we never push
> null onto this queue).
> 
> > +
> > +static void monitor_qmp_response_flush(Monitor *mon)
> > +{
> > +    QObject *data;
> > +
> > +    while ((data = monitor_qmp_response_pop_one(mon))) {
> > +        monitor_json_emitter_raw(mon, data);
> > +        qobject_unref(data);
> > +    }
> > +}
> 
> This flushes the queue to @mon.  Good.
> 
> > +
> >  /*
> >   * Return one QMPResponse.  The response is only valid if
> >   * response.data is not NULL.
> >   */
> > -static QMPResponse monitor_qmp_response_pop_one(void)
> > +static QMPResponse monitor_qmp_response_pop(void)
> >  {
> >      Monitor *mon;
> >      QObject *data = NULL;
> >  
> >      qemu_mutex_lock(&monitor_lock);
> >      QTAILQ_FOREACH(mon, &mon_list, entry) {
> > -        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> > -        data = g_queue_pop_head(mon->qmp.qmp_responses);
> > -        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> > +        data = monitor_qmp_response_pop_one(mon);
> >          if (data) {
> >              break;
> >          }
>        }
>        qemu_mutex_unlock(&monitor_lock);
>        return (QMPResponse) { .mon = mon, .data = data };
>    }
> 
> Not this patch's fault, but this function gave me pause until I got the
> loop's purpose: the function returns a response from *any* monitor.
> 
> Moreover, your naming creates an inconsistency with
> monitor_qmp_requests_pop_one().
> 
> I append my attempt to make it easier to understand, and restore
> consistency.  I guess I'd split it into a preparatory patch and a fixup
> for this one.

Will do.

> 
> > @@ -539,7 +558,7 @@ static void monitor_qmp_bh_responder(void *opaque)
> >      QMPResponse response;
> >  
> >      while (true) {
> > -        response = monitor_qmp_response_pop_one();
> > +        response = monitor_qmp_response_pop();
> >          if (!response.data) {
> >              break;
> >          }
> > @@ -4366,6 +4385,7 @@ static void monitor_qmp_event(void *opaque, int event)
> >          mon_refcount++;
> >          break;
> >      case CHR_EVENT_CLOSED:
> > +        monitor_qmp_response_flush(mon);
> 
> This wastes work in the common case when @mon's output fd has been
> closed already.  I think that's just fine.

Yeah.  Since I'll repost, I consider to add some comment for that.

> 
> >          monitor_qmp_cleanup_queues(mon);
> >          json_message_parser_destroy(&mon->qmp.parser);
> >          json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
> 
> 
> diff --git a/monitor.c b/monitor.c
> index e59d4f09ac..af28977549 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -512,7 +512,7 @@ struct QMPResponse {
>  };
>  typedef struct QMPResponse QMPResponse;
>  
> -static QObject *monitor_qmp_response_pop_one(Monitor *mon)
> +static QObject *monitor_qmp_requests_pop(Monitor *mon)

I guess it's a typo; I'll keep the "response" word.

>  {
>      QObject *data;
>  
> @@ -527,41 +527,39 @@ static void monitor_qmp_response_flush(Monitor *mon)
>  {
>      QObject *data;
>  
> -    while ((data = monitor_qmp_response_pop_one(mon))) {
> +    while ((data = monitor_qmp_requests_pop(mon))) {

Same here.

>          monitor_json_emitter_raw(mon, data);
>          qobject_unref(data);
>      }
>  }
>  
>  /*
> - * Return one QMPResponse.  The response is only valid if
> - * response.data is not NULL.
> + * Pop a QMPResponse from any monitor's response queue into @response.
> + * Return NULL when all queues are empty, else @response.

I'll change the return value to a boolean directly if it's okay, since
after all we'll pass the QMPResponse in now.

I'll put the rest of the content into a standalone patch.

Thanks,

>   */
> -static QMPResponse monitor_qmp_response_pop(void)
> +static QMPResponse *monitor_qmp_response_pop_any(QMPResponse *response)
>  {
>      Monitor *mon;
>      QObject *data = NULL;
>  
>      qemu_mutex_lock(&monitor_lock);
>      QTAILQ_FOREACH(mon, &mon_list, entry) {
> -        data = monitor_qmp_response_pop_one(mon);
> +        data = monitor_qmp_requests_pop(mon);
>          if (data) {
> +            response->mon = mon;
> +            response->data = data;
>              break;
>          }
>      }
>      qemu_mutex_unlock(&monitor_lock);
> -    return (QMPResponse) { .mon = mon, .data = data };
> +    return data ? response : NULL;
>  }
>  
>  static void monitor_qmp_bh_responder(void *opaque)
>  {
>      QMPResponse response;
>  
> -    while (true) {
> -        response = monitor_qmp_response_pop();
> -        if (!response.data) {
> -            break;
> -        }
> +    while (monitor_qmp_response_pop_any(&response)) {
>          monitor_json_emitter_raw(response.mon, response.data);
>          qobject_unref(response.data);
>      }
> @@ -4126,7 +4124,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
>   * when we process one request on a specific monitor, we put that
>   * monitor to the end of mon_list queue.
>   */
> -static QMPRequest *monitor_qmp_requests_pop_one(void)
> +static QMPRequest *monitor_qmp_requests_pop_any(void)
>  {
>      QMPRequest *req_obj = NULL;
>      Monitor *mon;
> @@ -4158,7 +4156,7 @@ static QMPRequest *monitor_qmp_requests_pop_one(void)
>  
>  static void monitor_qmp_bh_dispatcher(void *data)
>  {
> -    QMPRequest *req_obj = monitor_qmp_requests_pop_one();
> +    QMPRequest *req_obj = monitor_qmp_requests_pop_any();
>  
>      if (req_obj) {
>          trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");

-- 
Peter Xu
