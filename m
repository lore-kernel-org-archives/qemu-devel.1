Received: from eggs.gnu.org ([2001:4830:134:3::10]:58306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqiUC-0004BS-Ki
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqiUA-0001lF-36
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:47:44 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cqiU9-0001kP-Sr
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:47:42 -0400
Received: by mail-wr0-f172.google.com with SMTP id g10so131883466wrg.2
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 08:47:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Vinzenz Feenstra <vfeenstr@redhat.com>
In-Reply-To: <20170322154649.6947-1-vfeenstr@redhat.com>
Date: Wed, 22 Mar 2017 16:47:39 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <50AD4E3B-F0A3-48AC-B2EB-770D80678981@redhat.com>
References: <20170322154649.6947-1-vfeenstr@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Sorry I meant to add you Michael not Paolo -_-

> On Mar 22, 2017, at 4:46 PM, Vinzenz 'evilissimo' Feenstra =
<vfeenstr@redhat.com> wrote:
>=20
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>=20
> Adds a new command `guest-get-timezone` reporting the currently
> configured timezone on the system. The information on what timezone is
> currently is configured is useful in case of Windows VMs where the
> offset of the hardware clock is required to have the same offset. This
> can be used for management systems like `oVirt` to detect the timezone
> difference and warn administrators of the misconfiguration.
>=20
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---
> qga/commands.c       | 19 +++++++++++++++++++
> qga/qapi-schema.json | 25 +++++++++++++++++++++++++
> 2 files changed, 44 insertions(+)
>=20
> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..83d7f99 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,22 @@ int ga_parse_whence(GuestFileWhence *whence, =
Error **errp)
>     error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>     return -1;
> }
> +
> +GuestTimezone *qmp_guest_get_timezone(Error **errp)
> +{
> +    GuestTimezone *info =3D g_new0(GuestTimezone, 1);
> +    GTimeZone *tz =3D g_time_zone_new_local();
> +    gint32 interval =3D g_time_zone_find_interval(tz, =
G_TIME_TYPE_STANDARD, 0);
> +    gchar const *name =3D g_time_zone_get_abbreviation(tz, interval);
> +    if (name !=3D NULL) {
> +        info->offset =3D g_time_zone_get_offset(tz, interval) / 60;
> +        info->zone =3D g_strdup(name);
> +    } else {
> +        error_setg(errp, "Timezone lookup failed");
> +        g_free(info);
> +        info =3D NULL;
> +    }
> +    g_time_zone_unref(tz);
> +    return info;
> +}
> +
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..6683aae 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,28 @@
>   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                '*input-data': 'str', '*capture-output': 'bool' },
>   'returns': 'GuestExec' }
> +
> +
> +##
> +# @GuestTimezone:
> +#
> +# @zone:    Timezone name
> +# @offset:  Offset to UTC in minutes
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestTimezone',
> +  'data':   { 'zone': 'str', 'offset': 'int' } }
> +
> +
> +##
> +# @guest-get-timezone:
> +#
> +# Retrieves the timezone information from the guest.
> +#
> +# Returns: The guest timezone GuestTimezone information on success.
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-timezone',
> +  'returns': 'GuestTimezone' }
> --=20
> 2.9.3
>=20
