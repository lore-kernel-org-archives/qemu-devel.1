Received: from eggs.gnu.org ([2001:4830:134:3::10]:38188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdXAI-0003Jb-Mi
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdXAH-0003bI-Je
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:41:30 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdXAH-0003bC-EU
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:41:29 -0400
Received: by mail-oi0-x242.google.com with SMTP id v8-v6so54360254oie.5
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 01:41:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6233d484-ebfd-3225-92b5-c1c1e07b047e@vivier.eu>
References: <cover.1467138806.git.riku.voipio@linaro.org>
	<435da5e7092aa54e12044b9401b42c4a9333c74d.1467138806.git.riku.voipio@linaro.org>
	<6233d484-ebfd-3225-92b5-c1c1e07b047e@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 09:41:07 +0100
Message-ID: <CAFEAcA_ccWh_N27nTbMu=C6gkekroHDzDmewbhBXw6SUZgYn-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 03/24] linux-user: Use safe_syscall
 wrapper for fcntl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 12 July 2018 at 08:18, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 28/06/2016 =C3=A0 21:12, riku.voipio@linaro.org a =C3=A9crit :
>> From: Peter Maydell <peter.maydell@linaro.org>
>>
>> Use the safe_syscall wrapper for fcntl. This is straightforward now
>> that we always use 'struct fcntl64' on the host, as we don't need
>> to select whether to call the host's fcntl64 or fcntl syscall
>> (a detail that the libc previously hid for us).
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
>> ---
>>  linux-user/syscall.c | 34 +++++++++++++++++++++++-----------
>>  1 file changed, 23 insertions(+), 11 deletions(-)
> ...
>> @@ -10252,7 +10264,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_=
long arg1,
>>              if (ret) {
>>                  break;
>>              }
>> -            ret =3D get_errno(fcntl(arg1, cmd, &fl));
>> +            ret =3D get_errno(safe_fcntl(arg1, cmd, &fl));
>>           break;
>>          default:
>>              ret =3D do_fcntl(arg1, arg2, arg3);
>>
>
> Peter,
>
> 435da5e709 linux-user: Use safe_syscall wrapper for fcntl
>
> do you remember why you only convert to safe_fcntl() the
> TARGET_F_SETLK64 and TARGET_F_SETLKW64 cases and not the
> TARGET_F_GETLK64 one (in TARGET_NR_fcntl64)?

I don't recall; I probably just missed that one. I don't
see any reason why it shouldn't be using safe_fcntl().

thanks
-- PMM
