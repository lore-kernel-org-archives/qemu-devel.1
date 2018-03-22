Received: from eggs.gnu.org ([2001:4830:134:3::10]:35350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyy73-0005f2-FA
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyy72-00039I-Kz
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:10:29 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyy72-000395-Fs
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:10:28 -0400
Received: by mail-ot0-x244.google.com with SMTP id 95-v6so8985043ote.5
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 04:10:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2bc48c10-9347-3bb5-0f80-822bc240273a@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
	<20180123144807.5618-13-laurent@vivier.eu>
	<758f54da-d733-6e95-57cf-cc8b25a81dd5@vivier.eu>
	<bf9d1394-f78d-b6ba-8893-d4c7fd592de3@vivier.eu>
	<CAFEAcA9==FswwaKG_eWncv7Eo-zF+OTOKmSC7N-mpTrSEzUJmg@mail.gmail.com>
	<2bc48c10-9347-3bb5-0f80-822bc240273a@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Mar 2018 11:10:07 +0000
Message-ID: <CAFEAcA-2ueNP71UJnJHdOjiYaa3W6FRa5C+tWrbpaoR1RMKvsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 12/13] page_unprotect(): handle calls to
 pages that are PAGE_WRITE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 March 2018 at 11:07, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 22/03/2018 =C3=A0 12:05, Peter Maydell a =C3=A9crit :
>> On 22 March 2018 at 10:36, Laurent Vivier <laurent@vivier.eu> wrote:re.
>>> It goes wrong in this part:
>>>
>>> +     */
>>> +    if (is_write && info->si_signo =3D=3D SIGSEGV && info->si_code =3D=
=3D
>>> SEGV_ACCERR &&
>>> +        h2g_valid(address)) {
>>>
>>> Because, on ppc, si_code is SEGV_MAPERR and not SEGV_ACCERR
>>> (on x86_64, si_code is SEGV_ACCERR as expected)
>>
>> So on PPC if you have a page mapped, and you access it with
>> the wrong permissions, you get SEGV_MAPERR? This seems like
>> a host kernel bug to me.
>
> Are we sure it is mapped? How to know?

We know it's mapped because the kernel doesn't give us the
SEGV_MAPERR code :-) Access to unmapped pages must be the
guest binary's problem -- the thing we're trying to detect
here is "is this a write access to a page that we mapped
read-only because we have a cache of code translated for it",
which is always going to be "mapped but not with the right
permissions".

thanks
-- PMM
