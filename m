Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E094EC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7041206BA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7041206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0JV-0007Ep-0W
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1iT0Fn-0005gz-Tn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1iT0Fk-0001HX-KU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:08:25 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:58498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1iT0Fk-0001Er-Ak
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:08:24 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id xA898KbB032676
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Nov 2019 10:08:20 +0100
Received: from [167.87.14.235] ([167.87.14.235])
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id xA898J8M018068;
 Fri, 8 Nov 2019 10:08:20 +0100
Subject: Re: [PATCH v2] ivshmem-server: Clean up shmem on shutdown
To: Markus Armbruster <armbru@redhat.com>
References: <d938a62c-7538-9d2b-cc0a-13b240ab9141@web.de>
 <2587815f-e4eb-1f44-0b2d-5b77e3337553@suse.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7c4cb51d-ce45-4324-811b-4674ab9aa691@siemens.com>
Date: Fri, 8 Nov 2019 10:08:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2587815f-e4eb-1f44-0b2d-5b77e3337553@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.138.37.39
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
Cc: Claudio Fontana <claudio.fontana@suse.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.08.19 15:01, Claudio Fontana wrote:
> On 8/5/19 7:54 AM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> So far, the server leaves the posix shared memory object behind when
>> terminating, requiring the user to explicitly remove it in order to
>> start a new instance.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Changes in v2:
>>   - respect use_shm_open
>>   - also clean up in ivshmem_server_start error path
>>
>>   contrib/ivshmem-server/ivshmem-server.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
>> index 77f97b209c..88daee812d 100644
>> --- a/contrib/ivshmem-server/ivshmem-server.c
>> +++ b/contrib/ivshmem-server/ivshmem-server.c
>> @@ -353,6 +353,9 @@ ivshmem_server_start(IvshmemServer *server)
>>   err_close_sock:
>>       close(sock_fd);
>>   err_close_shm:
>> +    if (server->use_shm_open) {
>> +        shm_unlink(server->shm_path);
>> +    }
>>       close(shm_fd);
>>       return -1;
>>   }
>> @@ -370,6 +373,9 @@ ivshmem_server_close(IvshmemServer *server)
>>       }
>>
>>       unlink(server->unix_sock_path);
>> +    if (server->use_shm_open) {
>> +        shm_unlink(server->shm_path);
>> +    }
>>       close(server->sock_fd);
>>       close(server->shm_fd);
>>       server->sock_fd = -1;
>> --
>> 2.16.4
>>
>>
> 
> Reviewed-by: Claudio Fontana <claudio.fontana@suse.com>
> 
> 
> 

Markus, would you take this?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

