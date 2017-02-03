Received: from eggs.gnu.org ([2001:4830:134:3::10]:55791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZbCA-00087F-9I
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZbC7-0000PP-NP
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:34:22 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:5992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cZbC7-0000O2-FZ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:34:19 -0500
References: <1486116298-25046-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486116298-25046-2-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51r33fwpn7.fsf@maestria.local.igalia.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <2937f5b6-b907-0de6-00fb-ee5fae675ed0@huawei.com>
Date: Fri, 3 Feb 2017 11:33:33 +0100
MIME-Version: 1.0
In-Reply-To: <w51r33fwpn7.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2 v15] fsdev: add IO throttle support to
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

On 2/3/2017 11:10 AM, Alberto Garcia wrote:
> On Fri 03 Feb 2017 11:04:57 AM CET, Pradeep Jagadeesh wrote:
>> This patchset adds the io throttle support for the 9p-local driver.
>> For now this functionality can be used only through qemu cli options.
>> QMP interface and support to other 9p drivers need further extensions.
>> To make it simple for other 9p drivers, the throttle code has been put in
>> separate files.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>
> I don't see any difference between this patch and the one in v14...

I moved the fsdev_throttle_cleanup() inside the unrealize() function

You want me to clean up even here ?

out:
        if (rc) {
            /* ... */
            fsdev_throttle_cleanup(s->ctx.fst);
            /* ... */
        }

I thought one place is enough.

Or I did not understand your comment :)

-Pradeep
>
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
> Berto
>
