Received: from eggs.gnu.org ([2001:4830:134:3::10]:43784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1da9jL-0005HM-Ol
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 19:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1da9jG-0004UV-Ls
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 19:59:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1da9jG-0004SG-8C
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 19:59:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6PNwo5U141522
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:59:04 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bx919bacq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:59:04 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Jul 2017 17:59:03 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170705075411.6556-4-sameeh@daynix.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
	<20170705075411.6556-4-sameeh@daynix.com>
Date: Tue, 25 Jul 2017 18:58:54 -0500
Message-Id: <150102713404.26979.2894844170099516962@loki>
Subject: Re: [Qemu-devel] [PATCH 3/5] qga-win: Add serial listener service
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

Quoting Sameeh Jubran (2017-07-05 02:54:09)
> From: Sameeh Jubran <sjubran@redhat.com>
> =

> Currently on Windows whenever the qemu-ga's service doesn't find the virt=
io-serial
> it terminates. This commit addresses this issue by adding a new listener =
service
> which registers for notifications of the virtio-port-serial device handle=
 the
> qemu-ga's service accordingly.
> =

> Note that adding a new service to the qga code is much neater and simpler=
 than
> changing the behaviour of the qemu-ga's service as a good portion of the =
code is
> shared between Windows and Linux.
> =

> A list of possible scenarios of which could lead to this behavour:
> =

> * qemu-ga's service is started while the virtio-serial driver hasn't been=
 installed yet
> * hotplug/ unplug of the virtio-serial device
> * upgrading the virtio-serial driver

These don't really strike me as being w32-specific. What happens if we
unplug the virtio-serial device on linux while qemu-ga is running,
or start qemu-ga on linux before virtio-console module is loaded?
Would that trigger the same class of failures?

Maybe we should just add a mode to the various qga/channel*.c
implementations that waits for a particular path to become available,
and then also goes back to waiting for availability if the path
disappears?

Considering that isa-serial is also supported on Windows, and maybe
eventually the virtio-vsock stuff, it seems clunky to require another
service to manage this, especially if it still leaves the issue open
on linux/posix where availability is just as important.

> =

> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>  Makefile                            |  11 ++-
>  Makefile.objs                       |   1 +
>  qga/Makefile.objs                   |   2 +
>  qga/channel.h                       |   9 ++
>  qga/main.c                          |  23 +++--
>  qga/serial-listener-service-win32.c | 181 ++++++++++++++++++++++++++++++=
++++++
>  qga/serial-listener-service-win32.h |  29 ++++++
>  qga/service-win32.c                 |  79 +++++++++++++---
>  qga/service-win32.h                 |   3 +
>  9 files changed, 315 insertions(+), 23 deletions(-)
>  create mode 100644 qga/serial-listener-service-win32.c
>  create mode 100644 qga/serial-listener-service-win32.h
> =

> diff --git a/Makefile b/Makefile
> index 22d29d6..3583c8d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -266,6 +266,7 @@ dummy :=3D $(call unnest-vars,, \
>                  chardev-obj-y \
>                  util-obj-y \
>                  qga-obj-y \
> +                qga-serial-listener-obj-y \
>                  ivshmem-client-obj-y \
>                  ivshmem-server-obj-y \
>                  libvhost-user-obj-y \
> @@ -390,6 +391,9 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_P=
ATH)/scripts/hxtool
>  qemu-ga$(EXESUF): LIBS =3D $(LIBS_QGA)
>  qemu-ga$(EXESUF): QEMU_CFLAGS +=3D -I qga/qapi-generated
> =

> +qga-serial-listener$(EXESUF): LIBS =3D $(LIBS_QGA)
> +qga-serial-listener$(EXESUF): QEMU_CFLAGS +=3D -I qga/qapi-generated
> +
>  gen-out-type =3D $(subst .,-,$(suffix $@))
> =

>  qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.=
py
> @@ -448,6 +452,11 @@ $(qga-obj-y) qemu-ga.o: $(QGALIB_GEN)
>  qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
>         $(call LINK, $^)
> =

> +$(qga-serial-listener-obj-y) qga-serial-listener.o: $(QGALIB_GEN)
> +
> +qga-serial-listener$(EXESUF): $(qga-serial-listener-obj-y) $(COMMON_LDAD=
DS)
> +       $(call LINK, $^)
> +
>  ifdef QEMU_GA_MSI_ENABLED
>  QEMU_GA_MSI=3Dqemu-ga-$(ARCH).msi
> =

> @@ -467,7 +476,7 @@ endif
> =

>  ifneq ($(EXESUF),)
>  .PHONY: qemu-ga
> -qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
> +qemu-ga: qga-serial-listener$(EXESUF) qemu-ga$(EXESUF) $(QGA_VSS_PROVIDE=
R) $(QEMU_GA_MSI)
>  endif
> =

>  ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
> diff --git a/Makefile.objs b/Makefile.objs
> index b2e6322..b3fc042 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -103,6 +103,7 @@ target-obj-y +=3D trace/
>  # FIXME: a few definitions from qapi-types.o/qapi-visit.o are needed
>  # by libqemuutil.a.  These should be moved to a separate .json schema.
>  qga-obj-y =3D qga/
> +qga-serial-listener-obj-y =3D qga/
>  qga-vss-dll-obj-y =3D qga/
> =

>  ######################################################################
> diff --git a/qga/Makefile.objs b/qga/Makefile.objs
> index 1c5986c..f9d0170 100644
> --- a/qga/Makefile.objs
> +++ b/qga/Makefile.objs
> @@ -5,4 +5,6 @@ qga-obj-$(CONFIG_WIN32) +=3D vss-win32.o
>  qga-obj-y +=3D qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-v=
isit.o
>  qga-obj-y +=3D qapi-generated/qga-qmp-marshal.o
> =

> +qga-serial-listener-obj-$(CONFIG_WIN32) =3D service-win32.o serial-liste=
ner-service-win32.o
> +
>  qga-vss-dll-obj-$(CONFIG_QGA_VSS) +=3D vss-win32/
> diff --git a/qga/channel.h b/qga/channel.h
> index 1778416..df53ec9 100644
> --- a/qga/channel.h
> +++ b/qga/channel.h
> @@ -12,6 +12,15 @@
>  #ifndef QGA_CHANNEL_H
>  #define QGA_CHANNEL_H
> =

> +#ifndef _WIN32
> +#define QGA_VIRTIO_PATH_DEFAULT "/dev/virtio-ports/org.qemu.guest_agent.=
0"
> +#define QGA_STATE_RELATIVE_DIR  "run"
> +#define QGA_SERIAL_PATH_DEFAULT "/dev/ttyS0"
> +#else
> +#define QGA_VIRTIO_PATH_DEFAULT "\\\\.\\Global\\org.qemu.guest_agent.0"
> +#define QGA_STATE_RELATIVE_DIR  "qemu-ga"
> +#define QGA_SERIAL_PATH_DEFAULT "COM1"
> +#endif
> =

>  typedef struct GAChannel GAChannel;
> =

> diff --git a/qga/main.c b/qga/main.c
> index cc58d2b..44b0822 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -41,15 +41,6 @@
>  #endif
>  #endif
> =

> -#ifndef _WIN32
> -#define QGA_VIRTIO_PATH_DEFAULT "/dev/virtio-ports/org.qemu.guest_agent.=
0"
> -#define QGA_STATE_RELATIVE_DIR  "run"
> -#define QGA_SERIAL_PATH_DEFAULT "/dev/ttyS0"
> -#else
> -#define QGA_VIRTIO_PATH_DEFAULT "\\\\.\\Global\\org.qemu.guest_agent.0"
> -#define QGA_STATE_RELATIVE_DIR  "qemu-ga"
> -#define QGA_SERIAL_PATH_DEFAULT "COM1"
> -#endif
>  #ifdef CONFIG_FSFREEZE
>  #define QGA_FSFREEZE_HOOK_DEFAULT CONFIG_QEMU_CONFDIR "/fsfreeze-hook"
>  #endif
> @@ -1163,6 +1154,10 @@ static void config_parse(GAConfig *config, int arg=
c, char **argv)
>                  if (ga_install_vss_provider()) {
>                      exit(EXIT_FAILURE);
>                  }
> +                if (ga_install_serial_listener_service(config->channel_p=
ath,
> +                    config->log_filepath, config->state_dir)) {
> +                    exit(EXIT_FAILURE);
> +                }
>                  if (ga_install_service(config->channel_path,
>                                         config->log_filepath, config->sta=
te_dir)) {
>                      exit(EXIT_FAILURE);
> @@ -1170,6 +1165,7 @@ static void config_parse(GAConfig *config, int argc=
, char **argv)
>                  exit(EXIT_SUCCESS);
>              } else if (strcmp(config->service, "uninstall") =3D=3D 0) {
>                  ga_uninstall_vss_provider();
> +                ga_uninstall_serial_listener_service();
>                  exit(ga_uninstall_service());
>              } else if (strcmp(config->service, "vss-install") =3D=3D 0) {
>                  if (ga_install_vss_provider()) {
> @@ -1179,6 +1175,15 @@ static void config_parse(GAConfig *config, int arg=
c, char **argv)
>              } else if (strcmp(config->service, "vss-uninstall") =3D=3D 0=
) {
>                  ga_uninstall_vss_provider();
>                  exit(EXIT_SUCCESS);
> +            } else if (strcmp(config->service, "sl-install") =3D=3D 0) {
> +                if (ga_install_serial_listener_service(config->channel_p=
ath,
> +                    config->log_filepath, config->state_dir)) {
> +                    exit(EXIT_FAILURE);
> +                }
> +                exit(EXIT_SUCCESS);
> +            } else if (strcmp(config->service, "sl-uninstall") =3D=3D 0)=
 {
> +                ga_uninstall_serial_listener_service();
> +                exit(EXIT_SUCCESS);
>              } else {
>                  printf("Unknown service command.\n");
>                  exit(EXIT_FAILURE);
> diff --git a/qga/serial-listener-service-win32.c b/qga/serial-listener-se=
rvice-win32.c
> new file mode 100644
> index 0000000..fa22055
> --- /dev/null
> +++ b/qga/serial-listener-service-win32.c
> @@ -0,0 +1,181 @@
> +/*
> + * QEMU Guest Agent helpers for win32 service management
> + *
> + * Authors:
> + *  Sameeh Jubran        <sjubran@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include <windows.h>
> +#include <dbt.h>
> +#include "qga/channel.h"
> +#include "qga/serial-listener-service-win32.h"
> +
> +static const GUID GUID_VIOSERIAL_PORT =3D { 0x6fde7521, 0x1b65, 0x48ae,
> +    { 0xb6, 0x28, 0x80, 0xbe, 0x62, 0x1, 0x60, 0x26 } };
> +
> +GASerialListenerService listener_service;
> +GMainLoop *main_loop;
> +bool barrier;
> +bool qga_vios_exists;
> +
> +DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data);
> +DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
> +    LPVOID ctx);
> +VOID WINAPI service_main(DWORD argc, TCHAR * argv[]);
> +static void quit_handler(int sig);
> +static bool virtio_serial_exists(DWORD *err);
> +
> +static bool virtio_serial_exists(DWORD *err)
> +{
> +    bool ret =3D false;
> +    HANDLE handle =3D CreateFile(QGA_VIRTIO_PATH_DEFAULT, GENERIC_READ |
> +        GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_FLAG_NO_BUFFERING |
> +        FILE_FLAG_OVERLAPPED, NULL);
> +
> +    if (handle =3D=3D INVALID_HANDLE_VALUE) {
> +        *err =3D GetLastError();
> +        ret =3D false;
> +    } else {
> +        ret =3D true;
> +    }
> +    CloseHandle(handle);
> +    return ret;
> +}
> +
> +static void quit_handler(int sig)
> +{
> +    if (g_main_loop_is_running(main_loop)) {
> +        g_main_loop_quit(main_loop);
> +    }
> +}
> +
> +DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data)
> +{
> +    DWORD ret =3D NO_ERROR;
> +    DWORD err_code;
> +    PDEV_BROADCAST_HDR broadcast_header =3D (PDEV_BROADCAST_HDR) data;
> +    if (barrier &&
> +        broadcast_header->dbch_devicetype =3D=3D DBT_DEVTYP_DEVICEINTERF=
ACE) {
> +        switch (type) {
> +            /* Device inserted */
> +        case DBT_DEVICEARRIVAL:
> +            /* Start QEMU-ga's service */
> +            if (!qga_vios_exists && virtio_serial_exists(&err_code)) {
> +                start_service(QGA_SERVICE_NAME);
> +                qga_vios_exists =3D true;
> +            }
> +            break;
> +            /* Device removed */
> +        case DBT_DEVICEQUERYREMOVE:
> +        case DBT_DEVICEREMOVEPENDING:
> +        case DBT_DEVICEREMOVECOMPLETE:
> +            /* Stop QEMU-ga's service */
> +            /* In a stop operation, we need to make sure the virtio-seri=
al that
> +            * qemu-ga uses is the one that is being ejected. We'll get t=
he error
> +            * ERROR_FILE_NOT_FOUND when attempting to call CreateFile wi=
th the
> +            * virtio-serial path.
> +            */
> +            if (qga_vios_exists && !virtio_serial_exists(&err_code) &&
> +                err_code =3D=3D ERROR_FILE_NOT_FOUND) {
> +                stop_service(QGA_SERVICE_NAME);
> +                qga_vios_exists =3D false;
> +            }
> +
> +            break;
> +        default:
> +            ret =3D ERROR_CALL_NOT_IMPLEMENTED;
> +        }
> +    }
> +        return ret;
> +}
> +
> +DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
> +    LPVOID ctx)
> +{
> +    DWORD ret =3D NO_ERROR;
> +
> +    switch (ctrl) {
> +    case SERVICE_CONTROL_STOP:
> +    case SERVICE_CONTROL_SHUTDOWN:
> +        quit_handler(SIGTERM);
> +        listener_service.qga_service.status.dwCurrentState =3D
> +            SERVICE_STOP_PENDING;
> +        SetServiceStatus(listener_service.qga_service.status_handle,
> +            &listener_service.qga_service.status);
> +    case SERVICE_CONTROL_DEVICEEVENT:
> +            handle_serial_device_events(type, data);
> +        break;
> +
> +    default:
> +        ret =3D ERROR_CALL_NOT_IMPLEMENTED;
> +    }
> +    return ret;
> +}
> +
> +VOID WINAPI service_main(DWORD argc, TCHAR * argv[])
> +{
> +    DWORD err_code =3D NO_ERROR;
> +    qga_vios_exists =3D barrier =3D false;
> +    listener_service.qga_service.status_handle =3D
> +        RegisterServiceCtrlHandlerEx(QGA_SERIAL_LISTENER_SERVICE_NAME,
> +        service_ctrl_handler, NULL);
> +
> +    if (listener_service.qga_service.status_handle =3D=3D 0) {
> +        g_critical("Failed to register extended requests function!\n");
> +        return;
> +    }
> +
> +    listener_service.qga_service.status.dwServiceType =3D SERVICE_WIN32;
> +    listener_service.qga_service.status.dwCurrentState =3D SERVICE_RUNNI=
NG;
> +    listener_service.qga_service.status.dwControlsAccepted =3D SERVICE_A=
CCEPT_STOP
> +        | SERVICE_ACCEPT_SHUTDOWN;
> +    listener_service.qga_service.status.dwWin32ExitCode =3D NO_ERROR;
> +    listener_service.qga_service.status.dwServiceSpecificExitCode =3D NO=
_ERROR;
> +    listener_service.qga_service.status.dwCheckPoint =3D 0;
> +    listener_service.qga_service.status.dwWaitHint =3D 0;
> +    SetServiceStatus(listener_service.qga_service.status_handle,
> +        &listener_service.qga_service.status);
> +
> +    DEV_BROADCAST_DEVICEINTERFACE notification_filter;
> +    ZeroMemory(&notification_filter, sizeof(notification_filter));
> +        notification_filter.dbcc_devicetype =3D DBT_DEVTYP_DEVICEINTERFA=
CE;
> +        notification_filter.dbcc_size =3D sizeof(DEV_BROADCAST_DEVICEINT=
ERFACE);
> +        notification_filter.dbcc_classguid =3D GUID_VIOSERIAL_PORT;
> +
> +    listener_service.device_notification_handle =3D
> +        RegisterDeviceNotification(listener_service.qga_service.status_h=
andle,
> +        &notification_filter, DEVICE_NOTIFY_SERVICE_HANDLE);
> +    if (!listener_service.device_notification_handle) {
> +        g_critical("Failed to register device notification handle!\n");
> +        return;
> +    }
> +
> +    qga_vios_exists =3D virtio_serial_exists(&err_code);
> +    /* In case qemu-ga is already running then Create file will return A=
ccess
> +    * denied when trying to open the virtio serial
> +    */
> +    if (!qga_vios_exists && err_code =3D=3D ERROR_ACCESS_DENIED) {
> +        qga_vios_exists =3D true;
> +    }
> +    barrier =3D true;
> +
> +    main_loop =3D g_main_loop_new(NULL, false);
> +    g_main_loop_run(main_loop);
> +    UnregisterDeviceNotification(listener_service.device_notification_ha=
ndle);
> +    listener_service.qga_service.status.dwCurrentState =3D SERVICE_STOPP=
ED;
> +    SetServiceStatus(listener_service.qga_service.status_handle,
> +        &listener_service.qga_service.status);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    SERVICE_TABLE_ENTRY service_table[] =3D {
> +        { (char *)QGA_SERIAL_LISTENER_SERVICE_NAME, service_main },
> +        { NULL, NULL } };
> +    StartServiceCtrlDispatcher(service_table);
> +
> +    return EXIT_SUCCESS;
> +}
> diff --git a/qga/serial-listener-service-win32.h b/qga/serial-listener-se=
rvice-win32.h
> new file mode 100644
> index 0000000..57b47c0
> --- /dev/null
> +++ b/qga/serial-listener-service-win32.h
> @@ -0,0 +1,29 @@
> +/*
> + * QEMU Guest Agent helpers for win32 service management
> + *
> + * Authors:
> + *  Sameeh Jubran        <sjubran@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QGA__SERIAL_LISTENER_SERVICE_WIN32_H
> +#define QGA__SERIAL_LISTENER_SERVICE_WIN32_H
> +
> +#include <service-win32.h>
> +
> +#define QGA_SERIAL_LISTENER_SERVICE_DISPLAY_NAME "QEMU Guest Agent Seria=
l \
> +Listener"
> +#define QGA_SERIAL_LISTENER_SERVICE_NAME         "QEMU Guest Agent Seria=
l \
> +Listener"
> +#define QGA_SERIAL_LISTENER_SERVICE_DESCRIPTION  "Enables running qemu-g=
a \
> +service on serial device events"
> +#define QGA_SERIAL_LISTENER_BINARY_NAME          "qga-serial-listener.ex=
e"
> +
> +typedef struct GASerialListenerService {
> +    GAService qga_service;
> +    HDEVNOTIFY device_notification_handle;
> +} GASerialListenerService;
> +
> +#endif
> diff --git a/qga/service-win32.c b/qga/service-win32.c
> index dc41d63..861f9fc 100644
> --- a/qga/service-win32.c
> +++ b/qga/service-win32.c
> @@ -12,7 +12,9 @@
>   */
>  #include "qemu/osdep.h"
>  #include <windows.h>
> +#include "shlwapi.h"
>  #include "qga/service-win32.h"
> +#include "qga/serial-listener-service-win32.h"
> =

>  static int printf_win_error(const char *text)
>  {
> @@ -108,6 +110,7 @@ static int get_service(const char *service_name, SC_H=
ANDLE* service)
>      *service =3D OpenService(manager, service_name, SERVICE_ALL_ACCESS);
>      if (service =3D=3D NULL) {
>          printf_win_error("Failed to open service");
> +        CloseServiceHandle(manager);
>          return EXIT_FAILURE;
>      }
> =

> @@ -115,27 +118,23 @@ static int get_service(const char *service_name, SC=
_HANDLE* service)
>      return EXIT_SUCCESS;
>  }
> =

> -int ga_install_service(const char *path, const char *logfile,
> -                       const char *state_dir)
> +static int install_service(const char *path, const char *logfile,
> +    const char *state_dir, TCHAR *binary_path, LPCTSTR service_name,
> +    LPCTSTR service_display_name, SERVICE_DESCRIPTION service_desc,
> +    bool start_service)
>  {
>      int ret =3D EXIT_FAILURE;
>      SC_HANDLE manager;
>      SC_HANDLE service;
> -    TCHAR module_fname[MAX_PATH];
>      GString *esc;
>      GString *cmdline;
> -    SERVICE_DESCRIPTION desc =3D { (char *)QGA_SERVICE_DESCRIPTION };
> =

> -    if (GetModuleFileName(NULL, module_fname, MAX_PATH) =3D=3D 0) {
> -        printf_win_error("No full path to service's executable");
> -        return EXIT_FAILURE;
> -    }
> =

>      esc     =3D g_string_new("");
>      cmdline =3D g_string_new("");
> =

>      g_string_append_printf(cmdline, "%s -d",
> -                           win_escape_arg(module_fname, esc));
> +                           win_escape_arg(binary_path, esc));
> =

>      if (path) {
>          g_string_append_printf(cmdline, " -p %s", win_escape_arg(path, e=
sc));
> @@ -157,7 +156,7 @@ int ga_install_service(const char *path, const char *=
logfile,
>          goto out_strings;
>      }
> =

> -    service =3D CreateService(manager, QGA_SERVICE_NAME, QGA_SERVICE_DIS=
PLAY_NAME,
> +    service =3D CreateService(manager, service_name, service_display_nam=
e,
>          SERVICE_ALL_ACCESS, SERVICE_WIN32_OWN_PROCESS, SERVICE_AUTO_STAR=
T,
>          SERVICE_ERROR_NORMAL, cmdline->str, NULL, NULL, NULL, NULL, NULL=
);
>      if (service =3D=3D NULL) {
> @@ -165,8 +164,12 @@ int ga_install_service(const char *path, const char =
*logfile,
>          goto out_manager;
>      }
> =

> -    ChangeServiceConfig2(service, SERVICE_CONFIG_DESCRIPTION, &desc);
> +    ChangeServiceConfig2(service, SERVICE_CONFIG_DESCRIPTION, &service_d=
esc);
>      fprintf(stderr, "Service was installed successfully.\n");
> +
> +    if (start_service && StartService(service, 0, NULL)) {
> +        fprintf(stderr, "Service was started successfully.\n");
> +    }
>      ret =3D EXIT_SUCCESS;
>      CloseServiceHandle(service);
> =

> @@ -179,7 +182,21 @@ out_strings:
>      return ret;
>  }
> =

> -int ga_uninstall_service(void)
> +int ga_install_service(const char *path, const char *logfile,
> +                       const char *state_dir)
> +{
> +    TCHAR module_fname[MAX_PATH];
> +
> +    if (GetModuleFileName(NULL, module_fname, MAX_PATH) =3D=3D 0) {
> +        printf_win_error("No full path to service's executable");
> +        return EXIT_FAILURE;
> +    }
> +    SERVICE_DESCRIPTION service_desc =3D { (char *)QGA_SERVICE_DESCRIPTI=
ON };
> +    return install_service(path, logfile, state_dir, module_fname,
> +        QGA_SERVICE_NAME, QGA_SERVICE_DISPLAY_NAME, service_desc, true);
> +}
> +
> +static int uninstall_service(LPCTSTR service_name)
>  {
>      SC_HANDLE manager;
>      SC_HANDLE service;
> @@ -190,7 +207,7 @@ int ga_uninstall_service(void)
>          return EXIT_FAILURE;
>      }
> =

> -    service =3D OpenService(manager, QGA_SERVICE_NAME, DELETE);
> +    service =3D OpenService(manager, service_name, DELETE);
>      if (service =3D=3D NULL) {
>          printf_win_error("No handle to service");
>          CloseServiceHandle(manager);
> @@ -209,6 +226,42 @@ int ga_uninstall_service(void)
>      return EXIT_SUCCESS;
>  }
> =

> +int ga_uninstall_service(void)
> +{
> +    return uninstall_service(QGA_SERVICE_NAME);
> +}
> +
> +int ga_install_serial_listener_service(const char *path, const char *log=
file,
> +    const char *state_dir)
> +{
> +    TCHAR module_fname[MAX_PATH];
> +    TCHAR binary_path[MAX_PATH];
> +
> +    if (GetModuleFileName(NULL, module_fname, MAX_PATH) =3D=3D 0) {
> +        printf_win_error("No full path to service's executable");
> +        return EXIT_FAILURE;
> +    }
> +    fprintf(stderr, "ga_install_serial_listener_service: module name: %s=
\n",
> +        module_fname);
> +    PathRemoveFileSpec(module_fname);
> +    if (SearchPath(module_fname, QGA_SERIAL_LISTENER_BINARY_NAME, NULL,
> +        MAX_PATH, binary_path, NULL) =3D=3D 0) {
> +        printf_win_error("No full path to service's executable");
> +        return EXIT_FAILURE;
> +    }
> +
> +    SERVICE_DESCRIPTION service_desc =3D {
> +        (char *)QGA_SERIAL_LISTENER_SERVICE_DESCRIPTION };
> +    return install_service(path, logfile, state_dir, binary_path,
> +        QGA_SERIAL_LISTENER_SERVICE_NAME,
> +        QGA_SERIAL_LISTENER_SERVICE_DISPLAY_NAME, service_desc, true);
> +}
> +
> +int ga_uninstall_serial_listener_service(void)
> +{
> +    return uninstall_service(QGA_SERIAL_LISTENER_SERVICE_NAME);
> +}
> +
>  int start_service(const char *service_name)
>  {
>      int ret =3D EXIT_FAILURE;
> diff --git a/qga/service-win32.h b/qga/service-win32.h
> index 65248ea..2728303 100644
> --- a/qga/service-win32.h
> +++ b/qga/service-win32.h
> @@ -28,6 +28,9 @@ typedef struct GAService {
>  int ga_install_service(const char *path, const char *logfile,
>                         const char *state_dir);
>  int ga_uninstall_service(void);
> +int ga_install_serial_listener_service(const char *path, const char *log=
file,
> +    const char *state_dir);
> +int ga_uninstall_serial_listener_service(void);
>  int start_service(const char *service_name);
>  int stop_service(const char *service_name);
> =

> -- =

> 2.9.4
>=20
