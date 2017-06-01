Received: from eggs.gnu.org ([2001:4830:134:3::10]:59632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dGMg8-0005if-II
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dGMg5-0000J8-EC
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:46:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dGMg5-0000IA-0h
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:46:01 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v519i4Rg144008
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 05:45:59 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2atfwha6p2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:45:59 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 10:45:56 +0100
References: <20170529131716.94338-1-pasic@linux.vnet.ibm.com>
	<87mv9sc2sk.fsf@secure.mitica>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 1 Jun 2017 11:45:53 +0200
MIME-Version: 1.0
In-Reply-To: <87mv9sc2sk.fsf@secure.mitica>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <00cb5dd9-7d21-a680-9d5e-401720e034c4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: vmstatify config migration for
 virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 05/31/2017 08:13 PM, Juan Quintela wrote:
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>> Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
>> flexibility (extending using subsections) and for fun.
>>
>> To achieve this we need to hack the config_vector, which is VirtIODevice
>> (that is common virtio) state, in the middle of the VirtioCcwDevice state
>> representation.  This somewhat ugly, but we have no choice because the
>> stream format needs to be preserved.
>>
>> Almost no changes in behavior. Exception is everything that comes with
>> vmstate like extra bookkeeping about what's in the stream, and maybe some
>> extra checks and better error reporting.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
>> +static void subch_dev_pre_save(void *opaque)
>> +{
>> +    SubchDev *s = opaque;
>> +
>> +    /* Prepare remote_schid for save */
>> +    s->migrated_schid = s->schid;
>> +}
>> +
>> +static int subch_dev_post_load(void *opaque, int version_id)
>> +{
>> +
>> +    SubchDev *s = opaque;
>> +
>> +    /* Re-assign the subchannel to remote_schid if necessary */
>> +    if (s->migrated_schid != s->schid) {
>> +        if (css_find_subch(true, s->cssid, s->ssid, s->schid) == s) {
> 
> I am assuming this is somehow similar to
>    old_s = channel_subsys.css[s->cssid]->sch_set[s->ssid]->sch[old_schid];
> 

That's right. A quick glance at the return statement(s) of css_find_subch
makes it very obvious. But css_find_subch does some null checks and may
differently for cssid == 0 (which does not matter here).

>> -    qemu_put_be32(f, s->curr_status.pmcw.intparm);
>> -    qemu_put_be16(f, s->curr_status.pmcw.flags);
>> -    qemu_put_be16(f, s->curr_status.pmcw.devno);
>> -    qemu_put_byte(f, s->curr_status.pmcw.lpm);
>> -    qemu_put_byte(f, s->curr_status.pmcw.pnom);
>> -    qemu_put_byte(f, s->curr_status.pmcw.lpum);
>> -    qemu_put_byte(f, s->curr_status.pmcw.pim);
>> -    qemu_put_be16(f, s->curr_status.pmcw.mbi);
>> -    qemu_put_byte(f, s->curr_status.pmcw.pom);
>> -    qemu_put_byte(f, s->curr_status.pmcw.pam);
> 
> I hope it somehow makes sense, I am having trouble following that you
> have fields named: pim, pam, pom, pnom, lpm, lpum, mda, mba ..... looks
> like hell for reviewing O:-)
> 
> And I thought that x86 was weird because it used all three letters
> acronyms
> 
> O:-)

nod

> 
> Later, Juan.
> 

Many thanks for the review and the r-b!

Regards,
Halil
