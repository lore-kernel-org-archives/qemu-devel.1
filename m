Received: from eggs.gnu.org ([2001:4830:134:3::10]:49658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1f6YEY-0003zc-P4
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1f6YEW-0008Mc-2r
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:09:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:12496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1f6YEV-0008Ll-PQ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:09:31 -0400
References: <000001d3c9cf$19f0a190$4dd1e4b0$@gmail.com>
	<29f1952e-325f-0a60-041c-fc651ae33fbb@redhat.com>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <9dee00f1-92bc-3789-f943-c56700e874d9@linux.intel.com>
Date: Thu, 12 Apr 2018 17:09:25 +0800
MIME-Version: 1.0
In-Reply-To: <29f1952e-325f-0a60-041c-fc651ae33fbb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Debugging on HAXM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexandro Sanchez Bach <alexaltea123@gmail.com>, qemu-devel@nongnu.org
Cc: 'Anthony Liguori' <aliguori@us.ibm.com>, 'Glauber Costa' <gcosta@redhat.com>, Yu Ning <yu.ning@intel.com>

Sorry for the very late response.  I completely forgot to check this 
mailbox...  Adding my usual corporate email to the cc.

On 4/2/2018 10:20, Paolo Bonzini wrote:
> On 01/04/2018 17:35, Alexandro Sanchez Bach wrote:
>> I've noticed that `gdb_breakpoint_insert` only considers KVM so far. My
>> question is: Has anyone planned adding debugging support to HAXM? Or is
>> anyone actively working on QEMU's HAXM frontend at all? If not, I would like
>> to work on it myself. Are there any guidelines or things I should take into
>> consideration to work on this accelerator (pinging Anthony and Glauber)?
> The main person working on HAXM is Yu Ning.  Anthony and Glauber are
> only listed because they are the authors of the KVM support (and HAXM
> support in turn is based on KVM).

That is correct, and thanks Paolo for the introduction.  In fact I just 
reviewed a HAXM pull request from Alexandro on GitHub, so we know each 
other already.

>
>> Would it be more reasonable to add debugging support to HAXM [1] directly
>> instead of trying to use the existing APIs from QEMU to achieve the same
>> thing  (I was thinking in patching memory, e.g. with `hlt` instructions, to
>> trigger VM exits)?
> That would probably be less "hackish", but harder too.  It would also
> let you support singlestep and hardware breakpoints---they are often
> better than software breakpoints for debugging if you can live with the
> limit of four breakpoints.
>
> Yu Ning, what do you think?

First of all, I think adding debugging support to HAXM is a great idea, 
and I really look forward to Alexandro's contribution.  But I only know 
the very basics of how breakpoints work, and I'm a little confused after 
reading your discussion.

I guess the "less hackish and harder" approach Paolo referred to is the 
KVM approach, not the patching-with-HLT approach.  If so, I'd agree.  It 
seems KVM implements software breakpoints with memory patching too, 
using the INT 3 instruction, which I think requires the hypervisor to 
handle breakpoint exceptions (#BP).  Is this the sole reason to patch 
with HLT instead of INT 3, to avoid handling #BP in HAXM or perhaps 
avoid modifying the HAXM kernel module at all?

Alexandro, I'm not sure what you mean by not using existing QEMU APIs.  
Surely you still need to add HAXM-specific logic to 
gdb_breakpoint_insert(), etc., otherwise you wouldn't be able to debug 
your guest using the QEMU gdbserver?  Finally, in case you need to add 
any new HAXM APIs, please feel free to propose a design on GitHub, and 
we can continue our discussion there.  Thanks.

-Yu
