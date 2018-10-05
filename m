Received: from eggs.gnu.org ([2001:4830:134:3::10]:57062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g8PBc-0004bH-30
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g8P3L-0005oG-E0
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:18:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1g8P3L-0005o5-5y
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:17:55 -0400
References: <1538734535-7483-1-git-send-email-thuth@redhat.com>
	<7381a5a1-07f5-f79a-177d-cd39bce5a52e@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a90da631-1b38-7cc3-8200-521128199264@redhat.com>
Date: Fri, 5 Oct 2018 14:17:46 +0200
MIME-Version: 1.0
In-Reply-To: <7381a5a1-07f5-f79a-177d-cd39bce5a52e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Compile only once,
 not for each target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10/05/18 12:49, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 10/5/18 12:15 PM, Thomas Huth wrote:
>> The generic-loader is currently compiled target specific due to one
>> single "#ifdef TARGET_WORDS_BIGENDIAN" in the file. We've already
>> got a function called target_words_bigendian() for this instead, so
>> we can put the generic-loader into common-obj to save some compilation
>> time.
>=20
> Please do this in 2 patches:
> - clean the target_words_bigendian() mess, if possible documenting the
> new function added in "qom/cpu.h"
> - then move generic-loader to common
>=20
> Is the comment added in 8e4a424b305 still valid?
>=20
> /*
>  * A helper function for the _utterly broken_ virtio device model to
> find out if
>  * it's running on a big endian machine. Don't do this at home kids!
>  */
> bool target_words_bigendian(void);

Yeah, that comment irks me too.

Not that it isn't valid, necessarily. "hw/virtio/virtio.c" still
features an embedded declaration of this function. Just above
virtio_default_endian(), which calls it. And the latter function is
called in several places (mostly from commit 616a655219a92).

So I can't really tell what's "utterly broken" here -- the device model
(i.e., the virtio implementation in QEMU), or the legacy *spec* that
required QEMU to jump through such hoops?

(Either way, the embedded declaration of the function should go.)

BTW, I don't think angry comments are useful in *code*. They look & feel
great for about a week. In a year, they just look unprofessional. (NB,
this is not about "political correctness"; it's just that, when someone
reads such a comment, they receive the anger *before* they understand,
or recall, the underlying problem.)

(Don't mean to derail Thomas's patch with some bikeshedding here...)

Thanks,
Laszlo

>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  exec.c                   | 1 -
>>  hw/core/Makefile.objs    | 2 +-
>>  hw/core/generic-loader.c | 6 +-----
>>  hw/virtio/virtio.c       | 1 -
>>  include/qom/cpu.h        | 2 ++
>>  qom/cpu.c                | 1 -
>>  6 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/exec.c b/exec.c
>> index d0821e6..3ae0e54 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -3910,7 +3910,6 @@ int qemu_target_page_bits_min(void)
>>   * A helper function for the _utterly broken_ virtio device model to =
find out if
>>   * it's running on a big endian machine. Don't do this at home kids!
>>   */
>> -bool target_words_bigendian(void);
>>  bool target_words_bigendian(void)
>>  {
>>  #if defined(TARGET_WORDS_BIGENDIAN)
>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>> index eb88ca9..b736ce2 100644
>> --- a/hw/core/Makefile.objs
>> +++ b/hw/core/Makefile.objs
>> @@ -20,6 +20,6 @@ common-obj-$(CONFIG_SOFTMMU) +=3D register.o
>>  common-obj-$(CONFIG_SOFTMMU) +=3D or-irq.o
>>  common-obj-$(CONFIG_SOFTMMU) +=3D split-irq.o
>>  common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
>> +common-obj-$(CONFIG_SOFTMMU) +=3D generic-loader.o
>> =20
>> -obj-$(CONFIG_SOFTMMU) +=3D generic-loader.o
>>  obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
>> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
>> index be29ae1..fbae05f 100644
>> --- a/hw/core/generic-loader.c
>> +++ b/hw/core/generic-loader.c
>> @@ -130,11 +130,7 @@ static void generic_loader_realize(DeviceState *d=
ev, Error **errp)
>>          s->cpu =3D first_cpu;
>>      }
>> =20
>> -#ifdef TARGET_WORDS_BIGENDIAN
>> -    big_endian =3D 1;
>> -#else
>> -    big_endian =3D 0;
>> -#endif
>> +    big_endian =3D target_words_bigendian();
>> =20
>>      if (s->file) {
>>          AddressSpace *as =3D s->cpu ? s->cpu->as :  NULL;
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 94f5c8e..4e61944 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -1169,7 +1169,6 @@ int virtio_set_status(VirtIODevice *vdev, uint8_=
t val)
>>      return 0;
>>  }
>> =20
>> -bool target_words_bigendian(void);
>>  static enum virtio_device_endian virtio_default_endian(void)
>>  {
>>      if (target_words_bigendian()) {
>> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
>> index dc130cd..0e2ce80 100644
>> --- a/include/qom/cpu.h
>> +++ b/include/qom/cpu.h
>> @@ -1085,6 +1085,8 @@ void cpu_exec_initfn(CPUState *cpu);
>>  void cpu_exec_realizefn(CPUState *cpu, Error **errp);
>>  void cpu_exec_unrealizefn(CPUState *cpu);
>> =20
>> +bool target_words_bigendian(void);
>> +
>>  #ifdef NEED_CPU_H
>> =20
>>  #ifdef CONFIG_SOFTMMU
>> diff --git a/qom/cpu.c b/qom/cpu.c
>> index 92599f3..f774654 100644
>> --- a/qom/cpu.c
>> +++ b/qom/cpu.c
>> @@ -194,7 +194,6 @@ static bool cpu_common_debug_check_watchpoint(CPUS=
tate *cpu, CPUWatchpoint *wp)
>>      return true;
>>  }
>> =20
>> -bool target_words_bigendian(void);
>>  static bool cpu_common_virtio_is_big_endian(CPUState *cpu)
>>  {
>>      return target_words_bigendian();
>>
>=20
