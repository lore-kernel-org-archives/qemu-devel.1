Received: from eggs.gnu.org ([2001:4830:134:3::10]:44642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gT3p2-0005dC-IA
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gT3p0-0003uM-Gk
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:52:32 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gT3oy-0003tN-Hk
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:52:30 -0500
Received: by mail-ot1-x341.google.com with SMTP id v23so7558582otk.9
	for <qemu-devel@nongnu.org>; Sat, 01 Dec 2018 03:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20181130151712.2312-1-peter.maydell@linaro.org>
	<20181130151712.2312-6-peter.maydell@linaro.org>
In-Reply-To: <20181130151712.2312-6-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Dec 2018 11:52:16 +0000
Message-ID: <CAFEAcA_6scdWd6V55O9B5cp1dOSP1oE7h4Ncd_=3-tcyCDOgEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/10] hw/i386/pc.c: Don't use load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, "patches@linaro.org" <patches@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Max Reitz <mreitz@redhat.com>, Philip Li <philip.li@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Qemu-block <qemu-block@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 30 Nov 2018 at 15:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The load_image() function is deprecated, as it does not let the
> caller specify how large the buffer to read the file into is.
> Use the glib g_file_get_contents() function instead, which does
> the whole "allocate memory for the file and read it in" operation.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

> -        initrd_size = get_image_size(initrd_filename);
> -        if (initrd_size < 0) {
> +        if (!g_file_get_contents(initrd_filename, &initrd_data,
> +                                 &initrd_size, &gerr)) {
>              fprintf(stderr, "qemu: error reading initrd %s: %s\n",
> -                    initrd_filename, strerror(errno));
> +                    initrd_filename, gerr->message);
>              exit(1);
> -        } else if (initrd_size >= initrd_max) {
> +        }
> +        if (initrd_size >= initrd_max) {
>              fprintf(stderr, "qemu: initrd is too large, cannot support."
> -                    "(max: %"PRIu32", need %"PRId64")\n", initrd_max, initrd_size);
> +                    "(max: %"PRIu32", need %"PRId64")\n",
> +                    initrd_max, initrd_size);

patchew reports that this introduces a format string
error on 32-bit hosts:

/tmp/qemu-test/src/hw/i386/pc.c: In function 'load_linux':
/tmp/qemu-test/src/hw/i386/pc.c:983:29: error: format '%lld' expects
argument of type 'long long int', but argument 4 has type 'gsize {aka
unsigned int}' [-Werror=format=]
             fprintf(stderr, "qemu: initrd is too large, cannot support."
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The underlying problem here is glib's weird insistance
on using its own types, which then interact badly
with everything else that's using standard POSIX types :-(

thanks
-- PMM
