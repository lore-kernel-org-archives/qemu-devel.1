Received: from eggs.gnu.org ([2001:4830:134:3::10]:36836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXk3N-0000k9-LF
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXk3M-0007JL-NZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:14:25 -0400
References: <20180625164239.13794-1-kwolf@redhat.com>
	<87h8lqkkrp.fsf@dusky.pond.sub.org>
	<424bb91d-a202-5c3b-1264-254cad0709d0@redhat.com>
	<20180626085324.GB32319@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2c966f0-22e9-1803-6a74-34d23851e704@redhat.com>
Date: Tue, 26 Jun 2018 11:14:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180626085324.GB32319@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb-storage: Add rerror/werror properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 26/06/2018 10:53, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jun 26, 2018 at 10:48:10AM +0200, Paolo Bonzini wrote:
>> On 26/06/2018 10:35, Markus Armbruster wrote:
>>> We also want to deprecate usb-storage, but
>>> I guess we're still not ready for that (it's a complicated story).
>>>
>>> To deprecate -drive without also deprecating usb-storage, we need to
>>> preserve features.
>>
>> Patch looks good to me too, but indeed why can't we deprecate
>> usb-storage in favor of usb-bot + scsi-disk?
>=20
> Presumably the migration state of usb-storage is different from the
> migration state of usb-bot + scsi-disk, so not a case where libvirt
> could silently switch from one to the other. It would need to be an
> explicit config change by apps/users.

>From a quick test, migrating

  qemu-kvm \
     -drive if=3Dnone,id=3Dusb,file=3D$HOME/chipsec.img,snapshot=3Don \
     -usb -device usb-storage,drive=3Dusb -M q35

into

  qemu-kvm \
     -drive if=3Dnone,id=3Dusb,file=3D$HOME/chipsec.img,snapshot=3Don \
     -usb -device usb-bot -device scsi-disk,drive=3Dusb -M q35

seems to work.  Both of them indeed use vmstate_usb_msd for
migration.

Paolo
