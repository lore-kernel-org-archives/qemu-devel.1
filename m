Received: from eggs.gnu.org ([208.118.235.92]:44006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1evPji-0008Qk-C2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nia.alarie@gmail.com>) id 1evPin-00080D-K7
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:51:42 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nia.alarie@gmail.com>)
	id 1evPin-0007yF-Bb
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:50:45 -0400
Received: by mail-lf0-x241.google.com with SMTP id l191-v6so24011737lfe.1
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 08:50:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ad11c22e-294b-d7e3-1589-7c4a42351980@redhat.com>
References: <20180312153344.23453-1-nia.alarie@gmail.com>
	<ad11c22e-294b-d7e3-1589-7c4a42351980@redhat.com>
From: nee <nia.alarie@gmail.com>
Date: Mon, 12 Mar 2018 15:50:43 +0000
Message-ID: <CA+k8WDptLRVNBstB4UEoaorS++_Xqn-j+FHYZhHG1igAJWB-rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] 9p: Convert use of atoi to qemu_strtoi
 to allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, groug@kaod.org, Joel Stanley <joel@jms.id.au>

On Mon, Mar 12, 2018 at 3:43 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/12/2018 10:33 AM, Nia Alarie wrote:
>>
>> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
>> ---
>>   hw/9pfs/9p.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>
>
> Helping out our CI tools:
> Based-on: <20180312124939.20562-1-berrange@redhat.com>
>
>>
>> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
>> index 48fa48e720..254385dfa4 100644
>> --- a/hw/9pfs/9p.c
>> +++ b/hw/9pfs/9p.c
>> @@ -15,6 +15,7 @@
>>   #include <glib/gprintf.h>
>>   #include "hw/virtio/virtio.h"
>>   #include "qapi/error.h"
>> +#include "qemu/cutils.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/iov.h"
>>   #include "qemu/sockets.h"
>> @@ -2213,8 +2214,14 @@ static void coroutine_fn v9fs_create(void *opaque)
>>           }
>>           v9fs_path_copy(&fidp->path, &path);
>>       } else if (perm & P9_STAT_MODE_LINK) {
>> -        int32_t ofid = atoi(extension.data);
>> -        V9fsFidState *ofidp = get_fid(pdu, ofid);
>> +        int ofid;
>
>
> 'unsigned int' and...
>
>> +        V9fsFidState *ofidp;
>> +
>> +        if (qemu_strtoi(extension.data, NULL, 10, &ofid)) {
>
>
> qemu_strtoui() might be smarter, per Greg's comments on v1.
>
>> +            err = -EINVAL;
>> +            goto out;
>> +        }
>> +        ofidp = get_fid(pdu, (int32_t)ofid);
>
>
> This cast is spurious.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

I did this because get_fid() takes an int32_t, not an unsigned int.
The struct V9fsFidState also uses an int32_t for its `fid` member. Do
you want me to change all these types, or just the function being used
here?
