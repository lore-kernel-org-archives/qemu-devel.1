Received: from eggs.gnu.org ([2001:4830:134:3::10]:33840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn2J1-0004Ei-OK
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn2J0-0002CV-Ik
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:45:47 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fn2J0-0002CI-CY
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:45:46 -0400
Received: by mail-oi0-x241.google.com with SMTP id w126-v6so28481572oie.7
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 06:45:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180807114501.12370-1-peter.maydell@linaro.org>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Aug 2018 14:45:24 +0100
Message-ID: <CAFEAcA-c+kEJgmSr98Q-gYO6=9Y=6Ndj_rs4JVAovUXB9wmtvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0] slirp: Correct size check in
 m_inc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, "patches@linaro.org" <patches@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, liqsub1 <liqsub1@163.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 7 August 2018 at 12:45, Peter Maydell <peter.maydell@linaro.org> wrote:
> The data in an mbuf buffer is not necessarily at the start of the
> allocated buffer. (For instance m_adj() allows data to be trimmed
> from the start by just advancing the pointer and reducing the length.)
> This means that the allocated buffer size (m->m_size) and the
> amount of space from the m_data pointer to the end of the
> buffer (M_ROOM(m)) are not necessarily the same.
>
> Commit 864036e251f54c9 tried to change the m_inc() function from
> taking the new allocated-buffer-size to taking the new room-size,
> but forgot to change the initial "do we already have enough space"
> check. This meant that if we were trying to extend a buffer which
> had a leading gap between the buffer start and the data, we might
> incorrectly decide it didn't need to be extended, and then
> overrun the end of the buffer, causing memory corruption and
> an eventual crash.
>
> Change the "already big enough?" condition from checking the
> argument against m->m_size to checking against M_ROOM().
> This only makes a difference for the callsite in m_cat();
> the other three callsites all start with a freshly allocated
> mbuf from m_get(), which will have m->m_size == M_ROOM(m).
>
> Fixes: 864036e251f54c9
> Fixes: https://bugs.launchpad.net/qemu/+bug/1785670
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Applied to master, thanks.

-- PMM
