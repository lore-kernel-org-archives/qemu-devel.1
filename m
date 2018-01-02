Received: from eggs.gnu.org ([2001:4830:134:3::10]:34171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eWHsB-0002Bf-VA
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 03:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eWHs8-0003RM-Ri
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 03:24:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eWHs8-0003Qn-LY
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 03:24:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<20171212164114.GF2409@work-vm>
	<e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
	<b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
	<225a4478-dc5e-a067-f207-e8a183afa0d9@linux.vnet.ibm.com>
	<9b719ebe-8b38-708c-45a7-d377a583f899@redhat.com>
	<5e07b5ea-e8b0-521a-b1af-31017fc52578@redhat.com>
	<87shc3rz5d.fsf@dusky.pond.sub.org>
	<bd60d7e7-8d33-3f87-b6be-89918c1e7ef6@linux.vnet.ibm.com>
Date: Tue, 02 Jan 2018 09:24:28 +0100
In-Reply-To: <bd60d7e7-8d33-3f87-b6be-89918c1e7ef6@linux.vnet.ibm.com>
	(seeteena's message of "Tue, 2 Jan 2018 12:12:49 +0530")
Message-ID: <87mv1w6537.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1] hmp: 'info snapshots' not showing the id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seeteena <s1seetee@linux.vnet.ibm.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, lma@suse.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

seeteena <s1seetee@linux.vnet.ibm.com> writes:

> On 12/22/2017 01:07 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 12/19/2017 08:20 AM, Max Reitz wrote:
>>>
>>>> So there are three things:
>>>>
>>>> (1) We probably should not allow snapshot names that could be IDs.
>>>> Easiest way to solve this: Names have to start with a non-digit.
>>> Yes, that would be a nice change.  It is not strictly backwards
>>> compatible (so we'd still have to cope with images that didn't follow
>>> the rule, whether created by older qemu or by non-qemu implementations
>>> of qcow2), but would alleviate a lot of confusion.
>> I recommend to restrict ID strings to letters, digits, '-', '.', '_',
>> starting with a letter.  Use id_wellformed() to check.
> char *id_generate(IdSubSystems id) autogenates ID in the format eg- 
> "#block146" with starting with '#' always.
> restricting ID strings to use id_wellformed() means we need to force
> ID to start with letter.
>
> #define ID_SPECIAL_CHAR '#' needs to change to (some letter)
> #define ID_SPECIAL_CHAR 'A'

Ensuring auto-generated IDs cannot clash with IDs chosen by the user is
a good idea.  We generally fail to do that in QEMU.

An obvious way to do it is to require the user's IDs to start with a
letter, and auto-generated IDs to start with another suitable character.
In theory, starting with '#' is problematic, because it needs to be
quoted in shell at the beginning of words.  Only matters if
auto-generated IDs make sense in command lines, which I guess they
currently don't.  I'd prefer a 'shell-safe' character all the same.

>> If backward compatibility is an issue, deprecate offending IDs (with a
>> suitable warning), and kill them off after the customary grace period.
>>
>> IDs embedded in image files and such you may have to keep working
>> somehow indefinitely.
