Received: from eggs.gnu.org ([2001:4830:134:3::10]:43507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4Qz9-0004VU-89
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4Qz5-0002VF-Kt
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:00:55 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:35111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4Qz5-0002VB-FZ
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:00:51 -0400
Received: by mail-ot0-x22a.google.com with SMTP id f47-v6so1071272oth.2
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 06:00:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877epkcwz8.fsf@linaro.org>
References: <20180406123838.21249-1-peter.maydell@linaro.org>
	<877epkcwz8.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 14:00:29 +0100
Message-ID: <CAFEAcA9sWOD2OauodzS3iAQFuXSS4Ji9K0x5Ki8f4cygqq97hA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] cpus.c: ensure running CPU
 recalculates icount deadlines on timer expiry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>

On 6 April 2018 at 13:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>> -    if (!qemu_in_vcpu_thread() && first_cpu) {
>> +    if (qemu_in_vcpu_thread()) {
>> +        /* A CPU is currently running; kick it back out to the
>> +         * tcg_cpu_exec() loop so it will recalculate its
>> +         * icount deadline immediately.
>> +         */
>> +        qemu_cpu_kick(current_cpu);
>
> This is only totally true if whatever has caused the re-calculation has
> ended the Translation Block, otherwise we won't finish until we've run a
> few more instructions.

That should always be true, because it will be an IO instruction,
which we enforce is always the last insn in a TB.

thanks
-- PMM
