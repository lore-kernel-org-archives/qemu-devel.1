Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDCEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 01:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F6020679
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 01:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="gglpfg4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F6020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=apple.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgedd-00027N-SV
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 21:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dirty@apple.com>) id 1jgecz-0001ie-BN
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 21:25:05 -0400
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:52758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dirty@apple.com>) id 1jgecy-0008GA-9V
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 21:25:05 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp03.apple.com (8.16.0.42/8.16.0.42) with SMTP id
 0541Frxc025780; Wed, 3 Jun 2020 18:25:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=KhJODEC5nbZxM8ascYpPNETvylJ2FSvjlVrKS85VGik=;
 b=gglpfg4NqvhcA/EOKzrdwoEq8HVkaVYMAysXiJSUZFJBEThmm7XwpYclfLtY1omQfQqK
 yZeTG5e0tqmybk2XeIYQv7AhkT0T/5BmMHOgIWt/eqTRXHjKs+c+1UZSPtoSE4yQ6twg
 EbzlSpXcKRMipbfKCLSWuvnah/WlZPsoZtAicUPl6N7f07Q9xR8M/WOb4kyicY0SVxtl
 GYOnS8Wh1huQqC6XO2ltUJMkbrkLarrPgUzAoIjjO62Jk0OIdB2xIJbc5p8WnoCGL3Np
 PjMROnN7LIEbU6wijZy0ageyZtxNHHmBUmW6tVzWBVE2BBoCwDaXEopeKfGYz2i0+tYJ WA== 
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 31bpfuukmk-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Wed, 03 Jun 2020 18:25:02 -0700
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0QBD00R30NXOBU50@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Wed, 03 Jun 2020 18:25:01 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0QBD00D00NUB6Y00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Wed,
 03 Jun 2020 18:25:00 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 99f89d79671c95ffdbff058802d4710e
X-Va-E-CD: d5bc4848abf0cdd29451008d60d7e712
X-Va-R-CD: 786c4deaabcbd7aec5837d95626d37ad
X-Va-CD: 0
X-Va-ID: 61838eab-12f1-4671-9d98-89f4c3b7fbda
X-V-A: 
X-V-T-CD: 99f89d79671c95ffdbff058802d4710e
X-V-E-CD: d5bc4848abf0cdd29451008d60d7e712
X-V-R-CD: 786c4deaabcbd7aec5837d95626d37ad
X-V-CD: 0
X-V-ID: 717a6570-e202-490a-b8cc-f634a69b9274
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-03_13:2020-06-02,
 2020-06-03 signatures=0
Received: from [17.234.60.254] (unknown [17.234.60.254])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0QBD0078CNXMTQ00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Wed,
 03 Jun 2020 18:24:59 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] configure: Don't warn about lack of PIE on macOS
From: Cameron Esfahani <dirty@apple.com>
In-reply-to: <20200601124257.32057-1-r.bolshakov@yadro.com>
Date: Wed, 03 Jun 2020 18:24:58 -0700
Cc: Cameron Esfahani via <qemu-devel@nongnu.org>
Content-transfer-encoding: 7bit
Message-id: <E59CA0DB-8844-47E2-B54B-61F35F1847D0@apple.com>
References: <20200601124257.32057-1-r.bolshakov@yadro.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-03_13:2020-06-02,
 2020-06-03 signatures=0
Received-SPF: pass client-ip=17.171.2.72; envelope-from=dirty@apple.com;
 helo=ma1-aaemail-dr-lapp03.apple.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 21:25:02
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Cameron Esfahani <dirty@apple.com> 

Cameron Esfahani
dirty@apple.com

"It is the spirit and not the form of law that keeps justice alive."

Earl Warren



> On Jun 1, 2020, at 5:42 AM, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
> 
> ld64 is making PIE executables for 10.7 and above by default, as
> documented in ld(1).
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
> configure | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/configure b/configure
> index af2ba83f0e..6dddbca4b2 100755
> --- a/configure
> +++ b/configure
> @@ -2137,6 +2137,8 @@ elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
>   QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
>   QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
>   pie="yes"
> +elif test "$darwin" = "yes"; then
> +  pie="yes"
> elif test "$pie" = "yes"; then
>   error_exit "PIE not available due to missing toolchain support"
> else
> -- 
> 2.26.1
> 
> 


