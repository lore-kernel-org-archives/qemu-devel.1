Received: from eggs.gnu.org ([2001:4830:134:3::10]:37511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC7tW-0006Ln-5f
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC7tV-0007X5-8Q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:42:38 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:45881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC7tV-0007WW-26
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:42:37 -0500
Received: by mail-wm0-x243.google.com with SMTP id y80so5435067wmd.0
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 09:42:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <94be963c-ec25-b798-2a8f-c05fbd2d6626@redhat.com>
References: <20171107145546.767-1-richard.henderson@linaro.org>
	<94be963c-ec25-b798-2a8f-c05fbd2d6626@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 17:42:15 +0000
Message-ID: <CAFEAcA8sLn7JK+LN=Zg_DLG14sHXq+HsBMgUtVF0P4sv2KMWCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] target/s390x: Finish
 implementing RISBGN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org

On 7 November 2017 at 16:00, Thomas Huth <thuth@redhat.com> wrote:
> On 07.11.2017 15:55, Richard Henderson wrote:
>> We added the entry to insn-data.def, but failed to update op_risbg
>> to match.  No need to special-case the imask inversion, since that
>> is already ~0 for RISBG (and now RISBGN).
>>
>> Fixes: 375ee58bedcda359011fe7fa99e0647f66f9ffa0
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1701798 (s390x part)
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/s390x/translate.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
>> index dee72a787d..85d0a6c3af 100644
>> --- a/target/s390x/translate.c
>> +++ b/target/s390x/translate.c
>> @@ -3432,6 +3432,7 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
>>      /* Adjust the arguments for the specific insn.  */
>>      switch (s->fields->op2) {
>>      case 0x55: /* risbg */
>> +    case 0x59: /* risbgn */
>>          i3 &= 63;
>>          i4 &= 63;
>>          pmask = ~0;
>> @@ -3447,7 +3448,7 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
>>          pmask = 0x00000000ffffffffull;
>>          break;
>>      default:
>> -        abort();
>> +        g_assert_not_reached();
>>      }
>>
>>      /* MASK is the set of bits to be inserted from R2.
>> @@ -3464,11 +3465,7 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
>>         insns, we need to keep the other half of the register.  */
>>      imask = ~mask | ~pmask;
>>      if (do_zero) {
>> -        if (s->fields->op2 == 0x55) {
>> -            imask = 0;
>> -        } else {
>> -            imask = ~pmask;
>> -        }
>> +        imask = ~pmask;
>>      }
>>
>>      len = i4 - i3 + 1;
>>
>
> Looks good.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Tested-by: Peter Maydell <peter.maydell@linaro.org>

...at least it fixes the simple test case from the bug report.

-- PMM
