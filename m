Received: from eggs.gnu.org ([2001:4830:134:3::10]:46880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gMDiv-0001mx-C2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gMDij-0004WL-0n
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:01:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gMDii-0004Um-Dz
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:01:44 -0500
Date: Mon, 12 Nov 2018 10:01:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181112095815-mutt-send-email-mst@kernel.org>
References: <20181016175236.5840-1-peter.maydell@linaro.org>
	<CAFEAcA_PZ6XDz70tbRJM8dJZQYUg=F23cmmXpc=PZC5=eP17Ew@mail.gmail.com>
	<CAFEAcA8iks-LCd2zqK_6Zvh9Z4rNCO1kjmP3Q5=pdXdxxtXCYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8iks-LCd2zqK_6Zvh9Z4rNCO1kjmP3Q5=pdXdxxtXCYg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/acpi/nvdimm: Don't take address of
 fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On Mon, Nov 12, 2018 at 02:42:16PM +0000, Peter Maydell wrote:
> Since nobody responded to my ping of a week ago I propose to just
> apply this to master...
> 
> thanks
> -- PMM

Sorry. My LPC talk proposal suddenly got accepted and
I was scrambling to get ready.

Please feel free to apply this for now:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Generally I think we need to rethink our approach to endian-ness. I
think we want to tag fields with specific endian-ness and use static
checkers to verify it. That is how Linux does it.
In particular this will mean no swapping bytes in place.

But that's a subject for another day.


> On 5 November 2018 at 14:40, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Ping? This patch got reviewed but does not seem to have
> > made it into anybody's tree.
> >
> > thanks
> > -- PMM
> >
> > On 16 October 2018 at 18:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> Taking the address of a field in a packed struct is a bad idea, because
> >> it might not be actually aligned enough for that pointer type (and
> >> thus cause a crash on dereference on some host architectures). Newer
> >> versions of clang warn about this. Avoid the bug by not using the
> >> "modify in place" byte swapping functions.
> >>
> >> Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >> Automatically generated patch, tested with "make check" only.
> >>
> >>  hw/acpi/nvdimm.c | 16 ++++++++--------
> >>  1 file changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> >> index 27eeb6609f5..e53b2cb6819 100644
> >> --- a/hw/acpi/nvdimm.c
> >> +++ b/hw/acpi/nvdimm.c
> >> @@ -581,7 +581,7 @@ static void nvdimm_dsm_func_read_fit(AcpiNVDIMMState *state, NvdimmDsmIn *in,
> >>      int size;
> >>
> >>      read_fit = (NvdimmFuncReadFITIn *)in->arg3;
> >> -    le32_to_cpus(&read_fit->offset);
> >> +    read_fit->offset = le32_to_cpu(read_fit->offset);
> >>
> >>      fit = fit_buf->fit;
> >>
> >> @@ -742,8 +742,8 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
> >>      int size;
> >>
> >>      get_label_data = (NvdimmFuncGetLabelDataIn *)in->arg3;
> >> -    le32_to_cpus(&get_label_data->offset);
> >> -    le32_to_cpus(&get_label_data->length);
> >> +    get_label_data->offset = le32_to_cpu(get_label_data->offset);
> >> +    get_label_data->length = le32_to_cpu(get_label_data->length);
> >>
> >>      nvdimm_debug("Read Label Data: offset %#x length %#x.\n",
> >>                   get_label_data->offset, get_label_data->length);
> >> @@ -781,8 +781,8 @@ static void nvdimm_dsm_set_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
> >>
> >>      set_label_data = (NvdimmFuncSetLabelDataIn *)in->arg3;
> >>
> >> -    le32_to_cpus(&set_label_data->offset);
> >> -    le32_to_cpus(&set_label_data->length);
> >> +    set_label_data->offset = le32_to_cpu(set_label_data->offset);
> >> +    set_label_data->length = le32_to_cpu(set_label_data->length);
> >>
> >>      nvdimm_debug("Write Label Data: offset %#x length %#x.\n",
> >>                   set_label_data->offset, set_label_data->length);
> >> @@ -877,9 +877,9 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> >>      in = g_new(NvdimmDsmIn, 1);
> >>      cpu_physical_memory_read(dsm_mem_addr, in, sizeof(*in));
> >>
> >> -    le32_to_cpus(&in->revision);
> >> -    le32_to_cpus(&in->function);
> >> -    le32_to_cpus(&in->handle);
> >> +    in->revision = le32_to_cpu(in->revision);
> >> +    in->function = le32_to_cpu(in->function);
> >> +    in->handle = le32_to_cpu(in->handle);
> >>
> >>      nvdimm_debug("Revision %#x Handler %#x Function %#x.\n", in->revision,
> >>                   in->handle, in->function);
> >> --
