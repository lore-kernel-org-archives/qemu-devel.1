Received: from eggs.gnu.org ([2001:4830:134:3::10]:33062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2iGb-00088w-II
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2iGa-0001Mu-Kc
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:59:17 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:34893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2iGa-0001MP-De
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:59:16 -0400
Received: by mail-wm0-x22f.google.com with SMTP id w64so3488531wma.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 10:59:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMT9Bn7OPU+h6o2Xj4DZXrVSBHr=jtR6jMSvhph0koegA@mail.gmail.com>
References: <1491736758-19540-1-git-send-email-sundeep.lkml@gmail.com>
	<1491736758-19540-2-git-send-email-sundeep.lkml@gmail.com>
	<CAKmqyKMW-aTdzvTH5sir1BPx6U9XtgiZZ7TVigooXLFMY=UEQg@mail.gmail.com>
	<CALHRZuroavWhKmiZEC6eCh0KFif0dWuQWi=QprH122QnAGjnpA@mail.gmail.com>
	<CAKmqyKMT9Bn7OPU+h6o2Xj4DZXrVSBHr=jtR6jMSvhph0koegA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 18:58:54 +0100
Message-ID: <CAFEAcA_PuC_B6GqL0n==SDZooQj9FtviHK3XixHd=m0Twmfp+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-devel RFC v2 1/4] msf2: Add Smartfusion2
 System timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: sundeep subbaraya <sundeep.lkml@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 24 April 2017 at 18:44, Alistair Francis <alistair23@gmail.com> wrote:
> Basically the simple explanation is that init is called when the
> object is created and realize is called when the object is realized.
>
> Generally for devices it will go something like this:
>  1. init
>  2. Set properties
>  3. Connect things
>  4. realize
>  5. Map to memory
>
>> Don't we need to use realize function for new models?
>
> AFAIK we still put things like: sysbus_init_irq(),
> memory_region_init_io() and sysbus_init_mmio() in the init function.
>
> I don't think we are at a stage yet to not use init functions.

Two-phase init is here to stay -- some things must be done in
init, some must be done in realize, and some can be done in
either. Some simple devices may find they can do everything
in only one function.

Must be done in init:
 * creating properties (for the cases where that is done "by hand"
   by calling object_property_add_*())
 * calling init on child objects which you want to pass through
   alias properties for

Must be done in realize:
 * anything that can fail such that we need to report the
   error and abandon creation of the device
 * anything which depends on the values of QOM properties that
   the caller might have set

We should probably sit down and write up some guidelines for
how we recommend dealing with the various things that could
be called in either function -- this is basically a code
style and consistency question.

thanks
-- PMM
