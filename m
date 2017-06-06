Received: from eggs.gnu.org ([2001:4830:134:3::10]:43164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIIsz-0007xN-Qv
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIIsw-0001VF-K8
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:07:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dIIsw-0001Uf-7R
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:07:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56I6PuZ060087
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 14:07:16 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aww80x9jn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 14:07:16 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Jun 2017 14:07:14 -0400
References: <20170602140531.48332-1-pasic@linux.vnet.ibm.com>
	<ad85aa78-b9f1-a2d7-08f6-798601307152@de.ibm.com>
	<36a993c4-f667-28c0-2d45-69fc6a42ed79@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Jun 2017 20:07:08 +0200
MIME-Version: 1.0
In-Reply-To: <36a993c4-f667-28c0-2d45-69fc6a42ed79@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <89a75c33-b27d-704f-896e-2fe19a999d82@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x: vmstatify config migration
 for virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 06/06/2017 08:02 PM, Halil Pasic wrote:
> 
> 
> On 06/06/2017 10:21 AM, Christian Borntraeger wrote:
>> On 06/02/2017 04:05 PM, Halil Pasic wrote:
>>> Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
>>> flexibility (extending using subsections) and for fun.
>>>
>>> To achieve this we need to hack the config_vector, which is VirtIODevice
>>> (that is common virtio) state, in the middle of the VirtioCcwDevice state
>>> representation.  This is somewhat ugly, but we have no choice because the
>>> stream format needs to be preserved.
>>>
>>> Almost no changes in behavior. Exception is everything that comes with
>>> vmstate like extra bookkeeping about what's in the stream, and maybe some
>>> extra checks and better error reporting.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>> ---
>>> @Christian: I have re-tested with 2.5 (because of the rebase).
>>> AFAIU this is pretty much ready to be picked.
>>
>>
>> I wanted to pick this, but it collides with yout patch
>>    s390x/css: catch section mismatch on load
>>
>>
>> Can you rebase it on this patch
>> (see https://github.com/borntraeger/qemu/commits/s390-next)
>>
>>
> 
> Hm, that's tricky because I actually have to do the equivalent
> of 's390x/css: catch section mismatch on load' as part of this.
> I have just sent out an RFC showing in that direction. There
> however I have to touch common vmstate stuff. I have initially
> hoped 's390x/css: catch section mismatch on load' into master
> soon and I can do a 2 patch series on top of that (first
> patch common vmstate stuff, second patch the adaptation of
> this patch).
> 
> Here is a link to my RFC:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg01413.html
> 
> What is in your opinion the best way to resolve this?

I have "s390x/css: catch section mismatch on load" on my next branch and the vmstatify patch
is the only reason why I did not yet send the pull request for the pending patches since I
hoped that I can send both. Since the section mismatch contains cc stable, I actually want it
applied before and a separate patch.
So I will just go ahead and send my patch queue tomorrow (with a pull request on friday) and we 
will handle this patch with the next chunk?
