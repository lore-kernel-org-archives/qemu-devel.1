Received: from eggs.gnu.org ([2001:4830:134:3::10]:60018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYA32-0005KT-JL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYA31-0005Qd-Gs
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:55:16 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYA31-0005QK-As
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:55:15 -0400
Received: by mail-wm0-x22c.google.com with SMTP id w126so22305151wme.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 04:55:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874lu74ask.fsf@dusky.pond.sub.org>
References: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
	<1500021225-4118-2-git-send-email-peter.maydell@linaro.org>
	<874lu74ask.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 12:54:53 +0100
Message-ID: <CAFEAcA8Yhke2xipJjHB_rDNcMsZgCktJH+CpPBpH79VvhgMZRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] configure: Rename CONFIG_IVSHMEM to
 CONFIG_IVSHMEM_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <n54@gmx.com>, "patches@linaro.org" <patches@linaro.org>

On 20 July 2017 at 12:17, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> The current CONFIG_IVSHMEM is confusing, because it looks like it's a
>> flag for "do we have ivshmem support?", but actually it's a flag for
>> "is the ivshmem PCI device being compiled?" (and implicitly "do we
>> have ivshmem support?" is tested with CONFIG_EVENTFD).
>>
>> Rename it to CONFIG_IVSHMEM_DEVICE to clear this confusion up;
>> shortly we will add a new CONFIG_IVSHMEM which really does indicate
>> whether the host can support ivshmem.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> I don't really care how we name this macro, but I can't help to
> wonder...  We have many CONFIG_<dev>.  The pci.mak context even shows
> some.  Why is <dev> = IVSHMEM confusing?  Why is <dev> = EDU *not*
> confusing?

Well, this did confuse the people involved in trying to fix
this bug first time round, because we tried to add
an "ifdef CONFIG_IVSHMEM" guard to the Makefile lines that
defnie the rules for ivshmem-client and ivshmem-server,
and it it fails in obscure and confusing ways because
CONFIG_IVSHMEM doesn't mean "ivshmem OK", it means only
"this particular foo-softmmu build has the ivshmem device in it".

Basically, it looks like a global config flag but it isn't
(because ivshmem has globally built parts, ie the tools,
as well as the device itself, and configure tests that control
whether it can be built or not) whereas nobody thinks CONFIG_EDU
is something that should control global parts of the build
because the device is only the device and the host config
doesn't matter.

thanks
-- PMM
