Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DE5C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 01:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14ED2158A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 01:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14ED2158A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaUiE-0002nD-Oy
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 20:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1iaUcc-0001Yy-MO
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 19:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1iaUVD-0002J7-D4
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 19:51:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40012 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1iaUV5-0001dW-Ud; Thu, 28 Nov 2019 19:51:13 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id AE28F7235E18717862E2;
 Fri, 29 Nov 2019 08:51:02 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 29 Nov 2019
 08:50:52 +0800
Subject: Re: [PATCH V2] block/nbd: fix memory leak in nbd_open()
To: Stefano Garzarella <sgarzare@redhat.com>
References: <1574942971-49208-1-git-send-email-pannengyuan@huawei.com>
 <20191128133637.gntn2a5jjpepa2sy@steredhat>
From: pannengyuan <pannengyuan@huawei.com>
Message-ID: <d7878021-68b2-d4f6-6f9a-51d8b45551d2@huawei.com>
Date: Fri, 29 Nov 2019 08:50:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191128133637.gntn2a5jjpepa2sy@steredhat>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.120.177.99]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, liyiting@huawei.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019/11/28 21:36, Stefano Garzarella wrote:
> On Thu, Nov 28, 2019 at 08:09:31PM +0800, pannengyuan@huawei.com wrote:
>> From: PanNengyuan <pannengyuan@huawei.com>
>>
>> In currently implementation there will be a memory leak when
>> nbd_client_connect() returns error status. Here is an easy way to
>> reproduce:
>>
>> 1. run qemu-iotests as follow and check the result with asan:
>>     ./check -raw 143
>>
>> Following is the asan output backtrack:
>> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f629688a560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
>>     #1 0x7f6295e7e015 in g_malloc0  (/usr/lib64/libglib-2.0.so.0+0x50015)
>>     #2 0x56281dab4642 in qobject_input_start_struct  /mnt/sdb/qemu-4.2.0-rc0/qapi/qobject-input-visitor.c:295
>>     #3 0x56281dab1a04 in visit_start_struct  /mnt/sdb/qemu-4.2.0-rc0/qapi/qapi-visit-core.c:49
>>     #4 0x56281dad1827 in visit_type_SocketAddress  qapi/qapi-visit-sockets.c:386
>>     #5 0x56281da8062f in nbd_config   /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1716
>>     #6 0x56281da8062f in nbd_process_options  /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1829
>>     #7 0x56281da8062f in nbd_open  /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873
>>
>> Direct leak of 15 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
>>     #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
>>     #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
>>     #3 0x56281da804ac in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1834
>>     #4 0x56281da804ac in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873
>>
>> Indirect leak of 24 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
>>     #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
>>     #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
>>     #3 0x56281dab41a3 in qobject_input_type_str_keyval  /mnt/sdb/qemu-4.2.0-rc0/qapi/qobject-input-visitor.c:536
>>     #4 0x56281dab2ee9 in visit_type_str  /mnt/sdb/qemu-4.2.0-rc0/qapi/qapi-visit-core.c:297
>>     #5 0x56281dad0fa1 in visit_type_UnixSocketAddress_members qapi/qapi-visit-sockets.c:141
>>     #6 0x56281dad17b6 in visit_type_SocketAddress_members  qapi/qapi-visit-sockets.c:366
>>     #7 0x56281dad186a in visit_type_SocketAddress qapi/qapi-visit-sockets.c:393
>>     #8 0x56281da8062f in nbd_config /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1716
>>     #9 0x56281da8062f in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1829
>>     #10 0x56281da8062f in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
>> ---
>> Changes v2 to v1:
>> - add a new function to do the common cleanups (suggested by Stefano Garzarella).
>> ---
>>  block/nbd.c | 26 ++++++++++++++++----------
>>  1 file changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 1239761..f8aa2a8 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -94,6 +94,8 @@ typedef struct BDRVNBDState {
>>  
>>  static int nbd_client_connect(BlockDriverState *bs, Error **errp);
>>  
>> +static void nbd_free_bdrvstate_prop(BDRVNBDState *s);
>> +
>>  static void nbd_channel_error(BDRVNBDState *s, int ret)
>>  {
>>      if (ret == -EIO) {
>> @@ -1486,6 +1488,17 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
>>      }
>>  }
>>  
>> +static void nbd_free_bdrvstate_prop(BDRVNBDState *s)
>> +{
>> +    object_unref(OBJECT(s->tlscreds));
>> +    qapi_free_SocketAddress(s->saddr);
>> +    g_free(s->export);
>> +    g_free(s->tlscredsid);
>> +    if (s->x_dirty_bitmap) {
>        ^ it is not needed, g_free() handles NULL pointers.
>> +        g_free(s->x_dirty_bitmap);
>> +    }
>> +}
>> +
> 
> Please, split this patch in two patches:
> - the first patch where you add this function and use it in
>   nbd_process_options() and nbd_close()
> - the second patch where you fix the leak in nbd_open()
> 
> Thanks,
> Stefano

Thanks, I will change and split it in next version.

> 
>>  /*
>>   * Parse nbd_open options
>>   */
>> @@ -1855,10 +1868,7 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
>>  
>>   error:
>>      if (ret < 0) {
>> -        object_unref(OBJECT(s->tlscreds));
>> -        qapi_free_SocketAddress(s->saddr);
>> -        g_free(s->export);
>> -        g_free(s->tlscredsid);
>> +        nbd_free_bdrvstate_prop(s);
>>      }
>>      qemu_opts_del(opts);
>>      return ret;
>> @@ -1881,6 +1891,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
>>  
>>      ret = nbd_client_connect(bs, errp);
>>      if (ret < 0) {
>> +        nbd_free_bdrvstate_prop(s);
>>          return ret;
>>      }
>>      /* successfully connected */
>> @@ -1937,12 +1948,7 @@ static void nbd_close(BlockDriverState *bs)
>>      BDRVNBDState *s = bs->opaque;
>>  
>>      nbd_client_close(bs);
>> -
>> -    object_unref(OBJECT(s->tlscreds));
>> -    qapi_free_SocketAddress(s->saddr);
>> -    g_free(s->export);
>> -    g_free(s->tlscredsid);
>> -    g_free(s->x_dirty_bitmap);
>> +    nbd_free_bdrvstate_prop(s);
>>  }
>>  
>>  static int64_t nbd_getlength(BlockDriverState *bs)
>> -- 
>> 2.7.2.windows.1
>>
>>
>>
> 


