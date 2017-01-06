Received: from eggs.gnu.org ([2001:4830:134:3::10]:57878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1cPLoI-00089W-Kt
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 23:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1cPLoH-0001Z7-Rx
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 23:07:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170105215704.GD13763@umbus.fritz.box>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1483615579-17618-3-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170105215704.GD13763@umbus.fritz.box>
From: Nikunj Dadhania <nikunj.dadhania@gmail.com>
Date: Fri, 6 Jan 2017 09:37:17 +0530
Message-ID: <CALAZu38dxsVUo4G0QqgpaNgkKNv+hixrk+34UeJsaMNWx7XCNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 02/14] target-ppc: Add xxinsertw
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 6 January 2017 at 03:27, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Thu, Jan 05, 2017 at 04:56:07PM +0530, Nikunj A Dadhania wrote:
>> xxinsertw: VSX Vector Insert Word
>
> I think this still has problems with out of bounds values.
>
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  target-ppc/helper.h                 |  1 +
>>  target-ppc/int_helper.c             | 25 +++++++++++++++++++++++++
>>  target-ppc/translate/vsx-impl.inc.c |  5 +++--
>>  target-ppc/translate/vsx-ops.inc.c  |  1 +
>>  4 files changed, 30 insertions(+), 2 deletions(-)
>>

>> +
>> +#if defined(HOST_WORDS_BIGENDIAN)
>> +    ins_index = index;
>> +    for (i = 0; i < es && ins_index < 16; i++, ins_index++) {
>> +        xt.u8[ins_index] = xb.u8[8 - es + i];
>
> Unlike extract, you don't mod the ins_index here.  Which IIUC, means
> for UIMM > 12 you will overwrite data beyond xt, which sounds like a
> very bad thing.

"ins_index < 16" in for loop will take.

>
>> +    }
>> +#else
>> +    ins_index = 15 - index;
>> +    for (i = es - 1; i >= 0 && ins_index >= 0; i--, ins_index--) {

Here "ins_index >= 0" in for loop will take.

>> +        xt.u8[ins_index] = xb.u8[8 + i];
>> +    }
>> +#endif
>> +
>> +    putVSR(xtn, &xt, env);
>> +}
>> +

Regards
Nikunj
