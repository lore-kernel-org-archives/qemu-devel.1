Received: from eggs.gnu.org ([2001:4830:134:3::10]:40127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csZMG-0003Ia-RK
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csZMB-0005L9-6L
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:27:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csZMA-0005Kr-Tq
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:27:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06FD54E048
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 18:27:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-8-git-send-email-armbru@redhat.com>
	<c0b92f66-8e3b-e419-359b-a6b0f986a03d@redhat.com>
Date: Mon, 27 Mar 2017 20:27:04 +0200
In-Reply-To: <c0b92f66-8e3b-e419-359b-a6b0f986a03d@redhat.com> (Max Reitz's
	message of "Mon, 27 Mar 2017 18:42:53 +0200")
Message-ID: <87o9wmeft3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 07/11] rbd: Clean up
 qemu_rbd_create()'s detour through QemuOpts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com

Max Reitz <mreitz@redhat.com> writes:

> On 27.03.2017 15:26, Markus Armbruster wrote:
>> The conversion from QDict to QemuOpts is pointless.  Simply get the
>> stuff straight from the QDict.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  block/rbd.c | 20 +++++---------------
>>  1 file changed, 5 insertions(+), 15 deletions(-)
>> 
>> diff --git a/block/rbd.c b/block/rbd.c
>> index b2afe07..cf0bab0 100644
>> --- a/block/rbd.c
>> +++ b/block/rbd.c
>> @@ -376,7 +376,6 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
>>      rados_t cluster;
>>      rados_ioctx_t io_ctx;
>>      QDict *options = NULL;
>> -    QemuOpts *rbd_opts = NULL;
>>      int ret = 0;
>>  
>>      secretid = qemu_opt_get(opts, "password-secret");
>> @@ -407,19 +406,11 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
>>          goto exit;
>>      }
>>  
>> -    rbd_opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>> -    qemu_opts_absorb_qdict(rbd_opts, options, &local_err);
>> -    if (local_err) {
>> -        error_propagate(errp, local_err);
>> -        ret = -EINVAL;
>> -        goto exit;
>> -    }
>> -
>> -    pool       = qemu_opt_get(rbd_opts, "pool");
>> -    conf       = qemu_opt_get(rbd_opts, "conf");
>> -    clientname = qemu_opt_get(rbd_opts, "user");
>> -    name       = qemu_opt_get(rbd_opts, "image");
>> -    keypairs   = qemu_opt_get(rbd_opts, "=keyvalue-pairs");
>> +    pool       = qdict_get_str(options, "pool");
>> +    conf       = qdict_get_str(options, "conf");
>> +    clientname = qdict_get_str(options, "user");
>> +    name       = qdict_get_str(options, "image");
>> +    keypairs   = qdict_get_str(options, "=keyvalue-pairs");
>
> This assumes that all of these options are given which they are not
> necessarily:
>
> $ ./qemu-img create -f rbd rbd:blub/ 1M
> Formatting 'rbd:blub/', fmt=rbd size=1048576
> [1]    27387 segmentation fault (core dumped)  ./qemu-img create -f rbd
> rbd:blub/ 1M
>
> qdict_get_try_str() would probably be better.

Yes, will fix.  I've fallen into this trap before...
