Received: from eggs.gnu.org ([209.51.188.92]:57039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hGRD6-00010V-TA
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hGRD4-0001BF-UR
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:45:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hGRD0-0000zj-WC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:45:25 -0400
From: Bandan Das <bsd@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<jpgk1fvp5wm.fsf@linux.bootlegged.copy>
	<20190415165426.GT5718@redhat.com> <20190416084059.GD31311@redhat.com>
	<jpglg0a3p93.fsf@linux.bootlegged.copy>
	<20190416161242.GU31311@redhat.com>
Date: Tue, 16 Apr 2019 12:45:04 -0400
In-Reply-To: <20190416161242.GU31311@redhat.com> ("Daniel P.
	\=\?utf-8\?Q\?Ber\?\= \=\?utf-8\?Q\?rang\=C3\=A9\=22's\?\=
	message of "Tue, 16 Apr 2019 17:12:42 +0100")
Message-ID: <jpgwojtoq5r.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Apr 16, 2019 at 12:10:16PM -0400, Bandan Das wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> ...
>> >> > The store is read only by default. Are you trying something like:
>> >> >  -device usb-mtp,rootdir=3D/code/mtpshare,readonly=3Dfalse ?
>> >>=20
>> >> Ah ha, I didn't realize I had to enable write support explicitly. Will
>> >> retry with that.
>> >
>> > Even after setting  readonly=3Dfalse, I still can't get "mtp-sendfile"
>> > to succeed in a guest.
>> >
>> I posted a patch for a bug introduced by a recent commit that made small=
er
>> file sizes return back with a incomplete file transfer.
>>=20
>> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02552.html
>
> Yes, I applied that and didn't see any difference in behaviour
>

Just noticed the error message you posted:

    Error sending file.
    Error 2: PTP Layer error 02ff: send_file_object_info(): Could not send =
object info.
    Error 2: Error 02ff: PTP I/O Error
    ERROR: Could not close session!

I can't find usb-mtp sending a "I/O error" on an error condition
for the objectinfo phase. It might be libmtp or even the command itself
failing for some reason. For incomplete transfer, I just checked, it's
spitting out the error message correctly as INCOMPLETE_FILE_TRANSFER.

With libmtp version 1.13 on a FC24 guest, here's the output:

$ mtp-sendfile test.txt test.img
libmtp version: 1.1.13

Device 0 (VID=3D46f4 and PID=3D0004) is UNKNOWN in libmtp v1.1.13.
Please report this VID/PID and the device model to the libmtp development t=
eam
ignoring libusb_claim_interface() =3D -6PTP_ERROR_IO: failed to open sessio=
n, trying again after resetting USB interface
LIBMTP libusb: Attempt to reset device
Sending test.txt to test.img
type: txt, 44
Sending file...
Progress: 322 of 322 (100%)
New file ID: 7

What guest is this ? I can try to reproduce.

> Regards,
> Daniel
