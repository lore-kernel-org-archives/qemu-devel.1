Received: from eggs.gnu.org ([2001:4830:134:3::10]:41263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1eKP9q-000190-Sq
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1eKP9m-0000AC-Os
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:45:42 -0500
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:39238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1eKP9m-00009r-Eq
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:45:38 -0500
Received: by mail-io0-x229.google.com with SMTP id h12so7547853iof.6
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 05:45:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151191103735.31225.17730405646233505006@sif>
References: <20171122113014.2512-1-sameeh@daynix.com>
	<151191103735.31225.17730405646233505006@sif>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 30 Nov 2017 15:45:37 +0200
Message-ID: <CAKPgXcEe-zu0s+0K43KWveu=LXZx+_p7P_9uQgocFpqbGVQ9SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

On Wed, Nov 29, 2017 at 1:17 AM, Michael Roth <mdroth@linux.vnet.ibm.com>
wrote:

> Quoting Sameeh Jubran (2017-11-22 05:30:14)
> > From: Sameeh Jubran <sjubran@redhat.com>
> >
> > We can get VSS_E_PROVIDER_ALREADY_REGISTERED error if for some
> > reason the uninstall of qemu-ga didn't complete successfully.
> > In this case we can try to unregister the component service
> > and attempt to register it again.
> >
> > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>
> This might be reasonable either way, but I'm concerned with why the
> uninstall of the VSS provider is failing in the first place. Are
> you seeing this issue with uninstall->install of the MSI package?
>
> If so there's 2 cases I've noticed with that:
>
> a) the VSS_E_PROVIDER_ALREADY_REGISTERED issue when you do the install,
>    which currently requires you to run qemu-ga -s vss-uninstall separately
>    and then retrying. This one would get fixed with this patch
> b) the DllRegisterServer call just hangs indefinitely. This one wouldn't
>    get fixed with this patch and it seems to be the one I see more often on
>    Windows 7
>
> I don't yet know the root cause, but both issues seem to have gone away for
> me with this patch:
>
> diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
> index 5af11627f8..c76b7a39c5 100644
> --- a/qga/installer/qemu-ga.wxs
> +++ b/qga/installer/qemu-ga.wxs
> @@ -81,7 +81,7 @@
>                Arguments="-d"
>                >
>              </ServiceInstall>
> -            <ServiceControl Id="StartService" Start="install" Stop="both"
> Remove="uninstall" Name="QEMU-GA" Wait="no" />
> +            <ServiceControl Id="StartService" Start="install" Stop="both"
> Remove="uninstall" Name="QEMU-GA" Wait="yes" />
>            </Component>
>            <?ifdef var.InstallVss?>
>            <Component Id="qga_vss_dll" Guid="{CB19C453-FABB-4BB1-
> ABAB-6B74F687BFBB}">
>
> Does this help in your case as well?
>
Yes it does, thanks!

>
> > ---
> >  qga/vss-win32/install.cpp | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> > index 51838eeb26..e7bc5e1d9d 100644
> > --- a/qga/vss-win32/install.cpp
> > +++ b/qga/vss-win32/install.cpp
> > @@ -443,6 +443,15 @@ STDAPI DllRegisterServer(void)
> >                                       VSS_PROV_SOFTWARE,
> >                                       const_cast<WCHAR*>(QGA_
> PROVIDER_VERSION),
> >                                       g_gProviderVersion);
> > +    if (hr == (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
> > +        DllUnregisterServer();
> > +        hr = pVssAdmin->RegisterProvider(g_gProviderId,
> CLSID_QGAVSSProvider,
> > +                                     const_cast<WCHAR *
> >(QGA_PROVIDER_LNAME),
> > +                                     VSS_PROV_SOFTWARE,
> > +                                     const_cast<WCHAR *
> >(QGA_PROVIDER_VERSION),
> > +                                     g_gProviderVersion);
> > +    }
> > +
> >      if (FAILED(hr)) {
> >          errmsg_dialog(hr, "RegisterProvider failed");
> >      }
> > --
> > 2.13.6
> >
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
