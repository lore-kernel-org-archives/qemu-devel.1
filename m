Received: from eggs.gnu.org ([2001:4830:134:3::10]:48126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dS2d5-0007AD-9j
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dS2d0-0000p8-1z
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:47:11 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dS2cz-0000or-Mq
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:47:05 -0400
Received: by mail-wm0-f50.google.com with SMTP id f67so57468809wmh.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 07:47:05 -0700 (PDT)
Date: Mon, 3 Jul 2017 16:47:01 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170703164701.1d175ed1@fiorina>
In-Reply-To: <CAJ+F1CK0BYgykhg5ZLr8ejz0EQCj8_2K_7Ri7vtdmEp4hiU3pg@mail.gmail.com>
References: <cover.1499082038.git.tgolembi@redhat.com>
	<28c65c91c4d63f1fe3bf69e7a70494af4b72b7e1.1499082038.git.tgolembi@redhat.com>
	<CAJ+F1CK0BYgykhg5ZLr8ejz0EQCj8_2K_7Ri7vtdmEp4hiU3pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 1/3] qemu-ga: add guest-get-osinfo
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org

Hi,

thanks for the review. Couple notes below.


On Mon, 03 Jul 2017 14:30:22 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> On Mon, Jul 3, 2017 at 1:40 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com>
> wrote:
>=20
> > Add a new 'guest-get-osinfo' command for reporting basic information of
> > the guest operating system. This includes machine architecture,
> > version and release of the kernel and several fields from os-release
> > file if it is present (as defined in [1]).
> >
> > [1] https://www.freedesktop.org/software/systemd/man/os-release.html
> >
> > Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> >  qga/commands-posix.c | 136 +++++++++++++++++++++++++++++++++++++
> >  qga/commands-win32.c | 185
> > +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  qga/qapi-schema.json |  65 ++++++++++++++++++
> >  3 files changed, 386 insertions(+)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index d8e412275e..7a933a5f12 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -13,6 +13,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include <sys/ioctl.h>
> > +#include <sys/utsname.h>
> >  #include <sys/wait.h>
> >  #include <dirent.h>
> >  #include <utmpx.h>
> > @@ -2577,3 +2578,138 @@ GuestUserList *qmp_guest_get_users(Error **err)
> >      g_hash_table_destroy(cache);
> >      return head;
> >  }
> > +
> > +/* Replace escaped special characters with theire real values. The
> > replacement
> > + * is done in place -- returned value is in the original string.
> > + */
> > +static void ga_osrelease_replace_special(gchar *value)
> > +{
> > +    gchar *p, *p2, quote;
> > +
> > +    /* Trim the string at first space or semicolon if it is not enclos=
ed
> > in
> > +     * single or double quotes. */
> > +    if ((value[0] !=3D '"') || (value[0] =3D=3D '\'')) {
> > +        p =3D strchr(value, ' ');
> > +        if (p !=3D NULL) {
> > +            *p =3D 0;
> > +        }
> > +        p =3D strchr(value, ';');
> > +        if (p !=3D NULL) {
> > +            *p =3D 0;
> > +        }
> > +        return;
> > +    }
> > +
> > +    quote =3D value[0];
> > +    p2 =3D value;
> > +    p =3D value + 1;
> > +    while (*p !=3D 0) {
> > +        if (*p =3D=3D '\\') {
> > +            p++;
> > +            switch (*p) {
> > +            case '$':
> > +            case '\'':
> > +            case '"':
> > +            case '\\':
> > +            case '`':
> > +                break;
> > +            default:
> > +                /* Keep literal backslash followed by whatever is ther=
e */
> > +                p--;
> > +                break;
> > +            }
> > +        } else if (*p =3D=3D quote) {
> > +            *p2 =3D 0;
> > +            break;
> > +        }
> > +        *(p2++) =3D *(p++);
> > +    }
> > +}
> > +
> > +static GKeyFile *ga_parse_osrelease(const char *fname)
> > +{
> > +    gboolean ret;
> > +    gchar *content =3D NULL;
> > +    gchar *content2 =3D NULL;
> > +    gsize len;
> > +    GError *err =3D NULL;
> > +    GKeyFile *keys =3D g_key_file_new();
> > +    const char *group =3D "[os-release]\n";
> > +
> > +    ret =3D g_file_get_contents(fname, &content, &len, &err);
> > +    if (ret !=3D TRUE) {
> > =20
>=20
> I would rather have
>=20
> if (!g_file_get_contents(..))
>=20
> same for the calls below,
>=20
>=20
> > +        slog("failed to read '%s', error: %s", fname, err->message);
> > +        goto fail;
> > +    }
> > +
> > +    ret =3D g_utf8_validate(content, len, NULL);
> > +    if (ret !=3D TRUE) {
> > +        slog("file is not utf-8 encoded: %s", fname);
> > +        goto fail;
> > +    }
> > +    content2 =3D g_strdup_printf("%s%s", group, content);
> > +    len +=3D strlen(group);
> > =20
>=20
> I wouldn't bother with len, and pass -1 to load_from_data
>=20
>=20
> > +
> > +    ret =3D g_key_file_load_from_data(keys, content2, len, G_KEY_FILE_=
NONE,
> > +        &err);
> > +    if (ret !=3D TRUE) {
> > +        slog("failed to parse file '%s', error: %s", fname, err->messa=
ge);
> > +        goto fail;
> > +    }
> > +
> > +    g_free(content);
> > +    g_free(content2);
> > +    return keys;
> > +
> > +fail:
> > +    g_error_free(err);
> > +    g_free(content);
> > +    g_free(content2);
> > +    g_key_file_free(keys);
> > +    return NULL;
> > +}
> > +
> > +GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> > +{
> > +    GuestOSInfo *info =3D g_new0(GuestOSInfo, 1);
> > +
> > +    struct utsname kinfo =3D {0};
> > +    if (uname(&kinfo) !=3D 0) {
> > +        error_setg_errno(errp, errno, "uname failed");
> > =20
>=20
> leaks info here
>=20
> Alternatively, you could make it non-fatal and keep going with a warning
> only?

The fields kernel_version, kernel_release and machine_hardware are
marked as mandatory in the schema. I assumed it's better to return an
error instead of empty strings in these fields.

Otherwise we could just mark those fields as optional too. But then we
can and up with empty response in the unlikely case where uname fails
and there is no os-release file.


> > +        return NULL;
> > +    }
> > +
> > +    info->kernel_version =3D g_strdup(kinfo.version);
> > +    info->kernel_release =3D g_strdup(kinfo.release);
> > +    info->machine_hardware =3D g_strdup(kinfo.machine);
> > +
> > +    GKeyFile *osrelease =3D ga_parse_osrelease("/etc/os-release");
> > +    if (osrelease =3D=3D NULL) {
> > +        osrelease =3D ga_parse_osrelease("/usr/lib/os-release");
> > +    }
> > +
> > +    if (osrelease !=3D NULL) {
> > +        char *value;
> > +
> > +#define GET_FIELD(field, osfield) do { \
> > +    value =3D g_key_file_get_value(osrelease, "os-release", osfield, N=
ULL);
> > \
> > +    if (value !=3D NULL) { \
> > +        ga_osrelease_replace_special(value); \
> > +        info->has_ ## field =3D true; \
> > +        info->field =3D value; \
> > +    } \
> > +} while (0)
> > +        GET_FIELD(id, "ID");
> > +        GET_FIELD(name, "NAME");
> > +        GET_FIELD(pretty_name, "PRETTY_NAME");
> > +        GET_FIELD(version, "VERSION");
> > +        GET_FIELD(version_id, "VERSION_ID");
> > +        GET_FIELD(variant, "VARIANT");
> > +        GET_FIELD(variant_id, "VARIANT_ID");
> > +#undef GET_FIELD
> > +
> > +        g_key_file_free(osrelease);
> > +    }
> > +
> > +    return info;
> > +}
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 439d229225..e471f5561b 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -1639,3 +1639,188 @@ GuestUserList *qmp_guest_get_users(Error **err)
> >      return NULL;
> >  #endif
> >  }
> > +
> > +typedef struct _ga_matrix_lookup_t {
> > +    int major;
> > +    int minor;
> > +    char const *version;
> > +    char const *version_id;
> > +} ga_matrix_lookup_t;
> > +
> > +static ga_matrix_lookup_t const WIN_VERSION_MATRIX[2][8] =3D {
> > +    {
> > +        /* Desktop editions */
> > +        { 5, 0, "Microsoft Windows 2000",   "2000"},
> > +        { 5, 1, "Microsoft Windows XP",     "xp"},
> > +        { 6, 0, "Microsoft Windows Vista",  "vista"},
> > +        { 6, 1, "Microsoft Windows 7"       "7"},
> > +        { 6, 2, "Microsoft Windows 8",      "8"},
> > +        { 6, 3, "Microsoft Windows 8.1",    "8.1"},
> > +        {10, 0, "Microsoft Windows 10",     "10"},
> > +        { 0, 0, 0}
> > +    },{
> > +        /* Server editions */
> > +        { 5, 2, "Microsoft Windows Server 2003",        "2003"},
> > +        { 6, 0, "Microsoft Windows Server 2008",        "2008"},
> > +        { 6, 1, "Microsoft Windows Server 2008 R2",     "2008r2"},
> > +        { 6, 2, "Microsoft Windows Server 2012",        "2012"},
> > +        { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
> > +        {10, 0, "Microsoft Windows Server 2016",        "2016"},
> > +        { 0, 0, 0},
> > +        { 0, 0, 0}
> > +    }
> > +};
> > +
> > +static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **err=
p)
> > +{
> > +    typedef NTSTATUS(WINAPI * rtl_get_version_t)(
> > +        RTL_OSVERSIONINFOEXW *os_version_info_ex);
> > +
> > +    info->dwOSVersionInfoSize =3D sizeof(RTL_OSVERSIONINFOEXW);
> > +
> > +    HMODULE module =3D GetModuleHandle("ntdll");
> > +    PVOID fun =3D GetProcAddress(module, "RtlGetVersion");
> > +    if (fun =3D=3D NULL) {
> > +        error_setg(errp, QERR_QGA_COMMAND_FAILED,
> > +            "Failed to get address of RtlGetVersion");
> > +        return;
> > +    }
> > +
> > +    rtl_get_version_t rtl_get_version =3D (rtl_get_version_t)fun;
> > +    rtl_get_version(info);
> > +    return;
> > +}
> > +
> > +static char *ga_get_win_name(OSVERSIONINFOEXW const *os_version, bool =
id)
> > +{
> > +    DWORD major =3D os_version->dwMajorVersion;
> > +    DWORD minor =3D os_version->dwMinorVersion;
> > +    int tbl_idx =3D (os_version->wProductType !=3D VER_NT_WORKSTATION);
> > +    ga_matrix_lookup_t const *table =3D WIN_VERSION_MATRIX[tbl_idx];
> > +    while (table->version !=3D NULL) {
> > +        if (major =3D=3D table->major && minor =3D=3D table->minor) {
> > +            if (id) {
> > +                return g_strdup(table->version_id);
> > +            } else {
> > +                return g_strdup(table->version);
> > +            }
> > +        }
> > +        ++table;
> > +    }
> > +    slog("failed to lookup Windows version: major=3D%lu, minor=3D%lu",
> > +        major, minor);
> > +    return g_strdup("N/A");
> > +}
> > +
> > +static char *ga_get_win_product_name(Error **errp)
> > +{
> > +    HKEY key =3D NULL;
> > +    DWORD size =3D 128;
> > +    char *result =3D g_malloc0(size);
> > +    LONG err =3D ERROR_SUCCESS;
> > +
> > +    err =3D RegOpenKeyA(HKEY_LOCAL_MACHINE,
> > +                      "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion=
",
> > +                      &key);
> > +    if (err !=3D ERROR_SUCCESS) {
> > +        error_setg_win32(errp, err, "failed to open registry key");
> > +        goto fail;
> > +    }
> > +
> > +    err =3D RegQueryValueExA(key, "ProductName", NULL, NULL,
> > +                            (LPBYTE)result, &size);
> > +    if (err =3D=3D ERROR_MORE_DATA) {
> > +        slog("ProductName longer than expected (%lu bytes), retrying",
> > +                size);
> > +        g_free(result);
> > +        result =3D NULL;
> > +        if (size > 0) {
> > +            result =3D g_malloc0(size);
> > +            err =3D RegQueryValueExA(key, "ProductName", NULL, NULL,
> > +                                    (LPBYTE)result, &size);
> > +        }
> > +    }
> > +    if (err !=3D ERROR_SUCCESS) {
> > +        error_setg_win32(errp, err, "failed to retrive ProductName");
> > +        goto fail;
> > +    }
> > +
> > +    return result;
> > +
> > +fail:
> > +    g_free(result);
> > +    return NULL;
> > +}
> > +
> > +static char *ga_get_current_arch(void)
> > +{
> > +    SYSTEM_INFO info;
> > +    GetNativeSystemInfo(&info);
> > +    char *result =3D NULL;
> > +    switch (info.wProcessorArchitecture) {
> > +    case PROCESSOR_ARCHITECTURE_AMD64:
> > +        result =3D g_strdup("x86_64");
> > +        break;
> > +    case PROCESSOR_ARCHITECTURE_ARM:
> > +        result =3D g_strdup("arm");
> > +        break;
> > +    case PROCESSOR_ARCHITECTURE_IA64:
> > +        result =3D g_strdup("ia64");
> > +        break;
> > +    case PROCESSOR_ARCHITECTURE_INTEL:
> > +        result =3D g_strdup("x86");
> > +        break;
> > +    case PROCESSOR_ARCHITECTURE_UNKNOWN:
> > +    default:
> > +        slog("unknown processor architecture 0x%0x",
> > +            info.wProcessorArchitecture);
> > +        result =3D g_strdup("unknown");
> > +        break;
> > +    }
> > +    return result;
> > +}
> > +
> > +GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> > +{
> > +    Error *local_err =3D NULL;
> > +    OSVERSIONINFOEXW os_version =3D {0};
> > +
> > +    ga_get_win_version(&os_version, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return NULL;
> > +    }
> > +
> > +    bool server =3D os_version.wProductType !=3D VER_NT_WORKSTATION;
> > +    char *product_name =3D ga_get_win_product_name(&local_err);
> > +    if (product_name =3D=3D NULL) {
> > +        error_propagate(errp, local_err);
> > +        return NULL;
> > +    }
> > +
> > +    GuestOSInfo *info =3D g_new0(GuestOSInfo, 1);
> > +
> > +    info->kernel_version =3D g_strdup_printf("%lu.%lu",
> > +        os_version.dwMajorVersion,
> > +        os_version.dwMinorVersion);
> > +    info->kernel_release =3D g_strdup_printf("%lu",
> > +        os_version.dwBuildNumber);
> > +    info->machine_hardware =3D ga_get_current_arch();
> > +
> > +    info->has_id =3D true;
> > +    info->id =3D g_strdup("mswindows");
> > +    info->has_name =3D true;
> > +    info->name =3D g_strdup("Microsoft Windows");
> > +    info->has_pretty_name =3D true;
> > +    info->pretty_name =3D product_name;
> > +    info->has_version =3D true;
> > +    info->version =3D ga_get_win_name(&os_version, false);
> > +    info->has_version_id =3D true;
> > +    info->version_id =3D ga_get_win_name(&os_version, true);
> > +    info->has_variant =3D true;
> > +    info->variant =3D g_strdup(server ? "server" : "client");
> > +    info->has_variant_id =3D true;
> > +    info->variant_id =3D g_strdup(server ? "server" : "client");
> > +
> > +    return info;
> > +}
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index 03743ab905..3d9478c10b 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1126,3 +1126,68 @@
> >  ##
> >  { 'command': 'guest-get-timezone',
> >    'returns': 'GuestTimezone' }
> > +
> > +##
> > +# @GuestOSInfo:
> > +#
> > +# @kernel-release:
> > +#     * _POSIX:_ release field returned by uname(2)
> > +#     * _Windows:_ version number of the OS
> > =20
>=20
> Does _foo_ really make the result more clear, I am not convinced, * foo:
> already stands out imho.
>=20

Yeah, I can remove that.

To me it just looked better in the generated docs (probably at the
expense of the readability of the schema itself).

    Tomas

> +# @kernel-version:
> > +#     * _POSIX:_ version field returned by uname(2)
> > +#     * _Windows:_ build number of the OS
> > +# @machine-hardware:
> > +#     * _POSIX:_ machine field returned by uname(2)
> > +#     * _Windows:_ architecture of the hardware
> > +# @id:
> > +#     * _POSIX:_ as defined by os-release(5)
> > +#     * _Windows:_ contains string "mswindows"
> > +# @name:
> > +#     * _POSIX:_ as defined by os-release(5)
> > +#     * _Windows:_ contains string "Microsoft Windows"
> > +# @pretty-name:
> > +#     * _POSIX:_ as defined by os-release(5)
> > +#     * _Windows:_ product name, e.g. "Microsoft Windows 10 Enterprise"
> > +# @version:
> > +#     * _POSIX:_ as defined by os-release(5)
> > +#     * _Windows:_ long version string, e.g. "Microsoft Windows Server
> > 2008"
> > +# @version-id:
> > +#     * _POSIX:_ as defined by os-release(5)
> > +#     * _Windows:_ short version identifier, e.g. "7" or "20012r2"
> > +# @variant:
> > +#     * _POSIX:_ as defined by os-release(5)
> > +#     * _Windows:_ contains string "server" or "client"
> > +# @variant-id:
> > +#     * _POSIX:_ as defined by os-release(5)
> > +#     * _Windows:_ contains string "server" or "client"
> > +#
> > +# Notes:
> > +#
> > +# On POSIX systems the fields @id, @name, @pretty-name, @version,
> > @version-id,
> > +# @variant and @variant-id follow the definition specified in
> > os-release(5).
> > +# Refer to the manual page for exact description of the fields. Their
> > values
> > +# are taken from the os-release file. If the file is not present in the
> > system,
> > +# or the values are not present in the file, the fields are not includ=
ed.
> > +#
> > +# On Windows the values are filled from information gathered from the
> > system.
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'struct': 'GuestOSInfo',
> > +  'data': {
> > +      'kernel-release': 'str', 'kernel-version': 'str',
> > +      'machine-hardware': 'str', '*id': 'str', '*name': 'str',
> > +      '*pretty-name': 'str', '*version': 'str', '*version-id': 'str',
> > +      '*variant': 'str', '*variant-id': 'str' } }
> > +
> > +##
> > +# @guest-get-osinfo:
> > +#
> > +# Retrieve guest operating system information
> > +#
> > +# Returns: @GuestOSInfo
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'command': 'guest-get-osinfo',
> > +  'returns': 'GuestOSInfo' }
> > --
> > 2.13.1
> > =20
>=20
> Looks good to me otherwise
> --=20
> Marc-Andr=C3=A9 Lureau


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
