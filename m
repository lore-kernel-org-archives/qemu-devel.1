Received: from eggs.gnu.org ([2001:4830:134:3::10]:51409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csa6N-0008GE-5L
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csa6J-0003l7-SH
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:14:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csa6J-0003kv-NG
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:14:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 993EC80F93
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:14:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-9-git-send-email-armbru@redhat.com>
	<d6cd1529-2f9a-45fe-3bbf-76e7baf5e9d4@redhat.com>
	<87h92eefmf.fsf@dusky.pond.sub.org>
	<a07cf17a-146e-1b5b-e5e5-0456cecb88d1@redhat.com>
Date: Mon, 27 Mar 2017 21:14:44 +0200
In-Reply-To: <a07cf17a-146e-1b5b-e5e5-0456cecb88d1@redhat.com> (Eric Blake's
	message of "Mon, 27 Mar 2017 14:00:15 -0500")
Message-ID: <87lgrq8rbv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev
 and -drive parameter auth-supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, jcody@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 03/27/2017 01:31 PM, Markus Armbruster wrote:
>
>>>> -
>>>> -##
>>>> -# @RbdAuthMethod:
>>>> -#
>>>> -# An enumeration of rados auth_supported types
>>>> -#
>>>> -# Since: 2.9
>>>> -##
>>>> -{ 'struct': 'RbdAuthMethod',
>>>> -  'data': { 'auth': 'RbdAuthSupport' } }
>>>> -
>>>
>>> Removing the .json QMP support is fine. But I'm reluctant to give R-b
>>> without knowing for sure that -drive usage won't regress.
>> 
>> auth-supported landed in master only on March 2nd.
>
> auth-supported via -blockdev-add only landed on March 2nd.  But
> auth-supported via -drive landed in commit 60390a2, Jan 2016; and is in
> use by libvirt:
>
> src/qemu/qemu_command.c:
> ":key=%s:auth_supported=cephx\\;none",

That's a key-value part of the pseudo-filename.  *Not* reverted by this
patch.  Only QemuOpts parameter auth_supported is.

QemuOpts parameter: -drive driver=rbd,auth_supported.0.auth=none,...
Pseudo-filename:    -drive file=rbd:...:auth_supported=none

>> What libvirt usage exactly do you think this could break?
>> 
>
> Libvirt has been managing rbd drives using -drive since at least libvirt
> commit 5745cd1, in Nov 2011, where even back then it was passing:
>             virBufferEscape(opt, ":", ":key=%s:auth_supported=cephx none",
>
> (back when it used space instead of ; to separate the list of supported
> auth types).
>
> As I've never personally used RBD (whether through qemu directly, or
> through libvirt), I'm extremely wary of breaking -drive usage that
> "works" (for some definition of "works"), even though I have no qualms
> making the QMP interface extremely limited.

All clear now?
