Received: from eggs.gnu.org ([2001:4830:134:3::10]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmQF-0005fm-Dc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmQB-0004wl-El
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csmQB-0004wc-8U
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:24:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DE7C64D86
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 08:24:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-9-git-send-email-armbru@redhat.com>
	<88f70b55-a43b-2515-7150-d0501557256c@redhat.com>
Date: Tue, 28 Mar 2017 10:24:04 +0200
In-Reply-To: <88f70b55-a43b-2515-7150-d0501557256c@redhat.com> (Eric Blake's
	message of "Mon, 27 Mar 2017 14:30:43 -0500")
Message-ID: <8760it4xnf.fsf@dusky.pond.sub.org>
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
>
> There may still be some tweaks to improve the commit message and/or code
> comments to clarify things that tripped me up until later in the
> subthread, but now that I understand the difference between pseudo-file
> format (where the key-value pair backdoor still works for libvirt's
> usage of -drive file=rbd:...) and QemuOpts format (-drive driver=rbd,...
> which didn't really exist in 2.8, and where we don't want to bake in
> something we don't like in 2.9), I agree with the move.

I'm inserting ...

>> Note that users can still configure authentication methods with a
>> configuration file.  They probably do that anyway if they use Ceph
>> outside QEMU as well.

... this hint right here:

   Further note that this doesn't affect use of key "auth-supported" in
   -drive file=rbd:...:key=value.

Good enough?

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
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
