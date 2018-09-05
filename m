Received: from eggs.gnu.org ([2001:4830:134:3::10]:39850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxbo3-0001s4-OR
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxbo0-00056M-CM
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:41:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxbo0-00051Z-36
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:41:28 -0400
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-4-git-send-email-robert.hu@linux.intel.com>
	<9e06fe89-2688-1e6e-16ec-d5e8cdc87ce4@redhat.com>
	<1536126475.15675.1.camel@linux.intel.com>
	<20180905141022.GM12698@habkost.net>
	<7273e550-8735-7524-f499-2e0710ed0619@redhat.com>
	<20180905164422.GQ12698@habkost.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d62b4c9-5268-ce3a-6e59-9e39011c2b74@redhat.com>
Date: Wed, 5 Sep 2018 12:41:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180905164422.GQ12698@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, robert.hu@intel.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com, Markus Armbruster <armbru@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On 09/05/2018 11:44 AM, Eduardo Habkost wrote:
> On Wed, Sep 05, 2018 at 10:32:33AM -0500, Eric Blake wrote:
>> On 09/05/2018 09:10 AM, Eduardo Habkost wrote:
>>> Question to the QAPI schema maintainers below:
>>>
>>
>>>>    ##
>>>> -{ 'struct': 'X86CPUFeatureWordInfo',
>>>> -  'data': { 'cpuid-input-eax': 'int',
>>>> -            '*cpuid-input-ecx': 'int',
>>>> -            'cpuid-register': 'X86CPURegister32',
>>>> +{ 'struct': 'X86CPUIDFeatureWordInfo',
>>>> +  'data': { 'input-eax': 'int',
>>>> +            '*input-ecx': 'int',
>>>> +            'register': 'X86CPURegister32',
>>>>                'features': 'int' } }
>>
>> You are renaming the struct (which is not visible over the wire), as well as
>> renaming members within the struct (which is visible, if this type appears
>> on the wire).
>>
>> However, 'grep FeatureWordInfo qapi/qapi-introspect.c' has no hits either
>> before or after this patch (well, first you have to build with my
>> currently-pending patch as part of Markus' pull request for this trick to
>> work, https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg05968.html).
>> Or, even without my patch, grepping for 'input-eax' has no hits as a member
>> name in any struct.  Which means that there are no QMP commands currently
>> exposing this struct over the wire.
> 
> There is one: qom-get.

Oh, right, the nasty exception that is not visible to introspection :(

>>> AFAICS, this will break the existing libvirt code: it will make
>>> qemuMonitorJSONParseCPUx86Features() error out because it won't
>>> find the "input-eax" field on all X86CPUFeatureWordInfo elements.
>>
>> No, this change can't break libvirt, since I just proved there is no QMP
>> command that libvirt could be using that either supplies an input member or
>> expects an output member named "input-eax" in the first place.
> 
> I'm sure it will break libvirt.  libvirt uses
> "qom-get path=<cpu-path> property=feature-words" to get
> X86FeatureWordInfo data, and it expects the returned data to
> have a "input-eax" field.

Yeah, since this type is used in the qom-get backdoor that evades 
introspection, it's even more important that you follow the 
backwards-compatibility rules and not rename or delete any 
previously-mandatory members, since libvirt CAN'T introspect if such 
changes have happened.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
