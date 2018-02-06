Received: from eggs.gnu.org ([2001:4830:134:3::10]:59560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ej9P2-0002gs-3S
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ej9P1-0001Te-6U
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:59:40 -0500
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:39237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ej9P1-0001TT-0I
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:59:39 -0500
Received: by mail-it0-x231.google.com with SMTP id c80so3851829itb.4
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 11:59:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_n23yw65QFUTuikY=0WZeMRySAnngeTBnObPFJPGqUUQ@mail.gmail.com>
References: <20180122172643.29742-1-ard.biesheuvel@linaro.org>
	<20180122172643.29742-2-ard.biesheuvel@linaro.org>
	<CAFEAcA9zA=PTmxQH1W1ht8sj9HFMVKSb12dsm-jX6FQEmQR+FA@mail.gmail.com>
	<CAKv+Gu80ngyOewT-J3sKVV2pn8e7SVspF8py_yiuQzY1KEEE-w@mail.gmail.com>
	<CAKv+Gu8ZnyorvLnSackEyHCd7dRjN-Uh1Ywv_nj7iZwE=8z1og@mail.gmail.com>
	<CAFEAcA_Kkg5HUqK8hT_6JMD9AMrBgD46tHODT8rM9Fp7o8PWBw@mail.gmail.com>
	<CAFEAcA8nStZMnTkOSTdPU2vHVGZegY0tpLv9T+w5BPUUuwzUQQ@mail.gmail.com>
	<CAFEAcA_n23yw65QFUTuikY=0WZeMRySAnngeTBnObPFJPGqUUQ@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 6 Feb 2018 20:59:36 +0100
Message-ID: <CAKv+Gu_EoqCHKQCWeWD=_34jgRtmKWBfRYM6gKL3X_zXgwQW7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/4] target/arm: implement SHA-512
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 February 2018 at 20:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 6 February 2018 at 19:15, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 6 February 2018 at 19:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> SM4EKEY, SM4E
>>
>> Sample SM4EKEY failure:
>> insn 0xce78cbdd (SM4EKEY V29.4S, V30.4S, V24.4S)
>>   V24   : 6ee7a2520059bd15bac75e4436b3a1bd
>>   V30   : a67d04e738f68da895ffd0c3e154e3e7
>>
>>   V29 actual:   a67d04e7b98aaef47bf01b8158da5407
>>   V29 expected: 8d492252b98aaef47bf01b8158da5407
>>
>> (top 32 bits are wrong)
>>
>> Sample SM4E failure:
>> insn 0xcec087dd (SM4E V29.4S, V30.4S)
>>   V30   : a67d04e738f68da895ffd0c3e154e3e7
>>   V29 actual  : e272e88588a781b7e77a90dd5641e34b
>>   V29 expected: a39884af88a781b7e77a90dd5641e34b
>>
>> (top 32 bits again)
>>
>> My test setup doesn't capture register values from
>> before the insn executes, which is awkward for SM4E since
>> it uses Vd as input as well as output. Probably the bug
>> is the same as SM4EKEY, though.
>
> ...and it's a pretty simple fix; we just weren't actually
> doing the 4th iteration of the algorithm:
>
> diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
> index b42c7e046b..2c3af64a52 100644
> --- a/target/arm/crypto_helper.c
> +++ b/target/arm/crypto_helper.c
> @@ -653,7 +653,7 @@ void HELPER(crypto_sm4e)(void *vd, void *vn)
>      union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
>      uint32_t t, i;
>
> -    for (i = 0; i < 3; i++) {
> +    for (i = 0; i < 4; i++) {
>          t = CR_ST_WORD(d, (i + 1) % 4) ^
>              CR_ST_WORD(d, (i + 2) % 4) ^
>              CR_ST_WORD(d, (i + 3) % 4) ^
> @@ -683,7 +683,7 @@ void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm)
>      uint32_t t, i;
>
>      d = n;
> -    for (i = 0; i < 3; i++) {
> +    for (i = 0; i < 4; i++) {
>          t = CR_ST_WORD(d, (i + 1) % 4) ^
>              CR_ST_WORD(d, (i + 2) % 4) ^
>              CR_ST_WORD(d, (i + 3) % 4) ^
>
> That change is sufficient for SM4E and SM4EKEY to pass my tests.
>

Thanks a lot for debugging that. As I said, I don't have test vectors,
or I would have tested it myself, and most likely would have found
this as well.
