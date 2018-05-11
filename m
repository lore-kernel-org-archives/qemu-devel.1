Received: from eggs.gnu.org ([2001:4830:134:3::10]:55253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH4Lc-0006J9-3K
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH4Lb-0002sE-Bi
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:28:20 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:44909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH4Lb-0002rE-7k
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:28:19 -0400
Received: by mail-ot0-x22a.google.com with SMTP id g7-v6so5510343otj.11
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 02:28:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1446725643-82458-3-git-send-email-pbonzini@redhat.com>
References: <1446725643-82458-1-git-send-email-pbonzini@redhat.com>
	<1446725643-82458-3-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 10:27:58 +0100
Message-ID: <CAFEAcA8xPCQpXYPPbfizzXZ-7OzUXGUN4dyqrbM3_Vy27coDKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 02/18] replay: internal functions for replay
 log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 5 November 2015 at 12:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> This patch adds functions to perform read and write operations
> with replay log.
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> +void replay_put_byte(uint8_t byte)
> +{
> +    if (replay_file) {
> +        putc(byte, replay_file);
> +    }
> +}

> +uint8_t replay_get_byte(void)
> +{
> +    uint8_t byte = 0;
> +    if (replay_file) {
> +        byte = getc(replay_file);
> +    }
> +    return byte;
> +}

Coverity (CID 1390576) points out that this function isn't checking
the error return from getc(). That means we could incorrectly return
255 from here and then the return value from replay_get_dword would
be 0xffffffff, which is unfortunate if the place that's using
that uses it as a loop boundary.

Incidentally, is it worth adding something to our coverity model
to tell coverity that data from replay_get_byte() is not tainted?

thanks
-- PMM
