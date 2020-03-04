Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD2BC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6387D20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 18:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hgkIT2Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6387D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Z4G-0001mx-Kx
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 13:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j9Z19-0007Gn-N8
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j9Z18-0000KJ-3B
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:45:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j9Z17-0000I9-PM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 13:45:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024IY59Q015663;
 Wed, 4 Mar 2020 18:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tbTlCgiuYflgGp6+gRPZjnB6kJoc0NwDzOQR5O8Hj34=;
 b=hgkIT2Ilmg8axJti3VCVK79yVirkH8u4nWYd5q5SAwJ3Dih3/H6ps19Rjsj4QZBAQ5Qt
 HeBZCf5KJacmOGRxnkt4T3mpDuaAAMPs+zYtCJXKqf1SPzKa287wbyi9rASxXxYJDDH6
 MW1BGIBRROWQ7oGvJraUhD+hStrKQhfplzsUXJHr2G5UJzgSKdGgTscqyoZbLZDlV4h7
 r0/C+tIzE7/cmP3dVpTBU0FDPFKYS91Ro2BAS78It3lAnQiHI6cZV1Q8L9+/wSq+Ut9y
 XGrm7jz4PFCLg2CjVCiTNbXkILH3kQhL/Wzno3lHLNwpiRytxvVdaJLRnQyNcTyvhvPC Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2yffwr07eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 18:45:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024IiogE162436;
 Wed, 4 Mar 2020 18:45:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2yg1eqh7p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Mar 2020 18:45:05 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024Ij3bj012869;
 Wed, 4 Mar 2020 18:45:03 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Mar 2020 10:45:03 -0800
Subject: Re: [PATCH v5 12/50] multi-process: remote process initialization
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <264de034fcdc1000bada4a93ac7e0856fef591f2.1582576372.git.jag.raman@oracle.com>
 <20200304102959.GB4104@work-vm>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <8be42511-b355-f375-7dc2-6bbf949ba36f@oracle.com>
Date: Wed, 4 Mar 2020 13:45:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304102959.GB4104@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=2 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=2
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040125
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, liran.alon@oracle.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/4/2020 5:29 AM, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
>> Adds the handler to process message from QEMU,
>> Initialize remote process main loop, handles SYNC_SYSMEM
>> message by updating its "system_memory" container using
>> shared file descriptors received from QEMU.
>>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> ---
>>   v4 -> v5:
>>    - We checked if we could use functions already defined in
>>      util/main-loop.c instead of using g_main_loop_run. However,
>>      we couldn't find a suitable function that's generic enough
>>      to do this. All of them have emulator code embedded in them
>>      which is not used by the remote process. We are therefore
>>      not making any change to this patch
>>
>>   remote/remote-main.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>
>> diff --git a/remote/remote-main.c b/remote/remote-main.c
>> index ecf30e0..56315cd 100644
>> --- a/remote/remote-main.c
>> +++ b/remote/remote-main.c
>> @@ -12,6 +12,7 @@
>>   #include "qemu-common.h"
>>   
>>   #include <stdio.h>
>> +#include <unistd.h>
>>   
>>   #include "qemu/module.h"
>>   #include "remote/pcihost.h"
>> @@ -19,12 +20,96 @@
>>   #include "hw/boards.h"
>>   #include "hw/qdev-core.h"
>>   #include "qemu/main-loop.h"
>> +#include "remote/memory.h"
>> +#include "io/mpqemu-link.h"
>> +#include "qapi/error.h"
>> +#include "qemu/main-loop.h"
>> +#include "sysemu/cpus.h"
>> +#include "qemu-common.h"
>> +#include "hw/pci/pci.h"
>> +#include "qemu/thread.h"
>> +#include "qemu/main-loop.h"
>> +#include "qemu/config-file.h"
>> +#include "sysemu/sysemu.h"
>> +#include "block/block.h"
>> +#include "exec/ramlist.h"
>> +
>> +static MPQemuLinkState *mpqemu_link;
>> +PCIDevice *remote_pci_dev;
>> +
>> +static void process_msg(GIOCondition cond, MPQemuChannel *chan)
>> +{
>> +    MPQemuMsg *msg = NULL;
>> +    Error *err = NULL;
>> +
>> +    if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
>> +        goto finalize_loop;
>> +    }
>> +
>> +    msg = g_malloc0(sizeof(MPQemuMsg));
>> +
>> +    if (mpqemu_msg_recv(msg, chan) < 0) {
>> +        error_setg(&err, "Failed to receive message");
> 
> Please give error messages more context, e.g. the device or process name
> or something like that so that; it helps when we get a user
> reporting a crash and they report 'Unknown command' in their log, but
> then we have to figure out where to point them.

Ah OK, we'll add the exec name & PID of the QEMU process that spawned
this remote process in the error messages.

Thank you!
--
Jag

> 
>> +        goto finalize_loop;
>> +    }
>> +
>> +    switch (msg->cmd) {
>> +    case INIT:
>> +        break;
>> +    case PCI_CONFIG_WRITE:
>> +        break;
>> +    case PCI_CONFIG_READ:
>> +        break;
>> +    default:
>> +        error_setg(&err, "Unknown command");
>> +        goto finalize_loop;
>> +    }
>> +
>> +    g_free(msg->data2);
>> +    g_free(msg);
>> +
>> +    return;
>> +
>> +finalize_loop:
>> +    if (err) {
>> +        error_report_err(err);
>> +    }
>> +    g_free(msg);
>> +    mpqemu_link_finalize(mpqemu_link);
>> +    mpqemu_link = NULL;
>> +}
>>   
>>   int main(int argc, char *argv[])
>>   {
>> +    Error *err = NULL;
>> +
>>       module_call_init(MODULE_INIT_QOM);
>>   
>> +    bdrv_init_with_whitelist();
>> +
>> +    if (qemu_init_main_loop(&err)) {
>> +        error_report_err(err);
>> +        return -EBUSY;
>> +    }
>> +
>> +    qemu_init_cpu_loop();
>> +
>> +    page_size_init();
>> +
>> +    qemu_mutex_init(&ram_list.mutex);
>> +
> 
> So these are some subset of the things from qemu_init; I guess
> we'll have to be careful when we add stuff to vl.c to think what should
> also be added here.
> 
> Dave
> 
>>       current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
>>   
>> +    mpqemu_link = mpqemu_link_create();
>> +    if (!mpqemu_link) {
>> +        printf("Could not create MPQemu link\n");
>> +        return -1;
>> +    }
>> +
>> +    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO);
>> +    mpqemu_link_set_callback(mpqemu_link, process_msg);
>> +
>> +    mpqemu_start_coms(mpqemu_link);
>> +
>>       return 0;
>>   }
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

