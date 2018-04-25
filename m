Received: from eggs.gnu.org ([2001:4830:134:3::10]:35943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <omer@kazuar-tech.com>) id 1fBRJA-0000hC-RE
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <omer@kazuar-tech.com>) id 1fBRJ8-0006dK-W0
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:46:32 -0400
Received: from mail-lf0-x22f.google.com ([2a00:1450:4010:c07::22f]:39299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <omer@kazuar-tech.com>)
	id 1fBRJ8-0006cx-GK
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:46:30 -0400
Received: by mail-lf0-x22f.google.com with SMTP id j193-v6so4425289lfg.6
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 13:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAA-pg_qXZLDEHq6jMN_4GUrFvQgf0AS8Fs559JbucptK6_zrFw@mail.gmail.com>
	<20180425095657.GF30024@redhat.com>
	<CAA-pg_oDCGqVDzk67Rw4mL83SexPbt1eZ8AoSMux9Xjda8nUFg@mail.gmail.com>
	<jpg36zjntuy.fsf@linux.bootlegged.copy>
	<CAA-pg_rGtB_XVQ1+zWq3W7=SVMXJxoEOu9C7573pMNAA2yUb1g@mail.gmail.com>
	<jpgbme7f37y.fsf@linux.bootlegged.copy>
In-Reply-To: <jpgbme7f37y.fsf@linux.bootlegged.copy>
From: Omer Katz <omer@kazuar-tech.com>
Date: Wed, 25 Apr 2018 20:46:18 +0000
Message-ID: <CAA-pg_rvmi-qHgmvmhMznx1n6BgKNr+Uee7jJaY0ZreTqrXtsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Bandan Das <bsd@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

I didn't really want MTP. Someone suggested it on IRC.
What I really wanted is to be able to run my filters while using the normal
QEMU USB driver.
I'm not sure how MTP even works so I figured that before I learn anything
about MTP I'll check here to see if I can implement this easily and
contribute such a patch.
On Wed, Apr 25, 2018, 11:20 PM Bandan Das <bsd@redhat.com> wrote:

> Omer Katz <omer@kazuar-tech.com> writes:
>
> > What would be a simpler way to do this so that the guest machine would
> > still be able to recognize the USB drive?
> > Right now we're triggering a script whenever udev recognizes that a USB
> > drive is plugged in.
> > The script copies the allowed files to a certain folder. The guest has =
a
> > cron job that periodically triggers scp from that folder to the guest.
> > That's a very complicated flow and I just described only the flow which
> > files are imported. I even omitted some of the moving parts since they
> are
> > irrelevant.
> > Long story short our architecture is very complicated because of this
> > issue.
>
> If you are using a physical USB drive, where do you envision the emulated
> mtp share fits ? One way would be that your udev scripts only copies
> files that can be read to the mtp share. Similarly, it only copies back
> written files that accept a certain criteria from the share.
>
> Ofcourse, you can try out adding your filter hooks to dev-mtp.c as well
> if you think that seems more suited to your use case. I was just
> wondering whether reviewers will point it out as too specific. In the
> worst case, it will be a in-house change that you will have to maintain
> yourself.
>
> Bandan
>
> >
> > On Wed, Apr 25, 2018, 7:17 PM Bandan Das <bsd@redhat.com> wrote:
> >
> >> Omer Katz <omer@kazuar-tech.com> writes:
> >>
> >> > We're connecting USB drives that we want the guests to copy files
> from.
> >> > The user should only be allowed to copy certain files into the syste=
m.
> >> > The same thing goes for copying files to the USB drive. We only allo=
w
> >> > certain files to be exported from the guest.
> >>
> >> If I understand your problem correctly, this should be doable by
> plugging
> >> in
> >> your logic into usb_mtp_write_data for the write side and
> >> usb_mtp_handle_data
> >> for the read side. The write probably doesn't need a lot, you trigger =
an
> >> error
> >> response the moment your data has something you don't want and discard
> the
> >> new file.
> >> For the read, though, you probably have to read the whole file first,
> >> which is not what the current code is doing (I think).
> >>
> >> Apart from that dev-mtp.c is implementing a MTP server based on the MT=
P
> >> spec and adding
> >> something like this would be confusing, I also feel that this is too
> >> specific a usecase
> >> and as Daniel said, there are perhaps simpler ways of doing it.
> >>
> >> Bandan
> >>
> >> > On Wed, Apr 25, 2018, 12:57 PM Daniel P. Berrang=C3=A9 <
> berrange@redhat.com>
> >> > wrote:
> >> >
> >> >> On Mon, Apr 23, 2018 at 03:10:32PM +0000, Omer Katz wrote:
> >> >> > Hi everyone,
> >> >> >
> >> >> > We have a use case that requires us to only allow certain files t=
o
> >> pass
> >> >> > through to the guest machine from USB storage devices.
> >> >> >
> >> >> > I was told on IRC that such a feature does not exist but the
> easiest
> >> way
> >> >> to
> >> >> > achieve our goal is to contribute a patch the the MTP device driv=
er
> >> since
> >> >> > other drivers operate on a filesystem level instead of a file lev=
el
> >> which
> >> >> > is what we need.
> >> >>
> >> >> IMHO the easiest way to stop the guest accessing files is to simply
> not
> >> >> put them in the directory that you are exporting the guest in the
> first
> >> >> place. If you have a directory that has some files you don't want
> >> accessed
> >> >> and can't remove them, then perhaps create a second directory and u=
se
> >> >> symlinks or hardlinks to pull in files from the original directory.
> >> >>
> >> >> > The plan is to pass the contents of each file to a program throug=
h
> >> stdin
> >> >> > and decide based on the exit code if the file should be allowed t=
o
> >> pass
> >> >> > through to the guest or not.
> >> >>
> >> >> I can't say I like this idea. It is a really very inefficient and
> heavy
> >> >> solution.
> >> >>
> >> >> > Since this is the first time I'm contributing to QEMU I'd like so=
me
> >> >> > guidance to where the filtering code should be.
> >> >> > https://github.com/qemu/qemu/blob/master/hw/usb/dev-mtp.c doesn't
> >> look
> >> >> that
> >> >> > complicated but I still need to understand it better to continue.
> >> >> > Furthermore, I need to know where to add such a command line
> option to
> >> >> > point QEMU to the filtering program.
> >> >> >
> >> >> > Would such a patch be accepted if all the requirements above are
> met?
> >> >>
> >> >> Can you explain the usage scenario you have in more details, rather
> than
> >> >> just the high level abstract.
> >> >>
> >> >>
> >> >> Regards,
> >> >> Daniel
> >> >> --
> >> >> |: https://berrange.com      -o-
> >> >> https://www.flickr.com/photos/dberrange :|
> >> >> |: https://libvirt.org         -o-
> >> >> https://fstop138.berrange.com :|
> >> >> |: https://entangle-photo.org    -o-
> >> >> https://www.instagram.com/dberrange :|
> >> >>
> >>
>
