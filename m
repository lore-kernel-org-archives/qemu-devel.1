Received: from eggs.gnu.org ([2001:4830:134:3::10]:42318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIMBH-0007K0-74
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 17:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIMB0-0003iX-Dn
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 17:38:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dIMAz-0003hb-Pc
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 17:38:10 -0400
Date: Tue, 6 Jun 2017 17:38:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170606213808.GA23654@flamenco>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-2-git-send-email-cota@braap.org>
	<CAJhHMCDHLrU5NEuZGJqkVcJyQnXYsrdcYbNiNw4DAgiT=0R9pQ@mail.gmail.com>
	<20170606161152.GA6109@flamenco>
	<8bc72799-f469-9728-fb4b-83b47b89a701@twiddle.net>
	<d7d34a47-2513-030d-17f7-ce2680197573@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d34a47-2513-030d-17f7-ce2680197573@web.de>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] compiler: define QEMU_CACHELINE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Martin Ijewski <gm.ijewski@web.de>
Cc: Richard Henderson <rth@twiddle.net>, Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jun 06, 2017 at 22:28:23 +0200, Geert Martin Ijewski wrote:
> On a fully patched Windows 10 with an i5-4690 this code works for me (TM):

Thanks!
Can you please test this?

		Emilio
---
#include "qemu/osdep.h"
#include <windows.h>

static unsigned int linesize_win(PROCESSOR_CACHE_TYPE type)
{
    PSYSTEM_LOGICAL_PROCESSOR_INFORMATION buf;
    DWORD size = 0;
    unsigned int ret = 0;
    BOOL success;
    size_t n;
    size_t i;

    success = GetLogicalProcessorInformation(0, &size);
    if (success || GetLastError() != ERROR_INSUFFICIENT_BUF) {
        return 0;
    }
    buf = (PSYSTEM_LOGICAL_PROCESSOR_INFORMATION)g_malloc0(size);
    if (!GetLogicalProcessorInformation(buf, &size)) {
        goto out;
    }

    n = size / sizeof(SYSTEM_LOGICAL_PROCESSOR_INFORMATION);
    for (i = 0; i < n; i++) {
        if (buf[i].Relationship == RelationCache &&
            buf[i].Cache.Level == 1 &&
            (buf[i].Cache.Type == CacheUnified ||
             buf[i].Cache.Type == type)) {
            ret = buf[i].Cache.LineSize;
            break;
        }
    }
 out:
    g_free(buf);
    return ret;
}

linesize_win(CacheInstruction);
linesize_win(CacheData);
