Received: from eggs.gnu.org ([2001:4830:134:3::10]:45208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2d29-0003jE-1k
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2d23-0001Zu-BV
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:24:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2d23-0001ZS-27
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:23:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD0CF93306
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 12:23:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490860207-8302-1-git-send-email-thuth@redhat.com>
	<1490860207-8302-2-git-send-email-thuth@redhat.com>
	<c341bda5-8e1d-2717-3606-51ef1611d1a8@redhat.com>
	<678cd353-56cb-3dac-3f91-966cb5abeb34@redhat.com>
	<55a17a77-9ab4-519a-b917-695fd33fd4be@redhat.com>
	<87fuhfcnov.fsf@dusky.pond.sub.org> <20170424113147.GA2075@work-vm>
Date: Mon, 24 Apr 2017 14:23:48 +0200
In-Reply-To: <20170424113147.GA2075@work-vm> (David Alan Gilbert's message of
	"Mon, 24 Apr 2017 12:31:48 +0100")
Message-ID: <87r30ihu3v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/3] libqtest: Ignore QMP events when
 parsing the response for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>> > On 04/04/2017 03:31 AM, Thomas Huth wrote:
>> >> On 03.04.2017 21:09, John Snow wrote:
>> >>>
>> >>>
>> >>> On 03/30/2017 03:50 AM, Thomas Huth wrote:
>> >>>> When running certain HMP commands (like "device_del") via QMP, we
>> >>>> can sometimes get a QMP event in the response first, so that the
>> >>>> "g_assert(ret)" statement in qtest_hmp() triggers and the test
>> >>>> fails. Fix this by ignoring such QMP events while looking for the
>> >>>> real return value from QMP.
>> >>>>
>> >>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> >>>> ---
>> >>>>  tests/libqtest.c | 6 ++++++
>> >>>>  1 file changed, 6 insertions(+)
>> >>>>
>> >>>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>> >>>> index a5c3d2b..c9b2d76 100644
>> >>>> --- a/tests/libqtest.c
>> >>>> +++ b/tests/libqtest.c
>> >>>> @@ -580,6 +580,12 @@ char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
>> >>>>                       " 'arguments': {'command-line': %s}}",
>> >>>>                       cmd);
>> >>>>      ret = g_strdup(qdict_get_try_str(resp, "return"));
>> >>>> +    while (ret == NULL && qdict_get_try_str(resp, "event")) {
>> >>>> +        /* Ignore asynchronous QMP events */
>> >>>> +        QDECREF(resp);
>> >>>> +        resp = qtest_qmp_receive(s);
>> >>>> +        ret = g_strdup(qdict_get_try_str(resp, "return"));
>> >>>> +    }
>> >>>>      g_assert(ret);
>> >>>>      QDECREF(resp);
>> >>>>      g_free(cmd);
>> >>>>
>> >>>
>> >>> You've probably been asked this, but can you just shove the QMP response
>> >>> you don't want into the event queue for consumption by other calls?
>> >> 
>> >> Well, this is the qtest_hmpv() function, so I assume that the caller
>> >> just wants to execute a HMP command and does not really care about QMP
>> >> events. If you care about QMP events, you should use the qmp functions
>> >> instead.
>> >> 
>> >>  Thomas
>> >> 
>> >
>> > I don't think it's obvious that using HMP functions should cause the QMP
>> > stream to become faulty, though.
>> 
>> qtest_hmpv() is a helper function.  It tries to be convenient for the
>> common case.  In particular, it receives, checks and consumes the QMP
>> reply.  Before the patch, it screws up when QMP events arrive before the
>> reply.  The patch fixes it by also consuming the events.  Makes sense.
>> 
>> The non-obviousness should be addressed in the function comment.
>> 
>> > If someone uses an HMP function and then tries to wait on a QMP event to
>> > confirm that some key condition has occurred (pausing or resuming, for
>> > instance) it would not be immediately apparent from the user's POV that
>> > this function just eats replies because it was convenient to do so.
>> 
>> Code that needs to see events can't use this helper function.  It needs
>> to use more primitive functions instead.
>> 
>> > I guess the event queue only exists in python though, so it's not as
>> > trivial as I was thinking it would be...
>> 
>> More sophisticated handling of QMP events in libqtest is out of scope
>> for this patch.  I'm not passing judgement on whether it would be
>> useful :)
>> 
>> With the function comment updated to mention QMP events get consumed:
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> OK, I've added that comment to qtest_hmp and qtest_hmpv when I've
> just queued it.
> (and removed an extra 'v')
>
>  /**
> - * qtest_hmpv:
> + * qtest_hmp:
>   * @s: #QTestState instance to operate on.
>   * @fmt...: HMP command to send to QEMU
>   *
>   * Send HMP command to QEMU via QMP's human-monitor-command.
> + * QMP events are discarded.
>   *
>   * Returns: the command's output.  The caller should g_free() it.
>   */
> @@ -149,6 +150,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...);
>   * @ap: HMP command arguments
>   *
>   * Send HMP command to QEMU via QMP's human-monitor-command.
> + * QMP events are discarded.
>   *
>   * Returns: the command's output.  The caller should g_free() it.
>   */
>
> Dave

Works for me, thanks!
