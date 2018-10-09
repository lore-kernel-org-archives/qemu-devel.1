Received: from eggs.gnu.org ([2001:4830:134:3::10]:58267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9lEL-0005Kb-F8
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9lEG-0005Tb-Ix
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:10:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g9lEG-0005TI-9F
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:10:48 -0400
References: <20181009060835.4608-1-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <02e87415-413e-656e-b1d0-568f7dcabc50@redhat.com>
Date: Tue, 9 Oct 2018 08:10:42 +0200
MIME-Version: 1.0
In-Reply-To: <20181009060835.4608-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ssi-sd: Make devices picking up
 backends unavailable with -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@redhat.com

On 2018-10-09 08:08, Markus Armbruster wrote:
> Device models aren't supposed to go on fishing expeditions for
> backends.  They should expose suitable properties for the user to set.
> For onboard devices, board code sets them.
>=20
> Device ssi-sd picks up its block backend in its init() method with
> drive_get_next() instead.  This mistake is already marked FIXME since
> commit af9e40a.
>=20
> Unset user_creatable to remove the mistake from our external
> interface.  Since the SSI bus doesn't support hotplug, only -device
> can be affected.  Only certain ARM machines have ssi-sd and provide an
> SSI bus for it; this patch breaks -device ssi-sd for these machines.
> No actual use of -device ssi-sd is known.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2:
> * Rebase to master
> * Improve commit message
>=20
>  hw/sd/ssi-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 95a143bfba..623d0333e8 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -284,6 +284,8 @@ static void ssi_sd_class_init(ObjectClass *klass, v=
oid *data)
>      k->cs_polarity =3D SSI_CS_LOW;
>      dc->vmsd =3D &vmstate_ssi_sd;
>      dc->reset =3D ssi_sd_reset;
> +    /* Reason: init() method uses drive_get_next() */
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo ssi_sd_info =3D {
>=20

Acked-by: Thomas Huth <thuth@redhat.com>
