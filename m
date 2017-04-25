Received: from eggs.gnu.org ([2001:4830:134:3::10]:44483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d37pj-0002fX-18
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 17:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d37pe-000334-33
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 17:17:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d37pd-00031N-Qo
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 17:17:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PLDgvH048908
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 17:17:08 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a27kn3seh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 17:17:08 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 17:17:06 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170419105258.4488-2-vfeenstr@redhat.com>
References: <20170419105258.4488-1-vfeenstr@redhat.com>
	<20170419105258.4488-2-vfeenstr@redhat.com>
Date: Tue, 25 Apr 2017 15:52:18 -0500
Message-Id: <149315353884.26622.6081569925906426907@loki>
Subject: Re: [Qemu-devel] [PATCH v6 1/1] qga: Add `guest-get-timezone`
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, sameeh@daynix.com

Quoting Vinzenz 'evilissimo' Feenstra (2017-04-19 05:52:58)
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
> =

> Adds a new command `guest-get-timezone` reporting the currently
> configured timezone on the system. The information on what timezone is
> currently is configured is useful in case of Windows VMs where the
> offset of the hardware clock is required to have the same offset. This
> can be used for management systems like `oVirt` to detect the timezone
> difference and warn administrators of the misconfiguration.
> =

> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/commands.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> =

> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..999538d 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,41 @@ int ga_parse_whence(GuestFileWhence *whence, Error *=
*errp)
>      error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>      return -1;
>  }
> +
> +GuestTimezone *qmp_guest_get_timezone(Error **errp)
> +{
> +#if !GLIB_CHECK_VERSION(2, 28, 0)
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +#else
> +    GuestTimezone *info =3D NULL;
> +    GTimeZone *tz =3D NULL;
> +    gint64 now =3D 0;
> +    gint32 intv =3D 0;
> +    gchar const *name =3D NULL;
> +
> +    info =3D g_new0(GuestTimezone, 1);
> +    tz =3D g_time_zone_new_local();
> +    if (tz =3D=3D NULL) {
> +        error_setg(errp, QERR_QGA_COMMAND_FAILED,
> +                   "Couldn't retrieve local timezone");
> +        goto error;
> +    }
> +
> +    now =3D g_get_real_time() / G_USEC_PER_SEC;
> +    intv =3D g_time_zone_find_interval(tz, G_TIME_TYPE_UNIVERSAL, now);
> +    info->offset =3D g_time_zone_get_offset(tz, intv);
> +    name =3D g_time_zone_get_abbreviation(tz, intv);
> +    if (name !=3D NULL) {
> +        info->has_zone =3D true;
> +        info->zone =3D g_strdup(name);
> +    }
> +    g_time_zone_unref(tz);
> +
> +    return info;
> +
> +error:
> +    g_free(info);
> +    return NULL;
> +#endif
> +}
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
> +# @offset:  Offset to UTC in seconds, negative numbers for time zones we=
st of
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
> -- =

> 2.9.3
>=20
