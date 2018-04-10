Received: from eggs.gnu.org ([2001:4830:134:3::10]:58870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5pQP-0008Jy-My
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5pQK-0002jJ-IB
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:18:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5pQK-0002iz-C1
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:18:44 -0400
Date: Tue, 10 Apr 2018 10:18:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410091832.GG5155@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180407000117.25640-1-lersek@redhat.com>
	<20180409084940.GE18283@redhat.com>
	<3381bdf1-62ea-9da7-c654-032c0c11fb4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3381bdf1-62ea-9da7-c654-032c0c11fb4e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, Apr 09, 2018 at 07:57:54PM +0200, Laszlo Ersek wrote:
> On 04/09/18 10:49, Daniel P. Berrang=C3=A9 wrote:
> > On Sat, Apr 07, 2018 at 02:01:17AM +0200, Laszlo Ersek wrote:
> >> Add a schema that describes the properties of virtual machine firmwa=
re.
> >>
> >> Each firmware executable installed on a host system should come with=
 a
> >> JSON file that conforms to this schema, and informs the management
> >> applications about the firmware's properties.
> >>
> >> In addition, a configuration directory with symlinks to the JSON fil=
es
> >> should exist, with the symlinks carefully named to reflect a priorit=
y
> >> order. Management applications can then search this directory in pri=
ority
> >> order for the first firmware executable that satisfies their search
> >> criteria. The found JSON file provides the management layer with dom=
ain
> >> configuration bits that are required to run the firmware binary.
> >>
> >> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> >> Cc: Alexander Graf <agraf@suse.de>
> >> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Cc: David Gibson <dgibson@redhat.com>
> >> Cc: Eric Blake <eblake@redhat.com>
> >> Cc: Gary Ching-Pang Lin <glin@suse.com>
> >> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> >> Cc: Markus Armbruster <armbru@redhat.com>
> >> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> >> Cc: Michal Privoznik <mprivozn@redhat.com>
> >> Cc: Peter Krempa <pkrempa@redhat.com>
> >> Cc: Peter Maydell <peter.maydell@linaro.org>
> >> Cc: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> >> ---
> >>
> >> Notes:
> >>     Folks on the CC list, please try to see if the suggested schema =
is
> >>     flexible enough to describe the virtual firmware(s) that you are
> >>     familiar with. Thanks!
> >>
> >>  Makefile              |   9 ++
> >>  Makefile.objs         |   4 +
> >>  qapi/firmware.json    | 343 +++++++++++++++++++++++++++++++++++++++=
+++++++++++
> >>  qapi/qapi-schema.json |   1 +
> >>  qmp.c                 |   5 +
> >>  .gitignore            |   4 +
> >>  6 files changed, 366 insertions(+)
> >>  create mode 100644 qapi/firmware.json
> >>
> >=20
> >> diff --git a/qapi/firmware.json b/qapi/firmware.json
> >> new file mode 100644
> >> index 000000000000..f267240f44dd
> >> --- /dev/null
> >> +++ b/qapi/firmware.json
> >> @@ -0,0 +1,343 @@
> >> +# -*- Mode: Python -*-
> >> +
> >> +##
> >> +# =3D Firmware
> >> +##
> >> +
> >> +##
> >> +# @FirmwareDevice:
> >> +#
> >> +# Defines the device types that a firmware file can be mapped into.
> >> +#
> >> +# @memory: The firmware file is to be mapped into memory.
> >> +#
> >> +# @kernel: The firmware file is to be loaded like a Linux kernel. T=
his is
> >> +#          similar to @memory but may imply additional processing t=
hat is
> >> +#          specific to the target architecture.
> >> +#
> >> +# @flash: The firmware file is to be mapped into a pflash chip.
> >> +#
> >> +# Since: 2.13
> >> +##
> >> +{ 'enum' : 'FirmwareDevice',
> >> +  'data' : [ 'memory', 'kernel', 'flash' ] }
> >> +
> >> +##
> >> +# @FirmwareAccess:
> >> +#
> >> +# Defines the possible permissions for a given access mode to a dev=
ice that
> >> +# maps a firmware file.
> >> +#
> >> +# @denied: The access is denied.
> >> +#
> >> +# @permitted: The access is permitted.
> >> +#
> >> +# @restricted-to-secure-context: The access is permitted for guest =
code that
> >> +#                                runs in a secure context; otherwis=
e the access
> >> +#                                is denied. The definition of "secu=
re context"
> >> +#                                is specific to the target architec=
ture.
> >> +#
> >> +# Since: 2.13
> >> +##
> >> +{ 'enum' : 'FirmwareAccess',
> >> +  'data' : [ 'denied', 'permitted', 'restricted-to-secure-context' =
] }
> >=20
> > I'm not really understanding the purpose of this - what does it map t=
o
> > on the command line ?
>=20
> That's difficult to answer generally, because -bios and -kernel have
> different meanings per board type. So I didn't aim at command line
> switches here; instead I tried to capture where and how the firmware
> wants to "end up" in the virtual hardware. How that maps to a particula=
r
> board is a separate question.

I tend to think that defining a mapping to command line arguments is a ke=
y
feature that this should cover. Even if there variations across boards, Q=
EMU
still has a small finite set of approaches to configure firmware, so it d=
oes
not feel unreasonable to define what they are and how they map to thes fi=
rmware
files.

Your FirmwareDevice enum above with "memory", "kernel" and "flash" has
pretty much suggested the -bios, -kernel or -drive if=3Dflash args anway

> So, the schema intends to describe the mapping that the firmware expect=
s
> from the board. How that is implemented on the QEMU command line is lef=
t
> as an exercise to ... libvirtd. :)

I think this is pretty unhelpful. Essentially that is saying here is a bi=
g
pile of information about firmware, but we're not going to tell you how t=
o
use it correctly, everyone must figure it out themselves.


> >> +##
> >> +# @FirmwareFile:
> >> +#
> >> +# Gathers the common traits of system firmware executables and NVRA=
M templates.
> >> +#
> >> +# @pathname: absolute pathname of the firmware file on the host fil=
esystem
> >> +#
> >> +# @description: human-readable description of the firmware file
> >> +#
> >> +# @tags: a list of machine-readable strings providing additional in=
formation
> >=20
> > This makes it look like this information is something applications sh=
ould be
> > using when setting up firmwares, which is definitely not what we want=
. Lets
> > rename this
> >=20
> >   "@build_options: arbitrary list of firmware specific build options,=
 for
> >                    informative purposes only. Applications should not=
 attempt
> >                    to interpret / assign meaning to these options"
>=20
> Hmmm, I agree with you half-way here. I'm not saying that applications
> *should* consult the tags, but they might want let the user express a
> search condition for the tags. Near the end of the RFC, there's an
> example JSON where the sole nvramslot advertizes two variable store
> templates (both of which are compatible with the firmware and the
> nvramslot from a technical POV). However, one varstore template is
> logically empty, and the other varstore template has the MS certificate=
s
> pre-enrolled and Secure Boot enabled. If the new domain is created with
> an OS installer that is not signed at all, the choice of varstore
> template can make a big difference. And, the way I could distinguish
> these two templates from each other (in a machine readable format) is
> the "tags" list -- pls. search the RFC for the string '"mscerts"'.

I don't think we should be using "tags" for the "mscerts" information.
There should be some kind of explicit way to denote that the vars have
been pre-enrolled or not.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
