Received: from eggs.gnu.org ([2001:4830:134:3::10]:47358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crLuR-0004kf-H3
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crLuO-0004q5-G6
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1crLuO-0004q0-AH
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:53:24 -0400
References: <1490347615-19222-1-git-send-email-thuth@redhat.com>
	<20170324103837.60533aaf.cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <45fd0904-be57-a3e3-bc2e-9218fc336e7b@redhat.com>
Date: Fri, 24 Mar 2017 10:53:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170324103837.60533aaf.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x/kvm: Fix problem when running
 with SELinux under z/VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On 24.03.2017 10:38, Cornelia Huck wrote:
> On Fri, 24 Mar 2017 10:26:55 +0100
> Thomas Huth <thuth@redhat.com> wrote:
[...]
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index ac47154..5167436 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -678,8 +678,7 @@ static void *legacy_s390_alloc(size_t size, uint64_t *align)
>>  {
>>      void *mem;
>>
>> -    mem = mmap((void *) 0x800000000ULL, size,
>> -               PROT_EXEC|PROT_READ|PROT_WRITE,
>> +    mem = mmap((void *) 0x800000000ULL, size, PROT_READ | PROT_WRITE,
>>                 MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>>      return mem == MAP_FAILED ? NULL : mem;
>>  }
> 
> Wouldn't it be better to adapt the SELinux rules?

I don't think that we want to change the default behavior of SELinux
here, since this is a security feature. Fortunately, there is already a
SELinux configuration variable available which can be used as a workaround:

 setsebool virt_use_execmem 1

But still, it would be nicer, if things worked out of the box instead...

 Thomas
