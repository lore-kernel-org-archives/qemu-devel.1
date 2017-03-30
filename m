Received: from eggs.gnu.org ([2001:4830:134:3::10]:54729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctcJm-00069p-9Z
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctcJl-00083z-Fg
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:48:58 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctcJl-00083W-AG
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:48:57 -0400
Received: by mail-wr0-x22c.google.com with SMTP id k6so60616235wre.2
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 08:48:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490888143-31601-1-git-send-email-mst@redhat.com>
References: <1490888143-31601-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 16:48:35 +0100
Message-ID: <CAFEAcA_zNqsSg+BObVBHHrFVi7phYoZvOToVhypA9R8ovwS7sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] tests/acpi: don't pack a structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>

On 30 March 2017 at 16:35, Michael S. Tsirkin <mst@redhat.com> wrote:
> There's no reason to pack structures where we don't care about size or
> padding, this applies to AcpiStdTable in tests/acpi-utils.h.
>
> OTOH bios-tables-test happens to be passing the address of a field in
> this  struct to a function that expects a pointer to normally aligned
> data which results in a SIGBUS on architectures like SPARC that have
> strict alignment requirements.
>
> Fixes: 9e8458c02 ("acpi unit-test: compare DSDT and SSDT tables against expected values")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tests/acpi-utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> index 9f9a2d5..348e4d7 100644
> --- a/tests/acpi-utils.h
> +++ b/tests/acpi-utils.h
> @@ -26,7 +26,7 @@ typedef struct {
>      gsize asl_len;
>      gchar *asl_file;
>      bool tmp_files_retain;   /* do not delete the temp asl/aml */
> -} QEMU_PACKED AcpiSdtTable;
> +} AcpiSdtTable;
>
>  #define ACPI_READ_FIELD(field, addr)           \
>      do {                                       \

Yes, this fixes the SPARC crashes.

Tested-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
