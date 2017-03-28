Received: from eggs.gnu.org ([2001:4830:134:3::10]:52201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1csnW3-00011I-L4
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1csnW1-0006Xf-GC
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:34:15 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1csnW1-0006XD-0J
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 05:34:13 -0400
Received: by mail-lf0-x242.google.com with SMTP id v2so9874809lfi.2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 02:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20170328072130.17142-1-vfeenstr@redhat.com>
In-Reply-To: <20170328072130.17142-1-vfeenstr@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Mar 2017 09:34:00 +0000
Message-ID: <CAJ+F1CK0n7m+mPBeUOOD0TXNroogjK3iMWthyQhdDVwd=3G8fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] qga: Add 'guest-get-users' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Hi

On Tue, Mar 28, 2017 at 9:22 AM Vinzenz 'evilissimo' Feenstra <
vfeenstr@redhat.com> wrote:

> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>
> A command that will list all currenctly logged in users having running
> processes.
>
> Examples:
>
> virsh # qemu-agent-command F25 '{ "execute": "guest-get-users" }'
> {"return":[{"user":"root"}]}
>
> virsh # qemu-agent-command Win2k12r2 '{ "execute": "guest-get-users" }'
> {"return":[{"domain":"LADIDA","user":"Administrator"}]}
>
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---
>

Is there RFE bugs for these qga patches? If they are public, it would be
worthwhile to add a link to your various qga patches.


>  qga/commands-posix.c | 35 +++++++++++++++++++++++
>  qga/commands-win32.c | 80
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  qga/qapi-schema.json | 21 ++++++++++++++
>  3 files changed, 136 insertions(+)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 73d93eb..8cb2094 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -15,6 +15,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/wait.h>
>  #include <dirent.h>
> +#include <utmpx.h>
>  #include "qga/guest-agent-core.h"
>  #include "qga-qmp-commands.h"
>  #include "qapi/qmp/qerror.h"
> @@ -2515,3 +2516,37 @@ void ga_command_state_init(GAState *s,
> GACommandState *cs)
>      ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
>  #endif
>  }
> +
> +GuestUserList *qmp_guest_get_users(Error **err)
> +{
> +    GHashTable *cache =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> +                                              NULL, NULL);
>

if there is no need for new_full() just use new() :)


> +    GuestUserList *head =3D NULL, *cur_item =3D NULL;
> +    setutxent();
> +    for (;;) {
> +        struct utmpx *user_info =3D getutxent();
> +        if (user_info =3D=3D NULL) {
> +            break;
> +        } else if (user_info->ut_type !=3D USER_PROCESS) {
> +            continue;
> +        } else if (g_hash_table_contains(cache, user_info->ut_user)) {


g_hash_table_contains requires glib 2.32, you should add a fallback code to
glib-compat.

+            continue;
> +        }
> +
> +        g_hash_table_insert(cache, user_info->ut_user, NULL);
> +
>

That doesn't look safe to me, user_info->ut_user content may change after
iterations. I think you should strdup the value instead.

Since you use the hashtable as a set, you could use g_hash_table_add.


> +        GuestUserList *item =3D g_new0(GuestUserList, 1);
> +        item->value =3D g_new0(GuestUser, 1);
> +        item->value->user =3D g_strdup(user_info->ut_user);
> +
>

Or simply use the value of item->value->user, so you don't need to do extra
dup/free.

+        if (!cur_item) {
> +            head =3D cur_item =3D item;
> +        } else {
> +            cur_item->next =3D item;
> +            cur_item =3D item;
> +        }
> +    }
> +    endutxent();
> +    g_hash_table_unref(cache);
> +    return head;
> +}
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 19d72b2..46c038b 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1536,3 +1536,83 @@ void ga_command_state_init(GAState *s,
> GACommandState *cs)
>          ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
>      }
>  }
> +
> +GuestUserList *qmp_guest_get_users(Error **err)
> +{
> +    GHashTable *cache =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> +                                              NULL, NULL);
>

same here


> +    GuestUserList *head =3D NULL, *cur_item =3D NULL;
> +
> +    LPWKSTA_USER_INFO_1 buffer =3D NULL, iter_buffer =3D 0;
> +    DWORD level =3D 1; /* Level 1 has more information */
> +    DWORD prefered_max_length =3D MAX_PREFERRED_LENGTH;
> +    DWORD entries_read =3D 0;
> +    DWORD total_entries =3D 0;
> +    DWORD resume_handle =3D 0;
> +    LPWSTR server_name =3D NULL;
> +    NET_API_STATUS result =3D ERROR_MORE_DATA;
> +
> +    while (result =3D=3D ERROR_MORE_DATA) {
> +        result =3D NetWkstaUserEnum(
> +            server_name,
> +            level,
> +            (LPBYTE *)&buffer,
> +            prefered_max_length,
> +            &entries_read,
> +            &total_entries,
> +            &resume_handle);
> +
> +        if (result !=3D ERROR_MORE_DATA && result !=3D ERROR_SUCCESS) {
> +            error_setg_win32(err, result, "Failed to enumerate active
> users");
> +            goto error;
> +        }
> +
> +        iter_buffer =3D buffer;
> +        DWORD i =3D 0;
> +        for (i =3D 0; i < entries_read; ++i, ++iter_buffer) {
> +            gchar *name =3D g_utf16_to_utf8(
> +                iter_buffer->wkui1_username,
> +                -1, NULL, NULL, NULL
> +            );
> +
> +            if (name =3D=3D NULL) {
> +                continue;
> +            }
> +
> +            if (g_hash_table_contains(cache, name)) {
> +                g_free(name);
> +                continue;
> +            }
> +
> +            gchar *domain =3D g_utf16_to_utf8(
> +                iter_buffer->wkui1_logon_domain,
> +                -1, NULL, NULL, NULL
> +            );
> +
> +            g_hash_table_insert(cache, name, NULL);
> +            GuestUserList *item =3D g_new0(GuestUserList, 1);
> +            item->value =3D g_new0(GuestUser, 1);
> +            item->value->user =3D name;
> +            item->value->domain =3D domain;
> +            item->value->has_domain =3D true;
> +
> +            if (!cur_item) {
> +                head =3D cur_item =3D item;
> +            } else {
> +                cur_item->next =3D item;
> +                cur_item =3D item;
> +            }
> +        }
> +    }
> +    NetApiBufferFree(buffer);
> +    g_hash_table_unref(cache);
> +    return head;
> +
> +error:
> +    if (buffer !=3D NULL) {
> +        NetApiBufferFree(buffer);
> +    }
> +    g_hash_table_unref(cache);
> +    qapi_free_GuestUserList(head);
> +    return NULL;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..190e8b4 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,24 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +
> +##
> +# @GuestUser:
> +# @user:      Username
> +# @domain:    Logon domain (windows only)
>

Or use a flat union? (like suggested for get-osinfo)


> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestUser',
> +  'data': { 'user': 'str', '*domain': 'str' } }
>
+
> +##
> +# @guest-get-users:
> +# Retrieves a list of currently active user accounts on the VM.
> +#
> +# Returns: A unique list of users.
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-users',
> +  'returns': ['GuestUser'] }
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
