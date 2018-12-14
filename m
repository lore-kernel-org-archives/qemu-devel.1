Received: from eggs.gnu.org ([2001:4830:134:3::10]:53974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXlfh-0002fK-AQ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXlff-0005fx-Ed
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:30:20 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXlfd-0005e0-Eo
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:30:17 -0500
Received: by mail-oi1-x242.google.com with SMTP id c206so4304514oib.0
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 03:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20181130151712.2312-1-peter.maydell@linaro.org>
In-Reply-To: <20181130151712.2312-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 11:30:01 +0000
Message-ID: <CAFEAcA85KvcWjNxjCPxrQ8gvs53MXX-e_GNVF-C8Nd=YV2BbFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/10] Remove deprecated load_image()
 function
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

On Fri, 30 Nov 2018 at 15:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset removes the load_image() function, which we noted
> in a comment as being deprecated in 2008 but were still using
> in a handful of places. All the use cases are bugs of some
> kind or another, either straightforward "no length checking
> at all" or "doesn't cope with the file getting larger between
> get_image_size()'s length check and the read in load_image()".
> IRC consensus was that this doesn't rise to the level of a
> security issue since the images being loaded should either
> be trusted or the management layer app should be fencing things
> off to ensure they don't change underfoot.
>
> The replacement is either:
>  * g_file_get_contents(), in places where we were previously
>    explicitly g_malloc()ing a buffer to load the image
>  * load_image_size(), in places where we load the image
>    into a pre-existing buffer, MemoryRegion, etc
>
> The final patch in the series adds a documentation comment
> for load_image_size().

I'm putting together a pullreq with some of the miscellaneous
cleanup patches I've sent out during codefreeze. I'm going to
add this series to it, with this squashed into patch 5:

@@ -982,7 +982,7 @@ static void load_linux(PCMachineState *pcms,
         if (initrd_size >= initrd_max) {
             fprintf(stderr, "qemu: initrd is too large, cannot support."
                     "(max: %"PRIu32", need %"PRId64")\n",
-                    initrd_max, initrd_size);
+                    initrd_max, (uint64_t)initrd_size);
             exit(1);
         }

and the commit message tweaks Eric requested to mention
when error-checking was added.

thanks
-- PMM
