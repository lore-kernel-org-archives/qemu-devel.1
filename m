Received: from eggs.gnu.org ([209.51.188.92]:38259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTVI-0001dM-R2
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTVE-0004uv-Vt
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:55:35 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggTVC-0004WU-IH
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:55:31 -0500
Received: by mail-ot1-x344.google.com with SMTP id n8so77238otl.6
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 11:55:15 +0000
Message-ID: <CAFEAcA9NGXRdbomKp+=ciUp9VWDOCaCpdq5+2V7U5_0RB-Fi8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/28] Machine props patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 4 Jan 2019 at 17:30, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 6395fe0c2c7d9f336d87960a7c9924b630c57c=
91:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-01-04 13:22:51 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/machine-props-pull-request
>
> for you to fetch changes up to e91feab787f901b831fe11ecffe0e2f5669da714:
>
>   hostmem: use object id for memory region name with >=3D 4.0 (2019-01-04=
 20:24:55 +0400)
>
> ----------------------------------------------------------------
> Generalize machine compatibility properties
>
> During "[PATCH v2 05/10] qom/globals: generalize
> object_property_set_globals()" review, Eduardo suggested to rework the
> GlobalProperty handling, so that -global is limited to QDev only and
> we avoid mixing the machine compats and the user-provided -global
> properties (instead of generalizing -global to various object kinds,
> like I proposed in v2).
>
> "qdev: do not mix compat props with global props" patch decouples a
> bit user-provided -global from machine compat properties. This allows
> to get rid of "user_provided" and "errp" fields in following patches.
>
> A new compat property "x-use-canonical-path-for-ramblock-id" is added
> to hostmem for legacy canonical path names, set to true for -file and
> -memfd with qemu < 4.0.
>
> (this series was initially titled "[PATCH v2 00/10] hostmem: use
> object "id" for memory region name with >=3D 3.1", but its focus is more
> in refactoring the global and compatilibity properties handling now)
>

Hi -- I get some compile failures here on Arm host builds:

In file included from /home/peter.maydell/qemu/target/arm/idau.h:31:0,
                 from /home/peter.maydell/qemu/target/arm/cpu.c:22:
/home/peter.maydell/qemu/target/arm/cpu.c: In function 'arm_host_initfn':
/home/peter.maydell/qemu/include/qom/object.h:518:5: error: passing
argument 1 of 'arm_cpu_post_init' from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
     ((type *)object_dynamic_cast_assert(OBJECT(obj), (name), \
     ^
/home/peter.maydell/qemu/target/arm/cpu-qom.h:32:5: note: in expansion
of macro 'OBJECT_CHECK'
     OBJECT_CHECK(ARMCPU, (obj), TYPE_ARM_CPU)
     ^
/home/peter.maydell/qemu/target/arm/cpu.c:2118:23: note: in expansion
of macro 'ARM_CPU'
     arm_cpu_post_init(ARM_CPU(obj));
                       ^
/home/peter.maydell/qemu/target/arm/cpu.c:743:6: note: expected
'Object * {aka struct Object *}' but argument is of type 'ARMCPU *
{aka struct ARMCPU *}'
 void arm_cpu_post_init(Object *obj)
      ^

This is a build failure only on Arm hosts because the relevant
code is inside #ifdef CONFIG_KVM. The following change is
sufficient to fix this:

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index baf430c..4c4e9e1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2115,7 +2115,7 @@ static void arm_host_initfn(Object *obj)
     ARMCPU *cpu =3D ARM_CPU(obj);

     kvm_arm_set_cpu_features_from_host(cpu);
-    arm_cpu_post_init(ARM_CPU(obj));
+    arm_cpu_post_init(obj);
 }

 static const TypeInfo host_arm_cpu_type_info =3D {

I'll leave it up to you to work out which commit it needs
to be squashed into.

thanks
-- PMM
