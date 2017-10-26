Received: from eggs.gnu.org ([2001:4830:134:3::10]:46911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7exH-0002wS-UV
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7exD-0008Kt-2a
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:00:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7exC-0008Ii-PW
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 05:59:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9Q9xIl8113597
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 05:59:54 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dudc60mne-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 05:59:52 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 05:59:51 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <7f4779f8.a9e3.15f58023405.Coremail.chen_han_xiao@126.com>
References: <20170929091122.22726-1-chen_han_xiao@126.com>
	<20170929233102.4b068e2f@fiorina>
	<150896868721.17721.8644098584872122342@sif>
	<7f4779f8.a9e3.15f58023405.Coremail.chen_han_xiao@126.com>
Date: Thu, 26 Oct 2017 04:59:34 -0500
Message-Id: <150901197477.2572.8281272155306151642@sif>
Subject: Re: [Qemu-devel] [PATCH] qga-win: fall back to hardcoded user and
 group names if LookupAccountSidW failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, qemu-devel@nongnu.org

Quoting Chen Hanxiao (2017-10-26 04:27:40)
> =

> =

> At 2017-10-26 05:58:07, "Michael Roth" <mdroth@linux.vnet.ibm.com> wrote:
> >Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2017-09-29 16:31:02)
> >> On Fri, 29 Sep 2017 17:11:22 +0800
> >> Chen Hanxiao <chen_han_xiao@126.com> wrote:
> >> =

> >> > From: Chen Hanxiao <chenhanxiao@gmail.com>
> >> > =

> >> > On some of windows (win08 sp2),
> >> > it doesn't work by calling LookupAccountSidW with
> >> > well-known SIDs,
> >> > We got an error:
> >> >     error 997 overlapped I/O operation is in progress
> >> > =

> >> > But hardcoded names work.
> >> > =

> >> > This patch introduces a workaroud for this issue:
> >> > if LookupAccountSidW failed, try hardcoded one.
> >> > =

> >> > Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> >> > ---
> >> >  qga/vss-win32/install.cpp | 10 ++++++++--
> >> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >> > =

> >> =

> >> I wonder if it's caused by qga itself or a race/conflict with some oth=
er
> >> app. But still...
> >> =

> >> =

> >> Reviewed-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> >
> >I think it might be getNameByStringSID()/LookupAccountSidW() reporting a
> >stale GetLastError() value.
> >
> >Does this fix the issue?
> =

> Not exactly.
> I tested your patch several times, it improved greatly.
> But failed only one time,
> got another error 1722.

Hmm, was that error also from the getNameByStringSID() call?

> =

> Build with my fallback patch and your suggestion, =

> installation work perfectly.

Thanks for testing.

> =

> Regards,
> - Chen
> =

> >
> >diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> >index ba7c94eb25..94c921e8de 100644
> >--- a/qga/vss-win32/install.cpp
> >+++ b/qga/vss-win32/install.cpp
> >@@ -149,9 +149,10 @@ static HRESULT getNameByStringSID(
> >     wchar_t domainName[BUFFER_SIZE];
> > =

> >     chk(ConvertStringSidToSidW(sid, &psid));
> >-    LookupAccountSidW(NULL, psid, buffer, bufferLen,
> >-                domainName, &domainNameLen, &groupType);
> >-    hr =3D HRESULT_FROM_WIN32(GetLastError());
> >+    if (!LookupAccountSidW(NULL, psid, buffer, bufferLen,
> >+                           domainName, &domainNameLen, &groupType)) {
> >+        hr =3D HRESULT_FROM_WIN32(GetLastError());
> >+    }
> > =

> >     LocalFree(psid);
> >
> >> =

> >> =

> >> -- =

> >> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> >> =

> >
