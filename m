Received: from eggs.gnu.org ([2001:4830:134:3::10]:60640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuzpU-0006f4-50
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuzmC-00026D-Cp
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:40:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuzmA-00024z-9f
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:40:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-5-marcandre.lureau@redhat.com>
	<20180827045602.GF3020@xz-x1> <87a7p6mr3e.fsf@dusky.pond.sub.org>
	<20180829004237.GG4446@xz-x1> <87r2ihh7qg.fsf@dusky.pond.sub.org>
	<20180829102102.GA9942@xz-x1>
Date: Wed, 29 Aug 2018 14:40:39 +0200
In-Reply-To: <20180829102102.GA9942@xz-x1> (Peter Xu's message of "Wed, 29 Aug
	2018 18:21:02 +0800")
Message-ID: <87ftyx9whk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/9] monitor: no need to save need_resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Wed, Aug 29, 2018 at 10:55:51AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > On Tue, Aug 28, 2018 at 05:46:29PM +0200, Markus Armbruster wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >>=20
>> >> > On Sat, Aug 25, 2018 at 03:57:19PM +0200, Marc-Andr=C3=A9 Lureau wr=
ote:
>> >> >> There is no need for per-command need_resume granularity, it should
>> >> >> resume after running an non-oob command on oob-disabled monitor.
>> >> >>=20
>> >> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> >> >
>> >> > Note that this series/patch still conflict with the "enable
>> >> > out-of-band by default" series.
>> >> >
>> >> >   [PATCH v6 00/13] monitor: enable OOB by default
>> >>=20
>> >> Yes.
>> >>=20
>> >> > I'm not against this patch to be merged since it has its r-b, but I
>> >> > feel like we'd better judge on whether we still like the response
>> >> > queue first, in case one day we'll need to add these things back.
>> >>=20
>> >> Let's not worry about things that may or may not happen at some
>> >> indeterminate time in the future.
>> >
>> > It might not be that "far future"...  Please see below.
>> >
>> >>=20
>> >> However:
>> >>=20
>> >> > When there could be functional changes around the code path I would
>> >> > think we'd better keep the cleanup patches postponed a bit until th=
ose
>> >> > functional changes are settled.  For now the functional part is dec=
ide
>> >> > how to fix up the rest of out-of-band issues (my proposal is in the
>> >> > series above which should solve everything that is related to
>> >> > out-of-band to be fixed; if there is more, I'll continue to work on
>> >> > it), whether we should enable it by default for 3.1 (my answer
>> >> > is... yes...), and what to do with it.
>> >>=20
>> >> I agree the important job is to finish OOB.
>> >>=20
>> >> Sometimes, it's better to clean up first.  Sometimes, it's not.
>> >>=20
>> >> Right now, the response queue is a useless complication, and
>> >> Marc-Andr=C3=A9's PATCH 3+4 get rid of it.  Lovely.  I understand this
>> >> conflicts with your OOB work.  The question is whether your work
>> >> fundamentally needs the response queue or not.
>> >
>> > Just to clarify a bit... I prefer to keep the response queue not
>> > because it's conflicting my existing work but because I think we might
>> > get use of it even in the near future.  I stated it here on the
>> > possibility that we might use the response queue to solve the
>> > unlimited monitor out_buf issue here:
>> >
>> > https://patchwork.kernel.org/patch/10511471/#22110771
>> >
>> > Quotes:
>> >
>> >         ...
>> >         Yeah actually this reminded me about the fact that we are
>> >         still using unlimited buffer size for the out_buf.  IMHO we
>> >         should make it a limited size after 3.0, then AFAICT if
>> >         without current qmp response queue we'll need to introduce
>> >         some similar thing to cache responses then when the out_buf is
>> >         full.
>> >
>> >         IMHO the response queue looks more like the correct place that
>> >         we should do the flow control, and the out_buf could be
>> >         majorly used to do the JSON->string convertion (so basically
>> >         IMHO the out_buf limitation should be the size of the maximum
>> >         JSON object that we'll have).
>> >         ...
>> >
>> > Let's imagine what we need if we want to limit the out_buf: (1) To
>> > limit the out_buf, we need somewhere to cache the responses that we
>> > want to put into out_buf but we can't when the out_buf is full -
>> > that's mostly the response queue now.  (2) Since we will need to queue
>> > these items onto out_buf when out_buf is not full, we'll possibly need
>> > something like a bottom half to kickoff when out_buf is able to handle
>> > more data - that's mostly the bottom half of the response queue.
>> >
>> > AFAIU the rest to do is very possible only that we set a limit to the
>> > out_buf but only if response queue is there...
>>=20
>> Limiting outbuf only to have the same data pile up earlier in the
>> pipeline doesn't seem helpful.  We need to throttle production of
>> output.  A simple way to do that is throttling input.  See below.
>>=20
>> > I didn't really work on the out_buf since I didn't want to further
>> > expand the out-of-band work (since it's already going far away before
>> > it settles down first...), and after all the out_buf issue is nothing
>> > related to the out-of-band work and it's there for a long time.
>> > However that's the major reason that I might prefer to keep the queue
>> > now.
>> >
>> > [1]
>>=20
>> Let's review what we have.
>>=20
>> QMP flow control is about limiting the amount of data QEMU buffers on
>> behalf of a QMP client.
>>=20
>> This is about robustness, not security.  There are countless ways a QMP
>> client can make QEMU use more memory.  We want to cope with accidents,
>> not stop attacks.
>>=20
>> A common and simple way to do flow control is to throttle receiving.
>> Unless the transport buffers way too much (which would be insane), the
>> peer will soon notice, and can adapt.
>>=20
>> QMP input flows from the character device to commands.  It is converted
>> from text to QObject along the way.  Output flows from commands to the
>> character device.  It is converted from QObject to text along the way.
>>=20
>> When the client sends input faster than QEMU can execute them, flow
>> control should kick in to stop adding more input to the pileup.  When
>> QEMU produces output faster than the client can receive it, flow control
>> should kick in to stop adding more output to the pileup.  We can do that
>> indirectly, by stopping input.
>>=20
>> Input buffering:
>>=20
>> * The chardev buffers 4KiB (I think).  Small enough to be ignored.
>>=20
>> * The JSON parser buffers one partial JSON value as a token list, up to
>>   a limit in the order of 64MiB.  Weasel words "in the order", because
>>   it measures memory consumption only indirectly.  The limit is
>>   ridicilously generous for a control plane purpose like QMP.
>>=20
>> * When the partial JSON value becomes complete, the JSON parser converts
>>   it to a QObject, then frees the token list.
>>=20
>> * Without OOB, the QMP core buffers one complete QObject (the command)
>>   until we're done with the command.  The JSON parser's buffer should be
>>   empty then, because the QMP core suspends reading from the char device
>>   while it deals with a command.
>>=20
>> * With OOB, the QMP core buffers up to 8 in-band commands and one
>>   out-of-band command.
>>=20
>>   When the in-band command buffer is full, we currently drop further
>>   in-band commands, but that's a bad idea, and we're going to suspend
>>   reading from the char device instead.  Once we do, the JSON parser's
>>   buffer should be empty when the in-band command buffer is full.  The
>>   remainder of my analysis assumes we suspend rather than drop.
>>=20
>> Output buffering:
>>=20
>> * Traditionally, the QMP core buffers one QObject while it converts it
>>   to text.  It buffers an unlimited amount of text in mon->outbuf.
>>=20
>> * Adding a request queue doesn't by itself change how much data is
>>   buffered, only when it's converted from QObject to text.  If the
>>   bottom half doing the conversion runs quickly, nothing changes.  If it
>>   gets delayed for some reason, QObjects can pile up in the response
>>   queue before they get converted and moved to mon->outbuf.
>>=20
>> Summary of flow control:
>>=20
>> * We limit input buffers and stop reading input when the limit is
>>   exceeded.  This stops input piling up.
>>=20
>> * We do not limit output at all.
>>=20
>> Ideally, we'd keep track of combined input and output buffer size, and
>> throttle input to keep it under control.  But separate limits for
>> individual buffers could be good enough, and might be simpler.
>
> (thanks for the summary)
>
>>=20
>> >> If your OOB work happens to be coded for the response queue, but the
>> >> problem could also be solved without the response queue, then the OOB
>> >> job doesn't fundamentally need the response queue.
>> >
>> > Yes, I think the OOB work itself does not need the response queue now.
>>=20
>> Understood.
>>=20
>> >> Unless that's the case, getting rid of the response queue is unnecess=
ary
>> >> churn.
>> >>=20
>> >> If it is the case, we still need to consider effort.  Which order is
>> >> less total work?  Which order gets us to the goal faster?
>> >>=20
>> >> Can you guys agree on answers to these questions, or do you need me to
>> >> answer them?
>> >>=20
>> >> Restating the questions:
>> >>=20
>> >> 1. Can you think of a way to do what Peter's OOB series does, but
>> >> without the response queue?
>> >>=20
>> >> 2. If you can, what's easier / cheaper / faster:
>> >>=20
>> >>    a. Merge Marc-Andr=C3=A9's patches to get rid of response queue, r=
ewrite
>> >>       OOB series without response queue on top.
>> >>=20
>> >>    b. Merge Peter's OOB series with response queue, rewrite patches to
>> >>       get rid of response queue on top.
>> >
>> > Let's have a quick look at above [1], if it's not a good reason (or
>> > even it's still unclear) then let's drop the queue.  It'll be
>> > perfectly fine I rebase my work upon Marc-Andr=C3=A9's.  After all the=
 only
>> > reason to keep the response queue for me is to save time (for anyone
>> > who will be working with monitors).  If we spend too much time on
>> > judging whether we should keep the queue (we've already spent some)
>> > then it's already a waste of time...  It does not worth it IMO.
>>=20
>> Time spent on coming up with a high-level plan for flow control is time
>> well spent.
>>=20
>> Sometimes, you have to explore and experiment before you can come up
>> with a high-level plan that has a reasonable chance of working.  No
>> license to skip the "think before you hack" step entirely.
>>=20
>> Here's the simplest (and possibly naive) plan I can think of: if
>> mon->outbuf exceeds a limit, suspend reading input.  No response queue.
>> Would it have a reasonable chance of working?
>
> Hmm I think it works...  Let's assume:
>
> - M: threshold size for outbuf
> - A: size of current outbuf
> - B: size of a new response message (and assume A+B>M, so the flow
>      control will trigger)
>
> I think that queue is not a must if we don't restrict the buffer that
> much - for example we can just queue the JSON object into outbuf when
> we receive the new message with size B (after queuing, we might get
> A+B>M, then it's slightly bigger than the limit threshold), now we
> suspend the monitor.

Yes.

M is a threshold for suspending the monitor, not a hard size limit.

Since the response QObjects has to go *somewhere*, we can just as well
stuff it into mon->outbuf.

The actual mon-outbuf size A may exceed the threshold M, but only while
the monitor is suspended.

> If we want to have a very strict buffer size limitation for outbuf so
> the outbuf never use more than M, we can't just queue it since it will
> overflow, then we need to stop the input and cache the object
> somewhere (e.g., the response queue).

Yes, but that doesn't actually limit memory use: instead of mon->outbuf
growing without bound, we now have response queue growing without bound.
Actual memory use changes only if one of the two representations QObject
and text is more compact.

Unscientific experiment: I instrumented qobject_to_json() to measure
size of its QObject input and text output (patch appended).  For
query-qmp-schema's output, I measure ~9.8MiB for QObject, and ~119KiB
for text:

    ### qobject_to_json(0x556653e7ac30)
    ###    #objs   #bytes QType
    ###        0        0 none
    ###      568        0 qnull
    ###        0        0 qnum
    ###    11876   540253 qstring
    ###     2301  9677496 qdict
    ###      509    86344 qlist
    ###        2       48 qbool
    ### 0x556653e7ac30 uses 10304141 vs. 121759

Most of the QObject's memory is occupied by QDicts.  The way they're
implemented is wasteful (known issue).  But even with a magical QDict
implementation that uses no memory at all, the QObject would still use
five times the memory of text.

My experiment suggests that to conserve memory, we should convert
responses to text right away.

> So I think now I agree with you that the response queue is not
> required if we think the first solution is okay for us.

Cool.  Can you explore that and post patches?

>
> Thanks,
>
>>=20
>> >> > If we found that it's too hard to enable it by default, I'm thinking
>> >> > whether we can make it a persistent flag for monitor (maybe turning
>> >> > the "x-oob" into a real "oob" and keep it, then we don't turn it on=
 by
>> >> > default), then we can let libvirt start working with out-of-band wi=
th
>> >> > the flag.  After all it's actually working mostly (the pending issu=
es
>> >> > are only things like flow control for malicious/buggy clients, but
>> >> > libvirt never had such an issue with it).
>> >>=20
>> >> The OOB job isn't complete without working flow control.  Nevertheles=
s,
>> >> I'm willing to consider enabling OOB without working flow control.
>> >
>> > That'll be great.  Thanks!
>> >
>> > (Though I think the current OOB series should have addressed all but
>> >  the out_buf flow control issue, right?)
>>=20
>> I hope so, but I haven't been able to review it, yet :)
>
> Regards,


diff --git a/qobject/qjson.c b/qobject/qjson.c
index db36101f3b..92fa87330e 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -203,6 +203,9 @@ static void to_json_list_iter(QObject *obj, void *opaqu=
e)
     s->count++;
 }
=20
+static size_t sz[QTYPE__MAX];
+static int hist[QTYPE__MAX];
+
 static void to_json(const QObject *obj, QString *str, int pretty, int inde=
nt)
 {
     switch (qobject_type(obj)) {
@@ -211,6 +214,7 @@ static void to_json(const QObject *obj, QString *str, i=
nt pretty, int indent)
         break;
     case QTYPE_QNUM: {
         QNum *val =3D qobject_to(QNum, obj);
+        sz[QTYPE_QNUM] +=3D sizeof(*val);
         char *buffer =3D qnum_to_string(val);
         qstring_append(str, buffer);
         g_free(buffer);
@@ -218,6 +222,7 @@ static void to_json(const QObject *obj, QString *str, i=
nt pretty, int indent)
     }
     case QTYPE_QSTRING: {
         QString *val =3D qobject_to(QString, obj);
+        sz[QTYPE_QSTRING] +=3D sizeof(*val) + val->capacity;
         const char *ptr;
         int cp;
         char buf[16];
@@ -275,6 +280,7 @@ static void to_json(const QObject *obj, QString *str, i=
nt pretty, int indent)
     case QTYPE_QDICT: {
         ToJsonIterState s;
         QDict *val =3D qobject_to(QDict, obj);
+        sz[QTYPE_QDICT] +=3D sizeof(*val) + val->size * sizeof(QDictEntry);
=20
         s.count =3D 0;
         s.str =3D str;
@@ -294,6 +300,7 @@ static void to_json(const QObject *obj, QString *str, i=
nt pretty, int indent)
     case QTYPE_QLIST: {
         ToJsonIterState s;
         QList *val =3D qobject_to(QList, obj);
+        sz[QTYPE_QLIST] +=3D sizeof(*val) + qlist_size(val) * sizeof(QList=
Entry);
=20
         s.count =3D 0;
         s.str =3D str;
@@ -312,6 +319,7 @@ static void to_json(const QObject *obj, QString *str, i=
nt pretty, int indent)
     }
     case QTYPE_QBOOL: {
         QBool *val =3D qobject_to(QBool, obj);
+        sz[QTYPE_QBOOL] +=3D sizeof(*val);
=20
         if (qbool_get_bool(val)) {
             qstring_append(str, "true");
@@ -323,13 +331,25 @@ static void to_json(const QObject *obj, QString *str,=
 int pretty, int indent)
     default:
         abort();
     }
+    hist[qobject_type(obj)]++;
 }
=20
 QString *qobject_to_json(const QObject *obj)
 {
     QString *str =3D qstring_new();
=20
+    memset(&sz, 0, sizeof(sz));
+    memset(&hist, 0, sizeof(hist));
+    printf("### qobject_to_json(%p)\n", obj);
+    printf("### %8s %8s QType\n", "#objs", "#bytes");
     to_json(obj, str, 0, 0);
+    size_t totsz =3D 0;
+    for (int i =3D 0; i < QTYPE__MAX; i++) {
+        printf("### %8d %8zd %s\n", hist[i], sz[i], QType_str(i));
+        totsz +=3D sz[i];
+    }
+    printf("### %p uses %zd vs. %zd\n", obj, totsz, strlen(str->string));
+    printf("### %.60s\n", str->string);
=20
     return str;
 }
