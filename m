Received: from eggs.gnu.org ([2001:4830:134:3::10]:42674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cxrfx-0001sC-Sb
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cxrfu-0006t8-NK
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:01:25 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cxrfu-0006s6-At
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:01:22 -0400
Received: by mail-wm0-f44.google.com with SMTP id o81so57696135wmb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 02:01:21 -0700 (PDT)
From: Vinzenz Feenstra <vfeenstr@redhat.com>
Message-Id: <A91706F9-A9DE-44F4-9D98-5EC1725C49CA@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Tue, 11 Apr 2017 11:01:17 +0200
In-Reply-To: <20170404055146.8901-2-vfeenstr@redhat.com>
References: <20170404055146.8901-1-vfeenstr@redhat.com>
	<20170404055146.8901-2-vfeenstr@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/1] qga: Add 'guest-get-users' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>

PING
> On Apr 4, 2017, at 7:51 AM, Vinzenz 'evilissimo' Feenstra =
<vfeenstr@redhat.com> wrote:
>=20
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>=20
> A command that will list all currently logged in users, and the time
> since when they are logged in.
>=20
> Examples:
>=20
> virsh # qemu-agent-command F25 '{ "execute": "guest-get-users" }'
> {"return":[{"login-time":1490622289.903835,"user":"root"}]}
>=20
> virsh # qemu-agent-command Win2k12r2 '{ "execute": "guest-get-users" =
}'
> {"return":[{"login-time":1490351044.670552,"domain":"LADIDA",
> "user":"Administrator"}]}
>=20
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---
> configure             |  2 +-
> include/glib-compat.h |  5 +++
> qga/commands-posix.c  | 54 +++++++++++++++++++++++++++++++
> qga/commands-win32.c  | 89 =
+++++++++++++++++++++++++++++++++++++++++++++++++++
> qga/qapi-schema.json  | 24 ++++++++++++++
> 5 files changed, 173 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index d1ce33b..779ebfd 100755
> --- a/configure
> +++ b/configure
> @@ -737,7 +737,7 @@ if test "$mingw32" =3D "yes" ; then
>   sysconfdir=3D"\${prefix}"
>   local_statedir=3D
>   confsuffix=3D""
> -  libs_qga=3D"-lws2_32 -lwinmm -lpowrprof -liphlpapi -lnetapi32 =
$libs_qga"
> +  libs_qga=3D"-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -liphlpapi =
-lnetapi32 $libs_qga"
> fi
>=20
> werror=3D""
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index 863c8cf..f8ee9dc 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -217,6 +217,11 @@ static inline void g_hash_table_add(GHashTable =
*hash_table, gpointer key)
> {
>     g_hash_table_replace(hash_table, key, key);
> }
> +
> +static gboolean g_hash_table_contains(GHashTable *hash_table, =
gpointer key)
> +{
> +    return g_hash_table_lookup_extended(hash_table, key, NULL, NULL);
> +}
> #endif
>=20
> #ifndef g_assert_true
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 73d93eb..3081ee7 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -15,6 +15,7 @@
> #include <sys/ioctl.h>
> #include <sys/wait.h>
> #include <dirent.h>
> +#include <utmpx.h>
> #include "qga/guest-agent-core.h"
> #include "qga-qmp-commands.h"
> #include "qapi/qmp/qerror.h"
> @@ -2515,3 +2516,56 @@ void ga_command_state_init(GAState *s, =
GACommandState *cs)
>     ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
> #endif
> }
> +
> +#ifndef QGA_MICRO_SECOND_TO_SECOND
> +#   define QGA_MICRO_SECOND_TO_SECOND 1000000
> +#endif
> +
> +static double ga_get_login_time(struct utmpx *user_info)
> +{
> +    double seconds =3D (double)user_info->ut_tv.tv_sec;
> +    double useconds =3D (double)user_info->ut_tv.tv_usec;
> +    useconds /=3D QGA_MICRO_SECOND_TO_SECOND;
> +    return seconds + useconds;
> +}
> +
> +GuestUserList *qmp_guest_get_users(Error **err)
> +{
> +    GHashTable *cache =3D g_hash_table_new(g_str_hash, g_str_equal);
> +    GuestUserList *head =3D NULL, *cur_item =3D NULL;
> +    setutxent();
> +    for (;;) {
> +        struct utmpx *user_info =3D getutxent();
> +        if (user_info =3D=3D NULL) {
> +            break;
> +        } else if (user_info->ut_type !=3D USER_PROCESS) {
> +            continue;
> +        } else if (g_hash_table_contains(cache, user_info->ut_user)) =
{
> +            gpointer value =3D g_hash_table_lookup(cache, =
user_info->ut_user);
> +            GuestUser *user =3D (GuestUser *)value;
> +            double login_time =3D ga_get_login_time(user_info);
> +            /* We're ensuring the earliest login time to be sent */
> +            if (login_time < user->login_time) {
> +                user->login_time =3D login_time;
> +            }
> +            continue;
> +        }
> +
> +        GuestUserList *item =3D g_new0(GuestUserList, 1);
> +        item->value =3D g_new0(GuestUser, 1);
> +        item->value->user =3D g_strdup(user_info->ut_user);
> +        item->value->login_time =3D ga_get_login_time(user_info);
> +
> +        g_hash_table_insert(cache, item->value->user, item->value);
> +
> +        if (!cur_item) {
> +            head =3D cur_item =3D item;
> +        } else {
> +            cur_item->next =3D item;
> +            cur_item =3D item;
> +        }
> +    }
> +    endutxent();
> +    g_hash_table_destroy(cache);
> +    return head;
> +}
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 19d72b2..8b84a90 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -11,6 +11,9 @@
>  * See the COPYING file in the top-level directory.
>  */
>=20
> +#ifndef _WIN32_WINNT
> +#   define _WIN32_WINNT 0x0600
> +#endif
> #include "qemu/osdep.h"
> #include <wtypes.h>
> #include <powrprof.h>
> @@ -25,6 +28,7 @@
> #include <initguid.h>
> #endif
> #include <lm.h>
> +#include <wtsapi32.h>
>=20
> #include "qga/guest-agent-core.h"
> #include "qga/vss-win32.h"
> @@ -1536,3 +1540,88 @@ void ga_command_state_init(GAState *s, =
GACommandState *cs)
>         ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
>     }
> }
> +
> +/* MINGW is missing two fields: IncomingFrames & OutgoingFrames */
> +typedef struct _GA_WTSINFOA {
> +    WTS_CONNECTSTATE_CLASS State;
> +    DWORD SessionId;
> +    DWORD IncomingBytes;
> +    DWORD OutgoingBytes;
> +    DWORD IncomingFrames;
> +    DWORD OutgoingFrames;
> +    DWORD IncomingCompressedBytes;
> +    DWORD OutgoingCompressedBy;
> +    CHAR WinStationName[WINSTATIONNAME_LENGTH];
> +    CHAR Domain[DOMAIN_LENGTH];
> +    CHAR UserName[USERNAME_LENGTH + 1];
> +    LARGE_INTEGER ConnectTime;
> +    LARGE_INTEGER DisconnectTime;
> +    LARGE_INTEGER LastInputTime;
> +    LARGE_INTEGER LogonTime;
> +    LARGE_INTEGER CurrentTime;
> +
> +} GA_WTSINFOA;
> +
> +GuestUserList *qmp_guest_get_users(Error **err)
> +{
> +#if (_WIN32_WINNT >=3D 0x0600)
> +#ifndef QGA_NANOSECONDS
> +#   define QGA_NANOSECONDS 10000000
> +#endif
> +#ifndef QGA_EPOCH_TIME_DIFF
> +#   define QGA_EPOCH_TIME_DIFF 116444736000000000LL
> +#endif
> +
> +    GHashTable *cache =3D g_hash_table_new(g_str_hash, g_str_equal);
> +    GuestUserList *head =3D NULL, *cur_item =3D NULL;
> +
> +    DWORD count =3D 0;
> +    WTS_SESSION_INFOA *entries =3D NULL;
> +    if (WTSEnumerateSessionsA(NULL, 0, 1, &entries, &count)) {
> +        for (DWORD i =3D 0; i < count; ++i) {
> +            DWORD buffer_size =3D 0;
> +            GA_WTSINFOA *session_info =3D NULL;
> +            if (WTSQuerySessionInformationA(
> +                NULL,
> +                entries[i].SessionId,
> +                WTSSessionInfo,
> +                (LPSTR *)&session_info,
> +                &buffer_size
> +            )) {
> +                if (strlen(session_info->UserName) =3D=3D 0 ||
> +                    g_hash_table_contains(cache, =
session_info->UserName)) {
> +                    WTSFreeMemory(session_info);
> +                    continue;
> +                }
> +
> +                GuestUserList *item =3D g_new0(GuestUserList, 1);
> +                item->value =3D g_new0(GuestUser, 1);
> +
> +                item->value->user =3D =
g_strdup(session_info->UserName);
> +                item->value->domain =3D =
g_strdup(session_info->Domain);
> +                item->value->has_domain =3D true;
> +
> +                INT64 login =3D session_info->LogonTime.QuadPart;
> +                login -=3D QGA_EPOCH_TIME_DIFF;
> +                item->value->login_time =3D ((double)login) / =
QGA_NANOSECONDS;
> +
> +                g_hash_table_add(cache, item->value->user);
> +
> +                if (!cur_item) {
> +                    head =3D cur_item =3D item;
> +                } else {
> +                    cur_item->next =3D item;
> +                    cur_item =3D item;
> +                }
> +            }
> +            WTSFreeMemory(session_info);
> +        }
> +        WTSFreeMemory(entries);
> +    }
> +    g_hash_table_destroy(cache);
> +    return head;
> +#else
> +    error_setg(err, QERR_UNSUPPORTED);
> +    return NULL;
> +#endif
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..27d10be 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,27 @@
>   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                '*input-data': 'str', '*capture-output': 'bool' },
>   'returns': 'GuestExec' }
> +
> +##
> +# @GuestUser:
> +# @user:       Username
> +# @domain:     Logon domain (windows only)
> +# @login-time: Time of login of this user on the computer. If =
multiple
> +#              instances of the user are logged in, the earliest =
login time is
> +#              reported. The value is in fractional seconds since =
epoch time.
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestUser',
> +  'data': { 'user': 'str', 'login-time': 'number', '*domain': 'str' } =
}
> +
> +##
> +# @guest-get-users:
> +# Retrieves a list of currently active users on the VM.
> +#
> +# Returns: A unique list of users.
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-users',
> +  'returns': ['GuestUser'] }
> --=20
> 2.9.3
>=20

--
Vinzenz Feenstra
Senior Software Developer
Red Hat Czech
