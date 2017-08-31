Received: from eggs.gnu.org ([2001:4830:134:3::10]:49144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnSCU-0005pI-Bf
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dnSCP-0008W5-Mb
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:20:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dnSCP-0008Uj-G9
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:20:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95F38C047B86
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 16:20:08 +0000 (UTC)
References: <1503592308-93913-9-git-send-email-imammedo@redhat.com>
	<1504185578-80843-1-git-send-email-imammedo@redhat.com>
	<94cbb70c-5d33-c638-9826-277a359d178e@redhat.com>
	<20170831160440.04b5827d@nial.brq.redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f9058fac-b053-8347-da74-33d7eebed8c1@redhat.com>
Date: Thu, 31 Aug 2017 18:20:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170831160440.04b5827d@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 v4 08/25] s390x: replace
 cpu_s390x_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 31.08.2017 16:04, Igor Mammedov wrote:
> On Thu, 31 Aug 2017 15:44:38 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 31.08.2017 15:19, Igor Mammedov wrote:
>>> cpu_s390x_init() is used only *-user targets indirectly
>>> via cpu_init() macro and has a hack to assign ids to created
>>> cpus (I'm not sure if 'id' really matters to *-user emulation).  
>>
>> It only has one cpu, right? With the below mentioned patch, the default
>> "id"/ (the cpu_addr) will be 0. So you can create one CPU without any
>> hacks. Or can it create more than 1?
> As I understand it creates only one cpu,
> but then there is fork related cpu_copy() which creates a cpu
> and the rewrites new CPUArchState with old cpu data
> 
>     CPUState *new_cpu = cpu_init(cpu_model);                                     
>     CPUArchState *new_env = new_cpu->env_ptr;                                    
>     ...                                                    
>     memcpy(new_env, env, sizeof(CPUArchState));
> 
> so I couldn't decide if id is of importance for *-user target
> (well, I'm not really interested in *-user), and opted for
> keeping current behavior (i.e. not breaking) in this patch
> just without cpu_s390x_init().
> 
> So if 'id' isn't really needed for  *-user target, hunk 2 could be
> dropped but it ought to be another patch on top as this change isn't
> related to the topic of this patch/series.
>  

Indeed, it seems to create a new cpu for every fork. So this is necessary.

-- 

Thanks,

David
