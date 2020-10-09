Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB013C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0185E222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgDEQeu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0185E222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsxf-0007wB-TU
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQsu4-0005Th-90
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQsu2-0002g5-MM
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602251866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7MSf6qVQ9AHNam+cl33azSUASXylTsMb5b/5cayVM0=;
 b=NgDEQeu3KaRVKx0DLsaCRtPUx7EOS1w0rycRQdEqjZ3e2kCLuMJLBSSv/HbpsmoLIpIO2a
 54MjY9wTjZz2cdJekSZSwkfjEu8ZoV9W1TlAnFc16PbpBUL4zo4+blvffy+aPyQ+VjBiFF
 Alz7HSWy/hcLPJ5gE14y0L8tAIXldLY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-dduxLxVZOF2M4AgjTPYsmw-1; Fri, 09 Oct 2020 09:57:43 -0400
X-MC-Unique: dduxLxVZOF2M4AgjTPYsmw-1
Received: by mail-wm1-f71.google.com with SMTP id 13so4258938wmf.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 06:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L7MSf6qVQ9AHNam+cl33azSUASXylTsMb5b/5cayVM0=;
 b=nK+3dFJOOa7wsIbPp0paM0re9G4e5Fx5D6/HRFVoBfrh4gxjkn17nzEx7oYzmDt+sO
 Ywo3mj2pTWmPKYUz0PoNnOEeBxyTmRwwsySpge0GCJD9Vvp9ZLo2GX/+pNvI7XfJ7S3D
 2wMpN+rWWecj504bxK3NS71jwQaEKECA6AF1Cpj1prM8ThxVe4k9a5SrMcTzVxak7uzr
 BB+5mPwEZAaOuOWTtM6VQo8vTgdNzUMiNygHOQAVhY3sqOLRUOZ1DFme9mu21B7qLk+w
 4jH86fztb3UMRfUc8ZeTHJ7Hk2awHhTQGIYYPAKwhEEyiebh9JcYD6YnNR/l9/d1mJMC
 WQ9g==
X-Gm-Message-State: AOAM533+xqGKRqJtbhS6E/wcPTTWDGd5FmDSLuoWP8fiAIix71YzYHzc
 CHBAVi4ZGLrnoW3xzsNNUTmoZmkojt+xA3Jv+dpS9tH+HqdQqKeKguMbaHmq+fF8KtukDL37mBf
 ON26ApQDA3X/Snos=
X-Received: by 2002:a1c:2d4:: with SMTP id 203mr14876545wmc.144.1602251862249; 
 Fri, 09 Oct 2020 06:57:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOr2zPA0VJmSIdFFbtwMrPc+hEZkd2qT6nQqZEMOrsD4rXdG8PPFNGIBTjl+5aeGgpJS0n+Q==
X-Received: by 2002:a1c:2d4:: with SMTP id 203mr14876517wmc.144.1602251861984; 
 Fri, 09 Oct 2020 06:57:41 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h16sm12809577wre.87.2020.10.09.06.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 06:57:41 -0700 (PDT)
Subject: Re: [PATCH 2/3] migration: Make save_snapshot() return bool, not 0/-1
To: qemu-devel@nongnu.org
References: <20201008174803.2696619-1-philmd@redhat.com>
 <20201008174803.2696619-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <12771745-2c0b-f829-2c3d-c655a2b9b5ba@redhat.com>
Date: Fri, 9 Oct 2020 15:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008174803.2696619-3-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 7:48 PM, Philippe Mathieu-Daudé wrote:
> Just for consistency, following the example documented since
> commit e3fe3988d7 ("error: Document Error API usage rules").

I meant to use this description:

   Just for consistency, following the example documented since
   commit e3fe3988d7 ("error: Document Error API usage rules"),
   return a boolean value indicating an error is set or not.

> Document the function.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   include/migration/snapshot.h |  9 ++++++++-
>   migration/savevm.c           | 16 ++++++++--------
>   replay/replay-debugging.c    |  2 +-
>   replay/replay-snapshot.c     |  2 +-
>   4 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
> index c85b6ec75b..a40c34307b 100644
> --- a/include/migration/snapshot.h
> +++ b/include/migration/snapshot.h
> @@ -15,7 +15,14 @@
>   #ifndef QEMU_MIGRATION_SNAPSHOT_H
>   #define QEMU_MIGRATION_SNAPSHOT_H
>   
> -int save_snapshot(const char *name, Error **errp);
> +/**
> + * save_snapshot: Save a snapshot.
> + * @name: path to snapshot
> + * @errp: pointer to error object
> + * On success, return %true.
> + * On failure, store an error through @errp and return %false.
> + */
> +bool save_snapshot(const char *name, Error **errp);
>   int load_snapshot(const char *name, Error **errp);
>   
>   #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a52da440f4..fd2e5e8b66 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2658,7 +2658,7 @@ int qemu_load_device_state(QEMUFile *f)
>       return 0;
>   }
>   
> -int save_snapshot(const char *name, Error **errp)
> +bool save_snapshot(const char *name, Error **errp)
>   {
>       BlockDriverState *bs;
>       QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
> @@ -2671,29 +2671,29 @@ int save_snapshot(const char *name, Error **errp)
>       AioContext *aio_context;
>   
>       if (migration_is_blocked(errp)) {
> -        return ret;
> +        return false;
>       }
>   
>       if (!replay_can_snapshot()) {
>           error_setg(errp, "Record/replay does not allow making snapshot "
>                      "right now. Try once more later.");
> -        return ret;
> +        return false;
>       }
>   
>       if (!bdrv_all_can_snapshot(errp)) {
> -        return ret;
> +        return false;
>       }
>   
>       /* Delete old snapshots of the same name */
>       if (name) {
>           if (bdrv_all_delete_snapshot(name, errp) < 0) {
> -            return ret;
> +            return false;
>           }
>       }
>   
>       bs = bdrv_all_find_vmstate_bs(errp);
>       if (bs == NULL) {
> -        return ret;
> +        return false;
>       }
>       aio_context = bdrv_get_aio_context(bs);
>   
> @@ -2702,7 +2702,7 @@ int save_snapshot(const char *name, Error **errp)
>       ret = global_state_store();
>       if (ret) {
>           error_setg(errp, "Error saving global state");
> -        return ret;
> +        return false;
>       }
>       vm_stop(RUN_STATE_SAVE_VM);
>   
> @@ -2779,7 +2779,7 @@ int save_snapshot(const char *name, Error **errp)
>       if (saved_vm_running) {
>           vm_start();
>       }
> -    return ret;
> +    return ret == 0;
>   }
>   
>   void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> index 8785489c02..5458a73fce 100644
> --- a/replay/replay-debugging.c
> +++ b/replay/replay-debugging.c
> @@ -327,7 +327,7 @@ void replay_gdb_attached(void)
>        */
>       if (replay_mode == REPLAY_MODE_PLAY
>           && !replay_snapshot) {
> -        if (save_snapshot("start_debugging", NULL) != 0) {
> +        if (!save_snapshot("start_debugging", NULL)) {
>               /* Can't create the snapshot. Continue conventional debugging. */
>           }
>       }
> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> index e26fa4c892..4f2560d156 100644
> --- a/replay/replay-snapshot.c
> +++ b/replay/replay-snapshot.c
> @@ -77,7 +77,7 @@ void replay_vmstate_init(void)
>   
>       if (replay_snapshot) {
>           if (replay_mode == REPLAY_MODE_RECORD) {
> -            if (save_snapshot(replay_snapshot, &err) != 0) {
> +            if (!save_snapshot(replay_snapshot, &err)) {
>                   error_report_err(err);
>                   error_report("Could not create snapshot for icount record");
>                   exit(1);
> 


