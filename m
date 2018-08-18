Received: from eggs.gnu.org ([2001:4830:134:3::10]:51389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fr4Wv-0002yI-Nl
	for Qemu-devel@nongnu.org; Sat, 18 Aug 2018 12:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fr4P5-0004UP-LD
	for Qemu-devel@nongnu.org; Sat, 18 Aug 2018 12:48:59 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <a924155b-0302-8e3f-395c-3504b8d6f729@redhat.com>
Date: Sat, 18 Aug 2018 12:48:28 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <800B3517-46C2-4869-ACAB-8BD582322E10@gmail.com>
References: <20180730212249.16418-1-programmingkidx@gmail.com>
	<5679ec6f-e2d7-e139-1b56-304540c89977@redhat.com>
	<f6fcbd58-2462-d432-a038-cc13bb0dcf23@redhat.com>
	<20180814084047.GD5025@dhcp-200-186.str.redhat.com>
	<D08F395C-E55A-4FF1-9844-02B606FDDF8E@gmail.com>
	<c1f8aba9-4a63-4dfa-cf0b-9521c869c9ff@redhat.com>
	<D1319041-4F97-49CD-A53C-BFFA6D39BC16@gmail.com>
	<a924155b-0302-8e3f-395c-3504b8d6f729@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: increase spacing between
 commands in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Qemu-devel@nongnu.org


> On Aug 17, 2018, at 4:59 PM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 08/17/2018 02:28 PM, Programmingkid wrote:
>=20
>>>>  -o             Used with a comma separated list of format specific =
options in a
>>>>                 name=3Dvalue format. Use "-o ?" for an overview of =
the options
>>>=20
>>> Please spell that "-o help", not "-o ?".   Otherwise, the user has =
to quote the ? to avoid it globbing into any single-byte file lying =
around in the current directory.
>> "-o ?" and "-o help" does not appear to work for this command. Maybe =
it should be removed.
>> This is what I tried:
>> 	qemu-img amend -o help
>> 	qemu-img amend -o ?
>=20
> The set of options depends on the file format being amended.  So, you =
have to try:
>=20
> qemu-img amend -o help -f qcow2
>=20
> or supply an image name, as in:
>=20
> qemu-img amend -o help myimage.qcow2
>=20
> (of course, the latter relies on image probing, which I just said is =
potentially unsafe if you didn't use -f).  But the point is the option =
-o does work, just not in isolation.
>=20
>=20
>>>>  -t             Specifies the cache mode that should be used with =
the
>>>>                 destination file.
>>>=20
>>> And what are those modes?  If you're going to be wordy, then give =
the user enough information to be useful.  Otherwise, being terse in =
--help is fine (and let the man page be wordy instead).
>> I don't know what the modes are. Anyone care to fill us in?
>=20
> The source code is your friend. qemu-img.c has:
>=20
>       case 'T':
>            cache =3D optarg;
> ...
>    ret =3D bdrv_parse_cache_mode(cache, &flags, &writethrough);
>=20
> then you search for bdrv_parse_cache_mode(), in block.c:
>=20
>    if (!strcmp(mode, "off") || !strcmp(mode, "none")) {
>        *writethrough =3D false;
>        *flags |=3D BDRV_O_NOCACHE;
>    } else if (!strcmp(mode, "directsync")) {
>        *writethrough =3D true;
>        *flags |=3D BDRV_O_NOCACHE;
>    } else if (!strcmp(mode, "writeback")) {
>        *writethrough =3D false;
>    } else if (!strcmp(mode, "unsafe")) {
>        *writethrough =3D false;
>        *flags |=3D BDRV_O_NO_FLUSH;
>    } else if (!strcmp(mode, "writethrough")) {
>        *writethrough =3D true;
>=20
> So six different aliases, for five different modes.  We can either =
improve --help output to document these directly, or add a '-t help' =
option (the way we have '-o help') to dynamically print the list.
>=20
>>>> Example:
>>>>     qemu-img amend -o compat=3D0.10 -f qcow2 image.qcow2
>>>=20
>>> Where's an example with --image-opts and --object secret?
>> I prefer examples that I think a user would actually use. The =
--image-opts and -object options are not necessary to use this command.
>=20
> Umm, they ARE necessary if you want to amend a LUKS-encrypted image, =
and that IS something I would actually use.  What's more, it's the =
complex examples (like a LUKS-encrypted image) where seeing something =
spelled out will save a LOT of hair-pulling from someone reading the =
docs (but, alongside it should ALSO be a short-and-simple example).
>=20
>>> We're trying to move away from compat=3D0.10 (also spelled =
compat=3Dv2), and instead start encouraging compat=3Dv3.
>> So you want this: qemu-img amend -o compat=3Dv3 -f qcow2 image.qcow2
>=20
> Yes, that's one reasonable example, but should not be the only =
example.

Here is an improved version of the amend documentation:

usage: qemu-img amend [--object objectdef] [--image-opts] [-p] [-q] [-f =
fmt]
[-t cache] -o options filename

Command parameters:
 -f             The format of the image file.

--image-opts    Treat filename as a set of image options, instead of a =
plain
                filename.

 -o             Used with a comma separated list of format specific =
options in a
                name=3Dvalue format. Use "-o help" for an overview of =
the options
                supported by the used format.

--object        'objectdef' is a QEMU user creatable object definition. =
See the
                qemu(1) manual page for a description of the object =
properties.
                The most common object type is a 'secret', which is used =
to
                supply passwords and/or encryption keys.

 -p             Display progress bar. If the -p option is not used for a =
command
                that supports it, the progress is reported when the =
process
                receives a "SIGUSR1" signal. Avoid using with the -q =
option.

 -q             Quiet mode - do not print any output (except errors). =
Avoid
                using with the -p option.

 -t             Specifies the cache mode that should be used with the
                destination file. Options are: none, writeback, =
writethrough,
                directsync, and unsafe.

Example:
    qemu-img amend -o compat=3Dv3 -f qcow2 image.qcow2
    qemu-img amend --object secret,id=3Dsec0,data=3Dtest --image-opts \
    driver=3Dluks,key-secret=3Dsec0,file.filename=3Dtest.luks -o size=3D2G=
