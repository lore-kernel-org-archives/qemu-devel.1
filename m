Received: from eggs.gnu.org ([2001:4830:134:3::10]:56161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cotSp-0001n0-CW
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cotSm-0000Bu-6g
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:06:47 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cotSm-0000Bg-13
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:06:44 -0400
Received: by mail-qt0-x243.google.com with SMTP id n37so9791225qtb.3
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 08:06:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <148976155089.11859.11860739290129101204.stgit@bahia>
	<20170317144300.GK8050@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e00c09b-c5c6-1f72-8494-d135f842cd63@amsat.org>
Date: Fri, 17 Mar 2017 12:06:39 -0300
MIME-Version: 1.0
In-Reply-To: <20170317144300.GK8050@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: proxy: assert if unmarshal fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

On 03/17/2017 11:43 AM, Daniel P. Berrange wrote:
> On Fri, Mar 17, 2017 at 03:39:10PM +0100, Greg Kurz wrote:
>> Replies from the virtfs proxy are made up of a fixed-size header (8 bytes)
>> and a payload of variable size (maximum 64kb). When receiving a reply,
>> the proxy backend first reads the whole header and then unmarshals it.
>> If the header is okay, it then does the same operation with the payload.
>>
>> Since the proxy backend uses a pre-allocated buffer which has enough room
>> for a header and the maximum payload size, marshalling should never fail
>> with fixed size arguments. Any error here is likely to result from a more
>> serious corruption in QEMU and we'd better dump core right away.
>>
>> This patch adds error checks where they are missing and converts the
>> associated error paths into assertions.
>>
>> Note that we don't want to use sizeof() in the checks since the value
>> we want to use depends on the format rather than the size of the buffer.
>> Short marshal formats can be handled with numerical values. Size macros
>> are introduced for bigger ones (ProxyStat and ProxyStatFS).

:) maybe this comment should go somewhere in <hw/9pfs/9p-proxy.h>

>> This should also address Coverity's complaints CID 1348519 and CID 1348520,
>> about not always checking the return value of proxy_unmarshal().
>>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
>> ---
>> v2: - added PROXY_STAT_SZ and PROXY_STATFS_SZ macros
>>     - updated changelog
>> ---
>>  hw/9pfs/9p-proxy.c |   24 +++++++++++++-----------
>>  hw/9pfs/9p-proxy.h |   10 ++++++++--
>>  2 files changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
>> index f4aa7a9d70f8..363bea66035e 100644
>> --- a/hw/9pfs/9p-proxy.c
>> +++ b/hw/9pfs/9p-proxy.c
>> @@ -165,7 +165,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
>>          return retval;
>>      }
>>      reply->iov_len = PROXY_HDR_SZ;
>> -    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
>> +    retval = proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
>> +    assert(retval == 8);
>>      /*
>>       * if response size > PROXY_MAX_IO_SZ, read the response but ignore it and
>>       * return -ENOBUFS
>> @@ -194,15 +195,14 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
>>      if (header.type == T_ERROR) {
>>          int ret;
>>          ret = proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
>> -        if (ret < 0) {
>> -            *status = ret;
>> -        }
>> +        assert(ret == 4);
>>          return 0;
>>      }
>>
>>      switch (type) {
>>      case T_LSTAT: {
>>          ProxyStat prstat;
>> +        QEMU_BUILD_BUG_ON(sizeof(prstat) != PROXY_STAT_SZ);
>
> I'd just put this assert at the struct declaration
>
> ..snip...
>
>> diff --git a/hw/9pfs/9p-proxy.h b/hw/9pfs/9p-proxy.h
>> index b84301d001b0..918c45016a3c 100644
>> --- a/hw/9pfs/9p-proxy.h
>> +++ b/hw/9pfs/9p-proxy.h
>> @@ -79,7 +79,10 @@ typedef struct {
>>      uint64_t st_mtim_nsec;
>>      uint64_t st_ctim_sec;
>>      uint64_t st_ctim_nsec;
>> -} ProxyStat;
>> +} QEMU_PACKED ProxyStat;
>> +
>> +#define PROXY_STAT_SZ \
>> +    (8 + 8 + 8 + 4 + 4 + 4 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8)
>
> eg.
>
>   QEMU_BUILD_BUG_ON(sizeof(ProxyStat) !=
>       (8 + 8 + 8 + 4 + 4 + 4 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8));

or

     QEMU_BUILD_BUG_ON(sizeof(ProxyStat) !=
         proxy_unmarshal_calcsize("qqqdddqqqqqqqqqq"));

or eventually stricter using some gcc/clang Statement Expressions:

#define proxy_unmarshal_strict(in_sg, in_sg_sz, offset, fmt, args...) \
     ({ \
         ssize_t retval; \
         retval = v9fs_iov_unmarshal(in_sg, 1, offset, 0, fmt, ##args); \
         QEMU_BUILD_BUG_ON(in_sg_sz != proxy_unmarshal_calcsize(fmt)); \
         retval; \
     })

so we could use:

     retval = proxy_unmarshal_strict(reply, sizeof(reply), 0, "dd",
                                     &header.type, &header.size);

>
>
> Regards,
> Daniel
>
