Received: from eggs.gnu.org ([2001:4830:134:3::10]:39620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZIAd-0000ai-UN
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZIAa-0002dQ-Sg
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:47:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZIAa-0002cZ-J9
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:47:44 -0400
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
	<1497523981-38449-41-git-send-email-pbonzini@redhat.com>
	<CAJ+F1CJYp-13xa++8_p4g=bNKP3-JsB6-2ZoFRRo=DPPyEJaUw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <94411096-c925-caee-beff-ecc690865305@redhat.com>
Date: Sun, 23 Jul 2017 16:47:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJYp-13xa++8_p4g=bNKP3-JsB6-2ZoFRRo=DPPyEJaUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 40/41] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>

On 18/07/2017 18:32, Marc-Andr=C3=A9 Lureau wrote:
>=20
>=20
> On Thu, Jun 15, 2017 at 1:20 PM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>     From: Felipe Franciosi <felipe@nutanix.com <mailto:felipe@nutanix.c=
om>>
>=20
>     This commit introduces a vhost-user device for SCSI. This is based
>     on the existing vhost-scsi implementation, but done over vhost-user
>     instead. It also uses a chardev to connect to the backend. Unlike
>     vhost-scsi (today), VMs using vhost-user-scsi can be live migrated.
>=20
>     To use it, start Qemu with a command line equivalent to:
>=20
>     qemu-system-x86_64 \
>            -chardev socket,id=3Dvus0,path=3D/tmp/vus.sock \
>            -device vhost-user-scsi-pci,chardev=3Dvus0,bus=3Dpci.0,addr=3D=
...
>=20
>     A separate commit presents a sample application linked with libiscs=
i to
>     provide a backend for vhost-user-scsi.
>=20
>     Signed-off-by: Felipe Franciosi <felipe@nutanix.com
>     <mailto:felipe@nutanix.com>>
>     Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com
>     <mailto:1488479153-21203-4-git-send-email-felipe@nutanix.com>>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>>
>     ---
>=20
>=20
> I just realized the patch was missing qemu-options.hx update. Oh wait,
> virtio-scsi-pci isn't documented either?
>=20
> Would it have been possible to add a vhost-user-chr=3Dchr argument on
> virtio-scsi-pci instead of introducing a new device? Would that make
> sense (to share code, argument etc)?

No, it wouldn't make sense.

The reason is that vhost-scsi devices are configured entirely outside
QEMU, and for this reason vhost-scsi/vhost-user-scsi do not expose a
SCSI bus at the QEMU level.  They do share code (through the
virtio-scsi-common superclass), but they are fundamentally different.

The vhost-blk device probably would also be a separate class, for the
same reason.  There is no way to define a -drive option with a chardev
backend.

Even vhost-user-net is somewhat hackish in its use of -netdev in my
opinion, because it cannot implement ->receive (except for the RARP
hack) and it bypasses things such as filters and hubs.

Paolo
