Received: from eggs.gnu.org ([2001:4830:134:3::10]:50160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cr22k-0004hQ-Df
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cr22g-0004KL-FO
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:40:42 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cr22g-0004Jd-8P
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 08:40:38 -0400
Received: by mail-wr0-x244.google.com with SMTP id y90so7220808wrb.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 05:40:38 -0700 (PDT)
References: <20170322171656.7901-1-vfeenstr@redhat.com>
	<20170322171656.7901-2-vfeenstr@redhat.com>
From: sameeh jubran <sameeh@daynix.com>
Message-ID: <db0744da-66e9-9f65-1772-2bbb6b85126e@daynix.com>
Date: Thu, 23 Mar 2017 14:40:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170322171656.7901-2-vfeenstr@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, mdroth@linux.vnet.ibm.com

I have tested the patch on Windows 2012 R2 and it seems to be working good.

Please see some comments inline.


On 3/22/2017 7:16 PM, Vinzenz 'evilissimo' Feenstra wrote:
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
>   qga/commands.c       | 19 +++++++++++++++++++
>   qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+)
>
> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..83d7f99 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,22 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
>       error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>       return -1;
>   }
> +
> +GuestTimezone *qmp_guest_get_timezone(Error **errp)
> +{
> +    GuestTimezone *info = g_new0(GuestTimezone, 1);
Check for null
> +    GTimeZone *tz = g_time_zone_new_local();
Check for null
> +    gint32 interval = g_time_zone_find_interval(tz, G_TIME_TYPE_STANDARD, 0);
Check if interval is -1
> +    gchar const *name = g_time_zone_get_abbreviation(tz, interval);
> +    if (name != NULL) {
> +        info->offset = g_time_zone_get_offset(tz, interval) / 60;
g_time_zone_get_offset returns the offset in seconds, dividing by 60 
will give us the offset in minutes.
Is there a reason to display it in minutes instead of hours?
Either way I think you should display the units in the output.

And 60 is a magic number, Even though it is very clear, I think it is 
better to add a define for that or check if glib already has one.
> +        info->zone = g_strdup(name);
> +    } else {
> +        error_setg(errp, "Timezone lookup failed");
> +        g_free(info);
> +        info = NULL;
> +    }
> +    g_time_zone_unref(tz);
> +    return info;
> +}
> +
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..62d6909 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,29 @@
>     'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                  '*input-data': 'str', '*capture-output': 'bool' },
>     'returns': 'GuestExec' }
> +
> +
> +##
> +# @GuestTimezone:
> +#
> +# @zone:    Timezone name
> +# @offset:  Offset to UTC in minutes. For western timezones the offset has a
> +#           negative value and for eastern the offset is positive value
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
> +# Returns: A GuestTimezone dictionary.
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-timezone',
> +  'returns': 'GuestTimezone' }
