Received: from eggs.gnu.org ([209.51.188.92]:44936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk8Ki-0003Si-NL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk8Ki-0004bo-2K
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:07:48 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:36919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gk8Kh-0004Vo-TR
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:07:48 -0500
Received: by mail-oi1-x230.google.com with SMTP id y23so6223572oia.4
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 06:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20190115200252.25911-1-mst@redhat.com>
	<CAFEAcA_CurRe0i7pU10OkNBFi53ayA4Y01HtF27qN1xo5nJqxg@mail.gmail.com>
	<20190117084350-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190117084350-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 14:07:32 +0000
Message-ID: <CAFEAcA_QCYGX6_4FZedHD=GiTDXz+D1VMZ9cfCxZ5-fNmS9srA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/49] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 17 Jan 2019 at 13:44, Michael S. Tsirkin <mst@redhat.com> wrote:
> Oh. I am pretty sure it's endian-ness :(
>
> Any chance you can quickly test the below?
>
> That would be appreciated ...
>
>
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 0bf7164590..a506dcbb29 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -274,6 +274,7 @@ static GArray *load_expected_aml(test_data *data)
>      AcpiSdtTable *sdt;
>      GError *error = NULL;
>      gboolean ret;
> +    gsize aml_len;
>
>      GArray *exp_tables = g_array_new(false, true, sizeof(AcpiSdtTable));
>      if (getenv("V")) {
> @@ -307,7 +308,8 @@ try_again:
>              fprintf(stderr, "Using expected file '%s'\n", aml_file);
>          }
>          ret = g_file_get_contents(aml_file, (gchar **)&exp_sdt.aml,
> -                                  (gsize *)&exp_sdt.aml_len, &error);
> +                                  &aml_len, &error);
> +        exp_sdt.aml_len = aml_len;
>          g_assert(ret);
>          g_assert_no_error(error);
>          g_assert(exp_sdt.aml);


I can test that once I've finished processing the other pullreq
I'm currently testing... That's not so much an endianness issue
as trying to fit a 64-bit value into a 32-bit field, though.
That cast in the code that is fixed here is an indication of
the bug :-)

thanks
-- PMM
