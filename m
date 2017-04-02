Received: from eggs.gnu.org ([2001:4830:134:3::10]:49366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cuZyq-0003jy-Gf
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cuZyn-0008Pm-8c
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:31:20 -0400
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:36645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cuZyn-0008PC-2j
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:31:17 -0400
Received: by mail-ua0-x229.google.com with SMTP id 97so14034098uaz.3
	for <qemu-devel@nongnu.org>; Sun, 02 Apr 2017 00:31:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKPgXcFgZ4PA4d8SqFTe1quk16jFnXVWsx8Lody1Z60B0wRXqA@mail.gmail.com>
References: <20170321104952.6236-1-sameeh@daynix.com>
	<149011257708.3910.6427658788264808225@loki>
	<CAKPgXcFgZ4PA4d8SqFTe1quk16jFnXVWsx8Lody1Z60B0wRXqA@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 2 Apr 2017 10:31:16 +0300
Message-ID: <CAKPgXcG4QSYUv1Jbxgwcn7ayzU=icMCTt07hK=MQX0GFSga9Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Fix Event Viewer errors caused by qemu-ga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

Ping.

On Wed, Mar 22, 2017 at 11:14 AM, Sameeh Jubran <sameeh@daynix.com> wrote:

>
>
> On Tue, Mar 21, 2017 at 6:09 PM, Michael Roth <mdroth@linux.vnet.ibm.com>
> wrote:
>
>> Quoting Sameeh Jubran (2017-03-21 05:49:52)
>> > When the command "guest-fsfreeze-freeze" is executed it causes
>> > the VSS service to log the errors below in the Event Viewer.
>> >
>> > These errors are caused by two issues in the function "CommitSnapshots"
>> in
>> > provider.cpp:
>> >
>> > 1. When VSS_TIMEOUT_MSEC expires the funtion returns E_ABORT. This
>> causes
>> > the error #12293.
>> >
>> > 2. The VSS_TIMEOUT_MSEC value is too big. According to msdn the
>> > "Flush & Hold" operation has 10 seconds timeout not configurable, The
>> > "CommitSnapshots" is a part of the "Flush & Hold" process and thus any
>> > timeout bigger than 10 seconds would cause the error #12298 and anything
>> > bigger than 40 seconds causes the error #12340. All this info can be
>> found here:
>> > https://msdn.microsoft.com/en-us/library/windows/desktop/aa3
>> 84589(v=vs.85).aspx
>>
>> Not sure how best to deal with this. Technically our CommitSnapshots
>> interface is driven by the backup job being run by QGA/QEMU management
>> side. If that amount of time exceeds the VSS limits then I think it's
>> appropriate for VSS to log the error accordingly. VSS_TIMEOUT_MSEC here
>> doesn't actually have too much correlation with the VSS-set timeout,
>> IIRC it's specifically picked to exceed both the 10 and 40 second
>> timeouts and acts more as a fail-safe timeout.
>
> The timeout was added in #commit: b39297aedfabe9b2c426cd540413be991500da25
> There is no point in setting the TIMEOUT for this long as the actual
> freeze - Fush and Hold Writes -
> is limited to 10 seconds ( not configurable) according to msdn
> https://msdn.microsoft.com/en-us/library/windows/
> desktop/aa384589%28v=vs.85%29.aspx
>
>>
>> Are the event logs causing issues? FWIW, on the posix side we also opt
>> for gratuitous logging to syslog and such, the idea there being that
>> cooperative guests would prefer transparency on how the agent is being
>> used.
>>
> Apparently, these error logs are annoying to some (
> https://bugzilla.redhat.com/show_bug.cgi?id=1387125),
> moreover I don't think that our implementation to the freeze operation -
> which is a workaround in a way -
> should log errors even though we know they are false alarm.
>
>>
>> That said, I do think error 12293 is unecessary, since IIUC it would
>> always be paired with the actual VSS-reported error. So avoiding the
>> E_ABORT seems reasonable either way.
>>
>> >
>> > |event id|                           error
>>  |
>> > * 12293  : Volume Shadow Copy Service error: Error calling a routine on
>> a
>> >            Shadow Copy Provider {00000000-0000-0000-0000-000000000000}.
>> >        Routine details CommitSnapshots [hr = 0x80004004, Operation
>> >        aborted.
>> >
>> > * 12340  : Volume Shadow Copy Error: VSS waited more than 40 seconds for
>> >            all volumes to be flushed.  This caused volume
>> >        \\?\Volume{62a171da-32ec-11e4-80b1-806e6f6e6963}\ to timeout
>> >        while waiting for the release-writes phase of shadow copy
>> >        creation. Trying again when disk activity is lower may solve
>> >        this problem.
>> >
>> > * 12298  : Volume Shadow Copy Service error: The I/O writes cannot be
>> held
>> >            during the shadow copy creation period on volume
>> >            \\?\Volume{62a171d9-32ec-11e4-80b1-806e6f6e6963}\. The
>> volume
>> >        index in the shadow copy set is 0. Error details:
>> >        Open[0x00000000, The operation completed successfully. ],
>> >        Flush[0x00000000, The operation completed successfully.],
>> >        Release[0x00000000, The operation completed successfully.],
>> >        OnRun[0x80042314, The shadow copy provider timed out while
>> >        holding writes to the volume being shadow copied. This is
>> >        probably due to excessive activity on the volume by an
>> >        application or a system service. Try again later when activity
>> >        on the volume is reduced.
>> >
>> > Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
>> > ---
>> >  qga/vss-win32/provider.cpp | 3 +--
>> >  1 file changed, 1 insertion(+), 2 deletions(-)
>> >
>> > diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
>> > index ef94669..d72f4d4 100644
>> > --- a/qga/vss-win32/provider.cpp
>> > +++ b/qga/vss-win32/provider.cpp
>> > @@ -15,7 +15,7 @@
>> >  #include <inc/win2003/vscoordint.h>
>> >  #include <inc/win2003/vsprov.h>
>> >
>> > -#define VSS_TIMEOUT_MSEC (60*1000)
>> > +#define VSS_TIMEOUT_MSEC (9 * 1000)
>> >
>> >  static long g_nComObjsInUse;
>> >  HINSTANCE g_hinstDll;
>> > @@ -377,7 +377,6 @@ STDMETHODIMP CQGAVssProvider::CommitSnapshots(VSS_ID
>> SnapshotSetId)
>> >      if (WaitForSingleObject(hEventThaw, VSS_TIMEOUT_MSEC) !=
>> WAIT_OBJECT_0) {
>> >          /* Send event to qemu-ga to notify the provider is timed out */
>> >          SetEvent(hEventTimeout);
>> > -        hr = E_ABORT;
>> >      }
>> >
>> >      CloseHandle(hEventThaw);
>> > --
>> > 2.9.3
>> >
>>
>>
>
>
> --
> Respectfully,
> *Sameeh Jubran*
> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
> *Software Engineer @ Daynix <http://www.daynix.com>.*
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
