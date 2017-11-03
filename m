Received: from eggs.gnu.org ([2001:4830:134:3::10]:55535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eAZyA-0004Yi-Oy
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eAZy5-0000L6-QH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:17:02 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:49502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1eAZy5-0000Ik-Jc
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:16:57 -0400
Received: by mail-wm0-f48.google.com with SMTP id b189so744579wmd.4
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 04:16:55 -0700 (PDT)
Date: Fri, 3 Nov 2017 12:16:51 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20171103121651.43730e76@fiorina>
In-Reply-To: <7cc46892.bc57.15f7c622d65.Coremail.chen_han_xiao@126.com>
References: <20170929091122.22726-1-chen_han_xiao@126.com>
	<20170929233102.4b068e2f@fiorina>
	<150896868721.17721.8644098584872122342@sif>
	<20171026155437.5f260b7b@fiorina>
	<150906632596.2572.511583404169655715@sif>
	<7cc46892.bc57.15f7c622d65.Coremail.chen_han_xiao@126.com>
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
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 2 Nov 2017 18:58:49 +0800 (CST)
"Chen Hanxiao" <chen_han_xiao@126.com> wrote:

> At 2017-10-27 09:05:25, "Michael Roth" <mdroth@linux.vnet.ibm.com> wrote:
> >Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2017-10-26 08:54:37) =20
> >> On Wed, 25 Oct 2017 16:58:07 -0500
> >> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> >>  =20
> >> > Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2017-09-29 16:31:02) =20
> >> > > On Fri, 29 Sep 2017 17:11:22 +0800
> >> > > Chen Hanxiao <chen_han_xiao@126.com> wrote:
> >> > >=20
> >> > > Reviewed-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.co=
m>   =20
> >> >=20
> >> > I think it might be getNameByStringSID()/LookupAccountSidW() reporti=
ng a
> >> > stale GetLastError() value.
> >> >  =20
> >>=20
> >> I suppose you're right! Taking a closer look there's one more issue wi=
th
> >> getNameByStringSID(). The call ConvertStringSidToSidW() does not return
> >> HRESULT so using chk() makes no sense.
> >>=20
> >> I propose slightly modified version of your fix:
> >>=20
> >> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> >> index ba7c94eb25..65f68f94a3 100644
> >> --- a/qga/vss-win32/install.cpp
> >> +++ b/qga/vss-win32/install.cpp
> >> @@ -148,10 +148,15 @@ static HRESULT getNameByStringSID(
> >>      DWORD domainNameLen =3D BUFFER_SIZE;
> >>      wchar_t domainName[BUFFER_SIZE];
> >> =20
> >> -    chk(ConvertStringSidToSidW(sid, &psid));
> >> -    LookupAccountSidW(NULL, psid, buffer, bufferLen,
> >> -                domainName, &domainNameLen, &groupType);
> >> -    hr =3D HRESULT_FROM_WIN32(GetLastError());
> >> +    if (!ConvertStringSidToSidW(sid, &psid) {
> >> +        hr =3D HRESULT_FROM_WIN32(GetLastError());
> >> +        goto out;
> >> +    }
> >> +    if (!LookupAccountSidW(NULL, psid, buffer, bufferLen,
> >> +                           domainName, &domainNameLen, &groupType)) {
> >> +        hr =3D HRESULT_FROM_WIN32(GetLastError());
> >> +        /* Fall through and free psid */
> >> +    }
> >> =20
> >>      LocalFree(psid); =20
> >
> >
> >Thanks! It's not yet clear if this fixes the issue completely (though it
> >seems likely), but it's clearly a bug either way so I've gone ahead and
> >applied it to the qga tree:
> >
> >  https://github.com/mdroth/qemu/commit/8cedc80555e5a395a4fda7130b011501=
5e775c48
> >
> >Chen, if there's still an issue with the updated patch please let me kno=
w. =20
>=20
> Sorry for the late reply.
>=20
> I tested the upstream qga-win on that windows VM for several times.
> It works fine by my limit tests.
>=20

I'm glad to hear that.

    Tomas

> Regards,
> - Chen
>=20
>=20
>=20
> > =20
> >> =20
> >>=20
> >> --=20
> >> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> >>  =20
> > =20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
