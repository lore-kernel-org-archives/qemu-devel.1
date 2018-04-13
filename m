Received: from eggs.gnu.org ([2001:4830:134:3::10]:56498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6zZ0-0000pX-IO
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6zYz-0001qt-ON
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:20:30 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6zYz-0001qN-IW
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:20:29 -0400
Received: by mail-oi0-x242.google.com with SMTP id 71-v6so8490022oie.12
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 07:20:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <380f519b-03e8-db3c-35db-4fe45aa2424d@vivier.eu>
References: <20180412140222.2096-1-peter.maydell@linaro.org>
	<380f519b-03e8-db3c-35db-4fe45aa2424d@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 15:20:08 +0100
Message-ID: <CAFEAcA8sXkuHj5_1ObVnVdcLfnjj1XENaR7Jd5DzxexqQVNg1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] linux-user/signal.c: Put AArch64
 frame record in the right place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>

On 13 April 2018 at 15:18, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 12/04/2018 =C3=A0 16:02, Peter Maydell a =C3=A9crit :
>> @@ -1850,12 +1856,6 @@ static void target_setup_frame(int usig, struct t=
arget_sigaction *ka,
>>      fr_ofs =3D layout.total_size;
>>      layout.total_size +=3D sizeof(struct target_rt_frame_record);
>>
>> -    /* We must always provide at least the standard 4K reserved space,
>> -     * even if we don't use all of it (this is part of the ABI)
>> -     */
>> -    layout.total_size =3D MAX(layout.total_size,
>> -                            sizeof(struct target_rt_sigframe));
>> -
>>      frame_addr =3D get_sigframe(ka, env, layout.total_size);
>>      trace_user_setup_frame(env, frame_addr);
>>      if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
>>
>
> It's hard to compare this code with the one in kernel, but if I compare
> the offset of "fr" in QEMU and the one of "next_frame" they seem identica=
l.

Mmm. We're not quite the same as the kernel, because we keep 64 bits
of trampoline code in our target_rt_frame_record, which don't exist
on the stack in the kernel. So we'll never be exactly like the
kernel's layout (until/unless we implement a VDSO).

> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks.

-- PMM
