Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E53C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4249206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V51GSojy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4249206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5u6j-0000OC-8u
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5u5z-0008ON-1C
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5u5v-0004LL-UP
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:54:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5u5v-0004L2-KO
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:54:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85FrZ2C103146;
 Thu, 5 Sep 2019 15:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=4tmQv1cu89xFjnyE+8kIQ0V35x8FlMlC5SpzO1SU/G4=;
 b=V51GSojyVWhhKt4vBtfQ4mEcdUEEMajw0oIPJGxPLQuOgQqdBwdDUbAuZK3B1BE/EELK
 c7USxYoYl+SvbgC4bYRVIsNmTtUzBj3tLNJQA7YKeNwJCjNltqXgPFE+9jhfAnvEMc2w
 zeYCLFgvufSz9wTDth68or9Q7JKQLimhvatlE5zReaSoL54d8PtpTGXe6ba2hxda8+fS
 vTAFHHsomAFL5yFviVZl5Yx7QzE3N3iLOEPx8ahPhRg99esitLAi7LfIdGY823si/jre
 TD7/qT24yc6JD4MVVAhC+ThoaPPMaeMM/2lHz9TlR9WN3neOa/t3U60Fywe3ERzErfg0 qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2uu4sb89p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:54:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85Fr8WY089426;
 Thu, 5 Sep 2019 15:54:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2uthq1w2cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:54:37 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x85FsZ8N001549;
 Thu, 5 Sep 2019 15:54:35 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Sep 2019 08:54:35 -0700
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <a90fb2dd9a528ef13962e9a80e5be08c036c37e9.1567534653.git.jag.raman@oracle.com>
 <20190904085607.GC2828@work-vm>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <1cb098b4-3887-987f-de07-a9fb8aa3692c@oracle.com>
Date: Thu, 5 Sep 2019 11:54:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190904085607.GC2828@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050150
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [RFC v3 PATCH 41/45] multi-process/mon: trim HMP
 command set for remote storage processes
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 mreitz@redhat.com, kanth.ghatraju@oracle.com, kraxel@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, liran.alon@oracle.com,
 marcandre.lureau@gmail.com, kwolf@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/4/2019 4:56 AM, Dr. David Alan Gilbert wrote:
> * Jagannathan Raman (jag.raman@oracle.com) wrote:
>> Trim down the list of HMP commands available for storage class of
>> remote processes.
>>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> ---
>>   New patch in v3
>>
>>   Makefile.objs              |   2 +
>>   Makefile.target            |  14 +-
>>   hmp-scsi-commands-info.hx  | 167 ++++++++++++++++++++
>>   hmp-scsi-commands.hx       | 384 +++++++++++++++++++++++++++++++++++++++++++++
>>   monitor/misc.c             |  84 +++++-----
>>   monitor/monitor-internal.h |  38 +++++
>>   qom/Makefile.objs          |   2 +-
>>   7 files changed, 651 insertions(+), 40 deletions(-)
>>   create mode 100644 hmp-scsi-commands-info.hx
>>   create mode 100644 hmp-scsi-commands.hx
>>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 04af900..11cd7be 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -45,6 +45,8 @@ remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o
>>   remote-lsi-obj-$(CONFIG_MPQEMU) += hw/
>>   remote-lsi-obj-$(CONFIG_MPQEMU) += ui/
>>   
>> +remote-lsi-obj-$(CONFIG_MPQEMU) += device-hotplug.o
>> +
>>   #######################################################################
>>   # crypto-obj-y is code used by both qemu system emulation and qemu-img
>>   
>> diff --git a/Makefile.target b/Makefile.target
>> index 0ca832f..00a4b85 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -210,6 +210,10 @@ endif
>>   generated-files-y += hmp-commands.h hmp-commands-info.h
>>   generated-files-y += config-devices.h
>>   
>> +ifdef CONFIG_MPQEMU
>> +generated-files-y += hmp-scsi-commands.h hmp-scsi-commands-info.h
>> +endif
>> +
>>   endif # CONFIG_SOFTMMU
>>   
>>   dummy := $(call unnest-vars,,obj-y)
>> @@ -294,10 +298,18 @@ hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
>>   hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
>>   	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
>>   
>> +ifdef CONFIG_MPQEMU
>> +hmp-scsi-commands.h: $(SRC_PATH)/hmp-scsi-commands.hx $(SRC_PATH)/scripts/hxtool
>> +	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
>> +
>> +hmp-scsi-commands-info.h: $(SRC_PATH)/hmp-scsi-commands-info.hx $(SRC_PATH)/scripts/hxtool
>> +	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
>> +endif
>> +
>>   clean: clean-target
>>   	rm -f *.a *~ $(PROGS)
>>   	rm -f $(shell find . -name '*.[od]')
>> -	rm -f hmp-commands.h gdbstub-xml.c
>> +	rm -f hmp-commands.h gdbstub-xml.c hmp-scsi-commands.h hmp-scsi-commands-info.h
>>   	rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
>>   ifdef CONFIG_TRACE_SYSTEMTAP
>>   	rm -f *.stp
>> diff --git a/hmp-scsi-commands-info.hx b/hmp-scsi-commands-info.hx
>> new file mode 100644
>> index 0000000..315a445
>> --- /dev/null
>> +++ b/hmp-scsi-commands-info.hx
>> @@ -0,0 +1,167 @@
>> +HXCOMM Use DEFHEADING() to define headings in both help text and texi
>> +HXCOMM Text between STEXI and ETEXI are copied to texi version and
>> +HXCOMM discarded from C version
>> +HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
>> +HXCOMM monitor info commands
>> +HXCOMM HXCOMM can be used for comments, discarded from both texi and C
>> +
>> +STEXI
>> +@table @option
>> +@item info @var{subcommand}
>> +@findex info
>> +Show various information about the system state.
>> +@table @option
>> +ETEXI
>> +
>> +    {
>> +        .name       = "version",
>> +        .args_type  = "",
>> +        .params     = "",
>> +        .help       = "show the version of QEMU",
>> +        .cmd        = hmp_info_version,
>> +        .flags      = "p",
>> +    },
>> +
>> +STEXI
>> +@item info version
>> +@findex info version
>> +Show the version of QEMU.
>> +ETEXI
> 
> It feels like you need a way to share this stuff without copying it;
> 'info version' isn't really a scsi specific command!
> One idea is you could add a new field, e.g.
> 
>       .subcommands = "scsi,somethingelse"
> 
> and then you process it to pick that up?

What do you think about breaking up hmp-commands-info.hx into smaller
files based on the types of devices it applies to - for example,
storage, network, console, etc..? We could then include the generated
file based on the device type.

Thanks!
--
Jag

> 
> <snip>
> 
>> diff --git a/monitor/misc.c b/monitor/misc.c
>> index 00338c0..4914f46 100644
>> --- a/monitor/misc.c
>> +++ b/monitor/misc.c
>> @@ -176,12 +176,12 @@ int hmp_compare_cmd(const char *name, const char *list)
>>       return 0;
>>   }
>>   
>> -static void do_help_cmd(Monitor *mon, const QDict *qdict)
>> +void do_help_cmd(Monitor *mon, const QDict *qdict)
> 
> If you're unstatic'ing things that don't have hmp in the name then you
> need to add it, i.e. hmp_do_help_cmd.
> 
> Dave
> 
>>   {
>>       help_cmd(mon, qdict_get_try_str(qdict, "name"));
>>   }
>>   
>> -static void hmp_trace_event(Monitor *mon, const QDict *qdict)
>> +void hmp_trace_event(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *tp_name = qdict_get_str(qdict, "name");
>>       bool new_state = qdict_get_bool(qdict, "option");
>> @@ -225,7 +225,7 @@ static void hmp_trace_file(Monitor *mon, const QDict *qdict)
>>   }
>>   #endif
>>   
>> -static void hmp_info_help(Monitor *mon, const QDict *qdict)
>> +void hmp_info_help(Monitor *mon, const QDict *qdict)
>>   {
>>       help_cmd(mon, "info");
>>   }
>> @@ -436,7 +436,7 @@ int monitor_get_cpu_index(void)
>>       return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
>>   }
>>   
>> -static void hmp_info_registers(Monitor *mon, const QDict *qdict)
>> +void hmp_info_registers(Monitor *mon, const QDict *qdict)
>>   {
>>       bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
>>       CPUState *cs;
>> @@ -459,7 +459,7 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
>>   }
>>   
>>   #ifdef CONFIG_TCG
>> -static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>> +void hmp_info_jit(Monitor *mon, const QDict *qdict)
>>   {
>>       if (!tcg_enabled()) {
>>           error_report("JIT information is only available with accel=tcg");
>> @@ -470,13 +470,13 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>>       dump_drift_info();
>>   }
>>   
>> -static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
>> +void hmp_info_opcount(Monitor *mon, const QDict *qdict)
>>   {
>>       dump_opcount_info();
>>   }
>>   #endif
>>   
>> -static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
>> +void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
>>   {
>>       int64_t max = qdict_get_try_int(qdict, "max", 10);
>>       bool mean = qdict_get_try_bool(qdict, "mean", false);
>> @@ -487,7 +487,7 @@ static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
>>       qsp_report(max, sort_by, coalesce);
>>   }
>>   
>> -static void hmp_info_history(Monitor *mon, const QDict *qdict)
>> +void hmp_info_history(Monitor *mon, const QDict *qdict)
>>   {
>>       MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
>>       int i;
>> @@ -507,7 +507,7 @@ static void hmp_info_history(Monitor *mon, const QDict *qdict)
>>       }
>>   }
>>   
>> -static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
>> +void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
>>   {
>>       CPUState *cs = mon_get_cpu();
>>   
>> @@ -518,7 +518,7 @@ static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
>>       cpu_dump_statistics(cs, 0);
>>   }
>>   
>> -static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
>> +void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *name = qdict_get_try_str(qdict, "name");
>>       bool has_vcpu = qdict_haskey(qdict, "vcpu");
>> @@ -578,7 +578,7 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
>>       error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "protocol", "spice");
>>   }
>>   
>> -static void hmp_logfile(Monitor *mon, const QDict *qdict)
>> +void hmp_logfile(Monitor *mon, const QDict *qdict)
>>   {
>>       Error *err = NULL;
>>   
>> @@ -588,7 +588,7 @@ static void hmp_logfile(Monitor *mon, const QDict *qdict)
>>       }
>>   }
>>   
>> -static void hmp_log(Monitor *mon, const QDict *qdict)
>> +void hmp_log(Monitor *mon, const QDict *qdict)
>>   {
>>       int mask;
>>       const char *items = qdict_get_str(qdict, "items");
>> @@ -605,7 +605,7 @@ static void hmp_log(Monitor *mon, const QDict *qdict)
>>       qemu_set_log(mask);
>>   }
>>   
>> -static void hmp_singlestep(Monitor *mon, const QDict *qdict)
>> +void hmp_singlestep(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *option = qdict_get_try_str(qdict, "option");
>>       if (!option || !strcmp(option, "on")) {
>> @@ -617,7 +617,7 @@ static void hmp_singlestep(Monitor *mon, const QDict *qdict)
>>       }
>>   }
>>   
>> -static void hmp_gdbserver(Monitor *mon, const QDict *qdict)
>> +void hmp_gdbserver(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *device = qdict_get_try_str(qdict, "device");
>>       if (!device)
>> @@ -633,7 +633,7 @@ static void hmp_gdbserver(Monitor *mon, const QDict *qdict)
>>       }
>>   }
>>   
>> -static void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
>> +void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *action = qdict_get_str(qdict, "action");
>>       if (select_watchdog_action(action) == -1) {
>> @@ -775,7 +775,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>>       }
>>   }
>>   
>> -static void hmp_memory_dump(Monitor *mon, const QDict *qdict)
>> +void hmp_memory_dump(Monitor *mon, const QDict *qdict)
>>   {
>>       int count = qdict_get_int(qdict, "count");
>>       int format = qdict_get_int(qdict, "format");
>> @@ -785,7 +785,7 @@ static void hmp_memory_dump(Monitor *mon, const QDict *qdict)
>>       memory_dump(mon, count, format, size, addr, 0);
>>   }
>>   
>> -static void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
>> +void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
>>   {
>>       int count = qdict_get_int(qdict, "count");
>>       int format = qdict_get_int(qdict, "format");
>> @@ -815,7 +815,7 @@ static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
>>       return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
>>   }
>>   
>> -static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>> +void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>>   {
>>       hwaddr addr = qdict_get_int(qdict, "addr");
>>       Error *local_err = NULL;
>> @@ -835,7 +835,7 @@ static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>>       memory_region_unref(mr);
>>   }
>>   
>> -static void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
>> +void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
>>   {
>>       target_ulong addr = qdict_get_int(qdict, "addr");
>>       MemTxAttrs attrs;
>> @@ -890,7 +890,7 @@ out:
>>       return ret;
>>   }
>>   
>> -static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
>> +void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
>>   {
>>       hwaddr addr = qdict_get_int(qdict, "addr");
>>       Error *local_err = NULL;
>> @@ -917,7 +917,7 @@ static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
>>   }
>>   #endif
>>   
>> -static void do_print(Monitor *mon, const QDict *qdict)
>> +void do_print(Monitor *mon, const QDict *qdict)
>>   {
>>       int format = qdict_get_int(qdict, "format");
>>       hwaddr val = qdict_get_int(qdict, "val");
>> @@ -943,7 +943,7 @@ static void do_print(Monitor *mon, const QDict *qdict)
>>       monitor_printf(mon, "\n");
>>   }
>>   
>> -static void hmp_sum(Monitor *mon, const QDict *qdict)
>> +void hmp_sum(Monitor *mon, const QDict *qdict)
>>   {
>>       uint32_t addr;
>>       uint16_t sum;
>> @@ -963,7 +963,7 @@ static void hmp_sum(Monitor *mon, const QDict *qdict)
>>   
>>   static int mouse_button_state;
>>   
>> -static void hmp_mouse_move(Monitor *mon, const QDict *qdict)
>> +void hmp_mouse_move(Monitor *mon, const QDict *qdict)
>>   {
>>       int dx, dy, dz, button;
>>       const char *dx_str = qdict_get_str(qdict, "dx_str");
>> @@ -987,7 +987,7 @@ static void hmp_mouse_move(Monitor *mon, const QDict *qdict)
>>       qemu_input_event_sync();
>>   }
>>   
>> -static void hmp_mouse_button(Monitor *mon, const QDict *qdict)
>> +void hmp_mouse_button(Monitor *mon, const QDict *qdict)
>>   {
>>       static uint32_t bmap[INPUT_BUTTON__MAX] = {
>>           [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
>> @@ -1004,7 +1004,7 @@ static void hmp_mouse_button(Monitor *mon, const QDict *qdict)
>>       mouse_button_state = button_state;
>>   }
>>   
>> -static void hmp_ioport_read(Monitor *mon, const QDict *qdict)
>> +void hmp_ioport_read(Monitor *mon, const QDict *qdict)
>>   {
>>       int size = qdict_get_int(qdict, "size");
>>       int addr = qdict_get_int(qdict, "addr");
>> @@ -1038,7 +1038,7 @@ static void hmp_ioport_read(Monitor *mon, const QDict *qdict)
>>                      suffix, addr, size * 2, val);
>>   }
>>   
>> -static void hmp_ioport_write(Monitor *mon, const QDict *qdict)
>> +void hmp_ioport_write(Monitor *mon, const QDict *qdict)
>>   {
>>       int size = qdict_get_int(qdict, "size");
>>       int addr = qdict_get_int(qdict, "addr");
>> @@ -1060,7 +1060,7 @@ static void hmp_ioport_write(Monitor *mon, const QDict *qdict)
>>       }
>>   }
>>   
>> -static void hmp_boot_set(Monitor *mon, const QDict *qdict)
>> +void hmp_boot_set(Monitor *mon, const QDict *qdict)
>>   {
>>       Error *local_err = NULL;
>>       const char *bootdevice = qdict_get_str(qdict, "bootdevice");
>> @@ -1073,7 +1073,7 @@ static void hmp_boot_set(Monitor *mon, const QDict *qdict)
>>       }
>>   }
>>   
>> -static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
>> +void hmp_info_mtree(Monitor *mon, const QDict *qdict)
>>   {
>>       bool flatview = qdict_get_try_bool(qdict, "flatview", false);
>>       bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
>> @@ -1086,7 +1086,7 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
>>   
>>   int64_t dev_time;
>>   
>> -static void hmp_info_profile(Monitor *mon, const QDict *qdict)
>> +void hmp_info_profile(Monitor *mon, const QDict *qdict)
>>   {
>>       static int64_t last_cpu_exec_time;
>>       int64_t cpu_exec_time;
>> @@ -1103,7 +1103,7 @@ static void hmp_info_profile(Monitor *mon, const QDict *qdict)
>>       dev_time = 0;
>>   }
>>   #else
>> -static void hmp_info_profile(Monitor *mon, const QDict *qdict)
>> +void hmp_info_profile(Monitor *mon, const QDict *qdict)
>>   {
>>       monitor_printf(mon, "Internal profiler not compiled\n");
>>   }
>> @@ -1112,7 +1112,7 @@ static void hmp_info_profile(Monitor *mon, const QDict *qdict)
>>   /* Capture support */
>>   static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
>>   
>> -static void hmp_info_capture(Monitor *mon, const QDict *qdict)
>> +void hmp_info_capture(Monitor *mon, const QDict *qdict)
>>   {
>>       int i;
>>       CaptureState *s;
>> @@ -1123,7 +1123,7 @@ static void hmp_info_capture(Monitor *mon, const QDict *qdict)
>>       }
>>   }
>>   
>> -static void hmp_stopcapture(Monitor *mon, const QDict *qdict)
>> +void hmp_stopcapture(Monitor *mon, const QDict *qdict)
>>   {
>>       int i;
>>       int n = qdict_get_int(qdict, "n");
>> @@ -1139,7 +1139,7 @@ static void hmp_stopcapture(Monitor *mon, const QDict *qdict)
>>       }
>>   }
>>   
>> -static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
>> +void hmp_wavcapture(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *path = qdict_get_str(qdict, "path");
>>       int has_freq = qdict_haskey(qdict, "freq");
>> @@ -1192,7 +1192,7 @@ static void hmp_warn_acl(void)
>>       warn_acl = true;
>>   }
>>   
>> -static void hmp_acl_show(Monitor *mon, const QDict *qdict)
>> +void hmp_acl_show(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *aclname = qdict_get_str(qdict, "aclname");
>>       QAuthZList *auth = find_auth(mon, aclname);
>> @@ -1219,7 +1219,7 @@ static void hmp_acl_show(Monitor *mon, const QDict *qdict)
>>       }
>>   }
>>   
>> -static void hmp_acl_reset(Monitor *mon, const QDict *qdict)
>> +void hmp_acl_reset(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *aclname = qdict_get_str(qdict, "aclname");
>>       QAuthZList *auth = find_auth(mon, aclname);
>> @@ -1236,7 +1236,7 @@ static void hmp_acl_reset(Monitor *mon, const QDict *qdict)
>>       monitor_printf(mon, "acl: removed all rules\n");
>>   }
>>   
>> -static void hmp_acl_policy(Monitor *mon, const QDict *qdict)
>> +void hmp_acl_policy(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *aclname = qdict_get_str(qdict, "aclname");
>>       const char *policy = qdict_get_str(qdict, "policy");
>> @@ -1277,7 +1277,7 @@ static QAuthZListFormat hmp_acl_get_format(const char *match)
>>       }
>>   }
>>   
>> -static void hmp_acl_add(Monitor *mon, const QDict *qdict)
>> +void hmp_acl_add(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *aclname = qdict_get_str(qdict, "aclname");
>>       const char *match = qdict_get_str(qdict, "match");
>> @@ -1330,7 +1330,7 @@ static void hmp_acl_add(Monitor *mon, const QDict *qdict)
>>       }
>>   }
>>   
>> -static void hmp_acl_remove(Monitor *mon, const QDict *qdict)
>> +void hmp_acl_remove(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *aclname = qdict_get_str(qdict, "aclname");
>>       const char *match = qdict_get_str(qdict, "match");
>> @@ -1799,13 +1799,21 @@ int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
>>   
>>   /* Please update hmp-commands.hx when adding or changing commands */
>>   static HMPCommand hmp_info_cmds[] = {
>> +#if defined(SCSI_PROCESS)
>> +#include "hmp-scsi-commands-info.h"
>> +#else
>>   #include "hmp-commands-info.h"
>> +#endif
>>       { NULL, NULL, },
>>   };
>>   
>>   /* hmp_cmds and hmp_info_cmds would be sorted at runtime */
>>   HMPCommand hmp_cmds[] = {
>> +#if defined(SCSI_PROCESS)
>> +#include "hmp-scsi-commands.h"
>> +#else
>>   #include "hmp-commands.h"
>> +#endif
>>       { NULL, NULL, },
>>   };
>>   
>> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
>> index 7760b22..5e8abd6 100644
>> --- a/monitor/monitor-internal.h
>> +++ b/monitor/monitor-internal.h
>> @@ -180,4 +180,42 @@ void help_cmd(Monitor *mon, const char *name);
>>   void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
>>   int hmp_compare_cmd(const char *name, const char *list);
>>   
>> +void do_help_cmd(Monitor *mon, const QDict *qdict);
>> +void hmp_trace_event(Monitor *mon, const QDict *qdict);
>> +void hmp_info_help(Monitor *mon, const QDict *qdict);
>> +void hmp_info_registers(Monitor *mon, const QDict *qdict);
>> +void hmp_info_jit(Monitor *mon, const QDict *qdict);
>> +void hmp_info_opcount(Monitor *mon, const QDict *qdict);
>> +void hmp_info_sync_profile(Monitor *mon, const QDict *qdict);
>> +void hmp_info_history(Monitor *mon, const QDict *qdict);
>> +void hmp_info_cpustats(Monitor *mon, const QDict *qdict);
>> +void hmp_info_trace_events(Monitor *mon, const QDict *qdict);
>> +void hmp_logfile(Monitor *mon, const QDict *qdict);
>> +void hmp_log(Monitor *mon, const QDict *qdict);
>> +void hmp_singlestep(Monitor *mon, const QDict *qdict);
>> +void hmp_gdbserver(Monitor *mon, const QDict *qdict);
>> +void hmp_watchdog_action(Monitor *mon, const QDict *qdict);
>> +void hmp_memory_dump(Monitor *mon, const QDict *qdict);
>> +void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
>> +void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
>> +void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
>> +void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
>> +void do_print(Monitor *mon, const QDict *qdict);
>> +void hmp_sum(Monitor *mon, const QDict *qdict);
>> +void hmp_mouse_move(Monitor *mon, const QDict *qdict);
>> +void hmp_mouse_button(Monitor *mon, const QDict *qdict);
>> +void hmp_ioport_read(Monitor *mon, const QDict *qdict);
>> +void hmp_ioport_write(Monitor *mon, const QDict *qdict);
>> +void hmp_boot_set(Monitor *mon, const QDict *qdict);
>> +void hmp_info_mtree(Monitor *mon, const QDict *qdict);
>> +void hmp_info_profile(Monitor *mon, const QDict *qdict);
>> +void hmp_info_capture(Monitor *mon, const QDict *qdict);
>> +void hmp_stopcapture(Monitor *mon, const QDict *qdict);
>> +void hmp_wavcapture(Monitor *mon, const QDict *qdict);
>> +void hmp_acl_show(Monitor *mon, const QDict *qdict);
>> +void hmp_acl_reset(Monitor *mon, const QDict *qdict);
>> +void hmp_acl_policy(Monitor *mon, const QDict *qdict);
>> +void hmp_acl_add(Monitor *mon, const QDict *qdict);
>> +void hmp_acl_remove(Monitor *mon, const QDict *qdict);
>> +
>>   #endif
>> diff --git a/qom/Makefile.objs b/qom/Makefile.objs
>> index e42ea7a..4410d71 100644
>> --- a/qom/Makefile.objs
>> +++ b/qom/Makefile.objs
>> @@ -7,4 +7,4 @@ common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
>>   remote-pci-obj-$(CONFIG_MPQEMU) += object.o qom-qobject.o container.o
>>   remote-pci-obj-$(CONFIG_MPQEMU) += object_interfaces.o
>>   remote-pci-obj-$(CONFIG_MPQEMU) += cpu.o
>> -remote-pci-obj-$(CONFIG_MPQEMU) += qom-qmp-cmds.o
>> +remote-pci-obj-$(CONFIG_MPQEMU) += qom-qmp-cmds.o qom-hmp-cmds.o
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

