Received: from eggs.gnu.org ([2001:4830:134:3::10]:44863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gS3y7-0002Vp-Mz
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gS3y2-0004ux-LU
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:49:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gS3y0-0004gV-Oi
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:49:42 -0500
Date: Wed, 28 Nov 2018 18:49:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181128184933.66391782@redhat.com>
In-Reply-To: <20181127092801.21777-16-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-16-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 15/28] hw: apply accel compat
 properties without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Andreas =?UTF-8?B?RsOkcmJl?= =?UTF-8?B?cg==?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

On Tue, 27 Nov 2018 13:27:48 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Introduce object_apply_global_props() function, to apply compatibility
> properties from a GPtrArray.
>=20
> For accel compatibility properties, apply them during
> device_post_init(), after accel_register_compat_props() has set them.
>=20
> To populate the compatibility properties, introduce SET_COMPAT(), a
> more generic version of SET_MACHINE_COMPAT() that can set compat
> properties on other objects than Machine, and using GPtrArray.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/qdev-core.h | 13 +++++++++++++
>  include/qom/object.h   |  3 +++
>  include/sysemu/accel.h |  4 +---
>  accel/accel.c          | 12 ------------
>  hw/core/qdev.c         | 11 +++++++++++
>  hw/xen/xen-common.c    | 38 +++++++++++++++++++-------------------
>  qom/object.c           | 25 +++++++++++++++++++++++++
>  vl.c                   |  2 +-
>  8 files changed, 73 insertions(+), 35 deletions(-)
>=20
[...]

> diff --git a/vl.c b/vl.c
> index fa25d1ae2d..c06e94271c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2963,7 +2963,7 @@ static void user_register_global_props(void)
>   */
>  static void register_global_properties(MachineState *ms)
>  {
> -    accel_register_compat_props(ms->accelerator);
> +    accel_register_compat_props(ACCEL_GET_CLASS(ms->accelerator)->compat=
_props);
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Acceptable way to do above is:
 Foo *foo =3DCAST(something)
 FUNC(foo->member)
if I recall correctly

>      machine_register_compat_props(ms);
>      user_register_global_props();
>  }
