Received: from eggs.gnu.org ([2001:4830:134:3::10]:37010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwY9z-00086s-Jx
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwY9w-0001Ul-I0
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:58:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cwY9w-0001UC-8t
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:58:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5C5280490
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 17:58:54 +0000 (UTC)
Date: Fri, 7 Apr 2017 18:58:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170407175849.GF2623@work-vm>
References: <1490860207-8302-1-git-send-email-thuth@redhat.com>
	<1490860207-8302-2-git-send-email-thuth@redhat.com>
	<c341bda5-8e1d-2717-3606-51ef1611d1a8@redhat.com>
	<678cd353-56cb-3dac-3f91-966cb5abeb34@redhat.com>
	<55a17a77-9ab4-519a-b917-695fd33fd4be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a17a77-9ab4-519a-b917-695fd33fd4be@redhat.com>
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
To: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

* John Snow (jsnow@redhat.com) wrote:
> 
> 
> On 04/04/2017 03:31 AM, Thomas Huth wrote:
> > On 03.04.2017 21:09, John Snow wrote:
> >>
> >>
> >> On 03/30/2017 03:50 AM, Thomas Huth wrote:
> >>> When running certain HMP commands (like "device_del") via QMP, we
> >>> can sometimes get a QMP event in the response first, so that the
> >>> "g_assert(ret)" statement in qtest_hmp() triggers and the test
> >>> fails. Fix this by ignoring such QMP events while looking for the
> >>> real return value from QMP.
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>  tests/libqtest.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/tests/libqtest.c b/tests/libqtest.c
> >>> index a5c3d2b..c9b2d76 100644
> >>> --- a/tests/libqtest.c
> >>> +++ b/tests/libqtest.c
> >>> @@ -580,6 +580,12 @@ char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
> >>>                       " 'arguments': {'command-line': %s}}",
> >>>                       cmd);
> >>>      ret = g_strdup(qdict_get_try_str(resp, "return"));
> >>> +    while (ret == NULL && qdict_get_try_str(resp, "event")) {
> >>> +        /* Ignore asynchronous QMP events */
> >>> +        QDECREF(resp);
> >>> +        resp = qtest_qmp_receive(s);
> >>> +        ret = g_strdup(qdict_get_try_str(resp, "return"));
> >>> +    }
> >>>      g_assert(ret);
> >>>      QDECREF(resp);
> >>>      g_free(cmd);
> >>>
> >>
> >> You've probably been asked this, but can you just shove the QMP response
> >> you don't want into the event queue for consumption by other calls?
> > 
> > Well, this is the qtest_hmpv() function, so I assume that the caller
> > just wants to execute a HMP command and does not really care about QMP
> > events. If you care about QMP events, you should use the qmp functions
> > instead.
> > 
> >  Thomas
> > 
> 
> I don't think it's obvious that using HMP functions should cause the QMP
> stream to become faulty, though.
> 
> If someone uses an HMP function and then tries to wait on a QMP event to
> confirm that some key condition has occurred (pausing or resuming, for
> instance) it would not be immediately apparent from the user's POV that
> this function just eats replies because it was convenient to do so.
> 
> I guess the event queue only exists in python though, so it's not as
> trivial as I was thinking it would be...

I think it's OK to discard the QMP events - it feels rare to mix and match
in a test; if you care about QMP events you'll probably be basing the
test around QMP rather than HMP.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
