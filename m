Received: from eggs.gnu.org ([2001:4830:134:3::10]:52962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1drN19-0006Ti-1K
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1drN13-0003Kv-2Q
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:36:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1drN12-0003K7-Pu
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:36:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8BBaCpR006220
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 07:36:35 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cwqmf8k1d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 07:36:35 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 11 Sep 2017 12:36:32 +0100
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
	<20170908152446.14606-5-pasic@linux.vnet.ibm.com>
	<20170911120722.17236996.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 11 Sep 2017 13:36:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170911120722.17236996.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <81215214-82a2-801f-3b5b-f649726f00c6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] s390x/css: fix incorrect length
 indication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/11/2017 12:07 PM, Cornelia Huck wrote:
> On Fri,  8 Sep 2017 17:24:46 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> We report incorrect length via SCSW program check instead of incorrect
>> length check (SCWS word 2 bit 10 instead of bit 9). Since we have there
>> is no fitting errno for incorrect length, and since I don't like what we
>> do with the errno's, as part of the fix, errnos used for control flow in
>> ccw interpretation are replaced with an enum using more speaking names.
> 
> I'm not sure whether this is the way to go. I mainly dislike the size
> of the patch (and the fact that it mixes a fix and a change of function
> signature).

Do you agree that we should move away from POSIX errno codes? I think
if we do, this cant' get much smaller.

> 
> Can we instead choose a mapping for incorrect length, and defer a
> possible rework?
> 

In the commit message, I say that I don't have a fitting errno.
If you tell me which one to use, I would be glad to split this up.
I don't like mixing re-factoring and changing behavior myself.

Can I have your position on the re-factoring (that is let us
imagine I did not change handling for incorrect length)?

> (Another idea would be to have the callback prepare the scsw via helper
> functions. We'd just keep -EAGAIN to keep processing a chain and 0 to
> stop.)
> 

That was my first idea how to improve on this. I should still have the
code (patches), but I'm not sure whether it's clean or lumped together
with other experiments.

After pushing the handling down the call chain (caller would use
inline functions to manipulate SCSW), I've realized that it does
not buy us much/anything expect the better names, while we get
the machine code manipulating the SCSW generated in multiple
instead of in one place. I also showed the results to Dong Jia and
he was ambivalent too: said something like it does look better,
but it ain't better enough to make it worthwhile.

This is why I've decided to go with a less intrusive approach:
just change the names so that it's obvious what's happening.

If you like, I look for those patches and if it ain't too
much work post them as an RFC -- so we have both options in
front of our eyes. 

>>
>> For virtio, if incorrect length checking is suppressed we keep the
>> current behavior (channel-program check).
> 
> Confused. If it is suppressed, there should not be an error, no?

No.

>From VIRTIO 1.0 4.3.1.2  Device Requirements: Basic Concepts

"If a driver did suppress length checks for a channel command, the device
MUST present a check condition if the transmitted data does not contain
enough data to process the command."
(http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-1230001)

So for virtio we have to present a check condition. Architecturally it
might look better if the one refusing is the device and not the CSS, but
for that we would have to change the VIRTIO spec. With the given
constraints a program check is IMHO the best fit.

> 
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/3270-ccw.c    |  24 +++++-----
>>  hw/s390x/css.c         |  67 +++++++++++++++-----------
>>  hw/s390x/virtio-ccw.c  | 128 ++++++++++++++++++++++++-------------------------
>>  include/hw/s390x/css.h |  13 ++++-
>>  4 files changed, 127 insertions(+), 105 deletions(-)
> 
