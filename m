Received: from eggs.gnu.org ([2001:4830:134:3::10]:37478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzLqS-0006aV-H6
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzLqN-0000B1-IN
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:58:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzLqN-0000A8-9y
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:58:35 -0400
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
	<20170711145441.33925-6-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d3f02459-af9f-d9d4-5d63-ea2a9f104cdd@redhat.com>
Date: Tue, 3 Oct 2017 13:58:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170711145441.33925-6-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/6] s390x/css: activate ChannelSubSys
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

On 11.07.2017 16:54, Halil Pasic wrote:
> Turn on migration for the channel subsystem for the next machine.  For
> legacy machines we still have to do things the old way.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/css.c             | 5 +++++
>  hw/s390x/s390-virtio-ccw.c | 9 ++++-----
>  include/hw/s390x/css.h     | 4 ++++
>  3 files changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 20b5fbed68..b89b60751a 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -407,6 +407,11 @@ static int subch_dev_post_load(void *opaque, int v=
ersion_id)
>      return 0;
>  }
> =20
> +void css_register_vmstate(void)
> +{
> +    vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
> +}
> +
>  IndAddr *get_indicator(hwaddr ind_addr, int len)
>  {
>      IndAddr *indicator;
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 751febb87a..20e3f06519 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -206,7 +206,7 @@ static void ccw_machine_class_init(ObjectClass *oc,=
 void *data)
> =20
>      s390mc->ri_allowed =3D true;
>      s390mc->cpu_model_allowed =3D true;
> -    s390mc->css_migration_enabled =3D false; /* TODO: set to true */
> +    s390mc->css_migration_enabled =3D true;
>      mc->init =3D ccw_init;
>      mc->reset =3D s390_machine_reset;
>      mc->hot_add_cpu =3D s390_hot_add_cpu;
> @@ -482,10 +482,9 @@ bool css_migration_enabled(void)
> =20
>  static void ccw_machine_2_10_instance_options(MachineState *machine)
>  {
> -    /*
> -     * TODO Once preparations are done register vmstate for the css if
> -     * css_migration_enabled().
> -     */
> +    if (css_migration_enabled()) {
> +        css_register_vmstate();
> +    }
>  }

The location for the above hunk seems to be quite unfortunate: For the
s390-ccw-virtio-2.11 machine, we now do not call css_register_vmstate()
anymore.

Maybe this should rather go into ccw_init() instead?

 Thomas
