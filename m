Received: from eggs.gnu.org ([2001:4830:134:3::10]:57733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxxfo-00034s-KY
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxxfn-0006oH-UA
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:02:28 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fxxfn-0006nm-Gn
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:02:27 -0400
Received: by mail-oi0-x243.google.com with SMTP id v198-v6so4204487oif.9
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 10:02:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c2d69fb0-fc47-e145-3b24-c7eb6c9cea45@redhat.com>
References: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
	<5c204531-2e59-4166-0325-745e4aa98531@redhat.com>
	<CAFEAcA-Auwy1Mp=L89VYB4xoCG1BFdCWyUjhA4HHFiGmycBjzg@mail.gmail.com>
	<c2d69fb0-fc47-e145-3b24-c7eb6c9cea45@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Sep 2018 18:02:05 +0100
Message-ID: <CAFEAcA-rynobR_maS0ru=MDupjXOVdgnXYFHe0amPZ1zOYAQ1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] scsi: remove lsi53c895a_create() and
 lsi53c810_create() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 6 September 2018 at 17:40, Thomas Huth <thuth@redhat.com> wrote:
> On 2018-09-06 16:50, Peter Maydell wrote:
>> Nothing typically does, but the "modern" style of having QOM objects which
>> use other QOM objects do so by embedding the child object's struct into
>> the struct of the parent requires that the struct definition is available.
>
> But in this case we don't have anything that "inherits" from LSIState,
> so shouldn't we rather follow the "information hiding" principle and
> keep the state local to the lsi53c895a.c file? If you want to use a
> "LSIState *" from another .c file, you can still put an "anonymous"
>
>  struct LSIState;
>  typedef struct LSIState LSIState;

This doesn't work for

typedef struct MySoC {
   MyUART uart;
   LSIState scsi;
   ...
} MySoC;

This isn't inheritance, it's just use ("has-a", not "is-a").

> in a header somewhere without revealing the implementation.
>
> I'm fine with putting the whole LSIState into a header file if we really
> need it, but in this case, I don't see the point.

Looking at the rest of the series there doesn't seem to be
any code that wants to do use-by-embedding, so we can
certainly postpone moving the struct into the header file
until we need it.

thanks
-- PMM
