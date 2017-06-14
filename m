Received: from eggs.gnu.org ([2001:4830:134:3::10]:53086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL6sR-0001va-Jf
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL6sP-0001c2-Hy
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:54:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL6sP-0001bv-92
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:54:21 -0400
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
	<1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
	<CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
Date: Wed, 14 Jun 2017 13:54:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, KONRAD Frederic <fred.konrad@greensocs.com>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 13/06/2017 12:33, Peter Maydell wrote:
>> For the migration maybe we can refresh the whole clock tree at the end
>> of the migration. Is that a good idea?
> That seems kind of awkward -- where would this code that did a
> clock tree refresh be? Also you're then reliant on all the
> callback functions registered to not actually do anything that
> affects device state when the refresh happens. It would be
> cleaner if the qemu-clk objects managed their own internal
> state migration (but can we do this without having to make
> them be Device objects rather than just objects ?).
> 
> Cc'd Paolo who might have an opinion on these -- my opinion currently
> is mostly "this doesn't really look right" rather than knowing what
> the right approach is.

Same here. :)

I think the various bindings and rates could be refreshed as devices are
migrated.  This assumes that the device migration order is okay
according to the clock tree, that is if you have three devices X/Y/Z and
five clocks a/b/c/d/e/f:

  fixed-clock
    |     |
   X:a   X:b
    |     |    \
   Y:c   Y:d      Z:e
          |
         Z:f

you could do this:

- migrate X
  - retrieve the PLL ratios for a and b's bound clocks (if the ratio
    is variable, otherwise no need for this)
  - in the post_load callback, bind a and b to the fixed-clock
    (if the binding is variable, otherwise no need for this)
- migrate Y
  - retrieve the PLL ratio for d's bound clocks (if the ratio
    is variable, otherwise no need for this)
  - in the post_load callback, bind c and d to a and b respectively
    (if the binding is variable, otherwise no need for this)
- migrate Z
  - in the post_load callback, bind e and f to b and d respectively
    (if the binding is variable, otherwise no need for this)

Paolo
