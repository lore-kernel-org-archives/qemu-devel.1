Received: from eggs.gnu.org ([2001:4830:134:3::10]:51612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fnj58-0000OY-Nh
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fnj57-0006Vy-OU
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:26:18 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fnj57-0006Vt-HB
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:26:17 -0400
Received: by mail-oi0-x242.google.com with SMTP id w126-v6so9174725oie.7
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 04:26:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809111233.GA2619@work-vm>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
	<20180809111233.GA2619@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Aug 2018 12:25:56 +0100
Message-ID: <CAFEAcA-+5xFDMuvK2W8v=Ufs2E1K4y9onZY_4x6RMYbHLFpkxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>, liqsub1 <liqsub1@163.com>

On 9 August 2018 at 12:12, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> diff --git a/slirp/mbuf.c b/slirp/mbuf.c
>> index 0c189e1a7bf..1b7868355a3 100644
>> --- a/slirp/mbuf.c
>> +++ b/slirp/mbuf.c
>> @@ -154,7 +154,7 @@ m_inc(struct mbuf *m, int size)
>>      int datasize;
>>
>>      /* some compilers throw up on gotos.  This one we can fake. */
>> -    if (m->m_size > size) {
>> +    if (M_ROOM(m) > size) {
>>          return;
>>      }
>
> I'm worried about a side effect of this change.
> A few lines below we have:
>
>         datasize = m->m_data - m->m_dat;
>         m->m_ext = g_malloc(size + datasize);
>         memcpy(m->m_ext, m->m_dat, m->m_size);
>         m->m_flags |= M_EXT;
>
> Question: What guarantees there's m_size room for that
> memcpy in the new m_ext?

It did take me a while to convince myself that that was true
when I was writing the patch... Here's the ASCII art:


   |--datasize---->|---m_len------->
   |----------m_size------------------------------>
                   |----M_ROOM-------------------->
                                    |-M_FREEROOM-->

   ^               ^                               ^
   m_dat           m_data                          end of buffer

("datasize" is a bit misnamed, as it's "size of the leading
gap between the start of the buffer and the data"; "gapsize"
would be more helpful.)

Anyway, we allocate size + datasize, and
m_size == datasize + M_ROOM. We know that size >= M_ROOM,
so the allocated buffer must be at least m_size big.

thanks
-- PMM
