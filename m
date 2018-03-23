Received: from eggs.gnu.org ([2001:4830:134:3::10]:46745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ezOEK-0005KF-R1
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ezOEF-0004z0-W3
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:03:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ezOEF-0004y2-RH
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:03:39 -0400
References: <1521794165-31678-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-KEnE9NKGC-vTnMByFC_LDPt2Ae8G7GfOxakfgMGH90w@mail.gmail.com>
	<6750673e-ffc3-578e-e867-332ac0790935@redhat.com>
	<CAFEAcA_u3cKF1aSHbrjW0Hc403G5GkNNom_9mqkJfregfqMymw@mail.gmail.com>
	<173b1d18-720a-4f61-29cf-4f812b78cb2e@redhat.com>
	<CAFEAcA_HaC6yjX7wW0MscxfiEafFT2uhMiWeN644NTYADhdEnQ@mail.gmail.com>
	<ebf41b29-24e1-2f51-e382-22b34260cb34@redhat.com>
	<CAFEAcA8ga2WjKcj=3ercfgC+wATk_jc2tEpQ48-r-OhoMUpzPA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d1b6658-b96c-49c4-563f-9e01e163782e@redhat.com>
Date: Fri, 23 Mar 2018 16:03:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ga2WjKcj=3ercfgC+wATk_jc2tEpQ48-r-OhoMUpzPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/riscv: Fix crashes with
 "-nodefaults"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 23/03/2018 15:28, Peter Maydell wrote:
>> Note it's a null "backend", not necessarily a null "character device".
>> Your proposal, namely ensuring that be->chr == NULL is handled properly
>> in qemu_chr_fe_init, would be just fine.
> 
> Hmm, the chardev layer code seems to have more ends than I expect.
> The "frontend" is the UART model, right, and I thought the
> "backend" was the TCP/UDP/serial port/stdio/etc end of things,
> but those seem to be Chardevs? If those aren't the backend,
> then what is?

The naming of Chardev/CharBackend was modeled after
BlockDriverState/BlockBackend, and it's not great but at least it's
consistent. :/

The CharBackend struct essentially connects a Chardev and its user.  It
ought to be possible for the Chardev to be NULL.

Paolo

> What I'd like, anyway, is that every UART model can cope with being
> setup with a NULL 'chardev' property, and ideally that that doesn't
> require a lot of extra code per-UART, and doesn't require each UART
> to create a TYPE_CHARDEV_NULL.
> 
