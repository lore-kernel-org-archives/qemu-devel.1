Received: from eggs.gnu.org ([2001:4830:134:3::10]:60577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g95PS-0007BT-39
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g95PQ-00026l-7N
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:31:34 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:36141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g95PQ-00026C-0U
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:31:32 -0400
Received: by mail-it1-x144.google.com with SMTP id c85-v6so8236804itd.1
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 02:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180927073624.17163-1-bishara@daynix.com>
	<20180927073624.17163-8-bishara@daynix.com>
	<CAJ+F1C+cUb-h0jSYem899WbQQiNCm97=VpmOaXao5Q+b6pUEHQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+cUb-h0jSYem899WbQQiNCm97=VpmOaXao5Q+b6pUEHQ@mail.gmail.com>
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun, 7 Oct 2018 12:31:22 +0300
Message-ID: <CADyT_0VxmVGJddyBHh+=xng4HxvQB2GTHzN-OFKCZgy=KjQYhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] qga-win: changing --retry-path option
 behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yan Vugenfirer <yan@daynix.com>

Your advice was taken and implemented, sending changes in the next version.

On Thu, Sep 27, 2018 at 2:48 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Thu, Sep 27, 2018 at 11:41 AM Bishara AbuHattoum <bishara@daynix.com>
> wrote:
> >
> > Currently whenever the qemu-ga's service doesn't find the virtio-serial
> > the run_agent() loops in a QGA_RETRY_INTERVAL (default 5 seconds)
> > intervals and try to restart the qemu-ga which causes a synchronous loo=
p.
> > Changed to wait and listen for the serial events by registering for
> > notifications a proper serial event handler that deals with events:
> >   DBT_DEVICEARRIVAL        indicates that the device has been inserted
> and
> >                            is available
> >   DBT_DEVICEREMOVECOMPLETE indicates that the devive has been removed
> > Which allow us to determine when the channel path is available for the
> > qemu-ga to restart.
> >
> > Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
> > Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
>
> looks good overall,
>
> > ---
> >  qga/main.c          | 101 +++++++++++++++++++++++++++++++++++++++++++-
> >  qga/service-win32.h |   4 ++
> >  2 files changed, 104 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/main.c b/qga/main.c
> > index 6a152eb3a7..215dcb36f1 100644
> > --- a/qga/main.c
> > +++ b/qga/main.c
> > @@ -34,6 +34,7 @@
> >  #include "qemu/systemd.h"
> >  #include "qemu-version.h"
> >  #ifdef _WIN32
> > +#include <dbt.h>
> >  #include "qga/service-win32.h"
> >  #include "qga/vss-win32.h"
> >  #endif
> > @@ -101,6 +102,8 @@ struct GAState {
> >      bool logging_enabled;
> >  #ifdef _WIN32
> >      GAService service;
> > +    HANDLE channel_available_event;
> > +    HANDLE stop_event;
> >  #endif
> >      bool delimit_response;
> >      bool frozen;
> > @@ -137,6 +140,7 @@ static const char *ga_freeze_whitelist[] =3D {
> >  #ifdef _WIN32
> >  DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
> >                                    LPVOID ctx);
> > +DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data);
> >  VOID WINAPI service_main(DWORD argc, TCHAR *argv[]);
> >  #endif
> >  static int run_agent(GAState *s);
> > @@ -729,6 +733,36 @@ static gboolean channel_init(GAState *s, const
> gchar *method, const gchar *path,
> >  }
> >
> >  #ifdef _WIN32
> > +DWORD WINAPI handle_serial_device_events(DWORD type, LPVOID data)
> > +{
> > +    DWORD ret =3D NO_ERROR;
> > +    PDEV_BROADCAST_HDR broadcast_header =3D (PDEV_BROADCAST_HDR)data;
> > +
> > +    if (broadcast_header->dbch_devicetype =3D=3D
> DBT_DEVTYP_DEVICEINTERFACE) {
> > +        switch (type) {
> > +            /* Device inserted */
> > +        case DBT_DEVICEARRIVAL:
> > +            /* Start QEMU-ga's service */
> > +            if (!SetEvent(ga_state->channel_available_event)) {
> > +                ret =3D GetLastError();
> > +            }
> > +            break;
> > +            /* Device removed */
> > +        case DBT_DEVICEQUERYREMOVE:
> > +        case DBT_DEVICEREMOVEPENDING:
> > +        case DBT_DEVICEREMOVECOMPLETE:
> > +            /* Stop QEMU-ga's service */
> > +            if (!ResetEvent(ga_state->channel_available_event)) {
> > +                ret =3D GetLastError();
> > +            }
> > +            break;
> > +        default:
> > +            ret =3D ERROR_CALL_NOT_IMPLEMENTED;
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> >  DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD type, LPVOID data,
> >                                    LPVOID ctx)
> >  {
> > @@ -740,9 +774,13 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWOR=
D
> type, LPVOID data,
> >          case SERVICE_CONTROL_STOP:
> >          case SERVICE_CONTROL_SHUTDOWN:
> >              quit_handler(SIGTERM);
> > +            SetEvent(ga_state->stop_event);
> >              service->status.dwCurrentState =3D SERVICE_STOP_PENDING;
> >              SetServiceStatus(service->status_handle, &service->status)=
;
> >              break;
> > +        case SERVICE_CONTROL_DEVICEEVENT:
> > +            handle_serial_device_events(type, data);
> > +            break;
> >
> >          default:
> >              ret =3D ERROR_CALL_NOT_IMPLEMENTED;
> > @@ -769,10 +807,25 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[=
])
> >      service->status.dwServiceSpecificExitCode =3D NO_ERROR;
> >      service->status.dwCheckPoint =3D 0;
> >      service->status.dwWaitHint =3D 0;
> > +    DEV_BROADCAST_DEVICEINTERFACE notification_filter;
> > +    ZeroMemory(&notification_filter, sizeof(notification_filter));
> > +    notification_filter.dbcc_devicetype =3D DBT_DEVTYP_DEVICEINTERFACE=
;
> > +    notification_filter.dbcc_size =3D
> sizeof(DEV_BROADCAST_DEVICEINTERFACE);
> > +    notification_filter.dbcc_classguid =3D GUID_VIOSERIAL_PORT;
> > +
> > +    service->device_notification_handle =3D
> > +        RegisterDeviceNotification(service->status_handle,
> > +            &notification_filter, DEVICE_NOTIFY_SERVICE_HANDLE);
> > +    if (!service->device_notification_handle) {
> > +        g_critical("Failed to register device notification handle!\n")=
;
> > +        return;
> > +    }
> >      SetServiceStatus(service->status_handle, &service->status);
> > +    ResetEvent(ga_state->stop_event);
> >
> >      run_agent(ga_state);
> >
> > +    UnregisterDeviceNotification(service->device_notification_handle);
> >      service->status.dwCurrentState =3D SERVICE_STOPPED;
> >      SetServiceStatus(service->status_handle, &service->status);
> >  }
> > @@ -1360,12 +1413,32 @@ static GAState *initialize_agent(GAConfig
> *config, int socket_activation)
> >
> >      s->config =3D config;
> >      s->socket_activation =3D socket_activation;
> > +
> > +#ifdef _WIN32
> > +    s->channel_available_event =3D CreateEvent(NULL, TRUE, FALSE,
> > +
>  TEXT("ChannelAvailableEvent"));
> > +    if (s->channel_available_event =3D=3D NULL) {
> > +        g_critical("CreateEvent failed");
> > +        return NULL;
> > +    }
> > +    s->stop_event =3D CreateEvent(NULL, TRUE, FALSE,
> > +                                TEXT("StopEvent"));
> > +    if (s->stop_event =3D=3D NULL) {
> > +        g_critical("CreateEvent failed");
> > +        return NULL;
> > +    }
> > +#endif
> > +
> >      ga_state =3D s;
> >      return s;
> >  }
> >
> >  static void cleanup_agent(GAState *s)
> >  {
> > +#ifdef _WIN32
> > +    CloseHandle(s->channel_available_event);
> > +    CloseHandle(s->stop_event);
> > +#endif
> >      if (s->command_state) {
> >          ga_command_state_cleanup_all(s->command_state);
> >          ga_command_state_free(s->command_state);
> > @@ -1397,6 +1470,32 @@ static int run_agent_once(GAState *s)
> >      return EXIT_SUCCESS;
> >  }
> >
> > +static void wait_for_channel_availability(GAState *s)
> > +{
> > +    g_warning("waiting for channel path...");
> > +#ifndef _WIN32
> > +    sleep(QGA_RETRY_INTERVAL);
> > +#else
> > +    DWORD dwWaitResult;
> > +
> > +    HANDLE lpHandles[2] =3D { s->channel_available_event, s->stop_even=
t };
> > +
> > +    dwWaitResult =3D WaitForMultipleObjects(2, lpHandles, false,
> INFINITE);
> > +
> > +    switch (dwWaitResult) {
> > +    case WAIT_OBJECT_0:
> > +        break;
> > +    case (WAIT_OBJECT_0 + 1):
> > +        g_warning("service stopped");
> > +        break;
>
> Given that both events do basically the same thing, you could use one
> called generically "wakeup".
>
> Alternatively, you could wait on the main_loop (manual iteration), and
> call g_main_context_wakeup() to avoid the extra events altogether (I
> think).
>
>
>
> > +    case WAIT_TIMEOUT:
> > +        break;
> > +    default:
> > +        g_critical("WaitForMultipleObjects failed");
> > +    }
> > +#endif
> > +}
> > +
> >  static int run_agent(GAState *s)
> >  {
> >      int ret =3D EXIT_SUCCESS;
> > @@ -1407,7 +1506,7 @@ static int run_agent(GAState *s)
> >          ret =3D run_agent_once(s);
> >          if (s->config->retry_path && !s->force_exit) {
> >              g_warning("agent stopped unexpectedly, restarting...");
> > -            sleep(QGA_RETRY_INTERVAL);
> > +            wait_for_channel_availability(s);
> >          }
> >      } while (s->config->retry_path && !s->force_exit);
> >
> > diff --git a/qga/service-win32.h b/qga/service-win32.h
> > index 89e99dfede..7b16d69b57 100644
> > --- a/qga/service-win32.h
> > +++ b/qga/service-win32.h
> > @@ -20,9 +20,13 @@
> >  #define QGA_SERVICE_NAME         "qemu-ga"
> >  #define QGA_SERVICE_DESCRIPTION  "Enables integration with QEMU machin=
e
> emulator and virtualizer."
> >
> > +static const GUID GUID_VIOSERIAL_PORT =3D { 0x6fde7521, 0x1b65, 0x48ae=
,
> > +{ 0xb6, 0x28, 0x80, 0xbe, 0x62, 0x1, 0x60, 0x26 } };
> > +
> >  typedef struct GAService {
> >      SERVICE_STATUS status;
> >      SERVICE_STATUS_HANDLE status_handle;
> > +    HDEVNOTIFY device_notification_handle;
> >  } GAService;
> >
> >  int ga_install_service(const char *path, const char *logfile,
> > --
> > 2.17.0
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
