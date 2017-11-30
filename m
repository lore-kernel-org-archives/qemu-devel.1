Received: from eggs.gnu.org ([2001:4830:134:3::10]:56395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKOTw-0006Ra-Ex
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKOTq-00085K-Jg
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:02:24 -0500
References: <1512031988-32490-1-git-send-email-thuth@redhat.com>
	<1512031988-32490-4-git-send-email-thuth@redhat.com>
	<CAFEAcA-LBOm=kHja3QJqOw-TT3GF9-i+wJfXdL-FU5NKimknzQ@mail.gmail.com>
	<22aa483a-ede3-482d-88a9-ca1c03c37420@redhat.com>
	<CAFEAcA_0W6AiBG_yqi_HAtZ5ChkOva3WWNRuQ6JbddVYH1sruA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ebd7a7f7-00d2-fc5f-631f-f5d07571648b@redhat.com>
Date: Thu, 30 Nov 2017 14:01:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0W6AiBG_yqi_HAtZ5ChkOva3WWNRuQ6JbddVYH1sruA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 3/7] tests/boot-serial-test: Add
 support for the mcf5208evb board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Anthony Green <green@moxielogic.com>, Laurent Vivier <laurent@vivier.eu>, qemu-arm <qemu-arm@nongnu.org>, Edgar Iglesias <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On 30/11/2017 13:51, Peter Maydell wrote:
> On 30 November 2017 at 12:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 30/11/2017 13:14, Peter Maydell wrote:
>>> On 30 November 2017 at 08:53, Thomas Huth <thuth@redhat.com> wrote:
>>>> +static const uint8_t kernel_mcf5208[] = {
>>>> +    0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
>>>> +    0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
>>>> +    0x11, 0x7c, 0x00, 0x04, 0x00, 0x08,     /* move.b #4,8(%a0)     Enable TX */
>>>> +    0x11, 0x40, 0x00, 0x0c,                 /* move.b %d0,12(%a0)   Print 'T' */
>>>> +    0x60, 0xfa                              /* bra.s  loop */
>>>> +};
>>>
>>> This approach doesn't seem to be scalable to me -- are we
>>> really going to have 50 or more fragments of hand-coded hex in
>>> this file to cover the various board models?
>>>
>>> I'd much rather see us have a framework for being able
>>> to build test blobs from source using a cross compiler
>>> setup (and docker or similar so anybody can rebuild
>>> the test blobs). That will be much easier to maintain
>>> and easier to extend to having tests that test other
>>> parts of the board or other aspects of TCG emulation.
>>
>> It seems a bit overkill, as these snippets are ~16 bytes long.
> 
> They're 16 bytes long because that's about the limit of
> what you can do with this approach. The consequence is that
> they barely test anything at all.

Certainly they are an awful test for boards, but they are a great smoke
test for TCG changes that require modifications in all target/
subdirectories.

The infrastructure you want for integration tests is already provided by
kvm-unit-tests, which satisfies at least bullets 2-4 from your list
below (the first is unclear to me).

Thanks,

Paolo

> A more sensible framework
> would allow:
>  * better testing of TCG instructions more generally
>  * writing your test cases in C
>  * more interesting board dependent tests
>  * "integration test" setups like 'boot entire kernel'
>  * etc
> 
> thanks
> -- PMM
> 
