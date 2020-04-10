Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E5C2BBC7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 08:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EF92051A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 08:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uD70Ck54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EF92051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMoxi-0000YQ-3Z
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 04:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jMowa-0008S9-B4
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 04:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jMowX-0001cs-R1
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 04:23:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jMowX-0001bq-Hj
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 04:23:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03A8INEU115035;
 Fri, 10 Apr 2020 08:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6QELAik0qRH2g5ocNYzQTtd83JKF0+IjzOapfl5OSUI=;
 b=uD70Ck54xHz2XT1oCtob4r0ZZWbR9r4kNRrnt7XluO+z5cUZpsOMv5yHllL/s4j1CyMK
 do+xIkdQrBsbGgWtOzcrqpG9evRstf/78WZOiIgofyPbGlyhy7IBlTyfpd+peBWZCvcx
 s53L4unLBKdWOKCM4SXalGvxoF/2mZQ4IetdR4cjzIiBBhhjAnEmiK+B7Rzi6K2PRDQW
 HDjUvPIMQ1k//fknLNnTqTwyb0N4vTP2c54b5yosALHO9MzoMqBOOEAS5CHFw/7kd06O
 Gxv+qaJ+Lv3PsP1B2cLTytuJ6bih9vyb6NcFF8c/TxhfR6XO8vvynxzQv1ly4XOxrahz Mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 3091m3nc7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2020 08:22:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03A8MqKK014861;
 Fri, 10 Apr 2020 08:22:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 309ag72mmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2020 08:22:58 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03A8MuVr016708;
 Fri, 10 Apr 2020 08:22:56 GMT
Received: from heatpipe (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 10 Apr 2020 01:22:55 -0700
Date: Fri, 10 Apr 2020 01:22:52 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v6 16/36] multi-process: remote process initialization
Message-ID: <20200410082252.GA28178@heatpipe>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
 <73241ca8e613a00d89f86d214bf586cad658a616.1586165556.git.elena.ufimtseva@oracle.com>
 <20200409180002.GG3065@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409180002.GG3065@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004100070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100069
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, liran.alon@oracle.com, stefanha@redhat.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 09, 2020 at 07:00:02PM +0100, Dr. David Alan Gilbert wrote:
> * elena.ufimtseva@oracle.com (elena.ufimtseva@oracle.com) wrote:
> > From: Jagannathan Raman <jag.raman@oracle.com>
> > 
> > Adds the handler to process message from QEMU,
> > Initialize remote process main loop, handles SYNC_SYSMEM
> > message by updating its "system_memory" container using
> > shared file descriptors received from QEMU.
> > 
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > ---
> >  remote/remote-main.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> > 
> > diff --git a/remote/remote-main.c b/remote/remote-main.c
> > index ecf30e0cba..51595f3141 100644
> > --- a/remote/remote-main.c
> > +++ b/remote/remote-main.c
> > @@ -12,6 +12,7 @@
> >  #include "qemu-common.h"
> >  
> >  #include <stdio.h>
> > +#include <unistd.h>
> >  
> >  #include "qemu/module.h"
> >  #include "remote/pcihost.h"
> > @@ -19,12 +20,98 @@
> >  #include "hw/boards.h"
> >  #include "hw/qdev-core.h"
> >  #include "qemu/main-loop.h"
> > +#include "remote/memory.h"
> > +#include "io/mpqemu-link.h"
> > +#include "qapi/error.h"
> > +#include "qemu/main-loop.h"
> > +#include "sysemu/cpus.h"
> > +#include "qemu-common.h"
> > +#include "hw/pci/pci.h"
> > +#include "qemu/thread.h"
> > +#include "qemu/main-loop.h"
> > +#include "qemu/config-file.h"
> > +#include "sysemu/sysemu.h"
> > +#include "block/block.h"
> > +#include "exec/ramlist.h"
> > +
> > +static MPQemuLinkState *mpqemu_link;
> > +
> > +static void process_msg(GIOCondition cond, MPQemuLinkState *link,
> > +                        MPQemuChannel *chan)
> > +{
> > +    MPQemuMsg *msg = NULL;
> > +    Error *err = NULL;
> > +
> > +    if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
> > +        goto finalize_loop;
> > +    }
> > +
> > +    msg = g_malloc0(sizeof(MPQemuMsg));
> > +
> > +    if (mpqemu_msg_recv(msg, chan) < 0) {
> > +        error_setg(&err, "Failed to receive message");
> > +        goto finalize_loop;
> > +    }
> > +
> > +    switch (msg->cmd) {
> > +    case INIT:
> > +        break;
> > +    default:
> > +        error_setg(&err, "Unknown command");
> 
> Again this doesn't seem to have changed since my 4th March review where
> I asked for better error messages.
>

Hi Dave

Apologies, we have omitted it (and other patches you have commented on).
We will re-send the series with these addressed shortly plus the test build error fix.

Elena
> Dave
> 
> > +        goto finalize_loop;
> > +    }
> > +
> > +    g_free(msg->data2);
> > +    g_free(msg);
> > +
> > +    return;
> > +
> > +finalize_loop:
> > +    if (err) {
> > +        error_report_err(err);
> > +    }
> > +    g_free(msg);
> > +    mpqemu_link_finalize(mpqemu_link);
> > +    mpqemu_link = NULL;
> > +}
> >  
> >  int main(int argc, char *argv[])
> >  {
> > +    Error *err = NULL;
> > +
> >      module_call_init(MODULE_INIT_QOM);
> >  
> > +    bdrv_init_with_whitelist();
> > +
> > +    if (qemu_init_main_loop(&err)) {
> > +        error_report_err(err);
> > +        return -EBUSY;
> > +    }
> > +
> > +    qemu_init_cpu_loop();
> > +
> > +    page_size_init();
> > +
> > +    qemu_mutex_init(&ram_list.mutex);
> > +
> >      current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
> >  
> > +    mpqemu_link = mpqemu_link_create();
> > +    if (!mpqemu_link) {
> > +        printf("Could not create MPQemu link\n");
> > +        return -1;
> > +    }
> > +
> > +    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO);
> > +
> > +    mpqemu_link_set_callback(mpqemu_link, process_msg);
> > +
> > +    qdev_machine_creation_done();
> > +    qemu_mutex_lock_iothread();
> > +    qemu_run_machine_init_done_notifiers();
> > +    qemu_mutex_unlock_iothread();
> > +
> > +    mpqemu_start_coms(mpqemu_link, mpqemu_link->com);
> > +
> >      return 0;
> >  }
> > -- 
> > 2.25.GIT
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

