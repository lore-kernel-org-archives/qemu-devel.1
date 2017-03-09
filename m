Received: from eggs.gnu.org ([2001:4830:134:3::10]:34278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm11K-0001oG-Qm
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm11H-0005n4-MD
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:34:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cm11H-0005mu-Fh
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:34:27 -0500
References: <1488985872-22447-1-git-send-email-yang.zhong@intel.com>
	<eb781f48-a5cf-4790-f0e8-4ef083c1e1a4@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c8f4fb6-89c4-84a5-6bbe-8fa849f17764@redhat.com>
Date: Thu, 9 Mar 2017 17:34:24 +0100
MIME-Version: 1.0
In-Reply-To: <eb781f48-a5cf-4790-f0e8-4ef083c1e1a4@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory: reduce heap Rss size around 3M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com



On 08/03/2017 12:17, Philippe Mathieu-Daud=E9 wrote:
> On 03/08/2017 12:11 PM, Yang Zhong wrote:
>> Since cpu-memory and memory have same address space,one malloced
>> memory is enough. This patch will skip memory malloc for memory
>> address space,which will reduce around 3M physical memory in heap.
>>
>> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
>> ---
>>  memory.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/memory.c b/memory.c
>> index 284894b..799ca4c 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -2422,8 +2422,10 @@ AddressSpace
>> *address_space_init_shareable(MemoryRegion *root, const char *name)
>>      AddressSpace *as;
>>
>>      QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>> -        if (root =3D=3D as->root && as->malloced) {
>> -            as->ref_count++;
>> +        if (root =3D=3D as->root) {
>> +            if (as->malloced) {
>> +                as->ref_count++;
>> +            }
>>              return as;
>>          }
>>      }
>>

This is wrong.  If as->malloced is false, the AddressSpace might be
embedded in another struct.  This other struct could be freed when
as->ref_count is still greater than 0, causing a use-after-free bug.

Paolo
