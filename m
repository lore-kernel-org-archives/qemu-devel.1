Received: from eggs.gnu.org ([2001:4830:134:3::10]:50564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKHYu-0006ST-6b
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 01:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKHTK-0004dW-W7
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 01:37:51 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181019113424.25727-1-armbru@redhat.com>
	<d370d182-01c8-f4ab-ed63-207a9dc4c4d6@redhat.com>
	<87r2fz5ywu.fsf@dusky.pond.sub.org>
	<3b245d71-abe1-9ae2-1671-7d29a1676d70@redhat.com>
Date: Wed, 07 Nov 2018 07:37:45 +0100
In-Reply-To: <3b245d71-abe1-9ae2-1671-7d29a1676d70@redhat.com> (Max Reitz's
	message of "Tue, 6 Nov 2018 01:54:00 +0100")
Message-ID: <877ehpxuiu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block: Make more block drivers
 compile-time configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, jeff@codyprime.org

Max Reitz <mreitz@redhat.com> writes:

> On 05.11.18 16:25, Markus Armbruster wrote:
>> Max Reitz <mreitz@redhat.com> writes:
>> 
>>> On 19.10.18 13:34, Markus Armbruster wrote:
>>>> From: Jeff Cody <jcody@redhat.com>
>>>>
>>>> This adds configure options to control the following block drivers:
>>>>
>>>> * Bochs
>>>> * Cloop
>>>> * Dmg
>>>> * Qcow (V1)
>>>> * Vdi
>>>> * Vvfat
>>>> * qed
>>>> * parallels
>>>> * sheepdog
>>>>
>>>> Each of these defaults to being enabled.
>>>>
>>>> Signed-off-by: Jeff Cody <jcody@redhat.com>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>
>>>> Hmm, we got quite a few --enable-BLOCK-DRIVER now.  Perhaps a single
>>>> list-valued option similar --target-list would be better.  Could be
>>>> done on top.
>>>>
>>>>  block/Makefile.objs | 22 ++++++++---
>>>>  configure           | 91 +++++++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 107 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>>>> index c8337bf186..1cad9fc4f1 100644
>>>> --- a/block/Makefile.objs
>>>> +++ b/block/Makefile.objs
>>    @@ -1,10 +1,18 @@
>>    -block-obj-y += raw-format.o qcow.o vdi.o vmdk.o cloop.o bochs.o vpc.o vvfat.o dmg.o
>>    +block-obj-y += raw-format.o vmdk.o vpc.o
>>    +block-obj-$(CONFIG_QCOW1) += qcow.o
>>    +block-obj-$(CONFIG_VDI) += vdi.o
>>    +block-obj-$(CONFIG_CLOOP) += cloop.o
>>    +block-obj-$(CONFIG_BOCHS) += bochs.o
>>    +block-obj-$(CONFIG_VVFAT) += vvfat.o
>>    +block-obj-$(CONFIG_DMG) += dmg.o
>>    +
>>     block-obj-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o qcow2-cache.o qcow2-bitmap.o
>>>
>>> [...]
>>>
>>>> @@ -45,7 +54,8 @@ gluster.o-libs     := $(GLUSTERFS_LIBS)
>>>>  vxhs.o-libs        := $(VXHS_LIBS)
>>>>  ssh.o-cflags       := $(LIBSSH2_CFLAGS)
>>>>  ssh.o-libs         := $(LIBSSH2_LIBS)
>>>> -block-obj-$(if $(CONFIG_BZIP2),m,n) += dmg-bz2.o
>>>> +block-obj-dmg-bz2$(if $(CONFIG_BZIP2),m,n) += dmg-bz2.o
>>>> +block-obj-$(CONFIG_DMG) += $(block-obj-dmg-bz2-y)
>>>
>>> This defines "block-obj-dmg-bz2m" or "block-obj-dmg-bz2n", so
>>> "block-obj-dmg-bz2-y" is never defined (note both the missing hyphen and
>>> the "m" vs. "y").
>>>
>>> How about:
>>>
>>> block-obj-dmg-bz2-$(CONFIG_BZIP2) += dmg-bz2.o
>> 
>> As far as I can tell, CONFIG_BZIP2 is either undefined or "y".  Thus,
>> block-obj-dmg-bz2-y is either left undefined or set to dmg-bz2.o.
>
> Yes.
>
>> Perhaps the '+=' be ':=', but we seem to use '+=' pretty
>> indiscriminately.
>
> Yep.  I don't know.  Whatever works, and both do, so...
>
>>> block-obj-$(if $(CONFIG_DMG),m,n) += $(block-obj-dmg-bz2-y)
>> 
>> As far as I can tell, CONFIG_DMG is also either undefined or "y".  So,
>> this adds dmg-bz2.o to block-obj-m if both CONFIG_BZIP2 and CONFIG_DMG
>> are enabled.
>
> Yes.
>
>> Shouldn't it be added to block-obj-y, like dmg.o, or am I confused?
>
> The behavior before this patch was to add it to block-obj-m.
> 27685a8dd08c051fa6d641fe46106fc0dfa51073 has the explanation: We want
> the bz2 part to be a module so you can launch qemu even without libbz2
> around.  Only when you use dmg will it load that module.
>
> (And if you dig deeper, it was 88d88798b7efe that (intentionally) broke
>  that intended behavior, until it was restored by the above commit.)

Thanks, v2 sent with your fix.
