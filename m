Received: from eggs.gnu.org ([2001:4830:134:3::10]:41196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g06iP-0005ih-Pc
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 11:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g06YA-00074V-GH
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:55:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42526 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g06YA-00074C-7x
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:55:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DA554072C04
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 14:55:25 +0000 (UTC)
References: <20180912123700.7708-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <15f866b3-6d08-7b0a-bffc-92ec4c1bc208@redhat.com>
Date: Wed, 12 Sep 2018 09:55:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180912123700.7708-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] display/edid: add edid generator to
 qemu.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 9/12/18 7:36 AM, Gerd Hoffmann wrote:
> EDID is a metadata format to describe monitors.  On physical hardware
> the monitor has an eeprom with that data block which can be read over
> i2c bus.
> 
> On a linux system you can usually find the EDID data block in
> /sys/class/drm/$card/$connector/edid.  xorg ships a edid-decode utility
> which you can use to turn the blob into readable form.
> 
> I think it would be a good idea to use EDID for virtual displays too.
> Needs changes in both qemu and guest kms drivers.  This patch is the
> first step, it adds an generator for EDID blobs to qemu.  Comes with a
> qemu-edid test tool included.
> 
> With EDID we can pass more information to the guest.  Names and serial
> numbers, so the guests display configuration has no boring "Unknown
> Monitor".  List of video modes.  Display resolution, pretty important
> in case we want add HiDPI support some day.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

> --- /dev/null
> +++ b/include/hw/display/edid.h
> @@ -0,0 +1,18 @@
> +#ifndef EDID_H
> +#define EDID_H

> --- /dev/null
> +++ b/hw/display/edid-generate.c
> @@ -0,0 +1,328 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/bswap.h"
> +#include "hw/display/edid.h"
> +

No copyright blurbs?

> +    /* =============== basic display parameters =============== */
> +
> +    /* video input: digital, 8bpc, displayport */
> +    edid[20] = 0xa5;
> +
> +    /* screen size: undefined */
> +    edid[21] = info->prefx * info->dpi / 2540;
> +    edid[22] = info->prefy * info->dpi / 2540;
> +
> +    /* display gamma: 1.0 */
> +    edid[23] = 0x00;
> +
> +    /* supported features bitmap: prefered timing */

preferred

> --- /dev/null
> +++ b/qemu-edid.c
> @@ -0,0 +1,86 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/bswap.h"
> +#include "hw/display/edid.h"

and again


> +int main(int argc, char *argv[])
> +{
> +    FILE *outfile = NULL;
> +    uint8_t blob[128];
> +    int rc;
> +
> +    for (;;) {
> +        rc = getopt(argc, argv, "ho:x:y:d:v:n:s:");
> +        if (rc == -1) {
> +            break;
> +        }
> +        switch (rc) {
> +        case 'o':
> +            outfile = fopen(optarg, "w");
> +            if (outfile == NULL) {
> +                fprintf(stderr, "open %s: %s\n", optarg, strerror(errno));
> +                exit(1);

Leaks if -o is passed on the command line more than once.

> +            }
> +            break;
> +        case 'x':
> +            info.prefx = atoi(optarg);

atoi() can't flag errors like '-x 1garbage'. Better is to use qemu_strtoi().

> +    memset(blob, 0, sizeof(blob));
> +    qemu_edid_generate(blob, sizeof(blob), &info);
> +    fwrite(blob, sizeof(blob), 1, outfile);
> +    fflush(outfile);
> +
> +    exit(0);

You could just 'return 0;' instead.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
