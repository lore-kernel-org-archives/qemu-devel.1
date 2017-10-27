Received: from eggs.gnu.org ([2001:4830:134:3::10]:60941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7t5p-0001RY-Df
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7t5m-0002Cy-47
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:05:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7t5l-0002Bw-SB
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:05:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9R14j2L081638
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:05:41 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dusb7bpyh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:05:40 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 19:05:40 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20171026155437.5f260b7b@fiorina>
References: <20170929091122.22726-1-chen_han_xiao@126.com>
	<20170929233102.4b068e2f@fiorina>
	<150896868721.17721.8644098584872122342@sif>
	<20171026155437.5f260b7b@fiorina>
Date: Thu, 26 Oct 2017 20:05:25 -0500
Message-Id: <150906632596.2572.511583404169655715@sif>
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
To: =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: Chen Hanxiao <chen_han_xiao@126.com>, qemu-devel@nongnu.org

Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2017-10-26 08:54:37)
> On Wed, 25 Oct 2017 16:58:07 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> =

> > Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2017-09-29 16:31:02)
> > > On Fri, 29 Sep 2017 17:11:22 +0800
> > > Chen Hanxiao <chen_han_xiao@126.com> wrote:
> > >   =

> > > > From: Chen Hanxiao <chenhanxiao@gmail.com>
> > > > =

> > > > On some of windows (win08 sp2),
> > > > it doesn't work by calling LookupAccountSidW with
> > > > well-known SIDs,
> > > > We got an error:
> > > >     error 997 overlapped I/O operation is in progress
> > > > =

> > > > But hardcoded names work.
> > > > =

> > > > This patch introduces a workaroud for this issue:
> > > > if LookupAccountSidW failed, try hardcoded one.
> > > > =

> > > > Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> > > > ---
> > > >  qga/vss-win32/install.cpp | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >   =

> > > =

> > > I wonder if it's caused by qga itself or a race/conflict with some ot=
her
> > > app. But still...
> > > =

> > > =

> > > Reviewed-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>  =

> > =

> > I think it might be getNameByStringSID()/LookupAccountSidW() reporting a
> > stale GetLastError() value.
> > =

> =

> I suppose you're right! Taking a closer look there's one more issue with
> getNameByStringSID(). The call ConvertStringSidToSidW() does not return
> HRESULT so using chk() makes no sense.
> =

> I propose slightly modified version of your fix:
> =

> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index ba7c94eb25..65f68f94a3 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -148,10 +148,15 @@ static HRESULT getNameByStringSID(
>      DWORD domainNameLen =3D BUFFER_SIZE;
>      wchar_t domainName[BUFFER_SIZE];
>  =

> -    chk(ConvertStringSidToSidW(sid, &psid));
> -    LookupAccountSidW(NULL, psid, buffer, bufferLen,
> -                domainName, &domainNameLen, &groupType);
> -    hr =3D HRESULT_FROM_WIN32(GetLastError());
> +    if (!ConvertStringSidToSidW(sid, &psid) {
> +        hr =3D HRESULT_FROM_WIN32(GetLastError());
> +        goto out;
> +    }
> +    if (!LookupAccountSidW(NULL, psid, buffer, bufferLen,
> +                           domainName, &domainNameLen, &groupType)) {
> +        hr =3D HRESULT_FROM_WIN32(GetLastError());
> +        /* Fall through and free psid */
> +    }
>  =

>      LocalFree(psid);


Thanks! It's not yet clear if this fixes the issue completely (though it
seems likely), but it's clearly a bug either way so I've gone ahead and
applied it to the qga tree:

  https://github.com/mdroth/qemu/commit/8cedc80555e5a395a4fda7130b0115015e7=
75c48

Chen, if there's still an issue with the updated patch please let me know.

>  =

> =

> -- =

> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>=20
