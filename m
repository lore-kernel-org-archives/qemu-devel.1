Received: from eggs.gnu.org ([2001:4830:134:3::10]:47292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ctwfH-0001Lr-G5
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ctwfE-0005BD-2g
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:32:31 -0400
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <1490894892-8055-1-git-send-email-minyard@acm.org>
	<0715ab2d-f367-03ef-1674-4c1e67756f85@redhat.com>
	<71b59e1b-caf0-d7b0-0648-b98d62e66c6b@acm.org>
	<f99214c2-6a18-5ab0-c6af-75590cc8d5fd@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <f0dd4986-add0-b3d5-745e-e56ca0d23a22@acm.org>
Date: Fri, 31 Mar 2017 08:32:23 -0500
MIME-Version: 1.0
In-Reply-To: <f99214c2-6a18-5ab0-c6af-75590cc8d5fd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9? v2 resend] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ed Maste <emaste@freebsd.org>, Corey Minyard <cminyard@mvista.com>

On 03/30/2017 03:00 PM, Eric Blake wrote:
> On 03/30/2017 02:10 PM, Corey Minyard wrote:
>
>>> Already reviewed by me, so now I'm just adding commentary: Is this still
>>> 2.9 material?  It silences a build warning under clang, although I
>>> didn't analyze whether the unpatched code actually caused an observable
>>> behavior bug or just compiler noise.
>>>
>> I don't believe the code has a bug, going through all the uses there is
>> no expression used as a parameter or set used in an expression.
> Actually, let's re-read the clang warning, posted by Ed - we DO have an
> expression used as a parameter:
>
>> Found via Clang warning: logical not is only applied to the left hand
>> side of this bitwise operator [-Wlogical-not-parentheses]
>>
>>                                !IPMI_BT_GET_HBUSY(ib->control_reg));
>>                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> expanded from macro 'IPMI_BT_SET_HBUSY'
>>                                         (((v & 1) << IPMI_BT_HBUSY_BIT)))
>>                                            ^ ~
> But we STILL have to audit to see if that expression used as a parameter
> causes a bug:
>
>          if (IPMI_BT_GET_HBUSY(val)) {
>              /* Toggle */
>              IPMI_BT_SET_HBUSY(ib->control_reg,
>                                !IPMI_BT_GET_HBUSY(ib->control_reg));
>          }
>
> with the expectation that it will toggle the bit.  But does it really?
>
> Unpatched, it expands to this:
>
> (ib->control_reg) = (((ib->control_reg) & ~IPMI_BT_HBUSY_MASK) |
>    (((!IPMI_BT_GET_HBUSY(ib->control_reg) & 1) << IPMI_BT_HBUSY_BIT)))
>
> Everything left of the | is okay, but to the right, this further expands to:
>
> (((!(((ib->control_reg) >> IPMI_BT_HBUSY_BIT) & 0x1) & 1) <<
> IPMI_BT_HBUSY_BIT))
>
> Since the inner expression of IPMI_BT_GET_HBUSY(ib->control_reg) is
> properly parenthesized and always 0 or 1, it boils down to either:
>
> (!0 & 1) << shift // 1 & 1, results in changing the HBUSY from 0 to 1
> (!1 & 1) << shift // 0 & 1, results in changing the HBUSY from 1 to 0
>
> so we actually achieve the toggle we wanted.  If I'm reading it
> correctly, the clang warning is asking if we instead meant:
>
> (!(0 & 1)) << shift // !0, results in changing the HBUSY from 0 to 1
> (!(1 & 1)) << shift // !1, results in changing the HBUSY from 1 to 0
>
> which, perhaps surprisingly, would have the same end results for all our
> inputs (but ONLY because the value we are passing to ! is already
> limited to the range of 0 and 1).
>
> Post-patch, we are changing to an expansion of:
>
> ((ib->control_reg) = (((ib->control_reg) & ~IPMI_BT_HBUSY_MASK) |
>    (((!IPMI_BT_GET_HBUSY(ib->control_reg)) & 1) << IPMI_BT_HBUSY_BIT)))
>
> Again, everything to the left of | is okay, to the right further expands to:
>
> (((!(((ib->control_reg) >> IPMI_BT_HBUSY_BIT) & 0x1)) & 1) <<
> IPMI_BT_HBUSY_BIT)
>
> which now boils down to either:
>
> (!(0) & 1) << shift
> (!(1) & 1) << shift
>
> where we are now being explicit that we want the ! bound only to the
> left argument, and not to the overall (a&b) expression.  But we are not
> changing semantics, and therefore not fixing an observable bug.
>
> Note, on the other hand, that a call such as
> IPMI_BT_SET_HBUSY(ib->control_reg, 2) would result in writing 0 to the
> HBUSY bit. In other words, the IPMI_BT_SET_HBUSY() macro is rather weird
> in that it sets or clears the HBUSY bit based solely on whether its v
> parameter is even or odd, rather than the more usual semantics of
> whether the v parameter is 0 or non-zero.  We could change that if we
> wanted - by having the macro expand to "(left | (!!(v) << shift))"
> instead of our current expansion of "(left | (((v) & 1) << shift))" -
> but I still don't think it would change the semantics of any existing
> caller.

Yeah, that would be better.  Should I do another patch?

-corey

>> That said, it's also not going to hurt anything and it's nice to silence
>> the
>> warnings.
> I don't know if there were other warnings or just the one on the use of
> IPMI_BT_SET_BUSY(); it may well be that auditing one of the other
> warnings may turn up an actual behavioral change, but at this point, I'm
> doubting that we are doing any more than shutting up the compiler, and
> working around compiler noise is not the same level of bug fix as an
> actual behavior change.  I'm not opposed to this patch going into 2.9,
> but I don't see any problem if it slips to 2.10.
>
