Received: from eggs.gnu.org ([2001:4830:134:3::10]:45118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cxroT-0007hR-Sd
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cxroQ-0001zm-Iz
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:10:13 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cxroQ-0001zC-8w
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:10:10 -0400
Received: by mail-wr0-f182.google.com with SMTP id z109so24479416wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 02:10:10 -0700 (PDT)
From: Vinzenz Feenstra <vfeenstr@redhat.com>
Message-Id: <42362591-42D0-452B-A8C9-60DA0C5F6876@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Tue, 11 Apr 2017 11:10:06 +0200
In-Reply-To: <CAKPgXcE95EgoxoSD9CdY0Rt6WWtKDfZTjePpE=GMXB4EXp9UGQ@mail.gmail.com>
References: <20170323113913.26974-1-vfeenstr@redhat.com>
	<20170323113913.26974-2-vfeenstr@redhat.com>
	<CAKPgXcE95EgoxoSD9CdY0Rt6WWtKDfZTjePpE=GMXB4EXp9UGQ@mail.gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, Sameeh Jubran <sameeh@daynix.com>

PING?


> On Apr 4, 2017, at 11:42 AM, Sameeh Jubran <sameeh@daynix.com> wrote:
>=20
> I have tested the patch on Windows 2012 R2
>=20
> Reviewed-by: Sameeh Jubran <sameeh@daynix.com =
<mailto:sameeh@daynix.com>>
> Tested-by: Sameeh Jubran <sameeh@daynix.com =
<mailto:sameeh@daynix.com>>
>=20
> On Thu, Mar 23, 2017 at 2:39 PM, Vinzenz 'evilissimo' Feenstra =
<vfeenstr@redhat.com <mailto:vfeenstr@redhat.com>> wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com =
<mailto:vfeenstr@redhat.com>>
>=20
> Adds a new command `guest-get-timezone` reporting the currently
> configured timezone on the system. The information on what timezone is
> currently is configured is useful in case of Windows VMs where the
> offset of the hardware clock is required to have the same offset. This
> can be used for management systems like `oVirt` to detect the timezone
> difference and warn administrators of the misconfiguration.
>=20
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com =
<mailto:vfeenstr@redhat.com>>
> ---
>  qga/commands.c       | 29 +++++++++++++++++++++++++++++
>  qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..3b5789c 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,32 @@ int ga_parse_whence(GuestFileWhence *whence, =
Error **errp)
>      error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>      return -1;
>  }
> +
> +GuestTimezone *qmp_guest_get_timezone(Error **errp)
> +{
> +    GuestTimezone *info =3D g_new0(GuestTimezone, 1);
> +    GTimeZone *tz =3D g_time_zone_new_local();
> +    if (tz =3D=3D NULL) {
> +        error_setg(errp, QERR_QGA_COMMAND_FAILED,
> +                   "Couldn't retrieve local timezone");
> +        goto error;
> +    }
> +
> +    gint64 now =3D g_get_real_time() / G_USEC_PER_SEC;
> +    gint32 intv =3D g_time_zone_find_interval(tz, =
G_TIME_TYPE_UNIVERSAL, now);
> +    info->offset =3D g_time_zone_get_offset(tz, intv);
> +    gchar const *name =3D g_time_zone_get_abbreviation(tz, intv);
> +    if (name !=3D NULL) {
> +        info->has_zone =3D true;
> +        info->zone =3D g_strdup(name);
> +    }
> +    g_time_zone_unref(tz);
> +
> +    return info;
> +
> +error:
> +    g_time_zone_unref(tz);
> +    g_free(info);
> +    return NULL;
> +}
> +
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..5183ea2 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,29 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +
> +
> +##
> +# @GuestTimezone:
> +#
> +# @zone:    Timezone name
> +# @offset:  Offset to UTC in seconds, negative numbers for time zones =
west of
> +#           GMT, positive numbers for east
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestTimezone',
> +  'data':   { '*zone': 'str', 'offset': 'int' } }
> +
> +
> +##
> +# @guest-get-timezone:
> +#
> +# Retrieves the timezone information from the guest.
> +#
> +# Returns: A GuestTimezone dictionary.
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-timezone',
> +  'returns': 'GuestTimezone' }
> --
> 2.9.3
>=20
>=20
>=20
>=20
> --=20
> Respectfully,
> Sameeh Jubran
> Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>
> Software Engineer @ Daynix <http://www.daynix.com/>.

--
Vinzenz Feenstra
Senior Software Developer
Red Hat Czech
