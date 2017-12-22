Received: from eggs.gnu.org ([2001:4830:134:3::10]:58547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eSHu0-0006jQ-Vz
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eSHtx-0000vT-2w
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:37:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eSHtw-0000uq-TG
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:37:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<20171212164114.GF2409@work-vm>
	<e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
	<b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
	<225a4478-dc5e-a067-f207-e8a183afa0d9@linux.vnet.ibm.com>
	<9b719ebe-8b38-708c-45a7-d377a583f899@redhat.com>
	<5e07b5ea-e8b0-521a-b1af-31017fc52578@redhat.com>
Date: Fri, 22 Dec 2017 08:37:50 +0100
In-Reply-To: <5e07b5ea-e8b0-521a-b1af-31017fc52578@redhat.com> (Eric Blake's
	message of "Thu, 21 Dec 2017 17:14:14 -0600")
Message-ID: <87shc3rz5d.fsf@dusky.pond.sub.org>
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
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, seeteena <s1seetee@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lma@suse.com, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 12/19/2017 08:20 AM, Max Reitz wrote:
>
>> So there are three things:
>>
>> (1) We probably should not allow snapshot names that could be IDs.
>> Easiest way to solve this: Names have to start with a non-digit.
>
> Yes, that would be a nice change.  It is not strictly backwards
> compatible (so we'd still have to cope with images that didn't follow
> the rule, whether created by older qemu or by non-qemu implementations
> of qcow2), but would alleviate a lot of confusion.

I recommend to restrict ID strings to letters, digits, '-', '.', '_',
starting with a letter.  Use id_wellformed() to check.

If backward compatibility is an issue, deprecate offending IDs (with a
suitable warning), and kill them off after the customary grace period.

IDs embedded in image files and such you may have to keep working
somehow indefinitely.
