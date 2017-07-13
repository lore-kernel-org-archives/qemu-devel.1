Received: from eggs.gnu.org ([2001:4830:134:3::10]:53236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVchD-0003Vg-TK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dVch9-000848-V5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:54:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dVch9-00083f-Ka
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:54:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DBs7xp069367
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:54:09 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3rcyyw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:54:08 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 12:54:06 +0100
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-2-ehabkost@redhat.com>
	<91940c7e-3685-26e0-e8f9-e050afcd28b5@linux.vnet.ibm.com>
	<20170712182929.GI6020@localhost.localdomain>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 13 Jul 2017 13:54:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170712182929.GI6020@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <640df239-d674-747d-d6d1-692030908c43@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev: fix the order compat and global
 properties are applied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>



On 07/12/2017 08:29 PM, Eduardo Habkost wrote:
> On Wed, Jul 12, 2017 at 07:33:15PM +0200, Halil Pasic wrote:
>>
>>
>> On 07/11/2017 02:43 AM, Eduardo Habkost wrote:
>>> From: Greg Kurz <groug@kaod.org>
>>>
>>> The current code recursively applies global properties from child up to
>>> parent types. This can cause properties passed with the -global option to
>>> be silently overridden by internal compat properties.
>>>
>>> This is exactly what happens with virtio-*-pci drivers since commit:
>>>
>>> "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour"
>>>
>>> Passing -device virtio-blk-pci.disable-modern=off has no effect on 2.6
>>> machine types because the internal virtio-pci.disable-modern=on compat
>>> property always prevail.
>>>
>>> This patch fixes the issue by reversing the logic: we now go through the
>>> global property list and, for each property, we check if it is applicable
>>> to the device.
>>>
>>> This result in compat properties being applied first, in the order they
>>> appear in the HW_COMPAT_* macros, followed by global properties, in they
>>> order appear on the command line.
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> Message-Id: <148103887228.22326.478406873609299999.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>>  hw/core/qdev-properties.c | 15 ++-------------
>>>  1 file changed, 2 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>> index f11d578..41cca9d 100644
>>> --- a/hw/core/qdev-properties.c
>>> +++ b/hw/core/qdev-properties.c
>>> @@ -1148,8 +1148,7 @@ int qdev_prop_check_globals(void)
>>>      return ret;
>>>  }
>>>
>>> -static void qdev_prop_set_globals_for_type(DeviceState *dev,
>>> -                                           const char *typename)
>>> +void qdev_prop_set_globals(DeviceState *dev)
>>>  {
>>>      GList *l;
>>>
>>> @@ -1157,7 +1156,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
>>>          GlobalProperty *prop = l->data;
>>>          Error *err = NULL;
>>>
>>> -        if (strcmp(typename, prop->driver) != 0) {
>>> +        if (object_dynamic_cast(OBJECT(dev), prop->driver) == NULL) {
>>>              continue;
>>>          }
>>>          prop->used = true;
>>> @@ -1175,16 +1174,6 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
>>>      }
>>>  }
>>>
>>> -void qdev_prop_set_globals(DeviceState *dev)
>>> -{
>>> -    ObjectClass *class = object_get_class(OBJECT(dev));
>>> -
>>> -    do {
>>> -        qdev_prop_set_globals_for_type(dev, object_class_get_name(class));
>>> -        class = object_class_get_parent(class);
>>> -    } while (class);
>>> -}
>>> -
>>>  /* --- 64bit unsigned int 'size' type --- */
>>>
>>>  static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
>>>
>>
>> Code looks good to me. Given that high profile people are happy with the
>> patch I won't object on the behavior aspect which I don't understand fully.
>> Thus:
>>
>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>
>>
>> Now a couple of questions for keeping  my clear conscience:
>> * What did we test? Since this patch is fixing a problem it
>> changes behavior. Did we test if there is something that breaks?
>>
>> * The previous version seems to establish a (somewhat strange)
>> precedence for the case the same device property (storage object)
>> is set via multiple super-classes (e.g. set both by parent and
>> parents parent). This seems to have at least been possible,
>> and technically it still is I guess. Now instead of most general
>> (super class) wins we have last added property wins. I assume it
>> isn't a problem, because we don't have something obscure like that.
>> Or am I wrong? This obviously connects to the first question.
>> (By the way, most specialized wins would not have been that
>> surprising given how inheritance and OO usually works. My assumption
>> that nobody used this obscure mechanism is largely based on it's
>> strangeness).
> 
> Note that we are not changing the behavior when the classes
> themselves set different defaults.  Subclasses are still free to
> override defaults set by superclasses inside QEMU code, and they
> will be unaffected by this series.  What we are changing here are
> the semantics of the -global command-line option when applied to
> superclasses.

I was not referring to this.

> 
> The main sources of global properties we have are:
> * MachineClass::compat_props> * -global command-line option

I was thinking about these two.

> * -cpu command-line option
> 
> The behavior on the compat_props case was addressed by the hack
> in commit 0bcba41f "machine: Convert abstract typename on
> compat_props to subclass names".  This means compat_props was
> already following the order in which properties were registered.

I disagree. Commit 0bcba41f affects only *abstract* classes. So
your statement is true if a non-abstract class inheriting form
device can only have abstract ancestor classes. I'm not aware
such rule exists in QEMU, and according to your reply to my comment
on patch 2 there are even people using non-abstract superclasses
for devices.

Since I don't tend to trust myself with constructing proofs
for such stuff in my head, I've tried out my hypothesis before
making my review.

This is the patch I used to verify my hypothesis:
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 41ca666..d524cd0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -445,6 +445,10 @@ static const TypeInfo ccw_machine_info = {
             .property = "max_revision",\
             .value    = "0",\
         },{\
+            .driver   = "virtio-ccw-device",\
+            .property = "max_revision",\
+            .value    = "1",\
+        },{\
             .driver   = "virtio-balloon-ccw",\
             .property = "max_revision",\
             .value    = "0",\
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index e18fd26..6992697 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1666,7 +1666,7 @@ static const TypeInfo virtio_ccw_device_info = {
     .instance_size = sizeof(VirtioCcwDevice),
     .class_init = virtio_ccw_device_class_init,
     .class_size = sizeof(VirtIOCCWDeviceClass),
-    .abstract = true,
+    .abstract = false,
 };
 
 /* virtio-ccw-bus */

Unfortunately it's virtio-ccw because I'm most familiar with that,
and I knew immediately how can I construct the situation I have in
mind there.

What we observe as the effect of this patch before your patch
both my virtio-ccw-blk and virtio-ccw-net were revision 1
when running a s390-ccw-virtio-2.4 (more general takes precedence).
After your patch series, since  virtio-ccw-net is further down in
the list, it ended up being revision 0 (virtio-ccw-blk remained
1 as my change was inserted after the property for virtio-ccw-blk
but before the property for virtio-ccw-net (in the array of
compat_prpos).

Do you agree, or should I re-check my experiment and maybe also
look for some example you can run on amd64.

> In this case there should be no behavior change, and we have
> something to test: check if the original bug[1] (where -global
> was unable to override compat_props) is still fixed.
> 
> However, the behavior of -global will change if the user
> specifies command-line options that contradict each other.  I
> don't believe users rely on that behavior, and the old behavior
> was a bug and not a feature.  In this case we can test it, but
> the behavior change is intentional.

I don't think old behavior was sane, that's why I gave my r-b
without insisting on the for me open questions.

Btw. I would not call that contradicting. But it certainly
is not something our users should rely on because (as we concluded
in the discussion at patch 2), using -global for a superclass is
not documented.

> 
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg416670.html
>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg416985.html
> 
