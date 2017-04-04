Received: from eggs.gnu.org ([2001:4830:134:3::10]:41942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cvKzN-0003Uy-8u
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 05:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cvKzJ-0000X1-2c
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 05:43:01 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:34186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cvKzI-0000WK-Sk
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 05:42:57 -0400
Received: by mail-vk0-x241.google.com with SMTP id y16so22040977vky.1
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 02:42:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170323113913.26974-2-vfeenstr@redhat.com>
References: <20170323113913.26974-1-vfeenstr@redhat.com>
	<20170323113913.26974-2-vfeenstr@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 4 Apr 2017 12:42:55 +0300
Message-ID: <CAKPgXcE95EgoxoSD9CdY0Rt6WWtKDfZTjePpE=GMXB4EXp9UGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, eblake@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>

I have tested the patch on Windows 2012 R2

Reviewed-by: Sameeh Jubran <sameeh@daynix.com>
Tested-by: Sameeh Jubran <sameeh@daynix.com>

On Thu, Mar 23, 2017 at 2:39 PM, Vinzenz 'evilissimo' Feenstra <
vfeenstr@redhat.com> wrote:

> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>
> Adds a new command `guest-get-timezone` reporting the currently
> configured timezone on the system. The information on what timezone is
> currently is configured is useful in case of Windows VMs where the
> offset of the hardware clock is required to have the same offset. This
> can be used for management systems like `oVirt` to detect the timezone
> difference and warn administrators of the misconfiguration.
>
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---
>  qga/commands.c       | 29 +++++++++++++++++++++++++++++
>  qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..3b5789c 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,32 @@ int ga_parse_whence(GuestFileWhence *whence, Error
> **errp)
>      error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>      return -1;
>  }
> +
> +GuestTimezone *qmp_guest_get_timezone(Error **errp)
> +{
> +    GuestTimezone *info = g_new0(GuestTimezone, 1);
> +    GTimeZone *tz = g_time_zone_new_local();
> +    if (tz == NULL) {
> +        error_setg(errp, QERR_QGA_COMMAND_FAILED,
> +                   "Couldn't retrieve local timezone");
> +        goto error;
> +    }
> +
> +    gint64 now = g_get_real_time() / G_USEC_PER_SEC;
> +    gint32 intv = g_time_zone_find_interval(tz, G_TIME_TYPE_UNIVERSAL,
> now);
> +    info->offset = g_time_zone_get_offset(tz, intv);
> +    gchar const *name = g_time_zone_get_abbreviation(tz, intv);
> +    if (name != NULL) {
> +        info->has_zone = true;
> +        info->zone = g_strdup(name);
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
> +# @offset:  Offset to UTC in seconds, negative numbers for time zones
> west of
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
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
