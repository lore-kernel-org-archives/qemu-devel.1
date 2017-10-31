Received: from eggs.gnu.org ([2001:4830:134:3::10]:60819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9TEx-0001zC-VX
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 05:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9TEt-0000Je-9c
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 05:53:48 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:45263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9TEt-0000Ig-2P
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 05:53:43 -0400
Received: by mail-wm0-x233.google.com with SMTP id y80so14313694wmd.0
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 02:53:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB01591265BB44E18E19B910879E5E0@MWHPR21MB0159.namprd21.prod.outlook.com>
References: <20171020214918.18944-1-Andrew.Baumann@microsoft.com>
	<CAFEAcA-bW6CtLTN0omLoL7x7r996rY9BS1MvH4KdfS-2z6g1LQ@mail.gmail.com>
	<MWHPR21MB01591265BB44E18E19B910879E5E0@MWHPR21MB0159.namprd21.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 09:53:21 +0000
Message-ID: <CAFEAcA-oEu+bOHFp_vHKALnnkK=krP_1pMoar5t=MqY24JHRtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] arm: implement cache/shareability
 attribute bits for PAR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 31 October 2017 at 01:23, Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
>> From: Peter Maydell [mailto:peter.maydell@linaro.org]
>> Hi. This is looking pretty good, but I have a few comments below,
>> and we're pretty much at the softfreeze date (KVM Forum last week
>> meant I didn't get much code review done, unfortunately). Would
>> you be too sad if this missed 2.11 ?
>
> No worries. It would be nice to have a stable release that we can tell pe=
ople supports arm64 Windows, but I recognise that this is a non-trivial cha=
nge, so if we have to wait for 2.12 to get that, then fair enough.

Is this the only missing piece, then? If we squint a bit we can
call it a bug fix as long as we can get it in early in the softfreeze
rather than later...


>> The v8A ARM ARM pseudocode CombineS1S2AttrHints() says that the hint
>> bits always come from s1 regardless of whose attrs won.
>
> Aha, I was wondering about this. Thanks for the pointer to the pseudocode=
... it isn't referenced anywhere in the relevant section! It's reassuring t=
o see that, aside from the hints (where the English was ambiguous IIRC), I =
seem to have got the rest of the translation correct.

I didn't find anything in the English text about hints at all.
(I'll have to go and have another look.)

>> You can play bit games with the format here, because
>> what we're effectively implementing is "whichever is last in
>> the order '0, 3, 2' wins", which is
>>    ret.shareability =3D MIN(s1.shareability ^ 1, s2.shareability ^ 1) ^ =
1;
>> (since the xor with 1 transforms (0,3,2) to (1,2,3) and is self-inverse)=
.
>> Is that better than the if ladder above? Not entirely sure :-)
>
> I've no confidence in my ability to get that bit-logic right, or
> even to check that you did. I'd rather leave it to the compiler to
> figure out how to play those optimisation games :)

Mmm. This isn't on a fast path I think so we may as well write
it clearly.

>> > +    /* Combine memory type and cacheability attributes */
>> > +    if (s1hi =3D=3D 0 || s2hi =3D=3D 0) {
>> > +        /* Device has precedence over normal */
>> > +        if (s1lo =3D=3D 0 || s2lo =3D=3D 0) {
>> > +            /* nGnRnE has precedence over anything */
>> > +            ret.attrs =3D 0;
>> > +        } else if (s1lo =3D=3D 4 || s2lo =3D=3D 4) {
>> > +            /* non-Reordering has precedence over Reordering */
>> > +            ret.attrs =3D 4;  /* nGnRE */
>> > +        } else if (s1lo =3D=3D 8 || s2lo =3D=3D 8) {
>> > +            /* non-Gathering has precedence over Gathering */
>> > +            ret.attrs =3D 8;  /* nGRE */
>> > +        } else {
>> > +            ret.attrs =3D 0xc; /* GRE */
>> > +        }
>>
>> Isn't this if-ladder equivalent to just "ret.attrs =3D MIN(s1lo, s2lo);"=
 ?
>
> Assuming both s1lo and s2lo avoid undefined encodings, yes it is. I tend =
to prefer the if-ladder just because it's a more direct translation of the =
spec (e.g. CombineS1S2Device() pseudocode). But in this case if you prefer =
I could change it to the MIN version for brevity, since it's fairly straigh=
tforward.

Your choice either way, then.

thanks
-- PMM
