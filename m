Received: from eggs.gnu.org ([2001:4830:134:3::10]:50911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWlLl-0001i1-Du
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 10:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eWlLi-0005Y8-9T
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 10:53:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eWlLh-0005X4-Vz
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 10:53:02 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w03FnXUT104093
	for <qemu-devel@nongnu.org>; Wed, 3 Jan 2018 10:52:57 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f8w7pp6c9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:52:56 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 3 Jan 2018 08:52:56 -0700
References: <20180102170645.5877-1-danielhb@linux.vnet.ibm.com>
	<ece03c18-76c3-294d-9c2a-778a23e8d9b4@redhat.com>
	<5bfd4a4e-26d9-8595-fc30-43c54b9f6bad@linux.vnet.ibm.com>
	<87po6rvz3o.fsf@dusky.pond.sub.org>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 3 Jan 2018 13:52:50 -0200
MIME-Version: 1.0
In-Reply-To: <87po6rvz3o.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <a8cd8eeb-5baa-06d3-49ff-a0159826c5bb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RESEND 1/1] qmp.c: system_wakeup: adding
 RUN_STATE_SUSPENDED check before proceeding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 01/03/2018 11:41 AM, Markus Armbruster wrote:
> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
>
>> On 01/02/2018 06:03 PM, Eric Blake wrote:
>>> On 01/02/2018 11:06 AM, Daniel Henrique Barboza wrote:
>>>> The qmp/hmp command 'system_wakeup' is simply a direct call to
>>>> 'qemu_system_wakeup_request' from vl.c. This function verifies if
>>>> runstate is SUSPENDED and if the wake up reason is valid before
>>>> proceeding. However, no error or warning is thrown if any of those
>>>> pre-requirements isn't met.
>>>>
>>>> This leads to situations such as the one described in
>>>> https://github.com/open-power-host-os/qemu/issues/31, where one
>>>> can induce the OS to be suspended by using pm-suspend (via
>>>> dompmsuspend, for example) but for some reason the machine failed to
>>>> go to the SUSPENDED runstate, staying at runstate RUNNING. The user
>>>> then tries to wake up the guest using system_wakeup (or dompmwakeup),
>>>> no error is thrown but nothing happened either because the wake up
>>>> wasn't fired at all. In the end, the user is left with a guest that
>>>> is dormant and believing that system_wakeup isn't working.
>>>>
>>>> This patch changes qmp_system_wakeup to make the runstate verification
>>>> before proceeding to call qemu_system_wakeup_request, firing up
>>>> an error message if the user tries to wake up a machine that
>>>> isn't in SUSPENDED state. The change isn't made inside
>>>> qemu_system_wakeup_request because it is used in migration,
>>>> ACPI and others where this usage might be valid. This patch
>>>> by no means fixes the situation described above, but it can direct
>>>> the user/management closer to the real problem.
>>> Converting something that silently did nothing successfully into now
>>> returning an error is somewhat backwards-incompatible.  Is this
>>> something that needs to go through a deprecation cycle, to give people a
>>> chance to fix QMP scripts that were relying on the previous no-op
>>> behavior to now work with the new semantics?
> I doubt it.
>
> We're fixing a silent failure to be "loud".  How exactly could that
> upset applications?
>
> Applications that don't bother to check the result remain exactly as
> broken as before.

That's true.

>
> Applications that do check become aware of the fact that the command did
> not work as advertized.  I guess this risks breaking them differently.
>
> qmp-spec.txt section 5. gives us license to add errors: "Clients must
> not assume any particular [...]  errors generated by a command, that is,
> new errors can be added to any existing command in newer versions of the
> Server.
>
>>> behavior to now work with the new semantics?  Or should we add an
>>> optional bool parameter to the command, where omitting the parameter
>>> gives the old semantics, but new enough clients can pass the bool to
>>> choose which behavior (no-op or error) they prefer?
>> Good point. Back when I first coded this patch I made sure that no QEMU test
>> were broken, but I didn't consider that existing user scripts that uses
>> system_wakeup might now yield a different result.
>>
>> The extra optional parameter seems a good approach to take here IMO. The
>> current system_wakeup implementation works fine if the user is careful
>> enough to not call it if the guest isn't on SUSPENDED state, so I am unsure
>> if deprecating this behavior in favor of this new one is a bit too extreme.
> I'd say we call the silent failure to wake up the guest a bug, and your
> patch a bug fix.

I am fine with this approach, specially after your argument about an
application that doesn't check the result of system_wakeup is already
broken. This patch would simply make the error explicit.


Daniel

>
> I figure we could find precedence for turning broken successful behavior
> into a clean error if we looked for it.
>
