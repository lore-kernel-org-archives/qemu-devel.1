Received: from eggs.gnu.org ([2001:4830:134:3::10]:50667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fG0YI-0000Si-HV
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fG0YD-0005XS-Fx
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:13:02 -0400
References: <1525774672-11913-1-git-send-email-thuth@redhat.com>
	<20180508124454.1b4a5799.cohuck@redhat.com>
	<7c0e5b23-ef92-141c-ae57-4928fc2962f2@redhat.com>
	<20180508130652.4cf57b8e.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c63070b6-3c98-b77e-87d5-a0eb4ee5603c@redhat.com>
Date: Tue, 8 May 2018 13:12:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180508130652.4cf57b8e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: struct tpi_info must be
 declared as aligned(4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On 08.05.2018 13:06, Cornelia Huck wrote:
> On Tue, 8 May 2018 12:49:59 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 08.05.2018 12:44, Cornelia Huck wrote:
>>> On Tue,  8 May 2018 12:17:52 +0200
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>   
>>>> I've run into a compilation error today with the current version of GCC 8:
>>>>
>>>> In file included from s390-ccw.h:49,
>>>>                  from main.c:12:
>>>> cio.h:128:1: error: alignment 1 of 'struct tpi_info' is less than 4 [-Werror=packed-not-aligned]
>>>>  } __attribute__ ((packed));
>>>>  ^
>>>> cc1: all warnings being treated as errors
>>>>
>>>> Since the struct tpi_info contains an element ("struct subchannel_id schid")
>>>> which is marked as aligned(4), we've got to mark the struct tpi_info as
>>>> aligned(4), too.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  pc-bios/s390-ccw/cio.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
>>>> index 55eaeee..1a0795f 100644
>>>> --- a/pc-bios/s390-ccw/cio.h
>>>> +++ b/pc-bios/s390-ccw/cio.h
>>>> @@ -125,7 +125,7 @@ struct tpi_info {
>>>>      __u32 reserved3  : 12;
>>>>      __u32 int_type   : 3;
>>>>      __u32 reserved4  : 12;
>>>> -} __attribute__ ((packed));
>>>> +} __attribute__ ((packed, aligned(4)));
>>>>  
>>>>  /* channel command word (type 1) */
>>>>  struct ccw1 {  
>>>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>
>>> Alternatively, we could also ditch this struct and the tpi function...
>>> but I have not given up hope yet that we might someday handle channel
>>> I/O more canonically in the bios :)  
>>
>> Yes, it's currently unused (so I think you could also pick up the patch
>> directly, without the need for recompiling the s390-ccw.img just because
>> of this) ... I don't mind too much if we fix it or remove it, but since
>> you've said that it might be useful in the future again, I think we can
>> simply keep it for now.
> 
> Related question: Should this be cc:stable (without a rebuild)? The
> same logic as for the just-merged e500 patch probably applies.

Since the stable releases are normally not built with -Werror, I think
it's ok to not include it there. OTOH it also does not hurt and silences
an annoying warning, and in case somebody tries to build a stable
release with -Werror, it also fixes the build there. So why not, please
add a "Cc: stable" when you pick up the patch.

 Thomas
