Received: from eggs.gnu.org ([2001:4830:134:3::10]:37746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPT4a-0002sK-LB
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPT4Z-0006Sw-Nl
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:24:56 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPT4Z-0006SX-ES
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 08:24:55 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 77so143884493wrb.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 05:24:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496679576-14336-1-git-send-email-peter.maydell@linaro.org>
References: <1496679576-14336-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 13:24:33 +0100
Message-ID: <CAFEAcA_qAkYYnZpUoXR_9w-d428GYer9RiT5Uv0yaq31xakRpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] slirp: handle errors in sosendoob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "patches@linaro.org" <patches@linaro.org>

Ping for review?

thanks
-- PMM

On 5 June 2017 at 17:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> At the moment the slirp sosendoob() function doesn't properly
> handle errors from slirp_send(), and its callers don't do
> anything with its return value either. (Coverity spots the
> latter as CID 1005633.)
>
> This patchset attempts to fix that. In the first patch we
> fix sosendoob() itself so that we return errors to the caller
> and treat short writes as reducing the amount of urgent data
> to be sent. In the second patch we make the call in sowrite()
> treat any return form sosendoob() which didn't transfer all
> the urgent data as a "disconnect the socket" error in the
> same way that it already handles errors for writes of
> non-urgent data. The call to sosendoob() in sbappend() can
> safely ignore any failures as in this case sowrite() will be
> called shortly and will deal with them.
>
> Coding style: I've opted to stick with the tab-indent
> that the slirp code uses rather than reindent to QEMU standard.
> Happy to go the other way if the maintainer prefers.
>
> Disclaimer: I have not tested these patches very hard and
> in particular they deal with error paths and with urgent
> data, neither of which I have any test case for...
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   slirp: Handle error returns from slirp_send() in sosendoob()
>   slirp: Handle error returns from sosendoob()
>
>  slirp/sbuf.c   |  2 +-
>  slirp/socket.c | 51 ++++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 35 insertions(+), 18 deletions(-)
