Received: from eggs.gnu.org ([2001:4830:134:3::10]:51751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo3K0-0000RX-1t
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo3Jz-0007ZQ-4j
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:03:00 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fo3Jy-0007YR-UV
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:02:59 -0400
Received: by mail-oi0-x244.google.com with SMTP id b16-v6so14580979oic.9
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 02:02:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809215421.hexdewc3igklwvob@var.youpi.perso.aquilenet.fr>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
	<20180809111233.GA2619@work-vm>
	<CAFEAcA-+5xFDMuvK2W8v=Ufs2E1K4y9onZY_4x6RMYbHLFpkxA@mail.gmail.com>
	<20180809113204.GB2618@work-vm>
	<20180809215421.hexdewc3igklwvob@var.youpi.perso.aquilenet.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Aug 2018 10:02:37 +0100
Message-ID: <CAFEAcA9hquE5jck7=-c6Xd36uDfm7Z_Kw39P1vCkZRqE1M4EDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>, liqsub1 <liqsub1@163.com>

On 9 August 2018 at 22:54, Samuel Thibault <samuel.thibault@gnu.org> wrote:
> Dr. David Alan Gilbert, le jeu. 09 ao=C3=BBt 2018 12:32:05 +0100, a ecrit=
:
>> >    |--datasize---->|---m_len------->
>> >    |----------m_size------------------------------>
>> >                    |----M_ROOM-------------------->
>> >                                     |-M_FREEROOM-->
>> >
>> >    ^               ^                               ^
>> >    m_dat           m_data                          end of buffer
>> >
>> > ("datasize" is a bit misnamed, as it's "size of the leading
>> > gap between the start of the buffer and the data"; "gapsize"
>> > would be more helpful.)
>> >
>> > Anyway, we allocate size + datasize, and
>> > m_size =3D=3D datasize + M_ROOM. We know that size >=3D M_ROOM,
>> > so the allocated buffer must be at least m_size big.
>>
>> Ah OK, thanks.
>> (That ascii art could do with being in a comment somewhere!)
>
> Indeed. Peter, maybe your Signed-off-by on this? :)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> Samuel
>
> commit 4be85a1eeb6b19e91491e689d4d0d054030cbb49
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Thu Aug 9 23:52:59 2018 +0200
>
>     slirp: document mbuf pointers and sizes
>
>     Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>
> diff --git a/slirp/mbuf.h b/slirp/mbuf.h
> index 33b84485d6..a5bb3f9e66 100644
> --- a/slirp/mbuf.h
> +++ b/slirp/mbuf.h
> @@ -47,6 +47,16 @@
>   * free the m_ext.  This is inefficient memory-wise, but who cares.
>   */
>
> +/*
> + *  |--gapsize----->|---m_len------->
> + *  |----------m_size------------------------------>
> + *                  |----M_ROOM-------------------->
> + *                                   |-M_FREEROOM-->
> + *
> + *  ^               ^                               ^
> + *  m_dat/m_ext     m_data                          end of buffer
> + */
> +

...but
(a) you should add a comment describing what 'gapsize'
is, ie that there may be a gap between the in-use data and the
start of the allocated buffer, and
(b) m_inc() should change its variable name to match.

thanks
-- PMM
