Received: from eggs.gnu.org ([2001:4830:134:3::10]:52751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dDeDH-0001GU-5r
	for qemu-devel@nongnu.org; Wed, 24 May 2017 17:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dDeDE-0003GN-2X
	for qemu-devel@nongnu.org; Wed, 24 May 2017 17:53:03 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dDeDD-0003Dl-Ox
	for qemu-devel@nongnu.org; Wed, 24 May 2017 17:52:59 -0400
Received: by mail-wr0-f174.google.com with SMTP id z52so62493359wrc.2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 14:52:57 -0700 (PDT)
Date: Wed, 24 May 2017 23:51:55 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170524235155.2b1454ef@fiorina>
In-Reply-To: <149202750217.22939.16193629731178448080@loki>
References: <20170331101947.2046-1-vfeenstr@redhat.com>
	<20170331101947.2046-2-vfeenstr@redhat.com>
	<e60c94da-f3d8-3139-27c5-2c357b37834b@redhat.com>
	<CAJ+F1CL+jkWOdCeDkfBUBFssR41kT9uumVYrcjqeuQ7YvNX5fg@mail.gmail.com>
	<149202750217.22939.16193629731178448080@loki>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qemu-ga: add guest-get-osrelease command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org

On Wed, 12 Apr 2017 15:05:02 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> On 04/03/2017 10:17 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >=20
> > On Fri, Mar 31, 2017 at 3:41 PM Eric Blake <eblake@redhat.com> wrote:
> >  =20
> >> On 03/31/2017 05:19 AM, Vinzenz 'evilissimo' Feenstra wrote: =20
> >>> From: Vinzenz Feenstra <vfeenstr@redhat.com>
> >>>
> >>> Add a new 'guest-get-osrelease' command to report OS information in
> >>> the
> >>> os-release format. As documented here:
> >>> https://www.freedesktop.org/software/systemd/man/os-release.html
> >>>
> >>> The win32 implementation generates the information.
> >>> On POSIX systems the /etc/os-release or /usr/lib/os-release files
> >>> content is returned when available and gets extended with the
> >>> fields:
> >>> - QGA_UNAME_RELEASE which is the content of `uname -r`
> >>> - QGA_UNAME_VERSION which is the content of `uname -v`
> >>> - QGA_UNAME_MACHINE which is the content of `uname -m`
> >>>
> >>> Here an example for a Fedora 25 VM:
> >>>
> >>> virsh # qemu-agent-command F25 '{ "execute": "guest-get-osrelease"
> >>> }'
> >>> {"return":{"content":"NAME=3DFedora\nVERSION=3D\"25 (Server Edition)\=
"\n
> >>> ID=3Dfedora\nVERSION_ID=3D25\nPRETTY_NAME=3D\"Fedora 25 (Server
> >>> Edition)\"\n
> >>> ANSI_COLOR=3D\"0;34\"\nCPE_NAME=3D\"cpe:/o:fedoraproject:fedora:25\"\n
> >>> HOME_URL=3D\"https://fedoraproject.org/\"\n
> >>> BUG_REPORT_URL=3D\"https://bugzilla.redhat.com/\"\n
> >>> REDHAT_BUGZILLA_PRODUCT=3D\"Fedora\"\n
> >>> REDHAT_BUGZILLA_PRODUCT_VERSION=3D25\nREDHAT_SUPPORT_PRODUCT=3D\"Fedo=
ra\"\n
> >>> REDHAT_SUPPORT_PRODUCT_VERSION=3D25\n
> >>> PRIVACY_POLICY_URL=3Dhttps://fedoraproject.org/wiki/Legal:PrivacyPoli=
cy\n
> >>> VARIANT=3D\"Server Edition\"\nVARIANT_ID=3Dserver\n\n
> >>> QGA_UNAME_RELEASE=3D\"4.8.6-300.fc25.x86_64\"\n
> >>> QGA_UNAME_VERSION=3D\"#1 SMP Tue Nov 1 12:36:38 UTC 2016\"\n
> >>> QGA_UNAME_MACHINE=3D\"x86_64\"\n"}} =20
> >>
> >> Uggh. This is a step backwards.  Now you are requiring the end user
> >> to
> >> parse a raw string, instead of giving them the information already
> >> broken out as a JSON dictionary.
> >> =20
> >=20
> > yes otoh, it uses an existing standard to retrieve various guest os
> > release
> > informations, which existing tool may know how to handle.
> >=20
> > (I feel partially guilty about it since I suggested it, mainly in a
> > discussion over irc and Vinzenz adopted it)
> >=20
> > The format is fairly straightforward to parse, but perhaps it should
> > be
> > sent as a JSON dict instead? However, that would mean that the list of
> > keys
> > is limited by what QGA protocol defines, and the agent would have to
> > parse
> > the file himself. And we would have to duplicate the documentation
> > etc..
> >=20
> > I would rely on the XDG format instead, given its simplicity,
> > extensibility
> > and documentation that fits the job nicely imho. =20
>=20
> I like the idea of using an existing standard, but if they really want
> to get at a raw dump of /etc/os-release to use with existing tools then
> I think guest-file-open/read are the more appropriate interfaces.
>=20
> Knowing that they *can* get at information like that for a particular
> guest, or do things like execute 'uname -m' via guest-exec, is where I
> think an interface like this has it's place.
>=20
> So I think a more curated/limited set of identifiers is sufficient, and
> still flexible enough to enable to more os-specific use-cases.
>=20
> But I also don't like the idea of re-defining what terms like
> "version_id", "variant", "varient_id", etc mean, so I think it's still
> a good idea to use the os-release-documented fields as the basis for
> the fields we decide to return in our dictionary, and note that
> explicitly in the schema documentation.
>=20

So what about the following, would that be acceptable?


##
# @GuestOSRelease:
#
# @content:
#           POSIX systems the @kernel_version, @kernel_release and
#           @machine_hardware correspond to the values release, version and
#           machine returned by uname(2). On Windows, they correspond to the
#           version number, build number and architecture.
#
#           On Linux-based system where os-release info is available either
#           from /etc/os-release or from /usr/lib/os-release, the fields @i=
d,
#           @name, @pretty_name, @version, @version_codename, @variant,
#           correspond to the fields of the same name defined in os-release=
(5).
#           On Windows, the data is generated based on the available
#           inforamtion.
#
# Since: 2.10
##
{ 'struct': 'GuestOSRelease',
  'data': {
      'kernel_release': 'str',
      'kernel_version': 'str',
      'machine_hardware': 'str'
      'id': '*str',
      'name': '*str',
      'pretty_name': '*str',
      'version': '*str',
      'version_codename': '*str',
      'variant': '*str',
  } }


    Tomas


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
