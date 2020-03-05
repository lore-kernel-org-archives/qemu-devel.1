Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB50C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878B220637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dmpLanya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878B220637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tkl-0007BC-Fy
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j9tQa-0005qK-RA
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1j9tQY-0005Hx-4c
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:32:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1j9tQX-0005Bb-QH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:32:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025GRpPG066334;
 Thu, 5 Mar 2020 16:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=u0u0xs267FZvCMxU1Rm4i7cW2EO/zxzCrO5DE5HpWBE=;
 b=dmpLanyaGjGsuQTmuGPBWRpERCE9BJLcbikEOufn7tTVefAGQbHf6G3ijqenkQ2zITAi
 PEu/QTV5TNWrTors5hBbcPHaprVcQg6no7M3yUhQX9f51cOHOsIlpsAuCaUt9ZkCRXtu
 iCuDbOWSEMxKsPg+rwXSl12goeuYtYJWRRx2tT8OjQMUdxTi7tqMyb58MjO6ceAorl+B
 balwX3ync/RCZ07Eox9tRgKnrkNEhza1K2qKgZ6c9jIhARQCpCuRlCt5q21EXcqthmaK
 1sOphOrsg88713YqI9WJhVPG7v/YcsZFZ6fESyJ6POCgw+7elbothp+BUSifcHWjExXJ Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2yffcuxb4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Mar 2020 16:32:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025GRBk1164918;
 Thu, 5 Mar 2020 16:32:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2yg1h3ugmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Mar 2020 16:32:33 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 025GWWEJ017160;
 Thu, 5 Mar 2020 16:32:32 GMT
Received: from flaka (/174.207.16.221) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Mar 2020 08:32:31 -0800
Date: Thu, 5 Mar 2020 08:32:28 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 42/50] multi-process/mig: Send VMSD of remote to the
 Proxy object
Message-ID: <20200305163228.GA26883@flaka>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <74d6f7b67720a31a53c25164f8d9769c32d8c643.1582576372.git.jag.raman@oracle.com>
 <20200305143949.GI3130@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305143949.GI3130@work-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050105
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
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 02:39:49PM +0000, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
> > The remote process sends the VMSD to the Proxy object, on the source
> > side
> > 
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > ---
> >  migration/savevm.c   | 27 +++++++++++++++++++++++++++
> >  migration/savevm.h   |  2 ++
> >  remote/remote-main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 72 insertions(+)
> > 
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 1d4220e..09af14d 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2942,3 +2942,30 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
> >  
> >      return !(vmsd && vmsd->unmigratable);
> >  }
> > +
> 
> Can we add something here commenting, e.g.
> /* Called by the remote process to serialise migration back to the qemu
>  * */

Will add this.
> > +int qemu_remote_savevm(QEMUFile *f)
> > +{
> > +    SaveStateEntry *se;
> > +    int ret;
> > +
> > +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > +        if (!se->vmsd || !vmstate_save_needed(se->vmsd, se->opaque)) {
> > +            continue;
> > +        }
> > +
> > +        save_section_header(f, se, QEMU_VM_SECTION_FULL);
> > +
> > +        ret = vmstate_save(f, se, NULL);
> > +        if (ret) {
> > +            qemu_file_set_error(f, ret);
> > +            return ret;
> > +        }
> > +
> > +        save_section_footer(f, se);
> > +    }
> > +
> > +    qemu_put_byte(f, QEMU_VM_EOF);
> > +    qemu_fflush(f);
> 
> You have a qemu_fflush in process_start_mig_out  just after you call it
> - so you don't need both; I suggest you remove this one.
>
Ok. 
> > +    return 0;
> 
> And make this return qemu_file_get_error(f);  just like
> qemu_save_device_state and then makybe some day we can merge them.
>
Will do.
> > +}
> 
> 
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index ba64a7e..0491d3a 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -65,4 +65,6 @@ void qemu_loadvm_state_cleanup(void);
> >  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> >  int qemu_load_device_state(QEMUFile *f);
> >  
> > +int qemu_remote_savevm(QEMUFile *f);
> > +
> >  #endif
> > diff --git a/remote/remote-main.c b/remote/remote-main.c
> > index 58d9905..e97eb76 100644
> > --- a/remote/remote-main.c
> > +++ b/remote/remote-main.c
> > @@ -53,6 +53,16 @@
> >  #include "qemu/log.h"
> >  #include "qemu/cutils.h"
> >  #include "remote-opts.h"
> > +#include "qapi/error.h"
> > +#include "io/channel-util.h"
> > +
> > +#include "io/channel.h"
> > +#include "io/channel-socket.h"
> > +#include "migration/qemu-file-types.h"
> > +#include "migration/savevm.h"
> > +#include "migration/qemu-file-channel.h"
> > +#include "migration/qemu-file.h"
> > +
> >  #include "monitor/monitor.h"
> >  #include "chardev/char.h"
> >  #include "sysemu/reset.h"
> > @@ -322,6 +332,36 @@ static int setup_device(MPQemuMsg *msg, Error **errp)
> >  
> >  }
> >  
> > +static void process_start_mig_out(MPQemuMsg *msg)
> > +{
> > +    int wait = msg->fds[1];
> > +    Error *err = NULL;
> > +    QIOChannel *ioc;
> > +    QEMUFile *f;
> > +
> > +    ioc = qio_channel_new_fd(msg->fds[0], &err);
> > +    if (err) {
> > +        error_report_err(err);
> > +        return;
> > +    }
> > +
> > +    qio_channel_set_name(QIO_CHANNEL(ioc), "remote-migration-channel");
> > +
> > +    f = qemu_fopen_channel_output(ioc);
> > +
> > +    bdrv_drain_all();
> > +    (void)bdrv_flush_all();
> 
> Do remote process always have block code? I mean can't we have a remote
> process that's just say a NIC ?

Not always (in the future), we will account for this.

> 
> > +    (void)qemu_remote_savevm(f);
> 
> It's probably bad to ignore errors here; what you could do is if there's
> an error, you shoul dprint something and then send a poison value back
> to the QEMU to let it know that you've failed.
> 

Yes, will add this.

> > +    qemu_fflush(f);
> > +
> > +    notify_proxy(wait, (uint64_t)qemu_ftell(f));
> > +    PUT_REMOTE_WAIT(wait);
> > +
> > +    qemu_fclose(f);
> > +}
> > +
> >  static void process_msg(GIOCondition cond, MPQemuChannel *chan)
> >  {
> >      MPQemuMsg *msg = NULL;
> > @@ -411,6 +451,9 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
> >              notify_proxy(msg->fds[0], 0);
> >          }
> >          break;
> > +    case START_MIG_OUT:
> > +        process_start_mig_out(msg);
> > +        break;
> >      default:
> >          error_setg(&err, "Unknown command");
> >          goto finalize_loop;
> > -- 
> > 1.8.3.1
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

