Received: from eggs.gnu.org ([2001:4830:134:3::10]:40844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1e7icP-0005ef-Ta
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1e7icL-0005eD-Qy
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:54:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:53650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1e7icL-0005bJ-K3
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:54:41 -0400
Received: by mail-wr0-f194.google.com with SMTP id u40so3236959wrf.10
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 06:54:40 -0700 (PDT)
Date: Thu, 26 Oct 2017 15:54:37 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20171026155437.5f260b7b@fiorina>
In-Reply-To: <150896868721.17721.8644098584872122342@sif>
References: <20170929091122.22726-1-chen_han_xiao@126.com>
	<20170929233102.4b068e2f@fiorina>
	<150896868721.17721.8644098584872122342@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Chen Hanxiao <chen_han_xiao@126.com>, qemu-devel@nongnu.org

On Wed, 25 Oct 2017 16:58:07 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2017-09-29 16:31:02)
> > On Fri, 29 Sep 2017 17:11:22 +0800
> > Chen Hanxiao <chen_han_xiao@126.com> wrote:
> >  =20
> > > From: Chen Hanxiao <chenhanxiao@gmail.com>
> > >=20
> > > On some of windows (win08 sp2),
> > > it doesn't work by calling LookupAccountSidW with
> > > well-known SIDs,
> > > We got an error:
> > >     error 997 overlapped I/O operation is in progress
> > >=20
> > > But hardcoded names work.
> > >=20
> > > This patch introduces a workaroud for this issue:
> > > if LookupAccountSidW failed, try hardcoded one.
> > >=20
> > > Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> > > ---
> > >  qga/vss-win32/install.cpp | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >  =20
> >=20
> > I wonder if it's caused by qga itself or a race/conflict with some other
> > app. But still...
> >=20
> >=20
> > Reviewed-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> =20
>=20
> I think it might be getNameByStringSID()/LookupAccountSidW() reporting a
> stale GetLastError() value.
>=20

I suppose you're right! Taking a closer look there's one more issue with
getNameByStringSID(). The call ConvertStringSidToSidW() does not return
HRESULT so using chk() makes no sense.

I propose slightly modified version of your fix:

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index ba7c94eb25..65f68f94a3 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -148,10 +148,15 @@ static HRESULT getNameByStringSID(
     DWORD domainNameLen =3D BUFFER_SIZE;
     wchar_t domainName[BUFFER_SIZE];
=20
-    chk(ConvertStringSidToSidW(sid, &psid));
-    LookupAccountSidW(NULL, psid, buffer, bufferLen,
-                domainName, &domainNameLen, &groupType);
-    hr =3D HRESULT_FROM_WIN32(GetLastError());
+    if (!ConvertStringSidToSidW(sid, &psid) {
+        hr =3D HRESULT_FROM_WIN32(GetLastError());
+        goto out;
+    }
+    if (!LookupAccountSidW(NULL, psid, buffer, bufferLen,
+                           domainName, &domainNameLen, &groupType)) {
+        hr =3D HRESULT_FROM_WIN32(GetLastError());
+        /* Fall through and free psid */
+    }
=20
     LocalFree(psid);
=20

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
