Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evLoq-0003PX-Ih
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evLop-0004su-Gv
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:40:44 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:41591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evLop-0004s6-BR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:40:43 -0400
Received: by mail-ot0-x231.google.com with SMTP id w38so14898861ota.8
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:40:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <359ea922.4a3d5.16219f40e21.Coremail.suhang16@mails.ucas.ac.cn>
References: <359ea922.4a3d5.16219f40e21.Coremail.suhang16@mails.ucas.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 11:40:22 +0000
Message-ID: <CAFEAcA-U4_gKK744dwY1+8yRX8APSpa+7EUgNB0SW9Omfc_SGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] BiteSizedTasks: API conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: thomas huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 12 March 2018 at 11:24, Su Hang <suhang16@mails.ucas.ac.cn> wrote:
> Dear Thomas,
> I'm tring to work on this job:
> BiteSizedTasks:
>     API conversion:
>         Replace calls to functions named cpu_physical_memory_* with address_space_*.

This is a generic suggestion, but not all cpu_physical_memory_*
functions currently have a direct counterpart in address_space_*.
(Note also that it is not as simple as "change the function name
at the call site -- there are more parameters to the address_space_*
functions. Ideally it also requires examining each call site to
see what it should do if the memory access fails, and what
address space it should really be using. This is rather more
complicated than it appears from the fact it's on a bite-sized-task
list. Any individual conversion of a callsite is probably small
enough to be bite-sized, but you shouldn't consider "change
everywhere" to be a single small task.)

As you've found, cpu_physical_memory_write_rom() is one of those
functions that doesn't currently have an address_space_* equivalent.

There's actually a 'TODO' note in our API docs in
docs/devel/loads-stores.rst about this:

# Note that unlike ``cpu_physical_memory_write()`` this function takes
# an AddressSpace argument, but unlike ``address_space_write()`` this
# function does not take a ``MemTxAttrs`` or return a ``MemTxResult``.
#
# **TODO**: we should probably clean up this inconsistency and
# turn the function into ``address_space_write_rom`` with an API
# matching ``address_space_write``.

and I think that would be the best thing:
 (1) have address_space_write_rom() which takes the extra
 MemTxAttrs argument and returns the MemTxResult, and
 make cpu_physical_memory_write_rom() just be a trivial
 wrapper around it
 (2) then change the callers to use address_space_write_rom()
 (3) remove the cpu_physical_memory_write_rom() wrapper

Step 2 is the harder part, because really it requires looking at
the call sites to see what they should do if the memory access
fails.

thanks
-- PMM
