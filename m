Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E589CC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276F020878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G+UcGbgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276F020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLshv-0004ik-Vv
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLsh5-000433-SJ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:43:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kLsh3-0008M1-JF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:43:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PITJpT177923;
 Fri, 25 Sep 2020 18:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Y6oulS03/k4Sd54fG5evpXChg4ftfztZMx4ltBMlWag=;
 b=G+UcGbgOglSqq8tMKO64I6OYSfRwOR6Isk7qD2yYdJKwJdRk2GvqxUE7iDFr0RG7xT/D
 ScBuOVcAtWygzG5fSWVF0ZX5QJBuCkVTNrUx6i9XjQ4iMmycnEc3LBjlUyWZ1UBoeBm6
 oXem/mRh/cRSsmd54EMulrtccquw3n8lMYJJM1UoHuiT8Mn3eqkXPKsrj3Ec32nspMzj
 D2T3CDJxilhUdg0CTGptPLD2suu+o8vr2T0sqLt9DvLlWpdr4vOclD/d2lguVVFQMNFG
 FOXs0qFCAQvOb9Cy+lI/8b+PQOXWLTdhtlREYn0OcaRiJcr2IypWuDck0mb7XWY/hpyy Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 33q5rgwjp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Sep 2020 18:43:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PIVVV8088997;
 Fri, 25 Sep 2020 18:43:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 33nux4ut60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2020 18:43:36 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PIhYBI003484;
 Fri, 25 Sep 2020 18:43:34 GMT
Received: from [10.39.220.177] (/10.39.220.177)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 25 Sep 2020 11:43:33 -0700
Subject: Re: [PATCH V1 03/32] savevm: QMP command for cprsave
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-4-git-send-email-steven.sistare@oracle.com>
 <20200911164338.GK3310@work-vm>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <b4172f01-2ad3-4b90-66cf-f810594737bf@oracle.com>
Date: Fri, 25 Sep 2020 14:43:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911164338.GK3310@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250130
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=steven.sistare@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 14:43:40
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
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

On 9/11/2020 12:43 PM, Dr. David Alan Gilbert wrote:
> * Steve Sistare (steven.sistare@oracle.com) wrote:
>> To enable live reboot, provide the cprsave QMP command and the VMS_REBOOT
>> vmstate-saving operation, which saves the state of the virtual machine in a
>> simple file.
>>
>> Syntax:
>>   {'command':'cprsave', 'data':{'file':'str', 'mode':'str'}}
>>
>>   The mode argument must be 'reboot'.  Additional modes will be defined in
>>   the future.
>>
>> Unlike the savevm command, cprsave supports any type of guest image and
>> block device.  cprsave stops the VM so that guest ram and block devices are
>> not modified after state is saved.  Guest ram must be mapped to a persistent
>> memory file such as /dev/dax0.0.  The ram object vmstate handler and block
>> device handler do not apply to VMS_REBOOT, so restrict them to VMS_MIGRATE
>> or VMS_SNAPSHOT.  After cprsave completes successfully, qemu exits.
>>
>> After issuing cprsave, the caller may update qemu, update the host kernel,
>> reboot, start qemu using the same arguments as the original process, and
>> issue the cprload command to restore the guest.  cprload is added by
>> subsequent patches.
>>
>> If the caller suspends the guest instead of stopping the VM, such as by
>> issuing guest-suspend-ram to the qemu guest agent, then cprsave and cprload
>> support guests with vfio devices.  The guest drivers suspend methods flush
>> outstanding requests and re-initialize the devices, and thus there is no
>> device state to save and restore.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> 
> Going back a step; could you.....
> 
>> ---
>>  include/migration/vmstate.h |  1 +
>>  include/sysemu/sysemu.h     |  2 ++
>>  migration/block.c           |  1 +
>>  migration/ram.c             |  1 +
>>  migration/savevm.c          | 59 +++++++++++++++++++++++++++++++++++++++++++++
>>  monitor/qmp-cmds.c          |  6 +++++
>>  qapi/migration.json         | 14 +++++++++++
>>  7 files changed, 84 insertions(+)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index fa575f9..c58551a 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -161,6 +161,7 @@ typedef enum {
>>  typedef enum {
>>      VMS_MIGRATE  = (1U << 1),
>>      VMS_SNAPSHOT = (1U << 2),
>> +    VMS_REBOOT   = (1U << 3),
>>      VMS_MODE_ALL = ~0U
>>  } VMStateMode;
>>  
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 4b6a5c4..6fe86e6 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -24,6 +24,8 @@ extern bool machine_init_done;
>>  void qemu_add_machine_init_done_notifier(Notifier *notify);
>>  void qemu_remove_machine_init_done_notifier(Notifier *notify);
>>  
>> +void save_cpr_snapshot(const char *file, const char *mode, Error **errp);
>> +
>>  extern int autostart;
>>  
>>  typedef enum {
>> diff --git a/migration/block.c b/migration/block.c
>> index 737b649..a69accb 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -1023,6 +1023,7 @@ static SaveVMHandlers savevm_block_handlers = {
>>      .load_state = block_load,
>>      .save_cleanup = block_migration_cleanup,
>>      .is_active = block_is_active,
>> +    .mode_mask = VMS_MIGRATE | VMS_SNAPSHOT,
>>  };
>>  
>>  void blk_mig_init(void)
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 76d4fee..f0d5d9f 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3795,6 +3795,7 @@ static SaveVMHandlers savevm_ram_handlers = {
>>      .load_setup = ram_load_setup,
>>      .load_cleanup = ram_load_cleanup,
>>      .resume_prepare = ram_resume_prepare,
>> +    .mode_mask = VMS_MIGRATE | VMS_SNAPSHOT,
>>  };
>>  
>>  void ram_mig_init(void)
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index ce02b6b..ff1a46e 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2680,6 +2680,65 @@ int qemu_load_device_state(QEMUFile *f)
>>      return 0;
>>  }
>>  
>> +static QEMUFile *qf_file_open(const char *filename, int flags, int mode,
>> +                              Error **errp)
>> +{
>> +    QIOChannel *ioc;
>> +    int fd = qemu_open(filename, flags, mode);
>> +
>> +    if (fd < 0) {
>> +        error_setg_errno(errp, errno, "%s(%s)", __func__, filename);
>> +        return NULL;
>> +    }
>> +
>> +    ioc = QIO_CHANNEL(qio_channel_file_new_fd(fd));
>> +
>> +    if (flags & O_WRONLY) {
>> +        return qemu_fopen_channel_output(ioc);
>> +    }
>> +
>> +    return qemu_fopen_channel_input(ioc);
>> +}
>> +
>> +void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
>> +{
>> +    int ret = 0;
>> +    QEMUFile *f;
>> +    VMStateMode op;
>> +
>> +    if (!strcmp(mode, "reboot")) {
>> +        op = VMS_REBOOT;
>> +    } else {
>> +        error_setg(errp, "cprsave: bad mode %s", mode);
>> +        return;
>> +    }
>> +
>> +    f = qf_file_open(file, O_CREAT | O_WRONLY | O_TRUNC, 0600, errp);
>> +    if (!f) {
>> +        return;
>> +    }
>> +
>> +    ret = global_state_store();
>> +    if (ret) {
>> +        error_setg(errp, "Error saving global state");
>> +        qemu_fclose(f);
>> +        return;
>> +    }
>> +
>> +    vm_stop(RUN_STATE_SAVE_VM);
>> +
>> +    ret = qemu_savevm_state(f, op, errp);
>> +    if ((ret < 0) && !*errp) {
>> +        error_setg(errp, "qemu_savevm_state failed");
>> +    }
> 
> just call qemu_save_device_state(f) there rather than introducing the
> modes?
> What you're doing is VERY similar to qmp_xen_save_devices_state and also
> COLO's device state saving.
> 
> (and also very similar to migration with the x-ignore-shared flag set).

Good idea, calling qemu_save_device_state instead of qemu_savevm_state will factor
out the steps that are specific to migration.  I'll still need the mode, though,
to exclude savevm_block_handlers, and maybe for other reasons.  I'll try it.

- Steve

>> +    qemu_fclose(f);
>> +
>> +    if (op == VMS_REBOOT) {
>> +        no_shutdown = 0;
>> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>> +    }
>> +}
>> +
[...]


