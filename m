Received: from eggs.gnu.org ([2001:4830:134:3::10]:41065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ezT8I-0005R9-2J
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ezT8E-0001Vy-Pw
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:17:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ezT8E-0001VL-J0
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:17:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id l16so5656245wmh.3
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 13:17:46 -0700 (PDT)
References: <20180223152640.11459-1-pbonzini@redhat.com>
	<cb07d198-c73a-a045-cb70-57433c45a5a0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <933679da-c0b1-f1e3-5681-9709bd383143@redhat.com>
Date: Fri, 23 Mar 2018 21:17:44 +0100
MIME-Version: 1.0
In-Reply-To: <cb07d198-c73a-a045-cb70-57433c45a5a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 0/5] atapi: change
 unlimited recursion to while loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org

On 23/03/2018 21:08, John Snow wrote:
> 
> 
> On 02/23/2018 10:26 AM, Paolo Bonzini wrote:
>> Real hardware doesn't have an unlimited stack, so the unlimited
>> recursion in the ATAPI code smells a bit.  In fact, the call to
>> ide_transfer_start easily becomes a tail call with a small change
>> to the code (patch 4).  The remaining four patches move code around
>> so as to the turn the call back to ide_atapi_cmd_reply_end into
>> another tail call, and then convert the (double) tail recursion into
>> a while loop.
>>
>> I'm not sure how this can be tested, apart from adding a READ CD
>> test to ahci-test (which I don't really have time for now, hence
>> the RFC tag).  The existing AHCI tests still pass, so patches 1-3
>> aren't complete crap.
>>
>> Paolo
>>
>> Paolo Bonzini (5):
>>   ide: push call to end_transfer_func out of start_transfer callback
>>   ide: push end_transfer callback to ide_transfer_halt
>>   ide: make ide_transfer_stop idempotent
>>   atapi: call ide_set_irq before ide_transfer_start
>>   ide: introduce ide_transfer_start_norecurse
>>
>>  hw/ide/ahci.c             | 12 +++++++-----
>>  hw/ide/atapi.c            | 37 ++++++++++++++++++++-----------------
>>  hw/ide/core.c             | 37 +++++++++++++++++++++++--------------
>>  include/hw/ide/internal.h |  3 +++
>>  4 files changed, 53 insertions(+), 36 deletions(-)
>>
> 
> LGTM; only comments wound up being naming.

The "PIO setup" FIS though should be sent at the *beginning* of data
transfer according to the spec.  And if that is fixed a bunch of things
are simpler (no end_transfer callback!).  I'll test and send next week.

Paolo
