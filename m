Received: from eggs.gnu.org ([209.51.188.92]:43118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1go3lU-0000bf-DI
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1go3lL-00089K-T7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:03:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1go3lI-000861-3J
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:03:29 -0500
References: <20190124040457.2546-1-doug16k@gmail.com>
	<CAFEAcA9fVkGEMPUaSapn6YOV0DR_rS17pWKZHTxQz0aCM+et3g@mail.gmail.com>
	<CAEfK_460635_tXwDLoKGhMQ7smz0Gy2OVLBMQpU8GrhxA02ywA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7e18561-95e1-4ca4-dd21-b1ed1bee40b4@redhat.com>
Date: Mon, 28 Jan 2019 10:56:01 +0100
MIME-Version: 1.0
In-Reply-To: <CAEfK_460635_tXwDLoKGhMQ7smz0Gy2OVLBMQpU8GrhxA02ywA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Fix i386/x86_64 machine
 description and add control registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 24/01/19 21:29, Doug Gale wrote:
> The machine description we send is being (silently) thrown on the floor
> by GDB and GDB silently uses the default machine description.
> 
> With current QEMU, if you debug gdb, and set debug_xml=1 and continue,
> then attach to qemu gdbstub from the debugged gdb, you will see the xml
> parse fail completely, and gdb will fall back to the default machine
> description, silently, and changes to our xml (in qemu source code) have
> no effect. They might as well be empty.
> 
> The point of fixing the machine description was IDE's with GDB
> integration will break on QEMU. The default machine description has
> fs_base, which fails to be retrieved, whick breaks the whole register
> window (in qt-creator at least, likely others). With my patch the
> register window works perfectly.
> 
> I didn't delete anything, I removed the superfluous nesting of files by
> xi:include and moved the description into a single xml file. I added
> fs_base, gs_base, k_gs_base, cr0/2/3/4/6, efer.
> 
> Removing the nesting into xml includes fixes it because the xml parse
> fails on <feature nested within <feature, so I solved it by removing
> unnecessary include indirections and placed the data inline.


Thanks, I put this as a commit message:

The machine description we send is being (silently) thrown on the floor
by GDB and GDB silently uses the default machine description, because
the xml parse fails on <feature> nested within <feature>.
Changes to the xml in qemu source code have no effect.

In addition, the default machine description has fs_base, which fails to
be retrieved, which breaks the whole register window.  Add it and the
other control registers.

Thanks,

Paolo
