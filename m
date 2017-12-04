Received: from eggs.gnu.org ([2001:4830:134:3::10]:46445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eLsGL-0006gZ-A2
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eLsGF-0003dH-8o
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:02:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47852
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eLsGF-0003ct-3J
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:02:23 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB4Ewr33011911
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 10:02:20 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2en5a3ksjk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 10:02:20 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 4 Dec 2017 15:02:18 -0000
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-2-pasic@linux.vnet.ibm.com>
	<20171204121027.3acec545.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 4 Dec 2017 16:02:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171204121027.3acec545.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <2b67738e-6ca3-c62a-f6a2-86f448f6ab74@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org



On 12/04/2017 12:10 PM, Cornelia Huck wrote:
> On Fri,  1 Dec 2017 15:31:34 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> The default css 0xfe is currently restricted to virtual subchannel
>> devices. The hope when the decision was made was, that non-virtual
>> subchannel devices will come around when guests can exploit multiple
>> channel subsystems. Since current guests don't do that, the pain of the
>> partitioned (cssid) namespace outweighs the gain.
>>
>> The default css 0xfe is currently restricted to virtual subchannel
>> devices. The hope when the decision was made was, that non-virtual
>> subchannel devices will come around when guest can exploit multiple
>> channel subsystems. Since the guests generally don't do, the pain
>> of the partitioned (cssid) namespace outweighs the gain.
> 
> Doubled paragraph?
> 

Yep. Copy paste mistake.

>>
>> Let us remove the corresponding restrictions (virtual devices
>> can be put only in 0xfe and non-virtual devices in any css except
>> the 0xfe -- while s390-squash-mcss then remaps everything to cssid 0).
>>
>> At the same time, change our schema for generating css bus ids to put
>> both virtual and non-virtual devices into the default css (spilling over
>> into other css images, if needed). The intention is to deprecate
>> s390-squash-mcss. Whit this change devices without a specified devno
> 
> s/Whit/With/

Nod

> 
>> won't end up hidden to guests not supporting multiple channel subsystems,
>> unless this can not be avoided (default css full).
>>
>> Deprecaton of s390-squash-mcss and indicating the changes via QMP is

s/Deprecaton/Deprecation/

>> expected to follow soon (as separate commits).
> 
> Let's drop this paragraph (the qmp interface should be squashed in, and
> you mention the deprecation right above.)
> 
>>
>> The adverse effect of getting rid of the restriction on migration should
>> not be too severe.  Vfio-ccw devices are not live-migratable yet, and for
>> virtual devices using the extra freedom would only make sense with the
>> aforementioned guest support in place.
>>
>> The auto-generated bus ids are affected by both changes. We hope to not
>> encounter any auto-generated bus ids in production as Libvirt is always
>> explicit about the bus id.  Since 8ed179c937 ("s390x/css: catch section
>> mismatch on load", 2017-05-18) the worst that can happen because the same
>> device ended up having a different bus id is a cleanly failed migration.
>> I find it hard to reason about the impact of changed auto-generated bus
>> ids on migration for command line users as I don't know which rules is
>> such an user supposed to follow.
> 
> Should we document somewhere that guests supposed to be migrated should
> make sure that they use explicit devnos?
> 

I think having a document collecting such migration rules and best practices
for command line users (and implicitly also for implementers of management
software) would be a good idea. Maybe there is such a documentation, but
I don't know where. The devnos should be a part of it for sure. But I'm
not volunteering for creating this kind of documentation. Natural languages
aren't my forte.

>>
>> Another pain-point is down- or upgrade of QEMU for command line users.
>> The old way and the new way of doing vfio-ccw are mutually incompatible.
>> Libvirt is only going to support the new way, so for libvirt users, the
>> possible problems at QEMU downgrade are the following. If a domain
>> contains virtual devices placed into a css different than 0xfe the domain
>> will refuse to start with a QEMU not having this patch. Putting devices
>> into a css different that 0xfe however won't make much sense in the near
>> future (guest support). Libvirt will refuse to do vfio-ccw with a QEMU
>> not having this patch. This is business as usual.
> 
> My writing style would be to have this as a shorter, bulleted list -
> but no need to rewrite this if this is understandable to the others on
> cc:
> 

If you want, we can iterate on the description. My primary concern was
to agree on how to advertise this change.

>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>
>> ---
>> Hi!
>>
>> I've factored out the announcing via QMP interface stuff to ease review.
>> I would not mind the two being squashed together before this hits main,
>> as I would much prefer having the two as one (atomic) change. But the
>> second part turned out so controversial, that splitting is expected to
>> benefit the review process.
>>
>> v2 -> v3:
>> * factored out announcing into a separate patch
>> * reworded commit message
>> * removed outdated comment about squash
>>
>> v1 -> v2:
>> * changed ccw bus id generation too (see commit message)
>> * moved the property to the machine (see cover letter)
>> * added a description to the property
>> ---
>>  hw/s390x/3270-ccw.c        |  2 +-
>>  hw/s390x/css.c             | 28 ++++------------------------
>>  hw/s390x/s390-ccw.c        |  2 +-
>>  hw/s390x/s390-virtio-ccw.c |  1 -
>>  hw/s390x/virtio-ccw.c      |  2 +-
>>  include/hw/s390x/css.h     | 12 ++++--------
>>  6 files changed, 11 insertions(+), 36 deletions(-)
>>
> 
>> @@ -2396,19 +2386,8 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
>>                                             bus_id.devid, &schid, errp)) {
>>              return NULL;
>>          }
>> -    } else if (squash_mcss || is_virtual) {
>> -        bus_id.cssid = channel_subsys.default_cssid;
>> -
>> -        if (!css_find_free_subch_and_devno(bus_id.cssid, &bus_id.ssid,
>> -                                           &bus_id.devid, &schid, errp)) {
>> -            return NULL;
>> -        }
>>      } else {
>> -        for (bus_id.cssid = 0; bus_id.cssid < MAX_CSSID; ++bus_id.cssid) {
>> -            if (bus_id.cssid == VIRTUAL_CSSID) {
>> -                continue;
>> -            }
>> -
>> +        for (bus_id.cssid = channel_subsys.default_cssid;;) {
> 
> This looks a bit ugly, but I don't see another compact way to do this.
> 
>>              if (!channel_subsys.css[bus_id.cssid]) {
>>                  css_create_css_image(bus_id.cssid, false);
>>              }
>> @@ -2418,7 +2397,8 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
>>                                                  NULL)) {
>>                  break;
>>              }
>> -            if (bus_id.cssid == MAX_CSSID) {
>> +            bus_id.cssid = (bus_id.cssid + 1) % MAX_CSSID;
>> +            if (bus_id.cssid == channel_subsys.default_cssid) {
>>                  error_setg(errp, "Virtual channel subsystem is full!");
>>                  return NULL;
>>              }
> 
> The interface exposing this change definitely needs to be squashed into
> this patch, but else looks good.
> 

Agree.
