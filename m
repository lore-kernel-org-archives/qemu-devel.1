Received: from eggs.gnu.org ([2001:4830:134:3::10]:36300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cimZK-0004DX-W4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cimZI-0007yh-5r
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:32:15 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cimZH-0007y5-NH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:32:12 -0500
Received: by mail-lf0-x243.google.com with SMTP id z127so1619328lfa.2
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 10:32:11 -0800 (PST)
MIME-Version: 1.0
References: <945CA011AD5F084CBEA3E851C0AB28894B8C3A14@SHSMSX101.ccr.corp.intel.com>
	<575E92DB.3080904@linux.vnet.ibm.com> <20160615193019.GB7300@work-vm>
	<5761C092.5070702@linux.vnet.ibm.com> <20160616080520.GA2249@work-vm>
	<5762BFE5.9070906@linux.vnet.ibm.com> <20160616152221.GD2249@work-vm>
	<5762C739.7060806@linux.vnet.ibm.com> <20160616175433.GC19710@work-vm>
	<5762F348.5050105@linux.vnet.ibm.com> <20160616192439.GE19710@work-vm>
	<57631A00.4010703@linux.vnet.ibm.com>
In-Reply-To: <57631A00.4010703@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Feb 2017 18:31:58 +0000
Message-ID: <CAJ+F1CKZHyay9KDT=rCc-RUZ-awwgFvAKkMeBUZJ9um=L6fU-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Berger <stefanb@us.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "SERBAN,
	CRISTINA" <cs1731@att.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH,
	CHING C" <cs1815@att.com>

Hi

On Fri, Jun 17, 2016 at 1:29 AM Stefan Berger <stefanb@linux.vnet.ibm.com>
wrote:

> On 06/16/2016 03:24 PM, Dr. David Alan Gilbert wrote:
> > * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> >> On 06/16/2016 01:54 PM, Dr. David Alan Gilbert wrote:
> >>> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> >>>> On 06/16/2016 11:22 AM, Dr. David Alan Gilbert wrote:
> >>>>> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> >>>>>> On 06/16/2016 04:05 AM, Dr. David Alan Gilbert wrote:
> >>>>>>> * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> >>>>>>>> On 06/15/2016 03:30 PM, Dr. David Alan Gilbert wrote:
> >>>>>>> <snip>
> >>>>>>>
> >>>>>>>>> So what was the multi-instance vTPM proxy driver patch set abou=
t?
> >>>>>>>> That's for containers.
> >>>>>>> Why have the two mechanisms? Can you explain how the multi-instan=
ce
> >>>>>>> proxy works; my brief reading when I saw your patch series seemed
> >>>>>>> to suggest it could be used instead of CUSE for the non-container
> case.
> >>>>>> The multi-instance vtpm proxy driver basically works through usage
> of an
> >>>>>> ioctl() on /dev/vtpmx that is used to spawn a new front- and
> backend pair.
> >>>>>> The front-end is a new /dev/tpm%d device that then can be moved
> into the
> >>>>>> container (mknod + device cgroup setup). The backend is an
> anonymous file
> >>>>>> descriptor that is to be passed to a TPM emulator for reading TPM
> requests
> >>>>>> coming in from that /dev/tpm%d and returning responses to. Since i=
t
> is
> >>>>>> implemented as a kernel driver, we can hook it into the Linux
> Integrity
> >>>>>> Measurement Architecture (IMA) and have it be used by IMA in place
> of a
> >>>>>> hardware TPM driver. There's ongoing work in the area of
> namespacing support
> >>>>>> for IMA to have an independent IMA instance per container so that
> this can
> >>>>>> be used.
> >>>>>>
> >>>>>> A TPM does not only have a data channel (/dev/tpm%d) but also a
> control
> >>>>>> channel, which is primarily implemented in its hardware interface
> and is
> >>>>>> typically not fully accessible to user space. The vtpm proxy drive=
r
> _only_
> >>>>>> supports the data channel through which it basically relays TPM
> commands and
> >>>>>> responses from user space to the TPM emulator. The control channel
> is
> >>>>>> provided by the software emulator through an additional TCP or
> UnixIO socket
> >>>>>> or in case of CUSE through ioctls. The control channel allows to
> reset the
> >>>>>> TPM when the container/VM is being reset or set the locality of a
> command or
> >>>>>> retrieve the state of the vTPM (for suspend) and set the state of
> the vTPM
> >>>>>> (for resume) among several other things. The commands for the
> control
> >>>>>> channel are defined here:
> >>>>>>
> >>>>>>
> https://github.com/stefanberger/swtpm/blob/master/include/swtpm/tpm_ioctl=
.h
> >>>>>>
> >>>>>> For a container we would require that its management stack
> initializes and
> >>>>>> resets the vTPM when the container is rebooted. (These are typical=
ly
> >>>>>> operations that are done through pulses on the motherboard.)
> >>>>>>
> >>>>>> In case of QEMU we would need to have more access to the control
> channel,
> >>>>>> which includes initialization and reset of the vTPM, getting and
> setting its
> >>>>>> state for suspend/resume/migration, setting the locality of
> commands, etc.,
> >>>>>> so that all low-level functionality is accessible to the emulator
> (QEMU).
> >>>>>> The proxy driver does not help with this but we should use the swt=
pm
> >>>>>> implementation that either has that CUSE interface with control
> channel
> >>>>>> (through ioctls) or provides UnixIO and TCP sockets for the contro=
l
> channel.
> >>>>> OK, that makes sense; does the control interface need to be handled
> by QEMU
> >>>>> or by libvirt or both?
> >>>> The control interface needs to be handled primarily by QEMU.
> >>>>
> >>>> In case of the libvirt implementation I am running an external progr=
am
> >>>> swtpm_ioctl that uses the control channel to gracefully shut down an=
y
> >>>> existing running TPM emulator whose device name happens to have the
> same
> >>>> name as the device of the TPM emulator that is to be created. So it
> cleans
> >>>> up before starting a new TPM emulator just to make sure that that ne=
w
> TPM
> >>>> instance can be started. Detail...
> >>>>
> >>>>> Either way, I think you're saying that with your kernel interface +
> a UnixIO
> >>>>> socket you can avoid the CUSE stuff?
> >>>> So in case of QEMU you don't need that new kernel device driver --
> it's
> >>>> primarily meant for containers. For QEMU one would start the TPM
> emulator
> >>>> and make sure that QEMU has access to the data and control channels,
> which
> >>>> are now offered as
> >>>>
> >>>> - CUSE interface with ioctl
> >>>> - TCP + TCP
> >>>> - UnixIO + TCP
> >>>> - TCP + UnioIO
> >>>> - UnixIO + UnixIO
> >>>> - file descriptors passed from invoker
> >>> OK, I'm trying to remember back; I'll admit to not having
> >>> liked using CUSE, but didn't using TCP/Unix/fd for the actual TPM
> >>> side require a lot of code to add a qemu interface that wasn't
> >>> ioctl?
> >> Adding these additional interface to the TPM was a bigger effort, yes.
> > Right, so that code isn't in upstream qemu is it?
>
> I was talking about the TPM emulator side that has been extended like
> this, not QEMU.
>
>
Out of curiosity, did you do it (adding socket/fd channel) for qemu or for
other reasons?


> >
> >>> Doesn't using the kernel driver give you the benefit of both worlds,
> >>> i.e. the non-control side in QEMU is unchanged.
> >> Yes. I am not sure what you are asking, though. A control channel is
> >> necessary no matter what. The kernel driver talks to /dev/vtpm-<VM
> uuid> via
> >> a file descriptor and uses commands sent through ioctl for the control
> >> channel. Whether QEMU now uses an fd that is a UnixIO or TCP socket to
> send
> >> the commands to the TPM or an fd that uses CUSE, doesn't matter much o=
n
> the
> >> side of QEMU. The control channel may be a bit different when using
> ioctl
> >> versus an fd (for UnixIO or TCP) or ioctl. I am not sure why we would
> send
> >> commands through that vTPM proxy driver in case of QEMU rather than
> talking
> >> to the TPM emulator directly.
> > Right, so what I'm thinking is:
> >     a) QEMU talks to /dev/vtpm-whatever for the normal TPM stuff
> >        no/little code is needed to be added to qemu upstream for that
>
> If we talk to /dev/vtpm-whatever, then in my book we would talk to a
> CUSE TPM device. We have compatibility for that via fd passing from
> libvirt.
>

 /dev/vtpmx created devices are not CUSE devices, are they?

Could you explain why containers use the TPM proxy driver to create sw TPM,
and not CUSE? Perhaps that will clear some aspects.. I imagine that the
kernel can provide some data from the TPM proxy driver, via /sys, or even
use some functions (random etc)? A CUSE driver is opaque to the host
kernel, right?

I understand simulated hw TPM needs the additional control channel (the
iostl stuff), and so they can't use the TPM proxy, as it wouldn't give you
that extra channel. But containers could eventually use CUSE created
devices (if they didn't need the extra /sys or other interface), right?


> >     b) Then you talk to the control side via an fd/socket
> >        you need to add your existing code for that.
>
> Not sure what /dev/vtpm-whatever is. If you mean the vtpm proxy driver
> by it then I don't understand why we would need that dependency along
> with the complication of how the setup for this particular device needs
> to be done (run ioctl on /dev/vtpmx to get a front end device and
> backend device file descriptor which then has to be passed to the swtpm
> to read from and write to).
>

I think we would like to see it as simple as containers, but they require
different level of operations. If all of emulation would be in qemu there
would be no need for control channel, so the control interface depends on
what qemu and the tpm emulation process do. None of it required for swtpm &
containers, but hw emulation needs more. I

t looks like TPM kernel interface is only data read/write, the CUSE IOCTLs
are only for control IPC. If so then I think it's simpler, and more
portable, to go with a pure socket/fd based solution, since CUSE in this
qemu case doesn't bring much benefits afaict.

Btw, is there a need to synchronize data & control channel? (asking because
it's not obvious when you say you can have both channels using different
transport)


> >
> > So that doesn't depend on CUSE, it doesn't depend on your particular
>
> If it doesn't depend on CUSE, it depends on a rather novel device driver
> that doesn't need to be used in the QEMU case.
>

> > vTPM implementation (except for the control socket data, but then
> > hopefully that's pretty abstract); all good?
> Not sure I followed you above.
>
>
Hopefully I dind't add more confusion :)
Thanks


>     Stefan
>
> >
> > Dave
> >
> >>    Stefan
> >>
> >>> Dave
> >>>
> >>>>     Stefan
> >>>>
> >>> --
> >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
>
>
> --
Marc-Andr=C3=A9 Lureau
