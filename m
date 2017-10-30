Received: from eggs.gnu.org ([2001:4830:134:3::10]:52474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e9Bty-0002Az-KV
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e9Btu-0002Dy-IE
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:22:58 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:54696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1e9Btu-0002Di-DI
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:22:54 -0400
Received: by mail-io0-x230.google.com with SMTP id e89so27934372ioi.11
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 08:22:54 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171030143220.GA5438@work-vm>
Date: Mon, 30 Oct 2017 11:22:51 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <C5B22F13-6DE1-48A8-BB7D-5A65826CB3CC@gmail.com>
References: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
	<38c3125f-b050-c0ba-282f-bc1e9e11d297@redhat.com>
	<20171029102106.GA2841@work-vm>
	<847196B3-8C4D-4B8E-A6A4-5ADAEC73FF62@gmail.com>
	<20171030143220.GA5438@work-vm>
Subject: Re: [Qemu-devel] drive_add: file names with spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Oct 30, 2017, at 10:32 AM, Dr. David Alan Gilbert =
<dgilbert@redhat.com> wrote:
>=20
> * Programmingkid (programmingkidx@gmail.com) wrote:
>>=20
>>> On Oct 29, 2017, at 6:21 AM, Dr. David Alan Gilbert =
<dgilbert@redhat.com> wrote:
>>>=20
>>> * Eric Blake (eblake@redhat.com) wrote:
>>>> On 10/28/2017 06:44 AM, Programmingkid wrote:
>>>>> I'm trying to use an image file that has spaces in its file name =
(and sometimes in the path) to be used as a USB flash drive. When I try =
adding the image file using the drive_add command I see this error: =
drive_add: extraneous characters at the end of the line
>>>>>=20
>>>>> I have tried using single and double quotes around the file name =
but this does not help. Is there a way to use files that have spaces in =
it's name with drive_add?
>>>>=20
>>>> Not in HMP, which lacks quoting.  (Unless you want to patch HMP to =
learn
>>>> quoting)
>>>=20
>>> I think it's already got that code at least in some places.
>>> monitor_parse_arguments calls get_str, and get_str understands " =
wrapped
>>> arguments.
>>>=20
>>> drive_add 1 "file=3Dfoo bar"
>>>=20
>>> gives me:
>>> Could not open 'foo bar': No such file or directory
>>>=20
>>> so I think that's doing the right thing.
>>>=20
>>> Dave
>>>=20
>>>> But using spaces in filenames works fine in QMP.
>>>>=20
>>>> --=20
>>>> Eric Blake, Principal Software Engineer
>>>> Red Hat, Inc.           +1-919-301-3266
>>>> Virtualization:  qemu.org | libvirt.org
>>>>=20
>>>=20
>>>=20
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>=20
>> Thank you so much for this info. It solved my problem :)
>=20
> Now, the real challenge is how to deal with a filename with a comma =
in;
>   drive_add 1 "file=3Dfoo,bar"
>   Could not open 'foo': No such file or directory

I think the logical thing to do is not to depend on characters like =
spaces and commas to indicate a change in field. This would mean a =
change to how the user could specify arguments to a command. My first =
thought is to use a json-like syntax like this:

CMD: drive_add
File: <full path of file>
ID: mydrive

but this would still have the problem with newline characters in the =
file name. Spaces, commas, single and double quotes would be usable. =
Newline characters in file names are rare enough that we might consider =
ignoring this case altogether.=20

Another option is using a tag based system that would be able to handle =
every character. Something like this:

drive_add 0 <file> /users/user/some path </file> <id> mydrive </id>

The only way this system would fail if the text "</file>" was in the =
file name.=20

Any solutions you wish to share?=
