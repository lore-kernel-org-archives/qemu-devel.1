Received: from eggs.gnu.org ([2001:4830:134:3::10]:53262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo3Ou-0002bx-L3
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fo3Ot-0002kG-4M
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:08:04 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fo3Os-0002jp-UI
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:08:03 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so14638918oiw.8
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 02:08:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zhxuu4ev.fsf@dusky.pond.sub.org>
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<87zhxuu4ev.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Aug 2018 10:07:41 +0100
Message-ID: <CAFEAcA_N_Btro-jaJXAiWhS9gD1hRkY=y5n0Q+J_k0=sh7TmJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts/checkpatch.pl: Enforce multiline
 comment syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 10 August 2018 at 07:22, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> We now require Linux-kernel-style multiline comments:
>>     /*
>>      * line one
>>      * line two
>>      */
>>
>> Enforce this in checkpatch.pl, by backporting the relevant
>> parts of the Linux kernel's checkpatch.pl. (The only changes
>> needed are that Linux's checkpatch.pl WARN() function takes
>> an extra argument that ours does not.)
>
> Really?  [*]

Yes; the parts that I have taken from checkpatch.pl
are only modified by adjusting the WARN() function calls.

>> The kernel's checkpatch does not enforce "leading /* on
>> a line of its own, so that part is unique to QEMU's checkpatch.
>>
>> Sample warning output:
>>
>> WARNING: Block comments use a leading /* on a separate line
>> #34: FILE: hw/intc/arm_gicv3_common.c:39:
>> +    /* Older versions of QEMU had a bug in the handling of state save/restore
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I'm still not used to the leeading-/*-on-it's-own style,
>> so having checkpatch catch my lapses is handy...
>
> Yes, please!
>
>> I used WARN level severity mostly because Linux does.
>> ---
>>  scripts/checkpatch.pl | 48 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 42e1c50dd80..18bc3c59c85 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1566,6 +1566,54 @@ sub process {
>>  # check we are in a valid C source file if not then ignore this hunk
>>               next if ($realfile !~ /\.(h|c|cpp)$/);
>>
>> +# Block comment styles
>> +
>> +             # Block comments use /* on a line of its own
>> +             if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&      #inline /*...*/
>> +                 $rawline =~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-blank
>> +                     WARN("Block comments use a leading /* on a separate line\n" . $herecurr);
>> +             }
>> +

This is the bit that is "unique to QEMU's checkpatch",
per the commit message.


> [*] The kernel's has
>
>    # Networking with an initial /*
>                    if ($realfile =~ m@^(drivers/net/|net/)@ &&
>                        $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
>                        $rawline =~ /^\+[ \t]*\*/ &&
>                        $realline > 2) {
>                            WARN("NETWORKING_BLOCK_COMMENT_STYLE",
>                                 "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
>                    }
>
> which makes no sense for us.

This is a part which I did not take from kernel checkpatch;
it is not a "relevant part", per the commit message.

> With a corrected commit message:

The commit message still makes sense to me.

> Reviewed-by: Markus Armbruster <armbru@redhat.com>

thanks
-- PMM
