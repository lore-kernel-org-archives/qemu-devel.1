Received: from eggs.gnu.org ([2001:4830:134:3::10]:47446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1dIMYI-0003h6-IY
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 18:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1dIMYF-0007am-F7
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 18:02:14 -0400
Received: from mout.web.de ([212.227.15.14]:62704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gm.ijewski@web.de>) id 1dIMYF-0007Zn-4V
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 18:02:11 -0400
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-2-git-send-email-cota@braap.org>
	<CAJhHMCDHLrU5NEuZGJqkVcJyQnXYsrdcYbNiNw4DAgiT=0R9pQ@mail.gmail.com>
	<20170606161152.GA6109@flamenco>
	<8bc72799-f469-9728-fb4b-83b47b89a701@twiddle.net>
	<d7d34a47-2513-030d-17f7-ce2680197573@web.de>
	<20170606213808.GA23654@flamenco>
From: Geert Martin Ijewski <gm.ijewski@web.de>
Message-ID: <215e328d-d350-f7b8-772f-065a329142f9@web.de>
Date: Wed, 7 Jun 2017 00:01:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170606213808.GA23654@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] compiler: define QEMU_CACHELINE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <rth@twiddle.net>, Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Am 06.06.2017 um 23:38 schrieb Emilio G. Cota:
 > On Tue, Jun 06, 2017 at 22:28:23 +0200, Geert Martin Ijewski wrote:
 >> On a fully patched Windows 10 with an i5-4690 this code works for me 
(TM):
 >
 > Thanks!
 > Can you please test this?
 >
 > 		Emilio
 > ---
 > #include "qemu/osdep.h"
 > #include <windows.h>

unnecassary as it's already included by qemu/osdep.h -> sysemu/os-win32.h
 >
 > static unsigned int linesize_win(PROCESSOR_CACHE_TYPE type)
 > {
 >      PSYSTEM_LOGICAL_PROCESSOR_INFORMATION buf;
 >      DWORD size = 0;
 >      unsigned int ret = 0;
 >      BOOL success;
 >      size_t n;
 >      size_t i;
 >
 >      success = GetLogicalProcessorInformation(0, &size);
 >      if (success || GetLastError() != ERROR_INSUFFICIENT_BUF) {
 >          return 0;
 >      }
 >      buf = (PSYSTEM_LOGICAL_PROCESSOR_INFORMATION)g_malloc0(size);
 >      if (!GetLogicalProcessorInformation(buf, &size)) {
 >          goto out;
 >      }
 >
 >      n = size / sizeof(SYSTEM_LOGICAL_PROCESSOR_INFORMATION);
 >      for (i = 0; i < n; i++) {
 >          if (buf[i].Relationship == RelationCache &&
 >              buf[i].Cache.Level == 1 &&
 >              (buf[i].Cache.Type == CacheUnified ||
 >               buf[i].Cache.Type == type)) {
 >              ret = buf[i].Cache.LineSize;
 >              break;
 >          }
 >      }
 >   out:
 >      g_free(buf);
 >      return ret;
 > }
 >
 > linesize_win(CacheInstruction);
 > linesize_win(CacheData);
 >
 >

Yes, that works.
Tested-by: Geert Martin Ijewski <gm.ijewski@web.de>
