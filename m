Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79E5207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6NWqLEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79E5207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidcN-00064Q-Sv
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jidQF-0005SH-Fz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:32:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34103
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jidQB-0006jB-R9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591705922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBqJy4zmBPXwXfHybYGFIgtFGgcDei0T1Xpgi5s+mLo=;
 b=T6NWqLENYX9kc/9hEl32M+6iTgXBJaS94Gkrq201mzhrd/aQhKWjbfkKPEUfz8Rnk2KyYN
 hCcsPesgHauircPlbE2OrhDMbnnyKtB2bKSYk2ZrzyZ7D+0YsUalChFWoP7DCMbwwDKV4+
 nViGp1CnTULrvq++i/AGPRcza4YaE1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-qVCTdyp0OiG0DX7yPwRERw-1; Tue, 09 Jun 2020 08:32:00 -0400
X-MC-Unique: qVCTdyp0OiG0DX7yPwRERw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5697918FE867;
 Tue,  9 Jun 2020 12:31:59 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-136.rdu2.redhat.com [10.10.115.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7004A2B5B8;
 Tue,  9 Jun 2020 12:31:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 066C12205BD; Tue,  9 Jun 2020 08:31:55 -0400 (EDT)
Date: Tue, 9 Jun 2020 08:31:55 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Whitelist fchmod
Message-ID: <20200609123155.GB211764@redhat.com>
References: <20200608093111.14942-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200608093111.14942-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 08, 2020 at 11:31:11AM +0200, Max Reitz wrote:
> lo_setattr() invokes fchmod() in a rarely used code path, so it should
> be whitelisted or virtiofsd will crash with EBADSYS.
> 
> Said code path can be triggered for example as follows:
> 
> On the host, in the shared directory, create a file with the sticky bit
> set and a security.capability xattr:
> (1) # touch foo
> (2) # chmod u+s foo
> (3) # setcap '' foo
> 
> Then in the guest let some process truncate that file after it has
> dropped all of its capabilities (at least CAP_FSETID):
> 
> int main(int argc, char *argv[])
> {
>     capng_setpid(getpid());
>     capng_clear(CAPNG_SELECT_BOTH);
>     capng_updatev(CAPNG_ADD, CAPNG_PERMITTED | CAPNG_EFFECTIVE, 0);
>     capng_apply(CAPNG_SELECT_BOTH);
> 
>     ftruncate(open(argv[1], O_RDWR), 0);
> }
> 
> This will cause the guest kernel to drop the sticky bit (i.e. perform a
> mode change) as part of the truncate (where FATTR_FH is set), and that
> will cause virtiofsd to invoke fchmod() instead of fchmodat().
> 
> (A similar configuration exists further below with futimens() vs.
> utimensat(), but the former is not a syscall but just a wrapper for the
> latter, so no further whitelisting is required.)
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1842667
> Reported-by: Qian Cai <caiqian@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Nice catch. 

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  tools/virtiofsd/seccomp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/seccomp.c
> index bd9e7b083c..3b1522acdd 100644
> --- a/tools/virtiofsd/seccomp.c
> +++ b/tools/virtiofsd/seccomp.c
> @@ -42,6 +42,7 @@ static const int syscall_whitelist[] = {
>      SCMP_SYS(exit_group),
>      SCMP_SYS(fallocate),
>      SCMP_SYS(fchdir),
> +    SCMP_SYS(fchmod),
>      SCMP_SYS(fchmodat),
>      SCMP_SYS(fchownat),
>      SCMP_SYS(fcntl),
> -- 
> 2.26.2
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs


