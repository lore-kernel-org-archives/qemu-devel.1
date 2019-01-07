Received: from eggs.gnu.org ([209.51.188.92]:44022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ggTlI-0007jY-8q
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1ggTlH-0004Zk-2x
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:12:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ggTlG-0004Yo-U6
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:12:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id t204so105430oie.7
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 04:12:06 -0800 (PST)
MIME-Version: 1.0
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-5-git-send-email-lizhijian@cn.fujitsu.com>
	<20181221110913-mutt-send-email-mst@kernel.org>
	<20181227203118.GA19442@habkost.net>
In-Reply-To: <20181227203118.GA19442@habkost.net>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 7 Jan 2019 13:11:54 +0100
Message-ID: <CAGxU2F5BAyKBmkUGiUO1DN18RXhovijvJVAEYzrPw1ZE+9xOyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 4/4] i386: allow to load initrd
 below 4G for recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel@nongnu.org, philip.li@intel.com, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Philippe Mathieu Daude <philmd@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi,

On Thu, Dec 27, 2018 at 9:32 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Fri, Dec 21, 2018 at 11:10:30AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Dec 06, 2018 at 10:32:13AM +0800, Li Zhijian wrote:
> > > a new field xloadflags was added to recent x86 linux, and BIT 1:
> > > XLF_CAN_BE_LOADED_ABOVE_4G is used to tell bootload that where initrd can be
> > > loaded safely.
> > >
> > > Current QEMU/BIOS always loads initrd below below_4g_mem_size which is always
> > > less than 4G, so here limiting initrd_max to 4G - 1 simply is enough if
> > > this bit is set.
> > >
> > > CC: Paolo Bonzini <pbonzini@redhat.com>
> > > CC: Richard Henderson <rth@twiddle.net>
> > > CC: Eduardo Habkost <ehabkost@redhat.com>
> > > CC: "Michael S. Tsirkin" <mst@redhat.com>
> > > CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > >
> > > ---
> > > V3: correct grammar and check XLF_CAN_BE_LOADED_ABOVE_4G first (Michael S. Tsirkin)
> > >
> > > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > > ---
> > >  hw/i386/pc.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index 3b10726..baa99c0 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -904,7 +904,15 @@ static void load_linux(PCMachineState *pcms,
> > >  #endif
> > >
> > >      /* highest address for loading the initrd */
> > > -    if (protocol >= 0x203) {
> > > +    if (protocol >= 0x20c &&
> > > +        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
> > > +        /*
> > > +         * Although kernel allows initrd loading to above 4G,
> > > +         * it just makes it as large as possible while still staying below 4G
> > > +         * since current BIOS always loads initrd below pcms->below_4g_mem_size
> > > +         */
> > > +        initrd_max = UINT32_MAX;
> > > +    } else if (protocol >= 0x203) {
> > >          initrd_max = ldl_p(header+0x22c);
> > >      } else {
> > >          initrd_max = 0x37ffffff;
> >
> >
> > I still have trouble understanding the above.
> > Anyone else wants to comment / help rephrase the comment
> > and commit log so it's readable?
>
>
> The comment seems to contradict what I see on the code:
>
> | Although kernel allows initrd loading to above 4G,
>
> Sounds correct.
>
>
> | it just makes it as large as possible while still staying below 4G
>
> I'm not a native English speaker, but I believe "it" here should
> be interpreted as "the kernel", which would be incorrect.  It's
> this QEMU function that limits initrd_max to a uint32 value, not
> the kernel.
>
>
> | since current BIOS always loads initrd below pcms->below_4g_mem_size
>
> I don't know why the BIOS is mentioned here.  The
> below_4g_mem_size limit comes from these 2 lines inside
> load_linux():
>
>     if (initrd_max >= pcms->below_4g_mem_size - pcmc->acpi_data_size) {
>         initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
>     }
> In addition to that, initrd_max is uint32_t simply because QEMU
> doesn't support the 64-bit boot protocol (specifically the
> ext_ramdisk_image field), so all talk about below_4g_mem_size
> seems to be just a distraction.
>
> All that said, I miss one piece of information here: is
> XLF_CAN_BE_LOADED_ABOVE_4G really supposed to override
> header+0x22c?  linux/Documentation/x86/boot.txt isn't clear about
> that.  Is there any reference that can help us confirm this?

Looking at the following patch seems that we can confirm the assumption:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=4bf7111f50167133a71c23530ca852a41355e739

Note: the patch was reverted due to bugs in some firmwares, but IMHO
the assumption is correct.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=47226ad4f4cfd1e91ded7f2ec42f83ff1c624663

Cheers,
Stefano

>
> --
> Eduardo
>
