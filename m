Received: from eggs.gnu.org ([2001:4830:134:3::10]:41336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csZQ6-0004wH-Ud
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csZQ3-0007nZ-Qm
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:31:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csZQ3-0007mQ-JN
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:31:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75B69C05680F
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 18:31:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-9-git-send-email-armbru@redhat.com>
	<d6cd1529-2f9a-45fe-3bbf-76e7baf5e9d4@redhat.com>
Date: Mon, 27 Mar 2017 20:31:04 +0200
In-Reply-To: <d6cd1529-2f9a-45fe-3bbf-76e7baf5e9d4@redhat.com> (Eric Blake's
	message of "Mon, 27 Mar 2017 12:03:04 -0500")
Message-ID: <87h92eefmf.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 03/27/2017 08:26 AM, Markus Armbruster wrote:
>> This reverts half of commit 0a55679.  We're having second thoughts on
>> the QAPI schema (and thus the external interface), and haven't reached
>> consensus, yet.  Issues include:
>> 
>
>> Let's avoid painting ourselves into a corner now, and revert the
>> feature for 2.9.
>> 
>> Note that users can still configure authentication methods with a
>> configuration file.  They probably do that anyway if they use Ceph
>> outside QEMU as well.
>
> If we're only reverting the QMP blockdev-add feature, then this makes
> absolute sense (it's not a regression since we don't have a release with
> it yet, and we don't want to bake something into the release that can't
> be supported).  But breaking -drive usage seems risky, especially since
> libvirt is already expecting to work - I'm worried that doing this may
> break existing libvirt command line usage if the QemuOpts side doesn't
> permit anything at all.  Maybe we need to rely on your '=foo' or 'x-foo'
> hack for letting QemuOpts still accept the old spelling during -drive
> but not during QMP.
>
>> 
>> qemu_rbd_array_opts()'s parameter @type now must be RBD_MON_HOST,
>> which is silly.  This will be cleaned up shortly.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/rbd.c          | 31 +++----------------------------
>>  qapi/block-core.json | 24 ------------------------
>>  2 files changed, 3 insertions(+), 52 deletions(-)
>> 
>
>> +++ b/qapi/block-core.json
>> @@ -2601,27 +2601,6 @@
>>  
>>  
>>  ##
>> -# @RbdAuthSupport:
>> -#
>> -# An enumeration of RBD auth support
>> -#
>> -# Since: 2.9
>> -##
>> -{ 'enum': 'RbdAuthSupport',
>> -  'data': [ 'cephx', 'none' ] }
>> -
>> -
>> -##
>> -# @RbdAuthMethod:
>> -#
>> -# An enumeration of rados auth_supported types
>> -#
>> -# Since: 2.9
>> -##
>> -{ 'struct': 'RbdAuthMethod',
>> -  'data': { 'auth': 'RbdAuthSupport' } }
>> -
>
> Removing the .json QMP support is fine. But I'm reluctant to give R-b
> without knowing for sure that -drive usage won't regress.

auth-supported landed in master only on March 2nd.

What libvirt usage exactly do you think this could break?
