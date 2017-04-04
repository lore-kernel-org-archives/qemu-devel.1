Received: from eggs.gnu.org ([2001:4830:134:3::10]:45745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cvXxW-0003Cm-DE
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cvXxS-0002Xw-DX
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:33:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cvXxS-0002XX-4X
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 19:33:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v34NXbDK043828
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 19:33:52 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29kurupmpw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 19:33:52 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 4 Apr 2017 17:33:51 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170323162650.16973-2-sameeh@daynix.com>
References: <20170323162650.16973-1-sameeh@daynix.com>
	<20170323162650.16973-2-sameeh@daynix.com>
Date: Tue, 04 Apr 2017 18:26:35 -0500
Message-Id: <149134839574.1924.8667411963457235603@loki>
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
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>

Quoting Sameeh Jubran (2017-03-23 11:26:50)
> Currently the service runs in background on boot even though it is not
> needed and once it is running it never stops. The service needs to be
> running only during freeze operation and it should be stopped after
> executing thaw.
> =

> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>


Thanks, applied to qga tree:

  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/vss-win32/install.cpp   | 28 ++++++++++++++++++++++++++--
>  qga/vss-win32/install.h     | 20 ++++++++++++++++++++
>  qga/vss-win32/requester.cpp |  2 ++
>  3 files changed, 48 insertions(+), 2 deletions(-)
>  create mode 100644 qga/vss-win32/install.h
> =

> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index f4160a3..f41fcdf 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -14,7 +14,7 @@
> =

>  #include "vss-common.h"
>  #include <inc/win2003/vscoordint.h>
> -#include <comadmin.h>
> +#include "install.h"
>  #include <wbemidl.h>
>  #include <comdef.h>
>  #include <comutil.h>
> @@ -276,7 +276,7 @@ STDAPI COMRegister(void)
> =

>      chk(pCatalog->CreateServiceForApplication(
>              _bstr_t(QGA_PROVIDER_LNAME), _bstr_t(QGA_PROVIDER_LNAME),
> -            _bstr_t(L"SERVICE_AUTO_START"), _bstr_t(L"SERVICE_ERROR_NORM=
AL"),
> +            _bstr_t(L"SERVICE_DEMAND_START"), _bstr_t(L"SERVICE_ERROR_NO=
RMAL"),
>              _bstr_t(L""), _bstr_t(L".\\localsystem"), _bstr_t(L""), FALS=
E));
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
> +    int count =3D 0;
> +
> +    chk(QGAProviderFind(QGAProviderCount, (void *)&count));
> +    if (count) {
> +        chk(CoCreateInstance(CLSID_COMAdminCatalog, NULL, CLSCTX_INPROC_=
SERVER,
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
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
> =

> @@ -501,4 +502,5 @@ void requester_thaw(int *num_vols, ErrorSet *errset)
>      requester_cleanup();
> =

>      CoUninitialize();
> +    StopService();
>  }
> -- =

> 2.9.3
>=20
