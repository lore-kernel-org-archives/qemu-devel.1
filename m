Received: from eggs.gnu.org ([2001:4830:134:3::10]:33902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eJp8E-0007Il-KE
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eJp8A-0001E7-BJ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:17:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eJp8A-0001DJ-34
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 18:17:34 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASNEQx4033730
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 18:17:29 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ehfp3c7hg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 18:17:28 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 28 Nov 2017 18:17:27 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20171122113014.2512-1-sameeh@daynix.com>
References: <20171122113014.2512-1-sameeh@daynix.com>
Date: Tue, 28 Nov 2017 17:17:17 -0600
Message-Id: <151191103735.31225.17730405646233505006@sif>
Subject: Re: [Qemu-devel] [PATCH] qga-win: VSS: Handle
 VSS_E_PROVIDER_ALREADY_REGISTERED error
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

Quoting Sameeh Jubran (2017-11-22 05:30:14)
> From: Sameeh Jubran <sjubran@redhat.com>
> =

> We can get VSS_E_PROVIDER_ALREADY_REGISTERED error if for some
> reason the uninstall of qemu-ga didn't complete successfully.
> In this case we can try to unregister the component service
> and attempt to register it again.
> =

> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>

This might be reasonable either way, but I'm concerned with why the
uninstall of the VSS provider is failing in the first place. Are
you seeing this issue with uninstall->install of the MSI package?

If so there's 2 cases I've noticed with that:

a) the VSS_E_PROVIDER_ALREADY_REGISTERED issue when you do the install,
   which currently requires you to run qemu-ga -s vss-uninstall separately
   and then retrying. This one would get fixed with this patch
b) the DllRegisterServer call just hangs indefinitely. This one wouldn't
   get fixed with this patch and it seems to be the one I see more often on
   Windows 7

I don't yet know the root cause, but both issues seem to have gone away for
me with this patch:

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index 5af11627f8..c76b7a39c5 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -81,7 +81,7 @@
               Arguments=3D"-d"
               >
             </ServiceInstall>
-            <ServiceControl Id=3D"StartService" Start=3D"install" Stop=3D"=
both" Remove=3D"uninstall" Name=3D"QEMU-GA" Wait=3D"no" />
+            <ServiceControl Id=3D"StartService" Start=3D"install" Stop=3D"=
both" Remove=3D"uninstall" Name=3D"QEMU-GA" Wait=3D"yes" />
           </Component>
           <?ifdef var.InstallVss?>
           <Component Id=3D"qga_vss_dll" Guid=3D"{CB19C453-FABB-4BB1-ABAB-6=
B74F687BFBB}">

Does this help in your case as well?

> ---
>  qga/vss-win32/install.cpp | 9 +++++++++
>  1 file changed, 9 insertions(+)
> =

> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 51838eeb26..e7bc5e1d9d 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -443,6 +443,15 @@ STDAPI DllRegisterServer(void)
>                                       VSS_PROV_SOFTWARE,
>                                       const_cast<WCHAR*>(QGA_PROVIDER_VER=
SION),
>                                       g_gProviderVersion);
> +    if (hr =3D=3D (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
> +        DllUnregisterServer();
> +        hr =3D pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSPr=
ovider,
> +                                     const_cast<WCHAR * >(QGA_PROVIDER_L=
NAME),
> +                                     VSS_PROV_SOFTWARE,
> +                                     const_cast<WCHAR * >(QGA_PROVIDER_V=
ERSION),
> +                                     g_gProviderVersion);
> +    }
> +
>      if (FAILED(hr)) {
>          errmsg_dialog(hr, "RegisterProvider failed");
>      }
> -- =

> 2.13.6
>=20
