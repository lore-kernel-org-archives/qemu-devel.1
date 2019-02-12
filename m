Received: from eggs.gnu.org ([209.51.188.92]:53082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gtXcb-0004bM-Ea
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gtXVE-0001H7-PV
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:49:35 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:43325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gtXVA-00017W-NQ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:49:31 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190211131731.GE2627@work-vm>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
	<20190204130958.18904-4-yury-kotov@yandex-team.ru>
	<20190211131731.GE2627@work-vm>
MIME-Version: 1.0
Date: Tue, 12 Feb 2019 15:49:19 +0300
Message-Id: <196271549975759@iva8-f16495710718.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] tests/migration-test: Add a test
 for ignore-shared capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>

11.02.2019, 16:17, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>> =C2=A0---
>> =C2=A0=C2=A0tests/migration-test.c | 109 +++++++++++++++++++++++++++++=
++++--------
>> =C2=A0=C2=A01 file changed, 89 insertions(+), 20 deletions(-)
>>
>> =C2=A0diff --git a/tests/migration-test.c b/tests/migration-test.c
>> =C2=A0index 8352612364..485f42b2d2 100644
>> =C2=A0--- a/tests/migration-test.c
>> =C2=A0+++ b/tests/migration-test.c
>> =C2=A0@@ -332,6 +332,13 @@ static void cleanup(const char *filename)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(path);
>> =C2=A0=C2=A0}
>>
>> =C2=A0+static char *get_shmem_opts(const char *mem_size, const char *s=
hmem_path)
>> =C2=A0+{
>> =C2=A0+ return g_strdup_printf("-object memory-backend-file,id=3Dmem0,=
size=3D%s"
>> =C2=A0+ ",mem-path=3D%s,share=3Don -numa node,memdev=3Dmem0",
>> =C2=A0+ mem_size, shmem_path);
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0static void migrate_check_parameter(QTestState *who, const=
 char *parameter,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0long long value)
>> =C2=A0=C2=A0{
>> =C2=A0@@ -430,73 +437,91 @@ static void migrate_postcopy_start(QTestSt=
ate *from, QTestState *to)
>> =C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0static int test_migrate_start(QTestState **from, QTestStat=
e **to,
>> =C2=A0- const char *uri, bool hide_stderr)
>> =C2=A0+ const char *uri, bool hide_stderr,
>> =C2=A0+ bool use_shmem)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gchar *cmd_src, *cmd_dst;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *bootpath =3D g_strdup_printf=
("%s/bootsect", tmpfs);
>> =C2=A0+ char *extra_opts =3D NULL;
>> =C2=A0+ char *shmem_path =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *arch =3D qtest_get_arc=
h();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *accel =3D "kvm:tcg";
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0got_stop =3D false;
>>
>> =C2=A0+ if (use_shmem) {
>> =C2=A0+ shmem_path =3D g_strdup_printf("/dev/shm/qemu-%d", getpid());
>> =C2=A0+ }
>
> I think /dev/shm is non-portable; so I think you'll need to have a way
> to skip the test on OSs that don't have it.
>

Ok, will fix in v3.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (strcmp(arch, "i386") =3D=3D 0 =
|| strcmp(arch, "x86_64") =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_bootf=
ile(bootpath, x86_bootsect);
>> =C2=A0+ extra_opts =3D use_shmem ? get_shmem_opts("150M", shmem_path) =
: NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_src =3D=
 g_strdup_printf("-machine accel=3D%s -m 150M"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -n=
ame source,debug-threads=3Don"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -s=
erial file:%s/src_serial"
>> =C2=A0- " -drive file=3D%s,format=3Draw",
>> =C2=A0- accel, tmpfs, bootpath);
>> =C2=A0+ " -drive file=3D%s,format=3Draw %s",
>> =C2=A0+ accel, tmpfs, bootpath,
>> =C2=A0+ extra_opts ? extra_opts : "");
>
> It's painful to have to use the ?: here as well as above where you set
> extra_opts, but I guess you need to, to allow you to free extra_opts
> below.
>

I'll think how to write it more clear. May be it's better to g_strdup("")
instead of NULL to eliminate some of ?:.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_dst =3D=
 g_strdup_printf("-machine accel=3D%s -m 150M"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -n=
ame target,debug-threads=3Don"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -s=
erial file:%s/dest_serial"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -d=
rive file=3D%s,format=3Draw"
>> =C2=A0- " -incoming %s",
>> =C2=A0- accel, tmpfs, bootpath, uri);
>> =C2=A0+ " -incoming %s %s",
>> =C2=A0+ accel, tmpfs, bootpath, uri,
>> =C2=A0+ extra_opts ? extra_opts : "");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0start_addr=
ess =3D X86_TEST_MEM_START;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0end_addres=
s =3D X86_TEST_MEM_END;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (g_str_equal(arch, "s390=
x")) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_bootf=
ile_s390x(bootpath);
>> =C2=A0+ extra_opts =3D use_shmem ? get_shmem_opts("128M", shmem_path) =
: NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_src =3D=
 g_strdup_printf("-machine accel=3D%s -m 128M"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -n=
ame source,debug-threads=3Don"
>> =C2=A0- " -serial file:%s/src_serial -bios %s",
>> =C2=A0- accel, tmpfs, bootpath);
>> =C2=A0+ " -serial file:%s/src_serial -bios %s %s",
>> =C2=A0+ accel, tmpfs, bootpath,
>> =C2=A0+ extra_opts ? extra_opts : "");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_dst =3D=
 g_strdup_printf("-machine accel=3D%s -m 128M"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -n=
ame target,debug-threads=3Don"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -s=
erial file:%s/dest_serial -bios %s"
>> =C2=A0- " -incoming %s",
>> =C2=A0- accel, tmpfs, bootpath, uri);
>> =C2=A0+ " -incoming %s %s",
>> =C2=A0+ accel, tmpfs, bootpath, uri,
>> =C2=A0+ extra_opts ? extra_opts : "");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0start_addr=
ess =3D S390_TEST_MEM_START;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0end_addres=
s =3D S390_TEST_MEM_END;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (strcmp(arch, "ppc64") =3D=
=3D 0) {
>> =C2=A0+ extra_opts =3D use_shmem ? get_shmem_opts("256M", shmem_path) =
: NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_src =3D=
 g_strdup_printf("-machine accel=3D%s -m 256M -nodefaults"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -n=
ame source,debug-threads=3Don"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -s=
erial file:%s/src_serial"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -p=
rom-env 'use-nvramrc?=3Dtrue' -prom-env "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"'nv=
ramrc=3Dhex .\" _\" begin %x %x "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"do =
i c@ 1 + i c! 1000 +loop .\" B\" 0 "
>> =C2=A0- "until'", accel, tmpfs, end_address,
>> =C2=A0- start_address);
>> =C2=A0+ "until' %s", accel, tmpfs, end_address,
>> =C2=A0+ start_address, extra_opts ? extra_opts : "");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_dst =3D=
 g_strdup_printf("-machine accel=3D%s -m 256M"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -n=
ame target,debug-threads=3Don"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" -s=
erial file:%s/dest_serial"
>> =C2=A0- " -incoming %s",
>> =C2=A0- accel, tmpfs, uri);
>> =C2=A0+ " -incoming %s %s",
>> =C2=A0+ accel, tmpfs, uri,
>> =C2=A0+ extra_opts ? extra_opts : "");
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0start_addr=
ess =3D PPC_TEST_MEM_START;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0end_addres=
s =3D PPC_TEST_MEM_END;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (strcmp(arch, "aarch64")=
 =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_bootf=
ile(bootpath, aarch64_kernel);
>> =C2=A0+ extra_opts =3D use_shmem ? get_shmem_opts("150M", shmem_path) =
: NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_src =3D=
 g_strdup_printf("-machine virt,accel=3D%s,gic-version=3Dmax "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"-na=
me vmsource,debug-threads=3Don -cpu max "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"-m =
150M -serial file:%s/src_serial "
>> =C2=A0- "-kernel %s ",
>> =C2=A0- accel, tmpfs, bootpath);
>> =C2=A0+ "-kernel %s %s",
>> =C2=A0+ accel, tmpfs, bootpath,
>> =C2=A0+ extra_opts ? extra_opts : "");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd_dst =3D=
 g_strdup_printf("-machine virt,accel=3D%s,gic-version=3Dmax "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"-na=
me vmdest,debug-threads=3Don -cpu max "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"-m =
150M -serial file:%s/dest_serial "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"-ke=
rnel %s "
>> =C2=A0- "-incoming %s ",
>> =C2=A0- accel, tmpfs, bootpath, uri);
>> =C2=A0+ "-incoming %s %s",
>> =C2=A0+ accel, tmpfs, bootpath, uri,
>> =C2=A0+ extra_opts ? extra_opts : "");
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0start_addr=
ess =3D ARM_TEST_MEM_START;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0end_addres=
s =3D ARM_TEST_MEM_END;
>> =C2=A0@@ -507,6 +532,7 @@ static int test_migrate_start(QTestState **f=
rom, QTestState **to,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(bootpath);
>> =C2=A0+ g_free(extra_opts);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (hide_stderr) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gchar *tmp=
;
>> =C2=A0@@ -524,6 +550,16 @@ static int test_migrate_start(QTestState **=
from, QTestState **to,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*to =3D qtest_init(cmd_dst);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(cmd_dst);
>> =C2=A0+
>> =C2=A0+ /*
>> =C2=A0+ * Remove shmem file immediately to avoid memory leak in test f=
ailed case.
>> =C2=A0+ * It's valid becase QEMU has already opened this file
>> =C2=A0+ */
>> =C2=A0+ if (use_shmem) {
>> =C2=A0+ unlink(shmem_path);
>> =C2=A0+ g_free(shmem_path);
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>> =C2=A0=C2=A0}
>>
>> =C2=A0@@ -603,7 +639,7 @@ static int migrate_postcopy_prepare(QTestSta=
te **from_ptr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *uri =3D g_strdup_printf("uni=
x:%s/migsocket", tmpfs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QTestState *from, *to;
>>
>> =C2=A0- if (test_migrate_start(&from, &to, uri, hide_error)) {
>> =C2=A0+ if (test_migrate_start(&from, &to, uri, hide_error, false)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -720,7 +756,7 @@ static void test_baddest(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *status;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool failed;
>>
>> =C2=A0- if (test_migrate_start(&from, &to, "tcp:0:0", true)) {
>> =C2=A0+ if (test_migrate_start(&from, &to, "tcp:0:0", true, false)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0migrate(from, "tcp:0:0", "{}");
>> =C2=A0@@ -745,7 +781,7 @@ static void test_precopy_unix(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char *uri =3D g_strdup_printf("uni=
x:%s/migsocket", tmpfs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QTestState *from, *to;
>>
>> =C2=A0- if (test_migrate_start(&from, &to, uri, false)) {
>> =C2=A0+ if (test_migrate_start(&from, &to, uri, false, false)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -781,6 +817,38 @@ static void test_precopy_unix(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g_free(uri);
>> =C2=A0=C2=A0}
>>
>> =C2=A0+static void test_ignore_shared(void)
>> =C2=A0+{
>> =C2=A0+ char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
>> =C2=A0+ QTestState *from, *to;
>> =C2=A0+
>> =C2=A0+ if (test_migrate_start(&from, &to, uri, false, true)) {
>> =C2=A0+ return;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ migrate_set_capability(from, "x-ignore-shared", true);
>> =C2=A0+ migrate_set_capability(to, "x-ignore-shared", true);
>> =C2=A0+
>> =C2=A0+ /* Wait for the first serial output from the source */
>> =C2=A0+ wait_for_serial("src_serial");
>> =C2=A0+
>> =C2=A0+ migrate(from, uri, "{}");
>> =C2=A0+
>> =C2=A0+ wait_for_migration_pass(from);
>> =C2=A0+
>> =C2=A0+ if (!got_stop) {
>> =C2=A0+ qtest_qmp_eventwait(from, "STOP");
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ qtest_qmp_eventwait(to, "RESUME");
>> =C2=A0+
>> =C2=A0+ wait_for_serial("dest_serial");
>> =C2=A0+ wait_for_migration_complete(from);
>> =C2=A0+
>> =C2=A0+ test_migrate_end(from, to, true);
>> =C2=A0+ g_free(uri);
>
> Can we reliably look at the migration stats and see if we've
> not transferred the shared data to make sure?
>

Agree, it makes sense, I'll add this check in v3.

> Dave
>
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0=C2=A0int main(int argc, char **argv)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char template[] =3D "/tmp/migratio=
n-test-XXXXXX";
>> =C2=A0@@ -832,6 +900,7 @@ int main(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/migration/depreca=
ted", test_deprecated);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/migration/bad_des=
t", test_baddest);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/migration/precopy=
/unix", test_precopy_unix);
>> =C2=A0+ qtest_add_func("/migration/ignore_shared", test_ignore_shared)=
;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D g_test_run();
>>
>> =C2=A0--
>> =C2=A02.20.1
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Yury
