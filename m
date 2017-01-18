Received: from eggs.gnu.org ([2001:4830:134:3::10]:36300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cTvku-0007hf-EJ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cTvkr-0000uU-BE
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:18:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cTvkr-0000tW-2n
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:18:45 -0500
References: <20170117010204.4909-1-ehabkost@redhat.com>
	<309bd499-204d-df07-aa99-9a999cfecabc@linux.vnet.ibm.com>
	<20170118170049.GB3491@thinpad.lan.raisama.net>
	<45e82b29-1ebe-3f34-0cc1-35d60c6044da@linux.vnet.ibm.com>
	<20170118173406.GF3491@thinpad.lan.raisama.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fd9074e6-8b39-9139-415e-cec2a8970a5e@redhat.com>
Date: Wed, 18 Jan 2017 20:18:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170118173406.GF3491@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/9] i386:
 query-cpu-model-expansion test script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

Am 18.01.2017 um 18:34 schrieb Eduardo Habkost:
> On Wed, Jan 18, 2017 at 12:09:28PM -0500, Jason J. Herne wrote:
>> On 01/18/2017 12:00 PM, Eduardo Habkost wrote:
>>> On Tue, Jan 17, 2017 at 10:22:10AM -0500, Jason J. Herne wrote:
>>>> On 01/16/2017 08:01 PM, Eduardo Habkost wrote:
>>>>> This is a follow-up to the series that implements
>>>>> query-cpu-model-expansion. Before including the test script, the
>>>>> series has some fixes to allow the results of
>>>>> query-cpu-model-expansion to be used in the QEMU command-line.
>>>>>
>>>>> The script probably will work on s390x too, but I couldn't test
>>>>> it yet.
>>>>>
>>>>
>>>> Eduardo,
>>>>
>>>> This test seems to mostly work on s390. The only issue I ran into is
>>>> querying host model using tcg only. s390 requires kvm to query the host
>>>> model. Perhaps we could just skip the tcg host test case on s390?
>>>
>>> We could still try to test "host", but add it to a greylist where
>>> errors returned by query-cpu-model-expansion can be non-fatal.
>>> query-cpu-model-expansion model="host" can also fail with KVM if
>>> the host doesn't support CPU models.
>>>
>>
>> David had the idea to just support -cpu host for tcg. We could do that.
>> In the meantime, I'm ok with your greylist idea too. This would allow the
>> script to work properly on s390 right from the start, and we can remove the
>> greylist when s390 supports specifying -cpu host for tcg.
> 
> I believe we will still need to ignore query-cpu-model-expansion
> errors on some cases, otherwise the test script will fail on
> hosts where KVM doesn't support CPU models in KVM.

That is indeed true. For "host" + KVM there would have to be an extra
check. non-fatal error sound right for this case (e.g. a warning)

> 
> But we probably don't need a hardcoded greylist, anyway: we could
> just make the error non-fatal in case the CPU model is not
> reported as migration-safe in query-cpu-definitions.
> 
> But I was wondering:
> 
> 1) Isn't "-cpu host" the default CPU model on s390x on KVM,
>    even if the host doesn't support CPU models?

Yes, it has an inbuilt compatibility mode when specified. If KVM support
for cpu models is missing, using "-cpu host" will work (as it worked on
QEMU versions without cpu model support), doing something like "-cpu
host,vx=on" will not work, as modifying features is not possible (as the
interface for query/config is missing).

Using "host" for all query-cpu-model is forbiden, as we can't tell what
this model looks like.

> 
> 2) Is it really correct to return an error on
>    "query-cpu-model-expansion model=host type=full" if the host
>    doesn't support CPU models?
> 

Yes it is, because there is no way to tell which features there are.
Returning { name: "host", props: {} } would be misleading, as it
would mean that there are no features. Which is wrong. We just can't
tell. It is up to the caller to handle this. E.g. ignoring and
continuing, doing compatibility stuff or simply reporting an error.

Also think about "query-cpu-model-expansion model=host type=static",
which will primarily be used by libvirt on s390x. There is no way to
expand this into a static cpu model. Faking anything will just hide errors.

If "host" can't be expanded, QEMU has to be treated like there is no CPU
model support (as for older QEMU versions).

>    What if it just returned { name: "host", props: {} }
>    on those cases, meaning that the CPU model is valid and
>    usable, but QEMU is unable to provide extra information about
>    it.
> 


-- 

David
