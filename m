Received: from eggs.gnu.org ([209.51.188.92]:43437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hBwqt-0003jw-Jd
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hBwqs-00081k-En
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:31:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hBwqs-00080e-4E
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:31:58 -0400
Date: Thu, 4 Apr 2019 15:31:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190404073147.GC23212@xz-x1>
References: <1553010562-13561-1-git-send-email-catherine.hecx@gmail.com>
	<1554219001-18301-1-git-send-email-catherine.hecx@gmail.com>
	<20190403022532.GJ11008@xz-x1>
	<CAEn6zmG_m1-NP00cL+cZw2PYjErGrDXZLVV9mGNiU2w5EU=7Bg@mail.gmail.com>
	<20190404042503.GA23212@xz-x1>
	<CAEn6zmFBtRiaiHo3New2O-7=aWft2m8sbtzeRiYeeO_khrC0DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEn6zmFBtRiaiHo3New2O-7=aWft2m8sbtzeRiYeeO_khrC0DA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: avoid filling ignore-shared
 ramblock when in incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Catherine Ho <catherine.hecx@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Apr 04, 2019 at 03:17:41PM +0800, Catherine Ho wrote:
> Hi Peter Xu
>=20
> On Thu, 4 Apr 2019 at 12:25, Peter Xu <peterx@redhat.com> wrote:
>=20
> > On Wed, Apr 03, 2019 at 11:21:47PM +0800, Catherine Ho wrote:
> > > Hi Peter Xu
> > >
> > > On Wed, 3 Apr 2019 at 10:25, Peter Xu <peterx@redhat.com> wrote:
> > >
> > > > On Tue, Apr 02, 2019 at 11:30:01AM -0400, Catherine Ho wrote:
> > > > > Commit 18269069c310 ("migration: Introduce ignore-shared capabi=
lity")
> > > > > addes ignore-shared capability to bypass the shared ramblock (e=
,g,
> > > > > membackend + numa node). It does good to live migration.
> > > > >
> > > > > This commit expectes that QEMU doesn't write to guest RAM until
> > > > > VM starts, but it does on aarch64 qemu:
> > > > > Backtrace:
> > > > > 1  0x000055f4a296dd84 in address_space_write_rom_internal () at
> > > > exec.c:3458
> > > > > 2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3=
479
> > > > > 3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
> > > > > 4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset=
.c:69
> > > > > 5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
> > > > > 6  0x000055f4a2c9851d in main () at vl.c:4552
> > > > >
> > > > > Actually, on arm64 virt marchine, ramblock "dtb" will be filled=
 into
> > ram
> > > > > during rom_reset. In ignore-shared incoming case, this rom fill=
ing
> > > > > is not required since all the data has been stored in memory ba=
ckend
> > > > file.
> > > > >
> > > > > Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
> > > > capability")
> > > > > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> > > > > Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
> > > >
> > > > (note: IIUC normally you should have your signed-off to be the la=
st
> > > >  line before the suggested-by :)
> > > >
> > > > About the patch content, I have had a question on whether we shou=
ld
> > > > need to check ignore-shared at all... That question lies in:
> > > >
> > > > https://patchwork.kernel.org/patch/10859889/#22546487
> > > >
> > > > And if my understanding was correct above, IMHO the patch could b=
e as
> > > > simply be as "if (runstate_check(RUN_STATE_INMIGRATE)) return;" a=
t [1]
> > > > below.
> > > >
> > > >
> > > Thanks=EF=BC=8C but I thought this method would break the x86 rom_r=
eset logic
> > during
> > > RUN_STATE_INMIGRATE.
> > > Please see the debugging patch and log lines below:
> > > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > > index fe5cb24122..b0c871af26 100644
> > > --- a/hw/core/loader.c
> > > +++ b/hw/core/loader.c
> > > @@ -1086,8 +1086,9 @@ int rom_add_option(const char *file, int32_t
> > > bootindex)
> > >  static void rom_reset(void *unused)
> > >  {
> > >      Rom *rom;
> > > -
> > >      QTAILQ_FOREACH(rom, &roms, next) {
> > > +        if (runstate_check(RUN_STATE_INMIGRATE))
> > > +           printf("rom name=3D%s\n",rom->name);
> > >          if (rom->fw_file) {
> > >              continue;
> > >          }
> > >
> > > rom name=3Dkvmvapic.bin
> > > rom name=3Dlinuxboot_dma.bin
> > > rom name=3Dbios-256k.bin
> > > rom name=3Detc/acpi/tables
> > > rom name=3Detc/table-loader
> > > rom name=3Detc/acpi/rsdp
> >
> > Hi, Catherine,
> >
> > I only see that rom names were dumped.  Could you help explain what i=
s
> > broken?  Thanks,
> >
> Thanks for the suggestion. I haven't seen any obvious errors on x86 wit=
h
> this change.
> I merely consider not to change the old code logic too much.
> Ok, I will change it as you suggested if no more comments.

Yeah let's see whether others would have any opinion on that since so
far I don't see a problem (after all those ROM data should be migrated
from source later on no matter whether they were modified on source).

Regards,

--=20
Peter Xu
