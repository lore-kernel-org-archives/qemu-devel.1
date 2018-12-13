Received: from eggs.gnu.org ([2001:4830:134:3::10]:52908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXRuB-0000Up-VL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXRuA-0006Mp-L2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:23:59 -0500
References: <20181212220410.569069-1-eblake@redhat.com>
	<CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
	<20181213104704.GD5171@redhat.com>
	<20181213140513.GD5427@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <675b2641-a082-eeba-7584-602c16c7c259@redhat.com>
Date: Thu, 13 Dec 2018 08:23:43 -0600
MIME-Version: 1.0
In-Reply-To: <20181213140513.GD5427@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC] qemu-io: Prefer stderr
 for error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Nir Soffer <nsoffer@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 12/13/18 8:05 AM, Kevin Wolf wrote:
> Am 13.12.2018 um 11:47 hat Daniel P. Berrang=C3=A9 geschrieben:
>> On Thu, Dec 13, 2018 at 01:52:29AM +0200, Nir Soffer wrote:
>>> On Thu, Dec 13, 2018 at 12:13 AM Eric Blake <eblake@redhat.com> wrote=
:
>>>>
>>>> When a qemu-io command fails, it's best if the failure message
>>>> goes to stderr rather than stdout.
>>>
>>> This makes sense, but it will break users like this:
>>>
>>> https://github.com/oVirt/vdsm/blob/a2836b1d58ffaa0f48cc9c814b6002161a=
81f044/tests/storage/qemuio.py#L45
>>>
>>> We need a way to detect qemu-io verification failures, maybe a specia=
l
>>> exit code?
>>>
>>> 0 - verification succeeded
>>> 1 - verification failed
>>> 2 - other error (e.g no such file)
>>
>> This makes sense. We should *never* expect applications to parse the
>> messages on stdout/err, because we reserve the right to change text
>> arbitrarily at any time. So we need to use exit status IMHO.
>=20
> qemu-io processes more than just a single command. What would the exit
> code be if one of the commands succeeds, one gets an I/O error, and the
> third one succeeds for I/O, but fails pattern verification?
>=20
> The things is, qemu-io was never meant to be used by other
> applications that need to process the results, it's a tool for testing
> and debugging. If we had meant it to be used by other programs, we woul=
d
> have given it a machine-friendly interface.
>=20
> The machine-friendly interface to the QEMU block layer is qemu-nbd.
>=20
>>> Or, if qemu-io had a way to read data and write it to stdout, we coul=
d
>>> compare the data and avoid the need for special exit code.
>>
>> That should be trivial to do, and quite desirable too IMHO - libvirt w=
ould
>> in fact quite like such a feature, as it would let us support format
>> conversions when using our upload/download APIs, without having to cre=
ate
>> intermediate files.  Alternatively 'qemu-img convert' could allow for
>> /dev/stdin and /dev/stdout as raw files, but that looks considerably
>> harder to implement.
>>
>> For your usecase that feels rather inefficient as you're introducing
>> multiple data copies, which will be bad for large images. Much better
>> if we just make qemu-io set good exit codes.
>=20
> 'read -v' produces a hex dump on stdout, but you still need to separate
> it from the other output and then parse the hexdump.
>=20
> The human interface of qemu-io is honestly just not the right tool for
> the job, and adding one-off tweaks to make it a little bit less horribl=
e
> to use for machines isn't the right approach because it's still not a
> proper machine protocol.

I actually agree with that sentiment - qemu-io is NOT a program where we=20
promise backwards compatibility (we're not going to break it without=20
reason, because we DO have to keep iotests running, but outside of=20
iotests, we are less concerned if other uses break).

But it DOES sound like teaching 'qemu-img convert' to optionally convert=20
only a subset of a file may be useful (I already tried once to make=20
'qemu-img dd' smarter, and the conclusion at the time is that it would=20
be better to just make qemu-img dd be syntactic sugar for a=20
full-featured qemu-img convert, which means making convert take an=20
offset and range limit to the source, as well as a separate offset into=20
the destination, for easily extracting portions of one file into=20
portions of another).  And I also agree that qemu-nbd already has offset=20
and range support.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
