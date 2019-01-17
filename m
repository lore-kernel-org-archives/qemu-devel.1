Received: from eggs.gnu.org ([209.51.188.92]:48464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gk8Vg-0000Gh-0i
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gk8Vf-0002V3-3M
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:19:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gk8Ve-0002PM-Sx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:19:07 -0500
Date: Thu, 17 Jan 2019 09:19:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190117090958-mutt-send-email-mst@kernel.org>
References: <20190115200252.25911-1-mst@redhat.com>
	<CAFEAcA_CurRe0i7pU10OkNBFi53ayA4Y01HtF27qN1xo5nJqxg@mail.gmail.com>
	<20190117084350-mutt-send-email-mst@kernel.org>
	<CAFEAcA_QCYGX6_4FZedHD=GiTDXz+D1VMZ9cfCxZ5-fNmS9srA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_QCYGX6_4FZedHD=GiTDXz+D1VMZ9cfCxZ5-fNmS9srA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 00/49] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 17, 2019 at 02:07:32PM +0000, Peter Maydell wrote:
> On Thu, 17 Jan 2019 at 13:44, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Oh. I am pretty sure it's endian-ness :(
> >
> > Any chance you can quickly test the below?
> >
> > That would be appreciated ...
> >
> >
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index 0bf7164590..a506dcbb29 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -274,6 +274,7 @@ static GArray *load_expected_aml(test_data *data)
> >      AcpiSdtTable *sdt;
> >      GError *error = NULL;
> >      gboolean ret;
> > +    gsize aml_len;
> >
> >      GArray *exp_tables = g_array_new(false, true, sizeof(AcpiSdtTable));
> >      if (getenv("V")) {
> > @@ -307,7 +308,8 @@ try_again:
> >              fprintf(stderr, "Using expected file '%s'\n", aml_file);
> >          }
> >          ret = g_file_get_contents(aml_file, (gchar **)&exp_sdt.aml,
> > -                                  (gsize *)&exp_sdt.aml_len, &error);
> > +                                  &aml_len, &error);
> > +        exp_sdt.aml_len = aml_len;
> >          g_assert(ret);
> >          g_assert_no_error(error);
> >          g_assert(exp_sdt.aml);
> 
> 
> I can test that once I've finished processing the other pullreq
> I'm currently testing... That's not so much an endianness issue
> as trying to fit a 64-bit value into a 32-bit field, though.
> That cast in the code that is fixed here is an indication of
> the bug :-)
> 
> thanks
> -- PMM

Right but it fits on LE.

-- 
MST
