Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9D3C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2959D2231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2pN0IN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2959D2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbqi-0002B8-8V
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZbmx-0006ZP-8r
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZbmv-0000UW-On
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604331028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0WJxWWeeL3V0Nn8Th+TdO8lB6goHt3ydNTAsfobTfw=;
 b=Y2pN0IN75m7e/KzykcaDuN1Cdh4eIlj0mrKAfcCQQwUE+nFMfUEbNJOHm/fsvHB4HUFhjb
 bq73XXHoKVn7AD40XhtqDPAEFyImqiuBFrWnAFTJ33BbsP9ZtCMCx5NLHHrLcZvNZoE30z
 QoRw07CC0juH36cjtrD7g2I4RaZcx4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-BXYOTTOSMKiuoieBh1Pzww-1; Mon, 02 Nov 2020 10:30:26 -0500
X-MC-Unique: BXYOTTOSMKiuoieBh1Pzww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C9FB57057
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 15:30:25 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 676585D9D2;
 Mon,  2 Nov 2020 15:30:24 +0000 (UTC)
Date: Mon, 2 Nov 2020 16:30:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/29] vl: split various early command line options to a
 separate function
Message-ID: <20201102163022.416bd0fa@redhat.com>
In-Reply-To: <20201027182144.3315885-6-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
 <20201027182144.3315885-6-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 14:21:20 -0400
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Various options affect the global state of QEMU including the rest of
> qemu_init, and they need to be called very early.  Group them together
> in a function that is called at the beginning.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  softmmu/vl.c | 202 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 113 insertions(+), 89 deletions(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
[...]
> +
> +static void qemu_maybe_daemonize(const char *pid_file)

why it's _maybe_ ?
It looks to me as just deamonize (or die which could be omitted)

> +{
> +    Error *err;
> +
> +    os_daemonize();
> +    rcu_disable_atfork();
> +
> +    if (pid_file && !qemu_write_pidfile(pid_file, &err)) {
> +        error_reportf_err(err, "cannot create PID file: ");
> +        exit(1);
> +    }
> +
> +    qemu_unlink_pidfile_notifier.notify = qemu_unlink_pidfile;
> +    qemu_add_exit_notifier(&qemu_unlink_pidfile_notifier);
> +}
[...]


