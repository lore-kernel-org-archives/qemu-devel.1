Received: from eggs.gnu.org ([2001:4830:134:3::10]:34136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cvYZl-0002KW-CT
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cvYZi-0001B6-6G
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:13:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cvYZh-0001AT-SV
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:13:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3503oGu042653
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 20:13:24 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29kydh7ck5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 20:13:23 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 4 Apr 2017 18:13:23 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAKPgXcFgZ4PA4d8SqFTe1quk16jFnXVWsx8Lody1Z60B0wRXqA@mail.gmail.com>
References: <20170321104952.6236-1-sameeh@daynix.com>
	<149011257708.3910.6427658788264808225@loki>
	<CAKPgXcFgZ4PA4d8SqFTe1quk16jFnXVWsx8Lody1Z60B0wRXqA@mail.gmail.com>
Date: Tue, 04 Apr 2017 19:13:13 -0500
Message-Id: <149135119349.1924.17722996773742039981@loki>
Subject: Re: [Qemu-devel] [PATCH] Fix Event Viewer errors caused by qemu-ga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

Quoting Sameeh Jubran (2017-03-22 03:14:53)
>On Tue, Mar 21, 2017 at 6:09 PM, Michael Roth
><mdroth@linux.vnet.ibm.com>
>wrote:
>
>> Quoting Sameeh Jubran (2017-03-21 05:49:52)
>>> When the command "guest-fsfreeze-freeze" is executed it causes
>>> the VSS service to log the errors below in the Event Viewer.
>>>
>>> These errors are caused by two issues in the function
>>> "CommitSnapshots"
>> in
>>> provider.cpp:
>>>
>>> 1. When VSS_TIMEOUT_MSEC expires the funtion returns E_ABORT. This
>>> causes
>>> the error #12293.
>>>
>>> 2. The VSS_TIMEOUT_MSEC value is too big. According to msdn the
>>> "Flush & Hold" operation has 10 seconds timeout not configurable, The
>>> "CommitSnapshots" is a part of the "Flush & Hold" process and thus
>>> any
>>> timeout bigger than 10 seconds would cause the error #12298 and
>>> anything
>>> bigger than 40 seconds causes the error #12340. All this info can be
>> found here:
>>> https://msdn.microsoft.com/en-us/library/windows/desktop/
>> aa384589(v=3Dvs.85).aspx
>>
>> Not sure how best to deal with this. Technically our CommitSnapshots
>> interface is driven by the backup job being run by QGA/QEMU management
>> side. If that amount of time exceeds the VSS limits then I think it's
>> appropriate for VSS to log the error accordingly. VSS_TIMEOUT_MSEC
>> here
>> doesn't actually have too much correlation with the VSS-set timeout,
>> IIRC it's specifically picked to exceed both the 10 and 40 second
>> timeouts and acts more as a fail-safe timeout.
>
>The timeout was added in #commit:
>b39297aedfabe9b2c426cd540413be991500da25
>There is no point in setting the TIMEOUT for this long as the actual
>freeze
>- Fush and Hold Writes -
>is limited to 10 seconds ( not configurable) according to msdn
>https://msdn.microsoft.com/en-us/library/windows/desktop/aa384589%28v=3Dvs=
.85%29.aspx

The reason it's set that long is because the VSS service is perfectly
capable of telling us exactly when it has timed out. I think racing with
it because we don't like how it chooses to log errors is an ugly approach,
and in the process of doing that we lose an extra second of time that
management might have been able to make use of to complete the snapshot
successfully. 10s is already small as is, losing 10% of that to avoid
Event Log messages seems like a poor trade-off.

>
>>
>> Are the event logs causing issues? FWIW, on the posix side we also opt
>> for gratuitous logging to syslog and such, the idea there being that
>> cooperative guests would prefer transparency on how the agent is being
>> used.
>>
>Apparently, these error logs are annoying to some (
>https://bugzilla.redhat.com/show_bug.cgi?id=3D1387125),

It seems more like users were complaining about a different event log
error dealing with permissions issues. I don't really see anyone
concerned with the timeout errors once it was apparent how they factored
into the overall snapshot operation.

>moreover I don't think that our implementation to the freeze operation -
>which is a workaround in a way -
>should log errors even though we know they are false alarm.

These aren't really false alarms. I think there's a good reason the VSS
service was designed to log failures to hold writes in the event log,
and we primarily use it for the same reason those errors would be
relevant: creating reliable snapshots.

Users who don't care about the errors can use the filtering facilities
built into the event log viewer. Users who do care probably feel a bit
more strongly about keeping that information logged.

>
>>
>> That said, I do think error 12293 is unecessary, since IIUC it would
>> always be paired with the actual VSS-reported error. So avoiding the
>> E_ABORT seems reasonable either way.
>>
>>>
>>> |event id|                           error
>>  |
>>> * 12293  : Volume Shadow Copy Service error: Error calling a routine
>>> on a
>>>            Shadow Copy Provider
>>>            {00000000-0000-0000-0000-000000000000}.
>>>        Routine details CommitSnapshots [hr =3D 0x80004004, Operation
>>>        aborted.
>>>
>>> * 12340  : Volume Shadow Copy Error: VSS waited more than 40 seconds
>>> for
>>>            all volumes to be flushed.  This caused volume
>>>        \\?\Volume{62a171da-32ec-11e4-80b1-806e6f6e6963}\ to timeout
>>>        while waiting for the release-writes phase of shadow copy
>>>        creation. Trying again when disk activity is lower may solve
>>>        this problem.
>>>
>>> * 12298  : Volume Shadow Copy Service error: The I/O writes cannot be
>> held
>>>            during the shadow copy creation period on volume
>>>            \\?\Volume{62a171d9-32ec-11e4-80b1-806e6f6e6963}\. The
>>>            volume
>>>        index in the shadow copy set is 0. Error details:
>>>        Open[0x00000000, The operation completed successfully. ],
>>>        Flush[0x00000000, The operation completed successfully.],
>>>        Release[0x00000000, The operation completed successfully.],
>>>        OnRun[0x80042314, The shadow copy provider timed out while
>>>        holding writes to the volume being shadow copied. This is
>>>        probably due to excessive activity on the volume by an
>>>        application or a system service. Try again later when activity
>>>        on the volume is reduced.
>>>
>>> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
>>> ---
>>>  qga/vss-win32/provider.cpp | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
>>> index ef94669..d72f4d4 100644
>>> --- a/qga/vss-win32/provider.cpp
>>> +++ b/qga/vss-win32/provider.cpp
>>> @@ -15,7 +15,7 @@
>>>  #include <inc/win2003/vscoordint.h>
>>>  #include <inc/win2003/vsprov.h>
>>>
>>> -#define VSS_TIMEOUT_MSEC (60*1000)
>>> +#define VSS_TIMEOUT_MSEC (9 * 1000)
>>>
>>>  static long g_nComObjsInUse;
>>>  HINSTANCE g_hinstDll;
>>> @@ -377,7 +377,6 @@ STDMETHODIMP
>>> CQGAVssProvider::CommitSnapshots(VSS_ID
>> SnapshotSetId)
>>>      if (WaitForSingleObject(hEventThaw, VSS_TIMEOUT_MSEC) !=3D
>> WAIT_OBJECT_0) {
>>>          /* Send event to qemu-ga to notify the provider is timed out
>>>          */
>>>          SetEvent(hEventTimeout);
>>> -        hr =3D E_ABORT;
>>>      }
>>>
>>>      CloseHandle(hEventThaw);
>>> --
>>> 2.9.3
>>>
