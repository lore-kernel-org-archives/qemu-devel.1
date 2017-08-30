Received: from eggs.gnu.org ([2001:4830:134:3::10]:34406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnA49-0005en-TK
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnA46-00043q-Qn
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:58:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23063)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnA46-00043a-Kp
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:58:22 -0400
References: <20170830170601.15855-1-david@redhat.com>
	<20170830170601.15855-4-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <09179efb-0930-bd84-ff22-1f4b23fa6a8e@redhat.com>
Date: Wed, 30 Aug 2017 22:58:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170830170601.15855-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 03/11] s390x: store cpu states inside
 machine state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

On 30.08.2017 19:05, David Hildenbrand wrote:
> Let's avoid global variables. While at it, move both functions using it=
,
> so we won't have to temporarily add includes (we'll be getting rid of
> s390-virtio.c soon).
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 39 ++++++++++++++++++++++++++++++=
++++++++
>  hw/s390x/s390-virtio.c             | 38 ------------------------------=
-------
>  hw/s390x/s390-virtio.h             |  1 -
>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>  4 files changed, 42 insertions(+), 39 deletions(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index dd504dd5ae..ffd56af834 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -32,6 +32,45 @@
>  #include "migration/register.h"
>  #include "cpu_models.h"
> =20
> +S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> +{
> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(qdev_get_machine());
> +
> +    if (cpu_addr >=3D max_cpus) {
> +        return NULL;
> +    }
> +
> +    /* Fast lookup via CPU ID */
> +    return ms->cpus[cpu_addr];
> +}

I wonder whether that function should rather go into a file in
target/s390x/ instead, since it is also used there and its prototype is
in cpu.h ?

[...]
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390=
-virtio-ccw.h
> index 41a9d2862b..4bef28ec39 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -21,11 +21,14 @@
>  #define S390_MACHINE_CLASS(klass) \
>      OBJECT_CLASS_CHECK(S390CcwMachineClass, (klass), TYPE_S390_CCW_MAC=
HINE)
> =20
> +struct S390CPU;

You define a "struct S390CPU" here ...

>  typedef struct S390CcwMachineState {
>      /*< private >*/
>      MachineState parent_obj;
> =20
>      /*< public >*/
> +    S390CPU **cpus;

... but use the typedef'ed S390CPU here ... looks somewhat suspicious, I
wonder whether the typedef is really in the right place?

>      bool aes_key_wrap;
>      bool dea_key_wrap;
>      uint8_t loadparm[8];

Anyway, that were just nits, I'm also fine with the patch as it is, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
