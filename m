Received: from eggs.gnu.org ([2001:4830:134:3::10]:42405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csZVU-0006AQ-2u
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csZVQ-0005KH-Jd
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:36:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csZVQ-0005JN-DZ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:36:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7054FC05680F
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 18:36:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-11-git-send-email-armbru@redhat.com>
	<405ce7e5-b356-f37e-892d-a39cb3a52fc5@redhat.com>
Date: Mon, 27 Mar 2017 20:36:37 +0200
In-Reply-To: <405ce7e5-b356-f37e-892d-a39cb3a52fc5@redhat.com> (Eric Blake's
	message of "Mon, 27 Mar 2017 12:15:05 -0500")
Message-ID: <87d1d2efd6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 10/11] Revert "rbd: add
 support for getting password from QCryptoSecret object"
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
>> This reverts commit 60390a2192e7b38aee18db6ce7fb740498709737.
>> 
>> The commit's rationale
>> 
>>     Currently RBD passwords must be provided on the command line
>>     via
>> 
>>       $QEMU -drive file=rbd:pool/image:id=myname:\
>>                    key=QVFDVm41aE82SHpGQWhBQXEwTkN2OGp0SmNJY0UrSE9CbE1RMUE=:\
>>                    auth_supported=cephx
>> 
>>     This is insecure because the key is visible in the OS process
>>     listing.
>> 
>> is invalid.  You can easily avoid passing keys on the command line by
>> using "keyfile" instead of "key".  In fact, the Ceph documentation
>> calls use of key "not recommended".  But the most common way to
>> provide keys is a keyring.  The default keyrings should be just fine
>> for most users.  When they aren't, you can configure your own keyrings
>> with "keyring" or override the key with "keyfile".
>> 
>> The commit adds parameter password-secret to -drive.  Support for it
>> was included in -blockdev, but reverted in the previous commit due to
>> concerns about the QMP interface.  Revert it from -drive, too.
>> 
>> Cc: Daniel P. Berrange <berrange@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/rbd.c | 47 -----------------------------------------------
>>  1 file changed, 47 deletions(-)
>
> Are we sure this won't be breaking existing libvirt clients?

I somehow misread the date on commit 60390a2.  It's actually too late to
revert it.  We'll have to live with this.  I'll drop this patch and
rework 11/11.
