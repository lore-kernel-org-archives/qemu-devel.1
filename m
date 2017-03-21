Received: from eggs.gnu.org ([2001:4830:134:3::10]:47552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqMM5-0000ev-SN
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cqMM2-0000UC-L5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:09:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cqMM2-0000T9-Bf
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:09:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2LG4q9q062419
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 12:09:48 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29b58tqnu1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 12:09:48 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 21 Mar 2017 10:09:47 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170321104952.6236-1-sameeh@daynix.com>
References: <20170321104952.6236-1-sameeh@daynix.com>
Date: Tue, 21 Mar 2017 11:09:37 -0500
Message-Id: <149011257708.3910.6427658788264808225@loki>
Subject: Re: [Qemu-devel] [PATCH] Fix Event Viewer errors caused by qemu-ga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>

Quoting Sameeh Jubran (2017-03-21 05:49:52)
> When the command "guest-fsfreeze-freeze" is executed it causes
> the VSS service to log the errors below in the Event Viewer.
> =

> These errors are caused by two issues in the function "CommitSnapshots" in
> provider.cpp:
> =

> 1. When VSS_TIMEOUT_MSEC expires the funtion returns E_ABORT. This causes
> the error #12293.
> =

> 2. The VSS_TIMEOUT_MSEC value is too big. According to msdn the
> "Flush & Hold" operation has 10 seconds timeout not configurable, The
> "CommitSnapshots" is a part of the "Flush & Hold" process and thus any
> timeout bigger than 10 seconds would cause the error #12298 and anything
> bigger than 40 seconds causes the error #12340. All this info can be foun=
d here:
> https://msdn.microsoft.com/en-us/library/windows/desktop/aa384589(v=3Dvs.=
85).aspx

Not sure how best to deal with this. Technically our CommitSnapshots
interface is driven by the backup job being run by QGA/QEMU management
side. If that amount of time exceeds the VSS limits then I think it's
appropriate for VSS to log the error accordingly. VSS_TIMEOUT_MSEC here
doesn't actually have too much correlation with the VSS-set timeout,
IIRC it's specifically picked to exceed both the 10 and 40 second
timeouts and acts more as a fail-safe timeout.

Are the event logs causing issues? FWIW, on the posix side we also opt
for gratuitous logging to syslog and such, the idea there being that
cooperative guests would prefer transparency on how the agent is being
used.

That said, I do think error 12293 is unecessary, since IIUC it would
always be paired with the actual VSS-reported error. So avoiding the
E_ABORT seems reasonable either way.

> =

> |event id|                           error                               |
> * 12293  : Volume Shadow Copy Service error: Error calling a routine on a
>            Shadow Copy Provider {00000000-0000-0000-0000-000000000000}.
>        Routine details CommitSnapshots [hr =3D 0x80004004, Operation
>        aborted.
> =

> * 12340  : Volume Shadow Copy Error: VSS waited more than 40 seconds for
>            all volumes to be flushed.  This caused volume
>        \\?\Volume{62a171da-32ec-11e4-80b1-806e6f6e6963}\ to timeout
>        while waiting for the release-writes phase of shadow copy
>        creation. Trying again when disk activity is lower may solve
>        this problem.
> =

> * 12298  : Volume Shadow Copy Service error: The I/O writes cannot be held
>            during the shadow copy creation period on volume
>            \\?\Volume{62a171d9-32ec-11e4-80b1-806e6f6e6963}\. The volume
>        index in the shadow copy set is 0. Error details:
>        Open[0x00000000, The operation completed successfully. ],
>        Flush[0x00000000, The operation completed successfully.],
>        Release[0x00000000, The operation completed successfully.],
>        OnRun[0x80042314, The shadow copy provider timed out while
>        holding writes to the volume being shadow copied. This is
>        probably due to excessive activity on the volume by an
>        application or a system service. Try again later when activity
>        on the volume is reduced.
> =

> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> ---
>  qga/vss-win32/provider.cpp | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> =

> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> index ef94669..d72f4d4 100644
> --- a/qga/vss-win32/provider.cpp
> +++ b/qga/vss-win32/provider.cpp
> @@ -15,7 +15,7 @@
>  #include <inc/win2003/vscoordint.h>
>  #include <inc/win2003/vsprov.h>
> =

> -#define VSS_TIMEOUT_MSEC (60*1000)
> +#define VSS_TIMEOUT_MSEC (9 * 1000)
> =

>  static long g_nComObjsInUse;
>  HINSTANCE g_hinstDll;
> @@ -377,7 +377,6 @@ STDMETHODIMP CQGAVssProvider::CommitSnapshots(VSS_ID =
SnapshotSetId)
>      if (WaitForSingleObject(hEventThaw, VSS_TIMEOUT_MSEC) !=3D WAIT_OBJE=
CT_0) {
>          /* Send event to qemu-ga to notify the provider is timed out */
>          SetEvent(hEventTimeout);
> -        hr =3D E_ABORT;
>      }
> =

>      CloseHandle(hEventThaw);
> -- =

> 2.9.3
>=20
