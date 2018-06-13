Received: from eggs.gnu.org ([2001:4830:134:3::10]:46759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTByz-0001pi-2A
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTByw-0006Zj-0w
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 16:03:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-12-f4bug@amsat.org>
	<15d222dd-d2e9-4855-62c6-f89f2ee59c52@linaro.org>
	<76aa5170-1d18-8799-6ff1-a7c0dba0b489@redhat.com>
	<8537ca07-2645-6c2c-5945-a91da035b474@linaro.org>
	<a856ef80-fcab-0003-2bdd-89a1849fe857@redhat.com>
	<7c27cd3e-124c-1c03-46de-1b016b37edf1@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <72cb44fc-fb48-49a6-3aa7-3e63762d9586@amsat.org>
Date: Wed, 13 Jun 2018 17:02:53 -0300
MIME-Version: 1.0
In-Reply-To: <7c27cd3e-124c-1c03-46de-1b016b37edf1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 11/40] hw/xen: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>

On 06/13/2018 04:31 PM, Richard Henderson wrote:
> On 06/13/2018 02:13 AM, Eric Blake wrote:
>> Or spell it UINT64_C(1) if you don't want a cast.
> 
> Not unsigned is what I want most.

I used both of your suggestions, but now new format string errors
appeared due to ram_addr_t being unsigned, so code cleaned using
MachineState->ram_size now complains.

include/exec/cpu-common.h:53:typedef uintptr_t ram_addr_t;
include/hw/boards.h:259:    ram_addr_t ram_size;

Is the following snippet OK?

     /* allocate RAM */
-    if (ram_size > (2048u << 20)) {
-        error_report("Too much memory for this machine: %dMB, maximum
2048MB",
-                     ((unsigned int)ram_size / (1 << 20)));
+    if (ram_size > 2 * GiB) {
+        error_report("Too much memory for this machine: %luMB, maximum
2048MB",
+                     ram_size / MiB);
         exit(1);
     }
