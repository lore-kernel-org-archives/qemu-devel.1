Received: from eggs.gnu.org ([2001:4830:134:3::10]:41488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fBN6y-0002DV-3X
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fBN6u-0003nI-Tq
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:17:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fBN6u-0003mf-Ny
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 12:17:36 -0400
From: Bandan Das <bsd@redhat.com>
References: <CAA-pg_qXZLDEHq6jMN_4GUrFvQgf0AS8Fs559JbucptK6_zrFw@mail.gmail.com>
	<20180425095657.GF30024@redhat.com>
	<CAA-pg_oDCGqVDzk67Rw4mL83SexPbt1eZ8AoSMux9Xjda8nUFg@mail.gmail.com>
Date: Wed, 25 Apr 2018 12:17:25 -0400
Message-ID: <jpg36zjntuy.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Filtering files passing through MTP devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Omer Katz <omer@kazuar-tech.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Omer Katz <omer@kazuar-tech.com> writes:

> We're connecting USB drives that we want the guests to copy files from.
> The user should only be allowed to copy certain files into the system.
> The same thing goes for copying files to the USB drive. We only allow
> certain files to be exported from the guest.

If I understand your problem correctly, this should be doable by plugging in
your logic into usb_mtp_write_data for the write side and usb_mtp_handle_da=
ta
for the read side. The write probably doesn't need a lot, you trigger an er=
ror
response the moment your data has something you don't want and discard the =
new file.
For the read, though, you probably have to read the whole file first,
which is not what the current code is doing (I think).

Apart from that dev-mtp.c is implementing a MTP server based on the MTP spe=
c and adding
something like this would be confusing, I also feel that this is too specif=
ic a usecase
and as Daniel said, there are perhaps simpler ways of doing it.

Bandan

> On Wed, Apr 25, 2018, 12:57 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
> wrote:
>
>> On Mon, Apr 23, 2018 at 03:10:32PM +0000, Omer Katz wrote:
>> > Hi everyone,
>> >
>> > We have a use case that requires us to only allow certain files to pass
>> > through to the guest machine from USB storage devices.
>> >
>> > I was told on IRC that such a feature does not exist but the easiest w=
ay
>> to
>> > achieve our goal is to contribute a patch the the MTP device driver si=
nce
>> > other drivers operate on a filesystem level instead of a file level wh=
ich
>> > is what we need.
>>
>> IMHO the easiest way to stop the guest accessing files is to simply not
>> put them in the directory that you are exporting the guest in the first
>> place. If you have a directory that has some files you don't want access=
ed
>> and can't remove them, then perhaps create a second directory and use
>> symlinks or hardlinks to pull in files from the original directory.
>>
>> > The plan is to pass the contents of each file to a program through std=
in
>> > and decide based on the exit code if the file should be allowed to pass
>> > through to the guest or not.
>>
>> I can't say I like this idea. It is a really very inefficient and heavy
>> solution.
>>
>> > Since this is the first time I'm contributing to QEMU I'd like some
>> > guidance to where the filtering code should be.
>> > https://github.com/qemu/qemu/blob/master/hw/usb/dev-mtp.c doesn't look
>> that
>> > complicated but I still need to understand it better to continue.
>> > Furthermore, I need to know where to add such a command line option to
>> > point QEMU to the filtering program.
>> >
>> > Would such a patch be accepted if all the requirements above are met?
>>
>> Can you explain the usage scenario you have in more details, rather than
>> just the high level abstract.
>>
>>
>> Regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-
>> https://www.flickr.com/photos/dberrange :|
>> |: https://libvirt.org         -o-
>> https://fstop138.berrange.com :|
>> |: https://entangle-photo.org    -o-
>> https://www.instagram.com/dberrange :|
>>
