Received: from eggs.gnu.org ([2001:4830:134:3::10]:49223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cuZxo-0003Iq-Vq
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cuZxl-0007i9-Ok
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:30:16 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cuZxl-0007dg-IB
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:30:13 -0400
Received: by mail-vk0-x243.google.com with SMTP id j137so14607099vke.0
	for <qemu-devel@nongnu.org>; Sun, 02 Apr 2017 00:30:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170323162650.16973-2-sameeh@daynix.com>
References: <20170323162650.16973-1-sameeh@daynix.com>
	<20170323162650.16973-2-sameeh@daynix.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 2 Apr 2017 10:30:09 +0300
Message-ID: <CAKPgXcHt-SDE8ObvpTXm3KaQvrxqKCcHy9TUcFvbnq+gHSDMww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH qemu-ga v2] qemu-ga: Make QGA VSS provider
 service run only when needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

Ping.

On Thu, Mar 23, 2017 at 7:26 PM, Sameeh Jubran <sameeh@daynix.com> wrote:

> Currently the service runs in background on boot even though it is not
> needed and once it is running it never stops. The service needs to be
> running only during freeze operation and it should be stopped after
> executing thaw.
>
> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> ---
>  qga/vss-win32/install.cpp   | 28 ++++++++++++++++++++++++++--
>  qga/vss-win32/install.h     | 20 ++++++++++++++++++++
>  qga/vss-win32/requester.cpp |  2 ++
>  3 files changed, 48 insertions(+), 2 deletions(-)
>  create mode 100644 qga/vss-win32/install.h
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index f4160a3..f41fcdf 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -14,7 +14,7 @@
>
>  #include "vss-common.h"
>  #include <inc/win2003/vscoordint.h>
> -#include <comadmin.h>
> +#include "install.h"
>  #include <wbemidl.h>
>  #include <comdef.h>
>  #include <comutil.h>
> @@ -276,7 +276,7 @@ STDAPI COMRegister(void)
>
>      chk(pCatalog->CreateServiceForApplication(
>              _bstr_t(QGA_PROVIDER_LNAME), _bstr_t(QGA_PROVIDER_LNAME),
> -            _bstr_t(L"SERVICE_AUTO_START"), _bstr_t(L"SERVICE_ERROR_
> NORMAL"),
> +            _bstr_t(L"SERVICE_DEMAND_START"), _bstr_t(L"SERVICE_ERROR_
> NORMAL"),
>              _bstr_t(L""), _bstr_t(L".\\localsystem"), _bstr_t(L""),
> FALSE));
>      chk(pCatalog->InstallComponent(_bstr_t(QGA_PROVIDER_LNAME),
>                                     _bstr_t(dllPath), _bstr_t(tlbPath),
> @@ -461,3 +461,27 @@ namespace _com_util
>          return bstr;
>      }
>  }
> +
> +/* Stop QGA VSS provider service from COM+ Application Admin Catalog */
> +
> +STDAPI StopService(void)
> +{
> +    HRESULT hr;
> +    COMInitializer initializer;
> +    COMPointer<IUnknown> pUnknown;
> +    COMPointer<ICOMAdminCatalog2> pCatalog;
> +
> +    int count = 0;
> +
> +    chk(QGAProviderFind(QGAProviderCount, (void *)&count));
> +    if (count) {
> +        chk(CoCreateInstance(CLSID_COMAdminCatalog, NULL,
> CLSCTX_INPROC_SERVER,
> +            IID_IUnknown, (void **)pUnknown.replace()));
> +        chk(pUnknown->QueryInterface(IID_ICOMAdminCatalog2,
> +            (void **)pCatalog.replace()));
> +        chk(pCatalog->ShutdownApplication(_bstr_t(QGA_PROVIDER_LNAME)));
> +    }
> +
> +out:
> +    return hr;
> +}
> diff --git a/qga/vss-win32/install.h b/qga/vss-win32/install.h
> new file mode 100644
> index 0000000..35364af
> --- /dev/null
> +++ b/qga/vss-win32/install.h
> @@ -0,0 +1,20 @@
> +/*
> + * QEMU Guest Agent VSS requester declarations
> + *
> + * Copyright Hitachi Data Systems Corp. 2013
> + *
> + * Authors:
> + *  Tomoki Sekiyama   <tomoki.sekiyama@hds.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef INSTALL_H
> +#define INSTALL_H
> +
> +#include <comadmin.h>
> +
> +STDAPI StopService(void);
> +
> +#endif
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 272e71b..27308ad 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "vss-common.h"
>  #include "requester.h"
> +#include "install.h"
>  #include <inc/win2003/vswriter.h>
>  #include <inc/win2003/vsbackup.h>
>
> @@ -501,4 +502,5 @@ void requester_thaw(int *num_vols, ErrorSet *errset)
>      requester_cleanup();
>
>      CoUninitialize();
> +    StopService();
>  }
> --
> 2.9.3
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
