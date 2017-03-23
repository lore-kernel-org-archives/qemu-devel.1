Received: from eggs.gnu.org ([2001:4830:134:3::10]:32911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cr2lK-0000ik-4Q
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cr2lG-0005tg-Ux
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:26:46 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cr2lG-0005tE-JW
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:26:42 -0400
Received: by mail-wm0-f43.google.com with SMTP id t189so63120547wmt.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 06:26:42 -0700 (PDT)
From: Vinzenz Feenstra <vfeenstr@redhat.com>
Message-Id: <AAC5CDB0-6044-41AF-8DAB-DD778255C688@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Thu, 23 Mar 2017 14:26:39 +0100
In-Reply-To: <CAJ+F1C+953eKcpLFO7_6mnXb0tE4zP_jAhhMbDX5tBEDUtNZVw@mail.gmail.com>
References: <20170322171656.7901-1-vfeenstr@redhat.com>
	<20170322171656.7901-2-vfeenstr@redhat.com>
	<db0744da-66e9-9f65-1772-2bbb6b85126e@daynix.com>
	<CAJ+F1C+953eKcpLFO7_6mnXb0tE4zP_jAhhMbDX5tBEDUtNZVw@mail.gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: sameeh jubran <sameeh@daynix.com>, QEMU Developers <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com


> On Mar 23, 2017, at 1:51 PM, Marc-Andr=C3=A9 Lureau =
<marcandre.lureau@gmail.com> wrote:
>=20
> Hi
>=20
> On Thu, Mar 23, 2017 at 4:41 PM sameeh jubran <sameeh@daynix.com =
<mailto:sameeh@daynix.com>> wrote:
> I have tested the patch on Windows 2012 R2 and it seems to be working =
good.
>=20
> Please see some comments inline.
>=20
>=20
> On 3/22/2017 7:16 PM, Vinzenz 'evilissimo' Feenstra wrote:
> > From: Vinzenz Feenstra <vfeenstr@redhat.com =
<mailto:vfeenstr@redhat.com>>
> >
> > Adds a new command `guest-get-timezone` reporting the currently
> > configured timezone on the system. The information on what timezone =
is
> > currently is configured is useful in case of Windows VMs where the
> > offset of the hardware clock is required to have the same offset. =
This
> > can be used for management systems like `oVirt` to detect the =
timezone
> > difference and warn administrators of the misconfiguration.
> >
> > Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com =
<mailto:vfeenstr@redhat.com>>
> > ---
> >   qga/commands.c       | 19 +++++++++++++++++++
> >   qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
> >   2 files changed, 45 insertions(+)
> >
> > diff --git a/qga/commands.c b/qga/commands.c
> > index 4d92946..83d7f99 100644
> > --- a/qga/commands.c
> > +++ b/qga/commands.c
> > @@ -499,3 +499,22 @@ int ga_parse_whence(GuestFileWhence *whence, =
Error **errp)
> >       error_setg(errp, "invalid whence code %"PRId64, =
whence->u.value);
> >       return -1;
> >   }
> > +
> > +GuestTimezone *qmp_guest_get_timezone(Error **errp)
> > +{
> > +    GuestTimezone *info =3D g_new0(GuestTimezone, 1);
> Check for null
> > +    GTimeZone *tz =3D g_time_zone_new_local();
> Check for null
> > +    gint32 interval =3D g_time_zone_find_interval(tz, =
G_TIME_TYPE_STANDARD, 0);
> Check if interval is -1

Will add the checks above in v3

> > +    gchar const *name =3D g_time_zone_get_abbreviation(tz, =
interval);
> > +    if (name !=3D NULL) {
> > +        info->offset =3D g_time_zone_get_offset(tz, interval) / 60;
> g_time_zone_get_offset returns the offset in seconds, dividing by 60
> will give us the offset in minutes.
> Is there a reason to display it in minutes instead of hours?

Yes, there are offsets that are in minutes, some are 45 minutes, some 30 =
minutes so hours
aren=E2=80=99t enough.

> Either way I think you should display the units in the output.
>=20
> And 60 is a magic number, Even though it is very clear, I think it is
> better to add a define for that or check if glib already has one.
>=20
> Instead, why not follow glib API and return seconds?

In an earlier iteration I did use a Windows API function and the offset =
value in Windows is returned
in minutes. See here the documentation for the  =E2=80=98Bias=E2=80=99 =
fields:
=
https://msdn.microsoft.com/en-us/library/windows/desktop/ms725481(v=3Dvs.8=
5).aspx =
<https://msdn.microsoft.com/en-us/library/windows/desktop/ms725481(v=3Dvs.=
85).aspx>

That was for me the main motivation, plus the seconds granularity is not =
required for the offsets,
minutes is granular enough. However I could change it to seconds of =
course, seems more
reasonable in the light of the glib support for it.


> =20
> > +        info->zone =3D g_strdup(name);
> > +    } else {
> > +        error_setg(errp, "Timezone lookup failed");
> > +        g_free(info);
> > +        info =3D NULL;
> > +    }
> > +    g_time_zone_unref(tz);
> > +    return info;
> > +}
> > +
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index a02dbf2..62d6909 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1042,3 +1042,29 @@
> >     'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
> >                  '*input-data': 'str', '*capture-output': 'bool' },
> >     'returns': 'GuestExec' }
> > +
> > +
> > +##
> > +# @GuestTimezone:
> > +#
> > +# @zone:    Timezone name
> > +# @offset:  Offset to UTC in minutes. For western timezones the =
offset has a
> > +#           negative value and for eastern the offset is positive =
value
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'struct': 'GuestTimezone',
> > +  'data':   { 'zone': 'str', 'offset': 'int' } }
> > +
> > +
> > +##
> > +# @guest-get-timezone:
> > +#
> > +# Retrieves the timezone information from the guest.
> > +#
> > +# Returns: A GuestTimezone dictionary.
> > +#
> > +# Since: 2.10
> > +##
> > +{ 'command': 'guest-get-timezone',
> > +  'returns': 'GuestTimezone' }
>=20
> --=20
> Marc-Andr=C3=A9 Lureau
