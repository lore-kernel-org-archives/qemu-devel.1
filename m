Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653BAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E83A206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvLzXuJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E83A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTmb-0000FM-C8
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jtTlU-0007XO-68
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:26:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jtTlR-0007tq-Sk
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594290409;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=R5Cj9XfO1jyGBU+E0BYhqSIh2NIiAirwW98mKz3sCBo=;
 b=MvLzXuJN4JBd20xrTaNk81S4vy9d+Vz7sxOVc9ZEATr4qwta8Awzq6eW8m5kQQY6LRG4Xq
 mlOU9xHkzEOvM0f+fGe+r2i0CP9TuVoW+VphGfa+amm1A8R0EfWt0PNp3z6Va2xSWiZ+/r
 xmD+Z5EvGR2a0oApxEGfaof4IG5Zuak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-7vwwr4zbOoq3VZiBENKiZQ-1; Thu, 09 Jul 2020 06:26:47 -0400
X-MC-Unique: 7vwwr4zbOoq3VZiBENKiZQ-1
Received: by mail-wr1-f72.google.com with SMTP id i12so1591086wrx.11
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 03:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version;
 bh=R5Cj9XfO1jyGBU+E0BYhqSIh2NIiAirwW98mKz3sCBo=;
 b=rWjJk08pKiGAS0QpVVl7ontKoyPD3hjhDePk7STYejbLGLb3xTPP72eO7GnIwKJmDl
 /ABubri5Uy10FZcLEyiwPVVQ9fg33FM5hqQt4oEfRiNdBhmXFSgOUkWjg3yY3OXPFnjJ
 Bi1hTysm+zzgFSI06jVT4CJDwoOP3DDXfzAaNpBsXgHFF6p4LHPNlXGUbX5x0KFPWuxt
 Cdd1MtkXEamAVnzx2DMsA22m5Lr1ZgHQKRLDvNfKuyCmzcAdCJrWoMnQgTWuKofniTGJ
 5iuJexkHyzJoJ0l4LRqvrmSfofQORcooflX9lQqhBll1S5HWvlb89OK5cZBFkqoKZsk4
 PiMw==
X-Gm-Message-State: AOAM530rvt/WRRGofqKmL60d27Iy5Xp9RgdOy1o3C2bNgxn/WmxvF3Ck
 VC04BhjkG1kp/21XnaqZtU6U3towVN3MeQfmHvfX595/3jneJEZZfGbpB2BCIstvpPIk+XL/9/+
 TUXLT5Ewb4bUj5+A=
X-Received: by 2002:a5d:470b:: with SMTP id y11mr65483854wrq.101.1594290406334; 
 Thu, 09 Jul 2020 03:26:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx84+d+N9Wi5XT+1Hsq5zcCEaEtZqGB0xxuR34SKLBowFYurqJslf7oJSaGp9mXAdPe+mRlgQ==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr65483830wrq.101.1594290406065; 
 Thu, 09 Jul 2020 03:26:46 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id k18sm4864474wrx.34.2020.07.09.03.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 03:26:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 1/7] migration/savevm: respect qemu_fclose() error code in
 save_snapshot()
In-Reply-To: <20200703161130.23772-2-den@openvz.org> (Denis V. Lunev's message
 of "Fri, 3 Jul 2020 19:11:24 +0300")
References: <20200703161130.23772-1-den@openvz.org>
 <20200703161130.23772-2-den@openvz.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 09 Jul 2020 12:26:44 +0200
Message-ID: <87imex2dcr.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Denis V. Lunev" <den@openvz.org> wrote:
> qemu_fclose() could return error, f.e. if bdrv_co_flush() will return
> the error.
>
> This validation will become more important once we will start waiting of
> asynchronous IO operations, started from bdrv_write_vmstate(), which are
> coming soon.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
> CC: Juan Quintela <quintela@redhat.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued


> ---
>  migration/savevm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b979ea6e7f..da3dead4e9 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2628,7 +2628,7 @@ int save_snapshot(const char *name, Error **errp)
>  {
>      BlockDriverState *bs, *bs1;
>      QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
> -    int ret = -1;
> +    int ret = -1, ret2;
>      QEMUFile *f;
>      int saved_vm_running;
>      uint64_t vm_state_size;
> @@ -2712,10 +2712,14 @@ int save_snapshot(const char *name, Error **errp)
>      }
>      ret = qemu_savevm_state(f, errp);
>      vm_state_size = qemu_ftell(f);
> -    qemu_fclose(f);
> +    ret2 = qemu_fclose(f);
>      if (ret < 0) {
>          goto the_end;
>      }
> +    if (ret2 < 0) {
> +        ret = ret2;
> +        goto the_end;
> +    }
>  
>      /* The bdrv_all_create_snapshot() call that follows acquires the AioContext
>       * for itself.  BDRV_POLL_WHILE() does not support nested locking because


