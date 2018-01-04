Received: from eggs.gnu.org ([2001:4830:134:3::10]:55379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eX8KD-000878-SA
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eX8Jy-00072k-Oe
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:25:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57320
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1eX8Jy-0006R8-6g
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:24:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w04GOESx068742
	for <qemu-devel@nongnu.org>; Thu, 4 Jan 2018 11:24:27 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2f9n8gq3yd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 11:24:26 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Thu, 4 Jan 2018 09:24:26 -0700
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<20171212164114.GF2409@work-vm>
	<e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
	<b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
	<225a4478-dc5e-a067-f207-e8a183afa0d9@linux.vnet.ibm.com>
	<9b719ebe-8b38-708c-45a7-d377a583f899@redhat.com>
	<5e07b5ea-e8b0-521a-b1af-31017fc52578@redhat.com>
	<87shc3rz5d.fsf@dusky.pond.sub.org>
	<bd60d7e7-8d33-3f87-b6be-89918c1e7ef6@linux.vnet.ibm.com>
	<87mv1w6537.fsf@dusky.pond.sub.org>
From: seeteena <s1seetee@linux.vnet.ibm.com>
Date: Thu, 4 Jan 2018 21:54:17 +0530
MIME-Version: 1.0
In-Reply-To: <87mv1w6537.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <bf3bd954-e990-85e2-b7d5-787b6e622fe5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] hmp: 'info snapshots' not showing the id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, lma@suse.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>



On 01/02/2018 01:54 PM, Markus Armbruster wrote:
> seeteena <s1seetee@linux.vnet.ibm.com> writes:
>
>> On 12/22/2017 01:07 PM, Markus Armbruster wrote:
>>> Eric Blake <eblake@redhat.com> writes:
>>>
>>>> On 12/19/2017 08:20 AM, Max Reitz wrote:
>>>>
>>>>> So there are three things:
>>>>>
>>>>> (1) We probably should not allow snapshot names that could be IDs.
>>>>> Easiest way to solve this: Names have to start with a non-digit.
>>>> Yes, that would be a nice change.  It is not strictly backwards
>>>> compatible (so we'd still have to cope with images that didn't follow
>>>> the rule, whether created by older qemu or by non-qemu implementations
>>>> of qcow2), but would alleviate a lot of confusion.
>>> I recommend to restrict ID strings to letters, digits, '-', '.', '_',
>>> starting with a letter.  Use id_wellformed() to check.
>> char *id_generate(IdSubSystems id) autogenates ID in the format eg-
>> "#block146" with starting with '#' always.
>> restricting ID strings to use id_wellformed() means we need to force
>> ID to start with letter.
>>
>> #define ID_SPECIAL_CHAR '#' needs to change to (some letter)
>> #define ID_SPECIAL_CHAR 'A'
> Ensuring auto-generated IDs cannot clash with IDs chosen by the user is
> a good idea.  We generally fail to do that in QEMU.
>
> An obvious way to do it is to require the user's IDs to start with a
> letter, and auto-generated IDs to start with another suitable character.
> In theory, starting with '#' is problematic, because it needs to be
> quoted in shell at the beginning of words.  Only matters if
> auto-generated IDs make sense in command lines, which I guess they
> currently don't.  I'd prefer a 'shell-safe' character all the same.

I was using loaned system from other team for recreate and it appears 
there is some issue in that system and I am not able to recreate the 
issue now.


QEMU 2.11.50 monitor - type 'help' for more information
(qemu) savevm 0
Error while creating snapshot on 'rootdisk'
(qemu) savevm 0
Error while creating snapshot on 'rootdisk'
(qemu) savevm 0
Error while creating snapshot on 'rootdisk'
(qemu) savevm 1
Error while creating snapshot on 'rootdisk'
(qemu)

>
>>> If backward compatibility is an issue, deprecate offending IDs (with a
>>> suitable warning), and kill them off after the customary grace period.
>>>
>>> IDs embedded in image files and such you may have to keep working
>>> somehow indefinitely.
