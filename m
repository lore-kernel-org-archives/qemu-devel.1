Received: from eggs.gnu.org ([2001:4830:134:3::10]:45625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dGOYy-00012v-0r
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dGOYt-0003lv-23
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:46:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dGOYs-0003lh-OC
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:46:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51BhqKF139845
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 07:46:41 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ateqd41w1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:46:41 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 12:46:38 +0100
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
	<20170529135520.101429-5-pasic@linux.vnet.ibm.com>
	<87a85sc102.fsf@secure.mitica>
	<4f30017b-22a9-496a-82d2-637a3317c692@linux.vnet.ibm.com>
	<20170601133251.4869b001.cornelia.huck@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 1 Jun 2017 13:46:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170601133251.4869b001.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <8f9e006d-50f1-ac03-568e-5467f86e53e5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/7] s390x/css: add missing css state
 conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@redhat.com



On 06/01/2017 01:32 PM, Cornelia Huck wrote:
> On Thu, 1 Jun 2017 11:35:27 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 05/31/2017 08:52 PM, Juan Quintela wrote:
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>> Although we have recently vmstatified the migration of some css
>>>> infrastructure,  for some css entities there is still state to be
>>>> migrated left, because the focus was keeping migration stream
>>>> compatibility (that is basically everything as-is).
>>>>
>>>> Let us add vmstate helpers and extend existing vmstate descriptions so
>>>> that we have everything we need. Let us guard the added state with via
>>>> css_migration_enabled, so we keep the compatible behavior if css
>>>> migration is disabled.
>>>>
>>>> Let's also annotate the bits which do not need to be migrated for better
>>>> readability.
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> ---
>>>>  hw/intc/s390_flic.c | 20 +++++++++++++++
>>>>  hw/s390x/css.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 94 insertions(+)
>>>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>
>>
>> Thanks!
>>
>>>
>>> For the vmstate bits.  I have exactly zero clue about s390
>>>
>>>> +static const VMStateDescription vmstate_chp_info = {
>>>> +    .name = "s390_chp_info",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_UINT8(in_use, ChpInfo),
>>>> +        VMSTATE_UINT8(type, ChpInfo),
>>>> +        VMSTATE_UINT8(is_virtual, ChpInfo),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>>> +
>>>>  typedef struct SubchSet {
>>>>      SubchDev *sch[MAX_SCHID + 1];
>>>>      unsigned long schids_used[BITS_TO_LONGS(MAX_SCHID + 1)];
>>>> @@ -215,6 +248,19 @@ typedef struct CssImage {
>>>>      ChpInfo chpids[MAX_CHPID + 1];
>>>>  } CssImage;
>>>>  
>>>> +static const VMStateDescription vmstate_css_img = {
>>>> +    .name = "s390_css_img",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .fields = (VMStateField[]) {
>>>> +        /* Subchannel sets have no relevant state. */
>>>> +        VMSTATE_STRUCT_ARRAY(chpids, CssImage, MAX_CHPID + 1, 0,
>>>> +                             vmstate_chp_info, ChpInfo),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +
>>>> +};
>>>
>>>> +static const VMStateDescription vmstate_css = {
>>>> +    .name = "s390_css",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_QTAILQ_V(pending_crws, ChannelSubSys, 1, vmstate_crw_container,
>>>> +                         CrwContainer, sibling),
>>>> +        VMSTATE_BOOL(sei_pending, ChannelSubSys),
>>>> +        VMSTATE_BOOL(do_crw_mchk, ChannelSubSys),
>>>> +        VMSTATE_BOOL(crws_lost, ChannelSubSys),
>>>> +        /* These were kind of migrated by virtio */
>>>> +        VMSTATE_UINT8(max_cssid, ChannelSubSys),
>>>> +        VMSTATE_UINT8(max_ssid, ChannelSubSys),
>>>> +        VMSTATE_BOOL(chnmon_active, ChannelSubSys),
>>>> +        VMSTATE_UINT64(chnmon_area, ChannelSubSys),
>>>> +        VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(css, ChannelSubSys, MAX_CSSID + 1,
>>>> +                0, vmstate_css_img, CssImage),
>>>
>>> I was about to suggest to move css from pointer to an embedded struct,
>>> and then noticed that MAX_CSSID is .... 65535.  I guess that this is

#define MAX_CSSID 255 
("include/hw/s390x/css.h" line 23) 

>>> going to be sparse, very sparse.  Perhaps there is an easier way to
>>> transmit it?
>>>
>>> You are transmiting:
>>>
>>> 65000 structs each of size MAX_CHPID (255) and each element is byte +
>>> byte +byte = 65000 * 255 * 3 = 47 MB.
>>>
>>> If it is really sparse, I think that sending something like a list
>>> of <index in array> <contents> could make sense, no?
>>>
>>> Or I am missunderstanding something?
>>>
>>
>> I think you are misunderstanding. Sparse arrays of pointers were not
>> supported in the first place. Support was added by me recentily (patch
>> 07d4e69 "migration/vmstate: fix array of ptr with nullptrs"). For a null
>> pointer just a single byte is transmitted. So we should be more like
>> around 64KB, given that it is really sparse. Bottom line, the in stream

Given that my calculation is also wrong. The overhead is below 255 bytes
(overhead compared to not transferring anything for null pointers, which
is clearly an unrealistic lower bound case).

>> representation is at least as efficient as the in memory representation.
>>
>> Of course we could do something special for sparse arrays of pointers in
>> general, and indeed, one of the possibilities is a list/vector of non
>> null indexes. 
> 
> Just as discussion fodder: For a run-of-the-mill qemu guest, I'd expect
> a low double-digit number of subchannels in css 0xfe, in subchannel set
> 0, which are clustered right at the beginning, and one chpid (0) in css
> 0xfe.
> 
> As the subchannel id is autogenerated based upon the devno (if
> provided), it is easy to have subchannels in an arbitrary subchannel
> set (of which there are only four), but to get high subchannel ids with
> a lot of empty slots before, you'd have to create a lot (really a lot)
> of devices and then detach most of them again - not a very likely
> pattern.
> 
> The 3270 support does not really change much: one additional subchannel
> (with the same characteristics) and one further chpid. But I don't
> expect many people to use 3270, and it is not (yet) migratable anyway.
> 
> vfio-ccw devices will be in another css (possibly mapped), but they are
> not migrateable either.
> 
> So if we want to optimize, some "nothing of interest beyond that point"
> marker might be useful - but not very.

Thus I do not think we need extra sparse array handling for this. 

(Nevertheless an extra sparse array handling might make sense for
vmstate core, provided there is an use case).

Halil

> 
>>
>> I would like to ask the s390x maintainers (mainly Connie) about the
>> particular case, and the migration maintainers (I spontaneously think of
>> you Juan and Dave) about the general case (If we want to have something
>> like VMSTATE_ARRAY_OF_POINTER_TO_STRUCT_SPARSE).
>>
>> Regards,
>> Halil
>>
>>> Later, Juan.
>>>
> 
> 
