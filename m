Received: from eggs.gnu.org ([2001:4830:134:3::10]:37808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cv3jH-0007QJ-KC
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cv3jF-0007jl-Tf
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:17:15 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cv3jF-0007ja-IL
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:17:13 -0400
Received: by mail-lf0-x244.google.com with SMTP id r36so13216590lfi.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 08:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20170331101947.2046-1-vfeenstr@redhat.com>
	<20170331101947.2046-2-vfeenstr@redhat.com>
	<e60c94da-f3d8-3139-27c5-2c357b37834b@redhat.com>
In-Reply-To: <e60c94da-f3d8-3139-27c5-2c357b37834b@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 03 Apr 2017 15:17:00 +0000
Message-ID: <CAJ+F1CL+jkWOdCeDkfBUBFssR41kT9uumVYrcjqeuQ7YvNX5fg@mail.gmail.com>
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
To: Eric Blake <eblake@redhat.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Hi

On Fri, Mar 31, 2017 at 3:41 PM Eric Blake <eblake@redhat.com> wrote:

> On 03/31/2017 05:19 AM, Vinzenz 'evilissimo' Feenstra wrote:
> > From: Vinzenz Feenstra <vfeenstr@redhat.com>
> >
> > Add a new 'guest-get-osrelease' command to report OS information in the
> > os-release format. As documented here:
> > https://www.freedesktop.org/software/systemd/man/os-release.html
> >
> > The win32 implementation generates the information.
> > On POSIX systems the /etc/os-release or /usr/lib/os-release files
> > content is returned when available and gets extended with the fields:
> > - QGA_UNAME_RELEASE which is the content of `uname -r`
> > - QGA_UNAME_VERSION which is the content of `uname -v`
> > - QGA_UNAME_MACHINE which is the content of `uname -m`
> >
> > Here an example for a Fedora 25 VM:
> >
> > virsh # qemu-agent-command F25 '{ "execute": "guest-get-osrelease" }'
> > {"return":{"content":"NAME=3DFedora\nVERSION=3D\"25 (Server Edition)\"\=
n
> > ID=3Dfedora\nVERSION_ID=3D25\nPRETTY_NAME=3D\"Fedora 25 (Server Edition=
)\"\n
> > ANSI_COLOR=3D\"0;34\"\nCPE_NAME=3D\"cpe:/o:fedoraproject:fedora:25\"\n
> > HOME_URL=3D\"https://fedoraproject.org/\"\n
> > BUG_REPORT_URL=3D\"https://bugzilla.redhat.com/\"\n
> > REDHAT_BUGZILLA_PRODUCT=3D\"Fedora\"\n
> > REDHAT_BUGZILLA_PRODUCT_VERSION=3D25\nREDHAT_SUPPORT_PRODUCT=3D\"Fedora=
\"\n
> > REDHAT_SUPPORT_PRODUCT_VERSION=3D25\n
> > PRIVACY_POLICY_URL=3Dhttps://fedoraproject.org/wiki/Legal:PrivacyPolicy=
\n
> > VARIANT=3D\"Server Edition\"\nVARIANT_ID=3Dserver\n\n
> > QGA_UNAME_RELEASE=3D\"4.8.6-300.fc25.x86_64\"\n
> > QGA_UNAME_VERSION=3D\"#1 SMP Tue Nov 1 12:36:38 UTC 2016\"\n
> > QGA_UNAME_MACHINE=3D\"x86_64\"\n"}}
>
> Uggh. This is a step backwards.  Now you are requiring the end user to
> parse a raw string, instead of giving them the information already
> broken out as a JSON dictionary.
>

yes otoh, it uses an existing standard to retrieve various guest os release
informations, which existing tool may know how to handle.

(I feel partially guilty about it since I suggested it, mainly in a
discussion over irc and Vinzenz adopted it)

The format is fairly straightforward to parse, but perhaps it should be
sent as a JSON dict instead? However, that would mean that the list of keys
is limited by what QGA protocol defines, and the agent would have to parse
the file himself. And we would have to duplicate the documentation etc..

I would rely on the XDG format instead, given its simplicity, extensibility
and documentation that fits the job nicely imho.

--=20
Marc-Andr=C3=A9 Lureau
