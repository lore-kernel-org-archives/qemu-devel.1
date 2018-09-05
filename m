Received: from eggs.gnu.org ([2001:4830:134:3::10]:59120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxZnN-0008Hr-Ej
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxZnJ-0002jj-5K
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:32:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxZnI-0002id-VG
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:32:37 -0400
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-4-git-send-email-robert.hu@linux.intel.com>
	<9e06fe89-2688-1e6e-16ec-d5e8cdc87ce4@redhat.com>
	<1536126475.15675.1.camel@linux.intel.com>
	<20180905141022.GM12698@habkost.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7273e550-8735-7524-f499-2e0710ed0619@redhat.com>
Date: Wed, 5 Sep 2018 10:32:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180905141022.GM12698@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] Change other funcitons referring to
 feature_word_info[]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, robert.hu@intel.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com, Markus Armbruster <armbru@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On 09/05/2018 09:10 AM, Eduardo Habkost wrote:
> Question to the QAPI schema maintainers below:
> 

>>   ##
>> -{ 'struct': 'X86CPUFeatureWordInfo',
>> -  'data': { 'cpuid-input-eax': 'int',
>> -            '*cpuid-input-ecx': 'int',
>> -            'cpuid-register': 'X86CPURegister32',
>> +{ 'struct': 'X86CPUIDFeatureWordInfo',
>> +  'data': { 'input-eax': 'int',
>> +            '*input-ecx': 'int',
>> +            'register': 'X86CPURegister32',
>>               'features': 'int' } }

You are renaming the struct (which is not visible over the wire), as 
well as renaming members within the struct (which is visible, if this 
type appears on the wire).

However, 'grep FeatureWordInfo qapi/qapi-introspect.c' has no hits 
either before or after this patch (well, first you have to build with my 
currently-pending patch as part of Markus' pull request for this trick 
to work, 
https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg05968.html). 
Or, even without my patch, grepping for 'input-eax' has no hits as a 
member name in any struct.  Which means that there are no QMP commands 
currently exposing this struct over the wire.

> 
> 
> Question to the QAPI maintainers: is this really allowed?  With
> this change, data that conforms to the new schema may not conform
> to the old schema, because now the "input-eax" field will become
> optional.

Yes, you can do whatever you want to QAPI structs that are not part of 
the QMP API, since they exist merely to make your C code easier.  You 
don't have to worry about backwards compatibility, because the only 
clients of such structs are being compiled at the same time as you make 
modifications to that struct.  Only once the struct appears in QMP 
introspection do you start having to worry about back-compat.  There, 
the rules are the struct names don't matter, but member names do; if the 
struct is used on input, then removing members is bad, adding mandatory 
members is bad, but adding optional members is okay (older clients don't 
know to pass in the new members, and may continue to pass in the member 
name you no longer want to use); if the struct is used on output, then 
removing non-optional members is bad, removing optional members is okay, 
and adding members is okay (clients are supposed to ignore unknown 
members, but may break if a previously mandatory member disappears).

> 
> AFAICS, this will break the existing libvirt code: it will make
> qemuMonitorJSONParseCPUx86Features() error out because it won't
> find the "input-eax" field on all X86CPUFeatureWordInfo elements.

No, this change can't break libvirt, since I just proved there is no QMP 
command that libvirt could be using that either supplies an input member 
or expects an output member named "input-eax" in the first place.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
