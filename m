Received: from eggs.gnu.org ([2001:4830:134:3::10]:36828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e01IP-0000Jn-9W
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e01IM-0008H9-4M
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:14:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e01IL-0008GX-RY
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:14:14 -0400
Date: Thu, 5 Oct 2017 10:14:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171005101409.69fae5de.cohuck@redhat.com>
In-Reply-To: <7b42b017-e216-854f-a4a1-4393811cb69f@redhat.com>
References: <1507125199-22562-1-git-send-email-thuth@redhat.com>
	<b3bebf28-76e6-5a4c-3a4c-34b940f85fb9@linux.vnet.ibm.com>
	<7b42b017-e216-854f-a4a1-4393811cb69f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/sclp: Mark the sclp device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 4 Oct 2017 19:06:57 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 04.10.2017 17:18, Pierre Morel wrote:
> > On 04/10/2017 15:53, Thomas Huth wrote: =20
> >> The "sclp" device is just an internal device that can not be instantia=
ted
> >> by the users. If they try to use it, they only get a simple error
> >> message:
> >>
> >> $ qemu-system-s390x -nographic -device sclp
> >> qemu-system-s390x: Option '-device s390-sclp-event-facility' cannot be
> >> handled by this machine
> >>
> >> Since sclp_init() tries to create a TYPE_SCLP_EVENT_FACILITY which is
> >> a non-pluggable sysbus device, there is really no way that the "sclp"
> >> device can be used by the user, so let's set the user_creatable =3D fa=
lse
> >> accordingly.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >> =C2=A0 hw/s390x/sclp.c | 5 +++++
> >> =C2=A0 1 file changed, 5 insertions(+)
> >>
> >> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> >> index 30aefbf..9be0cb8 100644
> >> --- a/hw/s390x/sclp.c
> >> +++ b/hw/s390x/sclp.c
> >> @@ -606,6 +606,11 @@ static void sclp_class_init(ObjectClass *oc, void
> >> *data)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->realize =3D sclp_realize;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->hotpluggable =3D false;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc->categ=
ories);
> >> +=C2=A0=C2=A0=C2=A0 /*
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 * Reason: Creates TYPE_SCLP_EVENT_FACILITY i=
n sclp_init
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 * which is a non-pluggable sysbus device
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> +=C2=A0=C2=A0=C2=A0 dc->user_creatable =3D false;
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sc->read_SCP_info =3D read_SCP_info;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sc->read_storage_element0_info =3D read=
_storage_element0_info;
> >> =20
> >=20
> > I must miss something.
> > Why is the sclp device not a SYS_BUS_DEVICE ?
> > The problem seems to come from the heterogeneity of the sclp and sclp
> > generated devices. =20
>=20
> I wonder whether it should rather be the other way round: Why is
> TYPE_SCLP_EVENT_FACILITY a sysbus device? Sysbus is an abstraction for
> simple on-board devices, while TYPE_SCLP_EVENT_FACILITY seems rather to
> be a pseudo-device... so it should rather simply be of TYPE_DEVICE
> instead? Or do I miss something?

We do have a number of devices that are sysbus because you could not
have bus-less devices back then. We might want to convert them to a
simple TYPE_DEVICE, but this needs double-checking regarding resets and
other things and I'd rather not spend that much time on that right now.
