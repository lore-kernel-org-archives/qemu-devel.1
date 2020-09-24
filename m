Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AEEC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B28121D20
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aBouQVcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B28121D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZAS-0000VF-K2
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ9T-0008GX-EQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:51:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLZ9R-0007Nx-M4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 17:51:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLnTeD086561;
 Thu, 24 Sep 2020 21:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FQGfiuaepectu+CIoUSJvXuOOlAqYeYqgVd0DEcZYuQ=;
 b=aBouQVcA39p/7+oNz2hRdZCWaE3K7/WCaPMv22jYZyXXFn5ztw+POFpooMbhnUbqMASx
 VpCPfbSfb1KuoK++mLC7HxyFAk+erC4WnJQnE3RmOoUt3HcBLGC6s3MynCy/VoAYGL7r
 WKqMaWtpyb4nn3j2O8A0ewJNutLqDNtgZXvRJjg6l8ooR1uT2DZ0jbg7zfFLWC7HCaOg
 VCZ88bngB37ZfkUulTe5Bd82IgzEP3M3QNxkxLUhJQ+h0brbIRrj0oGfqsrpbKvSaj2Q
 V0alS+F68DNxD4PGhCM/KX8B3L2E3f32Klhl9RPISl/3kBS6pzrdc8C/mjt+WfKK9cau Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 33q5rgs2qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 21:51:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OLoBrC050370;
 Thu, 24 Sep 2020 21:51:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 33r28xj898-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 21:51:38 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OLpahl009263;
 Thu, 24 Sep 2020 21:51:36 GMT
Received: from [10.39.244.100] (/10.39.244.100)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 14:51:36 -0700
Subject: Re: [PATCH V1 09/32] savevm: prevent cprsave if memory is volatile
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-10-git-send-email-steven.sistare@oracle.com>
 <20200911173512.GO3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <76393627-51be-e0b5-d7b3-bb7ae4aab9ca@oracle.com>
Date: Thu, 24 Sep 2020 17:51:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911173512.GO3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240156
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=steven.sistare@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 16:42:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/2020 1:35 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> cprsave and cprload require that guest ram be backed by an externally
>> visible shared file.  Check that in cprsave.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  exec.c                | 32 ++++++++++++++++++++++++++++++++
>>  include/exec/memory.h |  2 ++
>>  migration/savevm.c    |  4 ++++
>>  3 files changed, 38 insertions(+)
>>
>> diff --git a/exec.c b/exec.c
>> index 6f381f9..02160e0 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -2726,6 +2726,38 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr)
>>      return block->offset + offset;
>>  }
>>  
>> +/*
>> + * Return true if any memory regions are writable and not backed by shared
>> + * memory.  Exclude x86 option rom shadow "pc.rom" by name, even though it is
>> + * writable.
> 
> Tell me about 'pc.rom' - this is a very odd hack.
> Again note the trick done by the existing migration capability
> x-ignore-shared ; it doesn't special case, it just doesn't migrate
> the 'shared' blocks.

pc.rom is indeed a rom.  Its contents do not change, and it can be recreated
from scratch after a restart.  However, the x86 arch code does not mark it
readonly, so there is no proper way to tell it is not volatile, and its
presence blocks cprsave reboot.  Checking for the name "pc.rom" was the only
way to recognize this anomaly, short of modifying the x86 code.

However, I initially developed the above using an old version of qemu, and
a more recent version has fixed it:

pc_memory_init()
    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
                           &error_fatal);
    if (pcmc->pci_enabled) {
        memory_region_set_readonly(option_rom_mr, true);
    }

Now memory_region_is_rom() will correctly classify this segment, and I will
happily delete the hack.

- Steve

>> + */
>> +bool qemu_ram_volatile(Error **errp)
>> +{
>> +    RAMBlock *block;
>> +    MemoryRegion *mr;
>> +    bool ret = false;
>> +
>> +    rcu_read_lock();
>> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +        mr = block->mr;
>> +        if (mr &&
>> +            memory_region_is_ram(mr) &&
>> +            !memory_region_is_ram_device(mr) &&
>> +            !memory_region_is_rom(mr) &&
>> +            (!mr->name || strcmp(mr->name, "pc.rom")) &&
>> +            (block->fd == -1 || !qemu_ram_is_shared(block))) {
>> +
>> +            error_setg(errp, "Memory region %s is volatile",
>> +                       memory_region_name(mr));
>> +            ret = true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    rcu_read_unlock();
>> +    return ret;
>> +}
>> +
>>  /* Generate a debug exception if a watchpoint has been hit.  */
>>  void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>>                            MemTxAttrs attrs, int flags, uintptr_t ra)
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 307e527..6aafbb0 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -2519,6 +2519,8 @@ bool ram_block_discard_is_disabled(void);
>>   */
>>  bool ram_block_discard_is_required(void);
>>  
>> +bool qemu_ram_volatile(Error **errp);
>> +
>>  #endif
>>  
>>  #endif
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 1509173..f101039 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2713,6 +2713,10 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
>>          return;
>>      }
>>  
>> +    if (op == VMS_REBOOT && qemu_ram_volatile(errp)) {
>> +        return;
>> +    }
>> +
>>      f = qf_file_open(file, O_CREAT | O_WRONLY | O_TRUNC, 0600, errp);
>>      if (!f) {
>>          return;
>> -- 
>> 1.8.3.1
>>

