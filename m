Received: from eggs.gnu.org ([2001:4830:134:3::10]:43771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1da9jI-0005Gj-Ot
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 19:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1da9jD-0004Og-Nl
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 19:59:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50210
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1da9jD-0004Na-Hi
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 19:59:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6PNwnRF025657
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:59:02 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxdwfnsdj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:59:02 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Jul 2017 17:59:01 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170705075411.6556-3-sameeh@daynix.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
	<20170705075411.6556-3-sameeh@daynix.com>
Date: Tue, 25 Jul 2017 18:32:24 -0500
Message-Id: <150102554420.26979.10451385667905822656@loki>
Subject: Re: [Qemu-devel] [PATCH 2/5] qga-win: service-win32: Add
 start_service and stop_service functions
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

Quoting Sameeh Jubran (2017-07-05 02:54:08)
> From: Sameeh Jubran <sjubran@redhat.com>
> =

> This commits adds two functions which handle service's start and stop
> process in Windows.
> =

> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>  qga/service-win32.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  qga/service-win32.h |  2 ++
>  2 files changed, 54 insertions(+)
> =

> diff --git a/qga/service-win32.c b/qga/service-win32.c
> index fd434e3..dc41d63 100644
> --- a/qga/service-win32.c
> +++ b/qga/service-win32.c
> @@ -95,6 +95,26 @@ static const char *win_escape_arg(const char *to_escap=
e, GString *buffer)
>      return buffer->str;
>  }
> =

> +
> +static int get_service(const char *service_name, SC_HANDLE* service)

SC_HANDLE *service

> +{
> +    SC_HANDLE manager =3D NULL;

OpenSCManager returns NULL on error so no need to initialize the
value here.

> +    manager =3D OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
> +    if (manager =3D=3D NULL) {
> +        printf_win_error("No handle to service control manager");
> +        return EXIT_FAILURE;
> +    }
> +
> +    *service =3D OpenService(manager, service_name, SERVICE_ALL_ACCESS);
> +    if (service =3D=3D NULL) {

This should be checking *service AFAICT.

> +        printf_win_error("Failed to open service");
> +        return EXIT_FAILURE;
> +    }
> +
> +    CloseServiceHandle(manager);
> +    return EXIT_SUCCESS;
> +}
> +
>  int ga_install_service(const char *path, const char *logfile,
>                         const char *state_dir)
>  {
> @@ -188,3 +208,35 @@ int ga_uninstall_service(void)
> =

>      return EXIT_SUCCESS;
>  }
> +
> +int start_service(const char *service_name)
> +{
> +    int ret =3D EXIT_FAILURE;

get_service() will set this either way so no need to initialize.

> +    SC_HANDLE service =3D NULL;
> +    ret =3D get_service(service_name, &service);
> +    if (ret !=3D EXIT_SUCCESS) {
> +        return ret;
> +    }
> +    ret =3D StartService(service, 0 , NULL) ? EXIT_SUCCESS : GetLastErro=
r();
> +
> +    CloseServiceHandle(service);
> +    return ret;
> +}
> +
> +int stop_service(const char *service_name)
> +{
> +    int ret =3D EXIT_FAILURE;

No need to initialize

> +    SC_HANDLE service =3D NULL;
> +
> +    SERVICE_STATUS service_status;
> +    ret =3D get_service(service_name, &service);
> +
> +    if (ret !=3D EXIT_SUCCESS) {
> +        return ret;
> +    }
> +    ret =3D ControlService(service, SERVICE_CONTROL_STOP, &service_statu=
s) ?
> +        EXIT_SUCCESS : GetLastError();
> +
> +    CloseServiceHandle(service);
> +    return ret;
> +}
> diff --git a/qga/service-win32.h b/qga/service-win32.h
> index 89e99df..65248ea 100644
> --- a/qga/service-win32.h
> +++ b/qga/service-win32.h
> @@ -28,5 +28,7 @@ typedef struct GAService {
>  int ga_install_service(const char *path, const char *logfile,
>                         const char *state_dir);
>  int ga_uninstall_service(void);
> +int start_service(const char *service_name);
> +int stop_service(const char *service_name);
> =

>  #endif
> -- =

> 2.9.4
>=20
