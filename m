Received: from eggs.gnu.org ([2001:4830:134:3::10]:46800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evkO1-00032R-3p
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evkO0-0004dZ-1C
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:54:41 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:37651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evkNz-0004dJ-QJ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:54:39 -0400
Received: by mail-oi0-x22a.google.com with SMTP id f186so15352141oig.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 06:54:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8ac4ea80-7a1d-e52e-9e54-85a1f910a002@vivier.eu>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-8-lukeshu@lukeshu.com>
	<b7b5505b-34a9-9ca3-c257-385ef91eed60@vivier.eu>
	<8ac4ea80-7a1d-e52e-9e54-85a1f910a002@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 13:54:18 +0000
Message-ID: <CAFEAcA8Oi3put6VzTQLh7JtAjSX3eFoRKXdV8WLBzE+89frB+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/10] linux-user: init_guest_space: Clean
 up control flow a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Luke Shumaker <lukeshu@lukeshu.com>, QEMU Developers <qemu-devel@nongnu.org>, Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>

On 13 March 2018 at 13:30, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 09/03/2018 =C3=A0 21:37, Laurent Vivier a =C3=A9crit :
>> Le 28/12/2017 =C3=A0 19:08, Luke Shumaker a =C3=A9crit :
>>> --- a/linux-user/elfload.c
>>> +++ b/linux-user/elfload.c
>>> @@ -1906,24 +1906,28 @@ unsigned long init_guest_space(unsigned long ho=
st_start,
>>>          }
>>>
>>>          /* Check to see if the address is valid.  */
>>> -        if (!host_start || aligned_start =3D=3D current_start) {
>>> +        if (host_start && aligned_start !=3D current_start) {
>>> +            goto try_again;
>>> +        }
>>> +
>>>  #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
>>> -            /* On 32-bit ARM, we need to also be able to map the commp=
age.  */
>>> -            int valid =3D init_guest_commpage(aligned_start - guest_st=
art,
>>> -                                            aligned_size + guest_start=
);
>>> -            if (valid =3D=3D 1) {
>>> -                break;
>>> -            } else if (valid =3D=3D -1) {
>>> -                munmap((void *)real_start, real_size);
>>> -                return (unsigned long)-1;
>>> -            }
>>> -            /* valid =3D=3D 0, so try again. */
>>> -#else
>>> -            /* On other architectures, whatever we have here is fine. =
 */
>>> -            break;
>>> -#endif
>>> +        /* On 32-bit ARM, we need to also be able to map the commpage.=
  */
>>> +        int valid =3D init_guest_commpage(aligned_start - guest_start,
>>> +                                        aligned_size + guest_start);
>>> +        if (valid =3D=3D -1) {
>>> +            munmap((void *)real_start, real_size);
>>> +            return (unsigned long)-1;
>>> +        } else if (valid =3D=3D -1) {
>>
>> I think it should be "if (valid =3D=3D 0)" here.
>
> Any comment?

Yes, I think I agree.

thanks
-- PMM
