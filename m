Received: from eggs.gnu.org ([2001:4830:134:3::10]:47599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZaQ3-0007uH-2E
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZaPy-0006m2-19
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:44:39 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:5991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZaPx-0006l9-OX
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:44:33 -0500
References: <1485249848-13854-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1485249848-13854-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51a8a6rlsb.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <ef2102fa-7bce-e966-520a-c492d5cb2e5f@huawei.com>
Date: Fri, 3 Feb 2017 10:43:50 +0100
MIME-Version: 1.0
In-Reply-To: <w51a8a6rlsb.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2 v14] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

On 2/1/2017 4:08 PM, Alberto Garcia wrote:
> Hello, and sorry for being late reviewing these patches :)
>
> On Tue 24 Jan 2017 10:24:07 AM CET, Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:
>
>> This patchset adds the io throttle support for the 9p-local driver.
>> For now this functionality can be used only through qemu cli options.
>> QMP interface and support to other 9p drivers need further extensions.
>> To make it simple for other 9p drivers, the throttle code has been put
>> in separate files.
>
> Compared to the previous patch that I reviewed, you removed the
> fsdev_throttle_cleanup() call from v9fs_device_unrealize_common(). Why
> did you do that?
>
I actually missed while merging the code to newer version. Instead of 
putting inside the unrealize it went some other function.

> I miss the list of changes in the cover letter

>> --- a/hw/9pfs/9p.c
>> +++ b/hw/9pfs/9p.c
>> @@ -3520,6 +3520,10 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
>>          error_setg(errp, "share path %s is not a directory", fse->path);
>>          goto out;
>>      }
>> +
>> +    s->ctx.fst = &fse->fst;
>> +    fsdev_throttle_init(s->ctx.fst);
>> +
>>      v9fs_path_free(&path);
>>
>>      rc = 0;
>> @@ -3528,6 +3532,7 @@ out:
>>          if (s->ops && s->ops->cleanup && s->ctx.private) {
>>              s->ops->cleanup(&s->ctx);
>>          }
>> +        fsdev_throttle_cleanup(s->ctx.fst);
>>          g_free(s->tag);
>>          g_free(s->ctx.fs_root);
>>          v9fs_path_free(&path);
>
> You also added the fsdev_throttle_cleanup() here, but look at the code:
>
>        fsdev_throttle_init(s->ctx.fst);
>
>        v9fs_path_free(&path);
>
>        rc = 0;
>    out:
>        if (rc) {
>            /* ... */
>            fsdev_throttle_cleanup(s->ctx.fst);
>            /* ... */
>        }
>
> If rc != 0 you don't need to do the clean up, because there was never an
> initialization.
Fixed it, it was because of merging issue as I answered above.

-Pradeep
>
> Berto
>
