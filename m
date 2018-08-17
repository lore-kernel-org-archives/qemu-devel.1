Received: from eggs.gnu.org ([2001:4830:134:3::10]:41307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fqkQ8-0002rL-EN
	for Qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fqkQ7-0004Un-LE
	for Qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:28:28 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <c1f8aba9-4a63-4dfa-cf0b-9521c869c9ff@redhat.com>
Date: Fri, 17 Aug 2018 15:28:17 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1319041-4F97-49CD-A53C-BFFA6D39BC16@gmail.com>
References: <20180730212249.16418-1-programmingkidx@gmail.com>
	<5679ec6f-e2d7-e139-1b56-304540c89977@redhat.com>
	<f6fcbd58-2462-d432-a038-cc13bb0dcf23@redhat.com>
	<20180814084047.GD5025@dhcp-200-186.str.redhat.com>
	<D08F395C-E55A-4FF1-9844-02B606FDDF8E@gmail.com>
	<c1f8aba9-4a63-4dfa-cf0b-9521c869c9ff@redhat.com>
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


> On Aug 17, 2018, at 9:44 AM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 08/16/2018 08:27 PM, Programmingkid wrote:
>=20
>> I am by no means an expert at qemu-img. But I did try my best to =
create what I think should be the new output for qemu-img <command> =
--help. This is just the text I plan on using in a future patch. It is =
easier to read right now than it will be in patch form, so please let me =
know if there are any errors in this documentation. Thank you.
>> <amend>
>=20
> Just reviewing the first for now, to give you a feel for what to =
consider.
>=20
>> usage: qemu-img amend [--object objectdef] [--image-opts] [-p] [-q] =
[-f fmt]
>> [-t cache] -o options filename
>> Command parameters:
>>  -f             'fmt' is the disk image format. It is guessed =
automatically
>>                 in most cases.
>=20
> Bad advice. We WANT users to use -f (if you don't, and the automatic =
guessing sees something that is not raw, but your image SHOULD have been =
-f raw, then you have a security hole: the guest can write anything into =
a raw image to make the host access files it shouldn't based on =
interpreting the raw file as something else).  I'd drop the last =
sentence, and use just the first.

Ok.=20

>=20
>> --image-opts    Treat filename as a set of image options, instead of =
a plain
>>                 filename.
>>  -o             Used with a comma separated list of format specific =
options in a
>>                 name=3Dvalue format. Use "-o ?" for an overview of =
the options
>=20
> Please spell that "-o help", not "-o ?".   Otherwise, the user has to =
quote the ? to avoid it globbing into any single-byte file lying around =
in the current directory.

"-o ?" and "-o help" does not appear to work for this command. Maybe it =
should be removed.
This is what I tried:
	qemu-img amend -o help
	qemu-img amend -o ?

This is what I see in both instances: qemu-img: Expecting one image file =
name

>=20
>>                 supported by the used format
>> --object        'objectdef' is a QEMU user creatable object =
definition. See the
>>                 qemu(1) manual page for a description of the object =
properties.
>>                 The most common object type is a 'secret', which is =
used to
>>                 supply passwords and/or encryption keys.
>>  -p             Display progress bar. If the -p option is not used =
for a command
>>                 that supports it, the progress is reported when the =
process
>>                 receives a "SIGUSR1" signal.
>>  -q             Quiet mode - do not print any output (except errors). =
There's no
>>                 progress bar in case both -q and -p options are used.
>=20
> Not your fault, but I don't like it when interfaces take mutually =
exclusive operations but the last one does not win.  Either '-p -q' =
should behave like '-q', and '-q -p' behave like '-p' (because we accept =
the mutual exclusion but last one wins), or both forms should error =
(because they are incompatible).  But having both forms silently behave =
like '-q' is evil.  So, as long as you're willing to patch up =
interfaces, that's a project to consider.
>=20
>>  -t             Specifies the cache mode that should be used with the
>>                 destination file.
>=20
> And what are those modes?  If you're going to be wordy, then give the =
user enough information to be useful.  Otherwise, being terse in --help =
is fine (and let the man page be wordy instead).

I don't know what the modes are. Anyone care to fill us in?=20


>> Example:
>>     qemu-img amend -o compat=3D0.10 -f qcow2 image.qcow2
>=20
> Where's an example with --image-opts and --object secret?

I prefer examples that I think a user would actually use. The =
--image-opts and -object options are not necessary to use this command.

> We're trying to move away from compat=3D0.10 (also spelled compat=3Dv2),=
 and instead start encouraging compat=3Dv3.

So you want this: qemu-img amend -o compat=3Dv3 -f qcow2 image.qcow2

Thank you for reviewing my documentation.=
